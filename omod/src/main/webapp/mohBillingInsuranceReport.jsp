<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<openmrs:htmlInclude file="/scripts/calendar/calendar.js" />
<%@ include file="templates/mohBillingLocalHeader.jsp"%>
<%@ include file="templates/mohBillingReportHeader.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript" language="JavaScript">
	var $bill = jQuery.noConflict();
	$bill(document).ready(function(){
		$bill('.meta').hide();
		$bill('#submitId').click(function() {
			$bill('#formStatusId').val("clicked");
		});
		$bill("input#print_button").click(function() {
			$bill('.meta').show();
			$bill("div.printarea").printArea();
			$bill('.meta').hide();
		});

	});
</script>
<style>
.thirdParties,.timelabel,.time,.collector,.billCreator,.billStatus,.services,.deposit,.paymentType {
     display: none;
}
a.print {
    border: 2px solid #009900;
    background-color: #aabbcc;
    color: #ffffff;
    text-decoration: none;
}
</style>
<h2>
	Insurance Report
</h2>
<c:import url="mohBillingReportParameters.jsp" />
<b>Big Report ? </b> <a href="billingsessionControl.form" target="_blank" > Click here</a> for auto reflesh after running a report
<c:if test="${empty listOfAllServicesRevenue }">
 <div style="text-align: center;color: red;"><p>No Patient Bill found!</p></div>
