<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=16sok5oca8"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value='/js/MarkerClustering.js'/>"></script>

<script type="text/javascript">
	
    var markers = [];
    
	$( document ).ready(function() {
		var map = new naver.maps.Map("map", {
	        zoom: 7,
	        center: new naver.maps.LatLng(36.2253017, 127.6460516),
	        zoomControl: true,
	        zoomControlOptions: {
	            position: naver.maps.Position.TOP_LEFT,
	            style: naver.maps.ZoomControlStyle.SMALL
	        }
	    });

		fn_data();
		

	    var htmlMarker1 = {
	            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-1.png);background-size:contain;"></div>',
	            size: N.Size(40, 40),
	            anchor: N.Point(20, 20)
	        },
	        htmlMarker2 = {
	            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-2.png);background-size:contain;"></div>',
	            size: N.Size(40, 40),
	            anchor: N.Point(20, 20)
	        },
	        htmlMarker3 = {
	            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-3.png);background-size:contain;"></div>',
	            size: N.Size(40, 40),
	            anchor: N.Point(20, 20)
	        },
	        htmlMarker4 = {
	            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-4.png);background-size:contain;"></div>',
	            size: N.Size(40, 40),
	            anchor: N.Point(20, 20)
	        },
	        htmlMarker5 = {
	            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-5.png);background-size:contain;"></div>',
	            size: N.Size(40, 40),
	            anchor: N.Point(20, 20)
	        };

	    var markerClustering = new MarkerClustering({
	        minClusterSize: 2,
	        maxZoom: 13,
	        map: map,
	        markers: markers,
	        disableClickZoom: false,
	        gridSize: 120,
	        icons: [htmlMarker1, htmlMarker2, htmlMarker3, htmlMarker4, htmlMarker5],
	        indexGenerator: [10, 100, 200, 500, 1000],
	        stylingFunction: function(clusterMarker, count) {
	            $(clusterMarker.getElement()).find('div:first-child').text(count);
	        }
	    });
			
		
		
	});

	function initMap() {

		//지도 중심 설정
		var map = new naver.maps.Map("map", {
		    zoom: 6,
		    center: new naver.maps.LatLng(36.2253017, 127.6460516),
		    zoomControl: true,
		    zoomControlOptions: {
		        position: naver.maps.Position.TOP_LEFT,
		        style: naver.maps.ZoomControlStyle.SMALL
		    }
		});

	}

	function fn_data() {
		$.ajax({
			url : "<c:url value='/map/selectdataMap.do'/>",
			data : "",
			dataType : "json",
			method : 'post',
			success : function(data) {

			    for (var i = 0, ii = data.length; i < ii; i++) {
			         var spot = data[i],
			            latlng = new naver.maps.LatLng(spot.lat, spot.lng),
			            marker = new naver.maps.Marker({
			                position: latlng,
			                draggable: true
			            });

			        markers.push(marker);
			    }
			},
			error : function(e) {
				alert('오류가 발생하였습니다. 관리자에게 문의해주세요.');
			}
		});
	}
	

</script>


<!-- 네이버 지도가 뿌려질 곳 !  -->
<div class="contents">

	<!-- 서브 콘텐츠 시작(s) -->
	<form name="listFrm" id="listFrm" method="post">
		<input type="hidden" name="pageIndex" id="pageIndex"
			value="${searchVO.pageIndex }"> <input type="hidden"
			name="searchEventMngId">
		<div class="search_box">
			<ul class="clfix">
				<li class="long5 sch_btn_line"><label class="cate">검색조건</label>
					<select name="searchCondition">
						<option value="">전체</option>
						<option value="1"
							<c:if test="${searchVO.searchCondition eq '1' }">selected="selected"</c:if>>제목</option>
						<option value="2"
							<c:if test="${searchVO.searchCondition eq '2' }">selected="selected"</c:if>>작성자</option>
				</select> <input type="text" name="searchKeyword"
					value="${searchVO.searchKeyword }" class="sch_text"></li>

				<li class="long5 btn_area txtr"><a
					class="btnm btnBlue sameLine"
					href="<c:url value='/map/selectMap.do'/>">검색초기화</a> <a
					class="btnm btnLightRed sameLine" href="javascript:fn_data();"
					title="검색">검색</a></li>
			</ul>
		</div>
		<!-- //search_box 검색영역 -->

	</form>
</div>
<div id="map" style="width: 80%; height: 500px; margin: 0 auto;"></div>

