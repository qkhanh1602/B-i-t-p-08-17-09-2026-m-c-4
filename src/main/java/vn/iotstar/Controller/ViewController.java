package vn.iotstar.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {

    @GetMapping({"/", "/admin", "/admin/dashboard"})
    public String index() {
        return "redirect:/admin/category-ajax";
    }

    @GetMapping("/admin/category-ajax")
    public String categoryAjax() {
        return "admin/categories/ajax";
    }

    @GetMapping("/admin/product-ajax")
    public String productAjax() {
        return "admin/products/product-ajax";
    }
}