</c:if>
<c:if test="${not empty listOfAllServicesRevenue }">
<br/>
<b class="boxHeader">
${resultMsg} <b style="color: black;font: bold;"></b>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
<a href="insuranceReport.form?export=true">Excel</a></b>
<div class="box">
<table style="width: 100%">
	<tr>
		<th class="columnHeader" style="width: 3%">#</th>
		<th class="columnHeader" style="width: 3%">Admission Date</th>
        <th class="columnHeader" style="width: 3%">Closing Date</th>
		<th class="columnHeader">BENEFICIARY's NAMES'</th>
		<th class="columnHeader">HEAD HOUSEHOLD'S NAMES </th>
		<th class="columnHeader">FAMILY'S CODE </th>
		<th class="columnHeader">LEVEL </th>
		<th class="columnHeader" style="width: 6%">GB#</th>
		<th class="columnHeader" style="width: 6%">Card NUMBER</th>
		<th class="columnHeader">COMPANY</th>
		<th class="columnHeader">AGE</th>
		<th class="columnHeader">BIRTH DATE</th>
		<th class="columnHeader">Gender</th>
		<th class="columnHeader">DOCTOR</th>
		<c:forEach items="${columns }" var="categ">
			<c:if test="${categ eq 'FORMALITES ADMINISTRATIVES' }">
				<th class="columnHeader">OTHERCONSUM. </th>
			</c:if>
		 <c:if test="${categ != 'FORMALITES ADMINISTRATIVES' }">
			 <th class="columnHeader">${categ } </th>
		 </c:if>
		</c:forEach>
		<th class="columnHeader">100%</th>
		<c:if test="${insuranceFlatFee > 0}">
			<th class="columnHeader">FlatFeee:<b> <fmt:formatNumber value="${insuranceFlatFee}" type="number" pattern="#.##"/></b></th>
			<th class="columnHeader">Insurance:<b> <fmt:formatNumber value="${insuranceRate }" type="number" pattern="#.##"/>% - <fmt:formatNumber value="${insuranceFlatFee}" type="number" pattern="#.##"/> </b></th>
			<th class="columnHeader">Patient:<b> <fmt:formatNumber value="${100-insuranceRate}" type="number" pattern="#.##"/>% + <fmt:formatNumber value="${insuranceFlatFee}" type="number" pattern="#.##"/></b></th>
	    </c:if>
	    <c:if test="${empty insuranceFlatFee}">
			<th class="columnHeader">Insurance:<b> <fmt:formatNumber value="${insuranceRate }" type="number" pattern="#.##"/>% </b></th>
        	<th class="columnHeader">Patient:<b> <fmt:formatNumber value="${100-insuranceRate}" type="number" pattern="#.##"/>%</b></th>
       </c:if>
	</tr>
	<c:set var="patientRate" value="${100-insuranceRate}"/>
   <c:set var="totalFlatFee" value="0" scope="page" />
	<c:forEach items="${listOfAllServicesRevenue}" var="asr" varStatus="status">
		    <td class="rowValue ${(status.count%2!=0)?'even':''}">${status.count}</td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">
			<fmt:formatDate pattern="dd/MM/yyyy" value="${asr.consommation.globalBill.createdDate}" />
			</td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">
            <fmt:formatDate pattern="dd/MM/yyyy" value="${asr.consommation.globalBill.closingDate}" />
            </td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">${asr.consommation.beneficiary.patient.personName}</td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">${asr.consommation.beneficiary.ownerName}</td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">${asr.consommation.beneficiary.ownerCode}</td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">${asr.consommation.beneficiary.level}</td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">${asr.consommation.globalBill.billIdentifier}</td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">${asr.consommation.beneficiary.insurancePolicy.insuranceCardNo}</td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">${asr.consommation.beneficiary.company}</td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">${asr.consommation.beneficiary.patient.age}</td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}"> <fmt:formatDate pattern="dd/MM/yyyy" value="${asr.consommation.beneficiary.patient.birthdate}" />  </td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">${asr.consommation.beneficiary.patient.gender}</td>
            <td class="rowValue ${(status.count%2!=0)?'even':''}"> ${asr.consommation.globalBill.closedBy.familyName}  ${asr.consommation.globalBill.closedBy.givenName}</td>
			<c:set var="insuranceDueAmbulance" value="0"/>
			<c:set var="patientDueAmbulance" value="0"/>
			<c:set var="insuranceDueNoAmbulance" value="0"/>
			<c:set var="patientDueNoAmbulance" value="0"/>
			<c:set var="allDueAmount" value="0"/>
		    <c:set var="insuranceDue" value="0"/>
		    <c:set var="patientDue" value="0"/>

			<c:forEach items="${asr.revenues }" var="revenue">
				<c:if test="${patientRate > 0}">
			 		<td class="rowValue ${(status.count%2!=0)?'even':''}"><fmt:formatNumber value="${revenue.dueAmount*100/patientRate}" type="number" pattern="#.##"/></td>
				</c:if>
				<c:if test="${patientRate==0}">
					<c:set var="amount" value="0" />
					<c:forEach items="${revenue.billItems}" var="item">
						<c:set var="amount" value="${amount + (item.unitPrice)*(item.quantity)}" />
					</c:forEach>
                 	<td class="rowValue ${(status.count%2!=0)?'even':''}"><fmt:formatNumber value="${amount}" type="number" pattern="#.##"/></td>
				</c:if>
			</c:forEach>
			<c:choose>
				<c:when test="${asr.consommation.globalBill.insurance.name=='MUTUELLE_CBHI_90%'}">
					<c:forEach items="${asr.revenues }" var="serviceRevenue">
	                       <c:forEach items="${serviceRevenue.billItems}" var="psb">
							   <c:if test="${psb.hopService.name=='AMBULANCE'}">
								   <c:set var="insuranceDueAmbulance" value="${insuranceDueAmbulance + (psb.unitPrice)*(psb.quantity)*(insuranceRate)/100 }"/>
								   <c:set var="patientDueAmbulance" value="${patientDueAmbulance + (psb.unitPrice)*(psb.quantity)*(100-insuranceRate)/100 }"/>
							   </c:if>
							   <c:if test="${psb.hopService.name!='AMBULANCE'}">
								   <c:set var="insuranceDueNoAmbulance" value="${insuranceDueNoAmbulance + (psb.unitPrice)*(psb.quantity)}"/>
								   <c:set var="patientDueNoAmbulance" value="${0}"/>
							   </c:if>
							   <c:set var="allDueAmount" value="${allDueAmount + ((psb.unitPrice)*(psb.quantity))}"/>
						   </c:forEach>
					</c:forEach>
				</c:when>
		        <c:otherwise>
					<c:set var="insuranceDue" value="${asr.allDueAmounts*insuranceRate/100}"/>
					<c:set var="patientDue" value="${asr.allDueAmounts*patientRate/100}"/>
				</c:otherwise>
			</c:choose>
			<c:if test="${asr.consommation.globalBill.insurance.name=='MUTUELLE_CBHI_90%'}">
				<td class="rowValue ${(status.count%2!=0)?'even':''}"><fmt:formatNumber value="${allDueAmount}" type="number" pattern="#.##"/></td>
				<td class="rowValue ${(status.count%2!=0)?'even':''}"><fmt:formatNumber value="${insuranceDueAmbulance + insuranceDueNoAmbulance -200}" type="number" pattern="#.##"/></td>
				<td class="rowValue ${(status.count%2!=0)?'even':''}"><fmt:formatNumber value="${patientDueAmbulance + patientDueNoAmbulance + 200}" type="number" pattern="#.##"/></td>
			</c:if>
			<c:if test="${asr.consommation.globalBill.insurance.name!='MUTUELLE_CBHI_90%'}">
			<td class="rowValue ${(status.count%2!=0)?'even':''}"><fmt:formatNumber value="${asr.allDueAmounts}" type="number" pattern="#.##"/></td>
		    <td class="rowValue ${(status.count%2!=0)?'even':''}"><fmt:formatNumber value="${insuranceDue}" type="number" pattern="#.##"/></td>
		    <td class="rowValue ${(status.count%2!=0)?'even':''}"><fmt:formatNumber value="${patientDue}" type="number" pattern="#.##"/></td>
			</c:if>
		</tr>
	</c:forEach>
<tr>
<td><b style="color: blue;">TOTAL</b></td>
	<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><td></td><td></td>
	<c:forEach items="${totals }" var="total">
		  <td class="rowValue ${(status.count%2!=0)?'even':''}"><b style="color: blue;"><fmt:formatNumber value="${total}" type="number" pattern="#.##"/></b> </td>
		</c:forEach>
		<td class="rowValue ${(status.count%2!=0)?'even':''}"><b style="color: blue;"><fmt:formatNumber value="${total100}" type="number" pattern="#.##"/></b> </td>
		<td class="rowValue ${(status.count%2!=0)?'even':''}"><b style="color: blue;"><fmt:formatNumber value="${total100*insuranceRate/100 - totalFlatFee}" type="number" pattern="#.##"/></b> </td>
		<td class="rowValue ${(status.count%2!=0)?'even':''}"><b style="color: blue;"><fmt:formatNumber value="${total100*patientRate/100 + totalFlatFee}" type="number" pattern="#.##"/></b> </td>
</tr>
</table>
</div>
</c:if>
<%@ include file="/WEB-INF/template/footer.jsp"%>