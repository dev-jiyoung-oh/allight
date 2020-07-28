<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var gram; //상세 - 초기 gram
var kcal; //상세 - 초기 kcal

$(function(){
	//닫기 버튼을 눌렀을 때
    $('.create_modal .close').click(function(e) {
       //링크 기본동작은 작동하지 않도록 한다.
       e.preventDefault();
       $('#mask_create, .create_modal').hide();
       $('body').css("overflow", "scroll");
    });
 
    //검은 막을 눌렀을 때
    $('#mask_create').click(function() {
       $(this).hide();
       $('.create_modal').hide();
       $('body').css("overflow", "scroll");
    });
  
    //닫기 버튼을 눌렀을 때2
    $('.create_modal2 .close').click(function(e) {
       //링크 기본동작은 작동하지 않도록 한다.
       e.preventDefault();
       $('#mask_create2, .create_modal2').hide();
       $('body').css("overflow", "scroll");
    });
 
    //검은 막을 눌렀을 때2
    $('#mask_create2').click(function() {
       $(this).hide();
       $('.create_modal2').hide();
       $('body').css("overflow", "scroll");
    });
    
    // 밖에서 칼로리 등록 버튼 눌렀을 때
    $('#enrollBtn').click(function(){
    	var fcdnos = [];
    	// 선언한 배열에 선택한 cdno 넣기
    	$("input[name=checkbox]:checked").each(function() { 
            fcdnos.push(Number($(this).next('input').val()));
        });
    	
    	$('#cdnos').val(fcdnos);
    	$('#insertExerFrm').submit();
    });
    
	// 이름누르면 체크되게
    $('.cdname').click(function(){
    	var checkbox = $(this).closest('td').prev('td').children('input[name=checkbox]');
    	checkbox.attr('checked', !checkbox.is(':checked'));
    })
	
	// 뒤로가기 버튼 눌렀을 때
	$('#goBack').click(function(){
		$('#myFAEFrm').submit();
	})
    
    // 상세 모달에서 수량 바뀌면 분량(g),칼로리,그래프 변화
    $('#amount').change(function(){
    	$('#gram').val(gram*$(this).val());
    	$('#kcal').val(Math.floor(kcal*$('#gram').val()/gram));
    	
    	var ttan0 = Math.round(tan0*$(this).val()*100)/100;
    	var ddan0 = Math.round(dan0*$(this).val()*100)/100;
    	var jji0 = Math.round(ji0*$(this).val()*100)/100;
    	var ssik0 = Math.round(sik0*$(this).val()*100)/100;
    	var nna0 = Math.round(na0*$(this).val()*100)/100;
    	var ttan = Math.round(tan*$(this).val()*100)/100;
    	var ddan = Math.round(dan*$(this).val()*100)/100;
    	var jji = Math.round(ji*$(this).val()*100)/100;
    	var ssik = Math.round(sik*$(this).val()*100)/100;
    	var nna = Math.round(na*$(this).val()*100)/100;
    	
    	$('#tan').text(ttan0+'('+ttan+'%)');
    	$('#dan').text(ddan0+'('+ddan+'%)');
    	$('#ji').text(jji0+'('+jji+'%)');
    	$('#sik').text(ssik0+'('+ssik+'%)');
    	$('#na').text(nna0+'('+nna+'%)');
    	
    	$('#t-bar > div > div').css('width',ttan+'%');
    	$('#d-bar > div > div').css('width',ddan+'%');
    	$('#j-bar > div > div').css('width',jji+'%');
    	$('#s-bar > div > div').css('width',ssik+'%');
    	$('#n-bar > div > div').css('width',nna+'%');
    })
    
    // 상세 모달에서 분량(g) 바뀌면 칼로리 변화
	$('#gram').change(function(){
		$('#kcal').val(Math.floor(kcal*$('#gram').val()/gram));
	})
	
	// 마이칼로리 직접 입력 버튼 눌렀을 때
	$('#makeMyBtn').click(function(){
		wrapCreateByMask2();
	    $('body').css("overflow", "hidden");
	})
	
	// 마이칼로리 직접 입력 - 마이칼로리에 추가 버튼 눌렀을 떄
	$('#insertMyBtn').click(function(){
		var data = $("#insertMyCalFrm").serialize() ;
		
        $.ajax({
            type : 'post',
            url : './insertMyCal2.com',
            data : data,
            error: function(xhr, status, error){
                alert(error);
            },
            success : function(json){
                location.reload();
            },
        });
	})
	
	// 상세보기 - 칼로리 등록 버튼 눌렀을 때
	$('#detail-submit').click(function(){
		$('#detailFrm').submit();
	})
	
	// 상세보기 -  마이칼로리에 추가 버튼 눌렀을 때
	$('#insertItMyBtn').click(function(){
		var cdname = $('#name').text();
		var cdgram = $('#gram').val();
		var cdcal = $('#kcal').val();
		
        $.ajax({
            type : 'post',
            url : './insertMyCal2.com',
            data : {"dno":${DTO.dno},
            		"cdname":cdname,
            		"cdgram":cdgram,
            		"cdcal":cdcal},
            error: function(xhr, status, error){
                alert(error);
            },
            success : function(json){
            	alert('성공')
                location.reload();
            },
        });
	})
})

