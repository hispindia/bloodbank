
<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:require privilege="Add/Edit Bloodstock" otherwise="/login.htm" redirect="/module/bloodbank/main.form" />
<spring:message var="pageTitle" code="bloodbank.title" scope="page"/>
<%@ include file="/WEB-INF/template/header.jsp" %>
<%@ include file="includes/js_css.jsp" %>
<%@ include file="includes/nav.jsp" %>

<script type="text/javascript">
jQuery(document).ready(function() {
	
	jQuery("#receiptDate").change(function() {
		VALIDATION.checkRecieptDate();
	});
	});

VALIDATION={
	checkRecieptDate : function() {
		var recieptDate = new Date(STRING.convertDateFormat(jQuery('#receiptDate').val()));
		var expiryDate = new Date(STRING.convertDateFormat(jQuery('#dateExpiry').val()));

		if (recieptDate > expiryDate){
			jQuery('#receiptDate').val("");
			alert("You can not receipt an expired drug");
		}
	}
}

</script>

<div style="width: 20%; float: left; margin-left: 4px; ">
<b class="boxHeader"><spring:message code="bloodbank.receiveBlood.add"/></b>
<div class="box">
<form method="post" id="receiptBloodStockReceipt">
<input hidden type="numeric" id="receiptId" name="receiptId" value = "${receiptId}"  />

<c:if  test="${not empty errors}">
<c:forEach items="${errors}" var="error">
	<span class="error"><spring:message code="${error}" /></span>
</c:forEach>
</c:if>
<br/>
<table width="100%">
 <tr>
	<td><spring:message code="bloodbank.receiveBlood.bloodgroup"/></td>
		<td>
			<select name="bloodGroup" id="bloodGroup"  style="width: 80%;">
				<option value=""><spring:message code="bloodbank.receiveblood.selectbloodgroup"/></option>
                <c:forEach items="${bloodGroups}" var="bloodGroup">
                    <option value="${bloodGroup.answerConcept.id}" title="${bloodGroup.answerConcept.id}">${bloodGroup.answerConcept.name}</option>
                </c:forEach>
  			</select>
	</td>	
</tr>

	<tr>
		<td><spring:message code="bloodbank.receiveBlood.product"/><em>*</em></td>
		<td>
			<input type="text" id="product" name="product" />
		</td>
	</tr>
	<tr>
		<td><spring:message code="bloodbank.receiveBlood.dateOfReceipt"/><em>*</em></td>
		<td>
			<input type="text" id="dateOfReceipt" name="dateOfReceipt" class="date-pick left" readonly="readonly"  ondblclick="this.value='';"/>
		</td>
	</tr>
	
	<tr>
		<td><spring:message code="bloodbank.receiveBlood.dateOfExpiry"/><em>*</em></td>
		<td>
			<input type="text" id="dateOfExpiry" name="dateOfExpiry" class="date-pick left" readonly="readonly"  ondblclick="this.value='';"/>
		</td>
	</tr>
	
	<tr>
		<td><spring:message code="bloodbank.receiveBlood.donorName"/><em>*</em></td>
		<td>
			<input type="text" id="donorName" name="donorName" />
		</td>
	</tr>
	<tr>
		<td><spring:message code="bloodbank.receiveBlood.packNo"/><em>*</em></td>
		<td>
			<input type="text" id="packNo" name="packNo" />
		</td>
	</tr>

	
</table>
<br/>
<input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value="<spring:message code="bloodbank.receiveblood.addToSlip"/>">
<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="<spring:message code="bloodbank.receiveblood.back"/>" onclick="ACT.back();">
</form>
</div>
</div>
<!-- Receipt list -->
<div style="width: 79%; float: right; margin-right: 4px; ">
<b class="boxHeader">Receipt Slip</b> 

<table class="box" width="100%" border="1" cellpadding="5" cellspacing="0">
	<tr>
	<th>#</th>
	<th><spring:message code="bloodbank.receiveBlood.bloodgroup"/></th>
	<th><spring:message code="bloodbank.receiveBlood.product"/></th>
	<th><spring:message code="bloodbank.receiveBlood.dateOfReceipt"/></th>
	<th><spring:message code="bloodbank.receiveBlood.dateOfExpiry"/></th>
	<th><spring:message code="bloodbank.receiveBlood.donorName"/></th>
	<th><spring:message code="bloodbank.receiveBlood.packNo"/></th>
	</tr>
	<c:choose>
	<c:when test="${not empty bloodStocks}">
	<c:forEach items="${bloodStocks}" var="bloodStock" varStatus="varStatus">
	<tr class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } '>
		<td><c:out value="${(( pagingUtil.currentPage - 1  ) * pagingUtil.pageSize ) + varStatus.count }"/></td>
		<td>${bloodStock.bloodGroupConcept.name} </td>	
		<td>${bloodStock.product}</td>
		<td><openmrs:formatDate date="${bloodStock.receiptDate}" type="textbox"/></td>
		<td><openmrs:formatDate date="${bloodStock.expiryDate}" type="textbox"/></td>
		<td>${bloodStock.donorName}</td>
		<td>${bloodStock.packNo}</td>
	
		</tr>
	</c:forEach>
	
	</c:when>
	</c:choose>
</table>
<br/>
	<c:if  test="${not empty bloodStocks}">
		<table class="box" width="100%" cellpadding="5" cellspacing="0">
		<td>
				<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="<spring:message code="bloodbank.receiveblood.finish"/>" onclick="RECEIPT.receiptSlip(${receiptId});" />
			<!-- 	<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="<spring:message code="bloodbank.receiveblood.clear"/>"  onclick="RECEIPT.receiptSlip('1');"/>
				<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="<spring:message code="bloodbank.receiveblood.print"/>" onClick="RECEIPT.printDiv();" />
		-->	</td>
		</tr>
		</table>
	</c:if>
</div>
 
<%@ include file="/WEB-INF/template/footer.jsp" %>