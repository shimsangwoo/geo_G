<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>(예제)검색API 2.0</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<!-- API key를 포함하여 브이월드 API URL을 지정하여 호출 시작  -->
<script type="text/javascript" src="http://map.vworld.kr/jquery/jquery-1.7.1.min.js"></script>
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
div.maintitle {width:95%;height:50px;font-size:18px;line-height:50px;background-color:#004080;color:white;font-weight:bold;padding-left:20px;}
</style>
<script type="text/javascript">
function execute(){
	// api.vworld.kr도메인 외 다른 도메인에 사용시 proxy를 사용해야 합니다.
	let hosturl = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
	let url = hosturl + $("#url").val();
	let requestStr = url;
	let dataType = $.trim($("#format").val()).toLowerCase();
	let param = "";
	$("#requesturl, #resultbody").empty();
	$(".mandatory input[type=text]").each(function(){
		let val = $.trim($(this).val());
		let id = $(this).attr("id").toLowerCase();
		if (id == 'query') {val = encodeURIComponent(val);}
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
	
	if(id == "type_list"){
		$("#category").val("");
		if(value == "district"){			
			$("#category_list").empty();
			$("#category_list").append($('<option>',{value: "L1", text: "시도"}));
			$("#category_list").append($('<option>',{value: "L2", text: "시군구"}));
			$("#category_list").append($('<option>',{value: "L3", text: "일반구"}));
			$("#category_list").append($('<option>',{value: "L4", text: "읍면동"}));
			$("#category").val("L1");
			$("#category_list").show();
		}else if(value == "address"){
			$("#category_list").empty();
			$("#category_list").append($('<option>',{value: "road", text: "도로명"}));
			$("#category_list").append($('<option>',{value: "parcel", text: "지번"}));
			$("#category").val("road");
			$("#category_list").show();
		}else{
			$("#category_list").hide();
		}
	}
}

</script> 
</head> 
<body>
	<div id="desc" style="padding:0px 0px;">
		<div id="toolbar">	
			<div class="maintitle">(예제)검색API 2.0</div>
			<div class="mandatory">				
			<table class="board-write txt-left">
				<colgroup>
				<col width="200px" >
				<col width="50px" >
				<col />
				</colgroup>
				<tbody>
					<tr><th>요청URL</th><td></td><td><input type="text" id="url" value="/req/search?" readonly /></td></tr>
					<tr><th>서비스ID(service)</th><td>O/1</td><td><input type="text" id="service" value="search" readonly/></td></tr>
					<tr><th>서비스버전(version)</th><td>O/1</td><td><input type="text" id="version" value="2.0" readonly/></td></tr>
					<tr><th>오퍼레이션(request)</th><td>M/1</td><td><input type="text" id="request" value="search" readonly/>
							<select id="request_list" onchange="changeValue(this.id, this.value);">
							<option value="search">search</option>
							</select>
						</td>
					</tr>
					<tr><th>인증키(key)</th><td>M/1</td><td><input type="text" id="key" value="483E0418-2F46-3223-80A1-F66D16A24685" readonly/></td></tr>
					<tr><th>결과포맷(format)</th><td>O/1</td><td><input type="text" id="format" value="xml" readonly/>
						<select id="format_list" onchange="changeValue(this.id, this.value);">
						<option value="xml">xml</option>
						<option value="json">json</option>
						</select>
					</td></tr>
					<tr><th>오류결과포맷(errorFormat)</th><td>O/1</td><td><input type="text" id="errorformat" value="" readonly/>
						<select id="errorformat_list" onchange="changeValue(this.id, this.value);">
						<option value="">선택</option>
						<option value="xml">xml</option>
						<option value="json">json</option>
						</select>
					</td></tr>
					<tr><th>결과건수(size)</th><td>O/1</td><td><input type="text" id="size" value="10"/></td></tr>
					<tr><th>페이지번호(page)</th><td>O/1</td><td><input type="text" id="page" value="1"/></td></tr>
					<tr><th>검색어(query)</th><td>M/1</td><td><input type="text" id="query" value="강남역2호선"/>
						<select id="query_list" onchange="changeValue(this.id, this.value);">
						<option value="강남역2호선">강남역</option>
						<option value="강남대로 396">강남대로 396</option>
						<option value="역삼동 858">역삼동 858</option>
						</select>
					<br/>장소 예) 공간정보산업진흥원, 도로명주소 예) 판교로 344, 지번주소 예)삼평동 688-1
					</td></tr>
					<tr><th>검색대상(type)</th><td>O/1</td><td><input type="text" id="type" value="place" readonly/>
						<select id="type_list" onchange="changeValue(this.id, this.value);">
						<option value="place">장소</option>
						<option value="address">주소</option>
						<option value="district">행정구역</option>
						<option value="road">도로명</option>
						</select>
					</td></tr>
					<tr><th>하위유형(category)</th><td>O/n</td><td><input type="text" id="category" value=""/>
						<select id="category_list" onchange="changeValue(this.id, this.value);" style="display:none;">
						<option value="">선택</option>
						<option value="road">도로명</option>
						<option value="parcel">지번</option>
						</select>
						<br/>장소(type=place일 경우) : 장소 분류 유형(장소 분류표 참고) 입력
						<br/>주소(type=address일 경우) : ROAD(도로), PARCEL(지번) 중 1개 입력
					</td></tr>
					<tr><th>검색영역(bbox)</th><td>O/1</td><td><input type="text" id="bbox" value=""/>
					포맷 : minx,miny,maxx,maxy
					</td></tr>
					<tr><th>검색중심지점(center)</th><td>O/1</td><td><input type="text" id="center" value=""/>
					포맷 : x,y
					</td></tr>
					<tr><th>검색반경(radius)</th><td>O/1</td><td><input type="text" id="radius" value=""/>(단위 : m)
					center 파라미터가 없거나 유효하지 않을 경우 처리하지 않음
					</td></tr>
					<tr><th>결과좌표계(crs)</th><td>O/1</td><td><input type="text" id="crs" value="EPSG:4326"/>
					</td></tr>
				</tbody>
			</table>
			<div style="margin-bottom:5px;">
				요청구문은 다음과 같습니다 :
				<div id="requesturl" style="">
				</div>
			</div>
			<input type="button" value="테스트요청" onclick="javascript:execute();" />
				
		</div>
		</div>
	</div>
</body>
</html>