function wrapCreateByMask() {
   // 화면의 높이와 너비를 구한다.
   var maskHeight = $(document).height();
   var maskWidth = $(window).width();

   // 마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
   $('#mask_create').css({
      'width' : maskWidth,
      'height' : maskHeight
   });

   $('#mask_create').fadeTo("slow", 1);

   $('.create_modal').show();
};
function wrapCreateByMask2() {
   // 화면의 높이와 너비를 구한다.
   var maskHeight = $(document).height();
   var maskWidth = $(window).width();

   // 마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
   $('#mask_create2').css({
      'width' : maskWidth,
      'height' : maskHeight
   });

   $('#mask_create2').fadeTo("slow", 1);

   $('.create_modal2').show();
};
	
function detail(cdno,cdname,cdgram,cdcal){
	$('#detail-cdno').val(cdno);
	$('#detail-cdname').val(cdname);
	$('#name').text(cdname);
	$('#gram').val(cdgram);
	$('#kcal').val(cdcal);
	
	gram = cdgram;
	kcal = cdcal;
	
	wrapCreateByMask();
    $('body').css("overflow", "hidden");
}

function deleteMy(cdno) {
	$.ajax({
        type : 'post',
        url : './deleteMyCal.com',
        data : {"cdno":cdno},
        error: function(xhr, status, error){
            alert(error);
        },
        success : function(json){
            location.reload();
        },
    });
}

</script>
</head>
<body>
<div id="wrap2">
	<div class="title2">운동
		<div class="f-right" style="margin:0 20px 0 0">
			<input type="button" value="뒤로 가기" id="goBack">
		</div>
	</div>
	<div class="diary-content">
		<form id="MFsearchFrm">
		    <input type="text" name="searchWord" class="calTxt" placeholder="운동명 검색" value="${WORD}"/>
		    <button type="submit" class="calBtn">
		    	<img src="${pageContext.request.contextPath}/resources/img/search.png" class="shopSearchImg"/>
		   	</button>
		   	<input type="hidden" name="num" value="${DTO.dno}"/>
		   	<c:if test="${!empty DTO.ddate}">
		   		<input type="hidden" name="ddate" value="${DTO.ddate}"/>
		   	</c:if>
	   	</form>
   	
		
	   	<div class="search-divs1">
	   		<div class="f-left">
	   			검색결과 ${LIST.size()}<c:if test="${empty LIST}">0</c:if>개
	   		</div>
	   		<div class="f-right">
		   		<input type="button" value="칼로리 등록" class="btn" id="enrollBtn"/>
		   		<input type="button" value="마이칼로리 직접입력" class="btn" id="makeMyBtn"/>
	   		</div>
	   	</div>
	   	
	   	<div class="search-divs2">
				<ul>
					<li class="search-div"><a style="cursor:pointer;">칼로리 사전</a></li>
					<li class="search-div"><a style="cursor:pointer;">마이칼로리</a></li>
				</ul>
		</div>
		
		<table class="search-table" id="caldic-table">
			<c:forEach var="list" items="${LIST}">
			<tr>
				<td width="5%"><input type="checkbox" name="checkbox"/><input type="hidden" name="cdno" value="${list.cdno}"></td>
				<td width="65%" class="cdname">${list.cdname}&nbsp;&nbsp;(${list.cdgram}분)</td>
				<td width="25%" class="right" >${list.cdcal}kcal</td>
				<td width="5%" onclick="detail(${list.cdno},'${list.cdname}',${list.cdgram},${list.cdcal})">&gt;</td>
			</tr>
			</c:forEach>
			<c:if test="${empty LIST}">
				<tr>
					<td class="center">검색된 내용이 없습니다.</td>
				</tr>
			</c:if>
		</table>
		
		<table class="search-table" id="mycal-table">
			<c:forEach var="list" items="${MYLIST}">
			<tr>
				<td width="5%"><input type="checkbox" name="checkbox"/><input type="hidden" name="cdno" value="${list.cdno}"></td>
				<td width="60%" class="cdname">${list.cdname}&nbsp;&nbsp;(${list.cdgram}분)</td>
				<td width="25%" class="right">${list.cdcal}kcal</td>
				<td width="5%" onclick="detail(${list.cdno},'${list.cdname}',${list.cdgram},${list.cdcal})">&gt;</td>
				<td width="5%" onclick="deleteMy(${list.cdno})">X</td>
			</tr>
			</c:forEach>
			<c:if test="${empty MYLIST}">
				<tr>
					<td class="center">검색된 내용이 없습니다.</td>
				</tr>
			</c:if>
		</table>
	</div>
