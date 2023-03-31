# 지도활용(geoG)
---

> V-world

### 목차

#### - 인증키발급
#### - 지도 API
#### - 데이터 API
#### - OGC 표준 API
#### - 지오코더 API
#### - WebGL API

Openlayers기반, javascript로 제공, HTML sourcecode
http://openlayers.org

#### 지도 API
take vmap
- v -world : EPSG:3857, 전 세계를 한번에 표시할 때 주로 사용하는 좌표계로 google, OSM, bing사용 EPSG:9009013
- 국토지리정보원(국토정보맵) : EPSG:5179, UTM-K 한반도지역에서만 서비스, 단일 원점을 위해 만들어진 평면좌표계

#### 데이터 API
- 검색API
- 데이터API
- 공공데이터

REST API 활용방식으로 접근

#### OGC(Open Geospatial Consortium) 표준 API
- WMS(Web Map Service : 동적 지도 서비스) API
- WFS(Web Feature Servic : 동적 속성정보 서비스) API
- WMTS(Web Map Tile Service : 지도 타일 서비스) APT 파일이미지를 보여줌

브이월드 연속지적도/ 국가공간정보포털 지적도/ 국토정보기본도   Qgis, Cesium, Openlayers, WEBGL 등에 사용할 수 있다.
예)WMS자료_비행금지구역 + 브이월드지도

참고) http://spacen.or.kr/techday/index.html 

#### 지오코더 API
1. 주소데이터를 공간정보좌표로 변환(지오코딩 활용)
2. 공간정보좌표를 지도위에 표시(json, xml 파싱)

지오코더API가 검색API보다 좀 더 정확한 자료를 제공한다.
역지오코더 : 반대로 좌표를 주소로 바꾸어준다.-후대폰에서 내위치의 주소를 확인

#### WEBGL API
OBJ -> GLTF(오픈소스)
3D MODEL을 3차원 지도위에 올린다.
자료실에 샘플이 업로드
아이폰13Pro로 찍은 클라우드포인트로 활용


브이월드 무료컨설팅 채성기 선임연구원/ 031-606-2544/ sg.chae@spacen.or.kr

> 참조자료 : [2022 v-world tech-day]V-WORLD 2D, 3D
 오픈API 활용가이드(공간정보산업진흥원 채성기 팀장)

 >  [2022년 하반기 브이월드 온라인 교육 ~ 50:40] 방대한 주임 \
 [2022년 하반기 브이월드 온라인 교육 50:40 ~] 최성기 선임


최종작성일 : 2023.3.30.