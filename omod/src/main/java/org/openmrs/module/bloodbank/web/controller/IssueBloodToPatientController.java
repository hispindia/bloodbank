package org.openmrs.module.bloodbank.web.controller;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.openmrs.Concept;
import org.openmrs.ConceptAnswer;
import org.openmrs.api.context.Context;
import org.openmrs.module.bloodbank.BloodStockReceiptService;
import org.openmrs.module.bloodbank.BloodStockService;
import org.openmrs.module.bloodbank.BloodbankConstants;
import org.openmrs.module.bloodbank.model.BloodStock;
import org.openmrs.module.bloodbank.model.BloodStockReceipt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("IssueBloodToPatient")
public class IssueBloodToPatientController {

	@RequestMapping(value="/module/bloodbank/viewIssueBloodToPatient.form", method = RequestMethod.GET)
	public String addBloodStockReceiptDescriptionForm(Model model) {
		
		return "/module/bloodbank/viewIssueBloodToPatient";
	}
	
	
	

}