</div>

<!--<!--  어두워지는 부분1  -->
<div id="mask_create"></div>
<!-- 모달 부분1 (칼로리 상세) -->
<div class="create_modal">

<div class="top" style="">
   <div class="close" >x</div>
</div>

<div class="bottom">
<form class="diary-div" action="./insertMyExer2.com" id="detailFrm" method="post">
   <div class="title2">운동</div>
   <div class="diary-content">
      <div id="name" class="detail-name-div"></div>
      <input type="hidden" name="dno" value="${DTO.dno}"/>
      <input type="hidden" name="cdno" id="detail-cdno"/>
      <input type="hidden" name="mename" id="detail-cdname"/>
      <table id="detail-table">
         <tr>
            <td>시간(분)</td>
            <td><input type="number" value="1" min="1" id="gram" name="metime"/></td>
         </tr>
         <tr>
            <td>칼로리(kcal)</td>
            <td><input type="number" id="kcal" min="0" name="metotalcal"/></td>
         </tr>
      </table>
      <div class="center" style="margin:30px 0;">
         <input type="button" value="칼로리 등록" id="detail-submit"/>
         <input type="button" value="마이칼로리에 추가" id="insertItMyBtn"/>
         <input type="button" value="취소" class="close"/>
      </div>
   </div>
</form>
</div> 
</div> 

<!-- 어두워지는 부분2 (마이칼로리 추가) -->
<div id="mask_create2"></div>
<!-- 모달 부분2 (마이칼로리 추가) -->
<div class="create_modal2">

<div class="top" style="">
   <div class="close" >x</div>
</div>

<div class="bottom">
<form class="diary-div" id="insertMyCalFrm" method="post"> 
   <div class="title2">음식</div>
   <div class="diary-content">
      <div id="name" class="my-name-div">
      	<input type="text" name="cdname" placeholder="운동명을 입력해주세요." class="myCalText">
      </div>
      <input type="hidden" name="dno" value="${DTO.dno}"/>
      <table id="detail-table">
      	 <tr>
            <td>시간(분)</td>
            <td><input type="number" value="1" name="cdgram"/></td>
         </tr>
         <tr>
            <td>칼로리(kcal)</td>
            <td><input type="number" min="0" name="cdcal"/></td>
         </tr>
      </table>
      <div class="center" style="margin:30px 0;">
         <input type="button" value="마이칼로리에 추가" id="insertMyBtn"/>
         <input type="button" value="취소" class="close"/>
      </div>
   </div>
</form>
</div>
</div>

<form method="post" action="./insertMyExer.com" id="insertExerFrm">
	<input type="hidden" name="dno" value="${DTO.dno}"/>
	<c:if test="${!empty DTO.ddate}">
		<input type="hidden" name="ddate" value="${DTO.ddate}"/>
	</c:if>
	<input type="hidden" name="cdnos" id="cdnos"/>
</form>

<form action="./myFAE.com" id="myFAEFrm" method="post">
	<input type="hidden" name="num" value="${DTO.dno}"/>
	<c:if test="${!empty DTO.ddate}">
		<input type="hidden" name="ddate" value="${DTO.ddate}"/>
	</c:if>
</form>
</body>
</html>