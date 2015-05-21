# SpringMvcCrudDemo
vì răng những đoạn như này
[5:09:11 PM] luong bang nguyen: List<Account> accountList = accountSv.getAll();  
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("Accounts", accountList);
		map.put("account", account);
		map.put("numRows", accountSv.getCount());
		map.put("numPages", getPagesIndex()); 
		return new ModelAndView("index", "map", map);
[5:09:25 PM] luong bang nguyen: em không tách thành một hàm và sử dụng lại nhiều lần
[5:11:43 PM] luong bang nguyen: @RequestParam(required=false) em có thể sử dụng cái này
[5:12:12 PM] luong bang nguyen: ví dụ như cái record không nhất thiết người dùng phải nhập
[5:12:46 PM] luong bang nguyen: @ModelAttribute("person")
public Person getPerson(){
    return new Person();
}
[5:13:13 PM] luong bang nguyen: em có thể sử dụng  @ModelAttribute như thế này để giúp khởi tạo
[5:13:51 PM] luong bang nguyen: mà không cần phải truyền @ModelAttribute("account") Account account khi gọi getAccountList
[5:14:46 PM] luong bang nguyen: phân trang hay bất kể dữ nào cần thiết cho việc gọi lần đầu tiên em nên tách ra một hàm để dùng lại
[5:14:54 PM] luong bang nguyen: có gì thì chỉ sửa lại trong hàm đó mà thôi
