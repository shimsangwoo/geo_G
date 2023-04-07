<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>(예제)StaticMap API 2.0</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<!-- API key를 포함하여 브이월드 API URL을 지정하여 호출 시작  -->
<script type="text/javascript" src="http://map.vworld.kr/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="http://map.vworld.kr/js/map/proj4js.js"></script>
<script type="text/javascript" src="http://map.vworld.kr/js/map/OpenLayers-2.13/OpenLayers.js"></script>
<!--[if lt IE 9]>
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script> 
<![endif]-->
<style type="text/css">
*, body {font-family:NanumGothic, 돋움, Dotum, 나눔고딕;font-weight:normal;font-size:13px;}
input[type=button]{padding:2px 10px;line-height:24px;height:26px;min-width:100px; cursor:pointer;}
input[type=text],select{color:red;font-weight:bold;padding:2px 10px;line-height:22px;height:24px;border:solid 1px #e3e3e3;min-width:400px;}
textarea {color:blue;font-weight:bold;padding:2px 10px;line-height:22px;height:24px;border:solid 1px #e3e3e3;width:95%;height:150px;}
#requesturl, #resultbody {color:black;font-weight:normal; border: solid 1px #e3e3e3; width:95%; height:70px; overflow-x:hidden; overflow-y:auto; word-break:break-all; }
#resultbody { height: 150px;}
input:read-only {color:blue;}
input[readonly] {color:blue;}
input[type=file] {padding:2px 8px;/*line-height:24px;height:24px;*/border:solid 1px #e3e3e3;width:300px;}
select {padding-right:0px;min-width:100px;color:black;}
#toolbar{line-height:30px;min-height:30px;top:0px;font-weight:bold;}
div.mandatory label {min-width:200px; margin-right:10px;}
div.temporary b {font-weight:bold;color:blue;}
div.maintitle {width:95%;height:50px;font-size:18px;line-height:50px;background-color:#004080;color:white;font-weight:bold;padding-left:20px;}
#resultbox img {min-width:350px;min-height:150px;}
</style>
<script type="text/javascript">
$(document).ready(function() {
	//
	Proj4js.defs["EPSG:4019"] = "+proj=longlat +ellps=GRS80 +no_defs";
	Proj4js.defs["EPSG:3857"] = "+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs";
	Proj4js.defs["EPSG:900913"] = "+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs";
	
	//UTM-K
	Proj4js.defs["EPSG:5179"] = "+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs";
	//중부원점(50만)
	Proj4js.defs["EPSG:5181"]="+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=GRS80 +units=m +no_defs";
	//서부원점
	Proj4js.defs["EPSG:5185"] = "+proj=tmerc +lat_0=38 +lon_0=125 +k=1 +x_0=200000 +y_0=600000 +ellps=GRS80 +units=m +no_defs";
	//중부원점-o
	Proj4js.defs["EPSG:5186"] = "+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=600000 +ellps=GRS80 +units=m +no_defs";
	//동부원점
	Proj4js.defs["EPSG:5187"] = "+proj=tmerc +lat_0=38 +lon_0=129 +k=1 +x_0=200000 +y_0=600000 +ellps=GRS80 +units=m +no_defs";
	//동해(울릉)원점
	Proj4js.defs["EPSG:5188"] = "+proj=tmerc +lat_0=38 +lon_0=131 +k=1 +x_0=200000 +y_0=600000 +ellps=GRS80 +units=m +no_defs";
	$("#result_img, #resultbody").hide();
});
function execute(newWin){
	// api.vworld.kr도메인 외 다른 도메인에 사용시 proxy를 사용해야 합니다.
	let hosturl = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
	let url = hosturl + $("#url").val();
	let requestStr = url;
	let dataType = $.trim($("#format").val()).toLowerCase();
	let param = "";
	$("#requestbody, #resultbody").empty();
	$("#result_img, #resultbody").hide();
	$("#result_img").attr("src","");
	$(".mandatory input[type=text]").each(function(){
		let val = $.trim($(this).val());
		let id = $(this).attr("id").toLowerCase();
		if (id == 'marker' || id == 'route') {val = encodeURIComponent(val);}
		if (id != "url" && val != ''){
			param = param + "&"+id + "=" + val;
		}
	});
	
	requestStr += param.substring(1);
	$("#requesturl").text(requestStr);

	window.open("about:blank","responsewindow").location.href = requestStr;
}

function changeFormat(formatval){
	$("#format").val(formatval);
}

function changeValue(id, value){
	let targetid = id.split("_")[0];	
	$("#" + targetid).val(value);
}

function changeCRS(id, value){
	let targetid = id.split("_")[0];	
	$("#" + targetid).val(value);
	setCurrentCoord();
}

function setCurrentCoord(){
	try {
		let value = $("#crs").val();
		let scrs = $("#scrs").val();
		let epsg = value.toUpperCase();	

		if(value == scrs){
			$("#center").val($("#lon").val() + "," + $("#lat").val());
		}else{
			let lonlat = new OpenLayers.LonLat($("#lon").val(),$("#lat").val());
			let SCRS = new OpenLayers.Projection(scrs);
			let TCRS = new OpenLayers.Projection(epsg);
			let point = lonlat.transform(SCRS, TCRS);
			$("#center").val(point.lon + "," + point.lat);
		}
	}catch(e){}
}
</script> 
</head> 
<body>
	<div id="desc" style="padding:0px 0px;">
		<div id="toolbar">	
			<div class="maintitle">(예제)StaticMap API 2.0</div>
			<div class="temporary">
			경위도 좌표와 입력좌표계를 입력 후<b>"좌표적용"</b>버튼을 클릭하면 요청좌표계(crs)에 맞는 좌표로 변환됩니다. 요청좌표계(crs) 선택시 <b>자동변환</b> 됩니다.
			<table>
				<colgroup>
				<col width="200px" >
				<col />
				</colgroup>
				<tr><th>경도(WGS84)</th><td><input type="text" id="lon" value="126.978275264" /> 예) 126.978275264 , 14135156.944223</td></tr>
				<tr><th>위도(WGS84)</th><td><input type="text" id="lat" value="37.566642192" /> 예) 37.566642192 , 4518386.4796013</td></tr>
				<tr><th>원본좌표계</th><td><input type="text" id="scrs" value="epsg:4326" readonly/>
					<select id="scrs_list" onchange="changeValue(this.id, this.value);">
					<option value="epsg:4326">WGS84 경위도</option>
					<option value="epsg:4019">GRS80</option>
					<option value="epsg:3857">Google Mercator</option>
					<option value="epsg:5181">중부원점(GRS80, 50만)</option>
					<option value="epsg:5185">서부원점(GRS80)</option>
					<option value="epsg:5186">중부원점(GRS80)</option>
					<option value="epsg:5187">동부원점(GRS80)</option>
					<option value="epsg:5188">동해(울릉)원점(GRS80)</option>
					<option value="epsg:5179">UTM-K(GRS80)</option>
					</select>
				</td></tr>
			</table>
			<input type="button" value="좌표적용" onclick="javascript:setCurrentCoord();" />
			* 입력한 경위도 좌표값들이 요청좌표계(crs)에 맞는 좌표로 변환됩니다.
			</div>
			<div class="mandatory">				
			<table class="board-write txt-left">
				<colgroup>
				<col width="200px" >
				<col width="50px" >
				<col />
				</colgroup>
				<tbody>
					<tr><th>요청URL</th><td></td><td><input type="text" id="url" value="/req/image?" readonly /></td></tr>
					<tr><th>서비스ID(service)</th><td>O/1</td><td><input type="text" id="service" value="image" readonly/></td></tr>
					<tr><th>서비스버전(version)</th><td>O/1</td><td><input type="text" id="version" value="2.0" readonly/></td></tr>
					<tr><th>오퍼레이션(request)</th><td>M/1</td><td><input type="text" id="request" value="getmap" readonly/>	</td></tr>
					<tr><th>인증키(key)</th><td>M/1</td><td><input type="text" id="key" value="483E0418-2F46-3223-80A1-F66D16A24685" readonly/></td></tr>
					<tr><th>결과포맷(format)</th><td>O/1</td><td><input type="text" id="format" value="png" readonly/>
						<select id="format_list" onchange="changeValue(this.id, this.value);">
						<option value="png">png</option>
						<option value="jpeg">jpeg</option>
						<option value="bmp">bmp</option>
						</select>
					</td></tr>
					<tr><th>오류결과포맷(errorFormat)</th><td>O/1</td><td><input type="text" id="errorformat" value="" readonly/>
						<select id="errorformat_list" onchange="changeValue(this.id, this.value);">
						<option value="">선택</option>
						<option value="xml">xml</option>
						<option value="json">json</option>
						<option value="image">요청이미지포맷</option>
						<option value="blank">빈이미지</option>
						</select>
					</td></tr>
					<tr><th>지도 유형(basemap)</th><td>O/1</td><td><input type="text" id="basemap" value="GRAPHIC" readonly/>
						<select id="basemap_list" onchange="changeValue(this.id, this.value);">
						<option value="GRAPHIC">기본지도</option>
						<option value="NONE">없음</option>
						<option value="GRAPHIC_GRAY">회색지도</option>
						<option value="GRAPHIC_NIGHT">야간지도</option>
						<option value="PHOTO">영상지도</option>
						<option value="PHOTO_HYBRID">영상시설물지도</option>
						</select>
					</td></tr>
					<tr><th>검색중심지점(center)</th><td>M/1</td><td><input type="text" id="center" value="126.978275264,37.566642192" readonly/>
					</td></tr>
					<tr><th>좌표계(crs)</th><td>O/1</td><td><input type="text" id="crs" value="epsg:4326" readonly/>
						<select id="crs_list" onchange="changeCRS(this.id, this.value);">
						<option value="epsg:4326">WGS84 경위도</option>
						<option value="epsg:3857">Google Mercator</option>
						<option value="epsg:4019">GRS80</option>
						<option value="epsg:5181">중부원점(GRS80, 50만)</option>
						<option value="epsg:5185">서부원점(GRS80)</option>
						<option value="epsg:5186">중부원점(GRS80)</option>
						<option value="epsg:5187">동부원점(GRS80)</option>
						<option value="epsg:5188">동해(울릉)원점(GRS80)</option>
						<option value="epsg:5179">UTM-K(GRS80)</option>
						</select>
					</td></tr>
					<tr><th>줌 레벨(zoom)</th><td>M/1</td><td><input type="text" id="zoom" value="16" /> 예)14(6~18 범위내 허용)</td></tr>
					<tr><th>이미지폭과 높이(size)</th><td>M/1</td><td><input type="text" id="size" value="400,400" />픽셀값(숫자)</td></tr>
					<tr><th>오버레이(layers)</th><td>O/1</td><td><input type="text" id="layers" value="" /> 예)LT_C_UQ111</td></tr>
					<tr class="max"><th>마커(marker)</th><td>O/1</td><td><input type="text" id="marker" style="width:95%;" value="" />
					<br/>label:마커테스트1|color:red|point:126.9760222 37.5682154,126.9808716 37.5678752,126.9804424 37.5650008,126.9770736 37.5668037</td></tr>
					<tr class="max"><th>경로(route)</th><td>O/1</td><td><input type="text" id="route" style="width:95%;" value="" />
					<br/>style:dash|color:red|width:3|point:126.9760222 37.5682154,126.9808716 37.5678752,126.9804424 37.5650008,126.9770736 37.5668037</td></tr>
				</tbody>
			</table>
			<div style="margin-bottom:5px;">
				요청구문은 다음과 같습니다 :
				<div id="requesturl">
				</div>
			</div>
			<input type="button" value="테스트요청" onclick="javascript:execute();" />
				
		</div>
		</div>
	</div>
</body>
</html>