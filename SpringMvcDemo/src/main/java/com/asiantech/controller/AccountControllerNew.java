package com.asiantech.controller;

import java.util.List; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam; 
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.asiantech.model.Account;
import com.asiantech.service.AccountService;

@Controller
@RequestMapping("/account")
public class AccountControllerNew {
	@Autowired
	@Qualifier(AccountService.NAME)
	AccountService accountSv;
	
	@RequestMapping(value="/getList", method=RequestMethod.GET)
	public String getListAccounts(@RequestParam(required = false) Integer record, 
			@ModelAttribute("account") Account account , Model model) { 
		int numOfPage = 1;
		model.addAttribute(account); 
		if (record == null)
			model.addAttribute("Accounts", getRecord1to5());
		else {
			model.addAttribute("Accounts", getRecordLimitOff(record));
			numOfPage = record;
		} 
		model.addAttribute("numCountRows", accountSv.getCount());
		model.addAttribute("numPages", accountSv.getNumPagination());
		model.addAttribute("numOfPage", numOfPage);
		return "account/listaccount"; 
	}
	
	@RequestMapping(value = "/saveAccount", method = RequestMethod.POST)
	public String saveAccount(@RequestParam(required = false) Integer record,
			@ModelAttribute("account") Account account) {
		accountSv.save(account);
		return "redirect:/account/getList?record=" + record;
	}
	
	@RequestMapping(value ="/delete", method = RequestMethod.POST) 
	public String deleteAccount(@RequestParam int id,
			@RequestParam(required = false) Integer record) {
		System.out.println(id);
		 
		accountSv.deleteById(id);
		 
		return "Deleted account ID = "+id;
	}

	@RequestMapping("/edit")
	public String editAccount(@RequestParam int id,
			@RequestParam(required = false) Integer record,
			RedirectAttributes redirectAttrs) {

		redirectAttrs.addFlashAttribute(accountSv.getById(id));
		// redirectAttrs.addAttribute(account);
		return "redirect:/account/getList?record=" + record;
	}
	
	@RequestMapping("/vali")
	public String getVali() {

		 
		return "/account/html5";
	}

	
	public List<Account> getRecord1to5() {
		return accountSv.getAll();
	}

	public List<Account> getRecordLimitOff(int record) {
		int maxRows = 5;
		return accountSv.getLimit(maxRows, (record - 1) * maxRows);
	}
 
}
