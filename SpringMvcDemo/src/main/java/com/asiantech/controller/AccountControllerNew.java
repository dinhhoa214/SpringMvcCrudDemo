package com.asiantech.controller;
 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;  
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
			@RequestParam(required = false) Integer maxRows,
			@ModelAttribute("account") Account account , Model model) { 
		  
		if (maxRows == null)
			maxRows = 5;
		if (record == null ){
			model.addAttribute("Accounts", accountSv.getLimit(maxRows, 0));
			record = 1;
		}
		else 
			model.addAttribute("Accounts", accountSv.getLimit(maxRows, (record -1)* maxRows)); 
		 
		model.addAttribute(account);
		model.addAttribute("maxRow", maxRows);
		model.addAttribute("numCountRows", accountSv.getCount());
		model.addAttribute("numPages", accountSv.getNumPagination(maxRows));
		model.addAttribute("numOfPage", record);
		return "account/listaccount"; 
	}
	
	@RequestMapping(value = "/saveAccount", method = RequestMethod.POST)
	public String saveAccount(@RequestParam(required = false) Integer record,
			@RequestParam(required = false) Integer maxRows,
			@ModelAttribute("account") Account account) {
		accountSv.save(account);
		return "redirect:/account/getList?record=" + record +"&maxRows=" + maxRows;
	}
	
	@RequestMapping(value ="/delete", method = RequestMethod.POST) 
	public int deleteAccount(@RequestParam int id) { 
		accountSv.deleteById(id); 
		return id;
	}

	@RequestMapping("/edit")
	public String editAccount(@RequestParam int id,
			@RequestParam(required = false) Integer record,
			@RequestParam(required = false) Integer maxRows,
			RedirectAttributes redirectAttrs) {

		redirectAttrs.addFlashAttribute(accountSv.getById(id));
		// redirectAttrs.addAttribute(account);
		return "redirect:/account/getList?record=" + record +"&maxRows=" + maxRows;
	}
	 

	 
 
}
