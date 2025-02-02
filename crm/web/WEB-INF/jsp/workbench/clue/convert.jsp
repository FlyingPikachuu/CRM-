﻿<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<html>
<base href="<%=basePath%>">
<head>
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>


<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

<script type="text/javascript">
	$(function(){
		//阻止BootStrap框架默认回车键刷新表单，导致模态窗口关闭，页面内容消失的问题
		$(document).keydown(function(event){
			if (event.keyCode == 13) {
				$('.modal-content').each(function() {
					event.preventDefault();
				});
			}
		});

		$("#isCreateTransaction").click(function(){
			if(this.checked){
				$("#create-transaction2").show(200);
			}else{
				$("#create-transaction2").hide(200);
			}
		});

		//给搜索按钮添加单击事件
		$("#searchActivityBtn").click(function (){

			//清空搜索框
			$("#searchActivityTxt").val("");

			//清空列表
			$("#searchModalTbody").html("");

			$("#searchActivityModal").modal("show");
		});

		//给搜索输入框添加键盘弹起事件
		$("#searchActivityTxt").keyup(function (){
			let activityName=this.value;
			let clueId='${clue.id}';
			//发送请求
			$.ajax({
				url:'workbench/clue/searchActivity.do',
				data:{
					activityName:activityName,
					clueId:clueId
				},
				type:"post",
				datatype:"json",
				success:function (data){
					let htmlStr="";
					$.each(data,function (index,obj){
						htmlStr+="<tr>";
						htmlStr+="<td><input type=\"radio\" value='"+obj.id+"' activityName=\""+obj.name+"\" name=\"activity\"/></td>";
						htmlStr+="<td>"+obj.name+"</td>";
						htmlStr+="<td>"+obj.startDate+"</td>";
						htmlStr+="<td>"+obj.endDate+"</td>";
						htmlStr+="<td>"+obj.owner+"</td>";
						htmlStr+="</tr>";
					});
					$("#searchModalTbody").html(htmlStr);
				}
			});
		});

		//给所有搜索模态窗口添加单击事件
		$("#searchModalTbody").on("click","input[name='activity']",function (){
			let id = this.value;
			let activityName= $(this).attr("activityName");

			$("#activityId").val(id);
			$("#activityName").val(activityName);

			$("#searchActivityModal").modal("hide");
		});

		//给”转换“按钮添加点击事件
		$("#ConvertBtn").click(function (){
			let clueId = '${clue.id}';
			let money  = $("#amountOfMoney").val();
			let tradeName = $("#tradeName").val();
			let expectedDate =$("#expectedDate").val();
			let stage = $("#stage").val();
			let activityId = $("#activityId").val();
			let isCreateTran = $("#isCreateTransaction").prop('checked');
			if(tradeName==""){
				alert("交易名称不为空！");
				return;
			}
			if(stage==""){
				alert("阶段不为空！");
				return;
			}
			$.ajax({
				url:'workbench/clue/saveConvertClue.do',
				data:{
					clueId:clueId,
					money:money,
					tradeName:tradeName,
					expectedDate:expectedDate,
					stage:stage,
					activityId:activityId,
					isCreateTran:isCreateTran
				},
				type:'post',
				datatype:'json',
				success:function(data){
					if(data.code=="1"){
						window.location.href='workbench/clue/index.do';
					}else{
						alert(data.message);
					}
				}
			});
		});
		$("#cancelBtn").click(function (){
			window.history.back();
		})

	});
</script>

</head>
<body>
	
	<!-- 搜索市场活动的模态窗口 -->
	<div class="modal fade" id="searchActivityModal" role="dialog" >
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">搜索市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input  id="searchActivityTxt" type="text" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
								<td></td>
							</tr>
						</thead>
						<tbody id="searchModalTbody">
<%--							<tr>--%>
<%--								<td><input type="radio" name="activity"/></td>--%>
<%--								<td>发传单</td>--%>
<%--								<td>2020-10-10</td>--%>
<%--								<td>2020-10-20</td>--%>
<%--								<td>zhangsan</td>--%>
<%--							</tr>--%>
<%--							<tr>--%>
<%--								<td><input type="radio" name="activity"/></td>--%>
<%--								<td>发传单</td>--%>
<%--								<td>2020-10-10</td>--%>
<%--								<td>2020-10-20</td>--%>
<%--								<td>zhangsan</td>--%>
<%--							</tr>--%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div id="title" class="page-header" style="position: relative; left: 20px;">
		<h4>转换线索 <small>${clue.fullname}${clue.appellation}-${clue.company}</small></h4>
	</div>
	<div id="create-customer" style="position: relative; left: 40px; height: 35px;">
		新建客户：${clue.company}
	</div>
	<div id="create-contact" style="position: relative; left: 40px; height: 35px;">
		新建联系人：${clue.fullname}${clue.appellation}
	</div>
	<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
		<input type="checkbox" id="isCreateTransaction"/>
		为客户创建交易
	</div>
	<div id="create-transaction2" style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;" >
	
		<form>
		  <div class="form-group" style="width: 400px; position: relative; left: 20px;">
		    <label for="amountOfMoney">金额</label>
		    <input type="text" class="form-control" id="amountOfMoney">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="tradeName">交易名称<span style="font-size: 15px; color: red;">*</span></label>
		    <input type="text" class="form-control" id="tradeName" value="${clue.company}-">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="expectedDate">预计成交日期</label>
		    <input type="text" class="form-control" id="expectedDate">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="stage">阶段<span style="font-size: 15px; color: red;">*</span></label>
		    <select id="stage"  class="form-control">
		    	<option></option>
		    	<c:forEach items="${stageList}" var="sl">
					<option value="${sl.id}">${sl.value}</option>
				</c:forEach>
		    </select>
		  </div>
		  <div id="div_${clue.id}" class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="activity">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" id="searchActivityBtn" style="text-decoration: none;"><span class="glyphicon glyphicon-search"></span></a></label>
			  <input type="hidden" id="activityId">
		    <input id="activityName" type="text" class="form-control" id="activity" placeholder="点击上面搜索" readonly>
		  </div>
		</form>
		
	</div>
	
	<div id="owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
		记录的所有者：<br>
		<b>${clue.owner}</b>
	</div>
	<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
		<input id="ConvertBtn" class="btn btn-primary" type="button" value="转换">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input id="cancelBtn" class="btn btn-default" type="button" value="取消">
	</div>
</body>
</html>