package com.springapp.mvc.controller;

import com.springapp.mvc.DTO.*;
import com.springapp.mvc.Entity.*;
import com.springapp.mvc.Service.Interface.*;
import ma.glasnost.orika.MapperFacade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

/**
 * Created by helldes on 27.02.2015.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    CategoryService categoryService;

    @Autowired
    UserService userService;

    @Autowired
    RoleService roleService;

    @Autowired
    ProductService productService;

    @Autowired
    BrandService brandService;

    @Autowired
    ProductAttributeService productAttributeService;

    @Autowired
    AttributeService attributeService;

    @Autowired
    MapperFacade mapper;

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String admin_jsp(ModelMap model) {
        model.addAttribute("title", "Spring Security Custom Login Form");
        model.addAttribute("message", "This is protected page!");
        return "admin";
    }

/////////////////  CATEGORY
/*
    @RequestMapping(value = "/category_add", method = RequestMethod.POST)
    public String addCategory(
            @RequestBody CategoryDTO dto
    ) {

        Category category = mapper.map(dto, Category.class);
        if (dto.getParent() == 0){
            dto.setParent();
        }
        categoryService.create(mapper.map(dto, Category.class));
        return "redirect:/login/main";
    }
*/

    @RequestMapping(value = "/category_add", method = RequestMethod.POST)
    public String addCategory(
            @RequestParam String name,
            @RequestParam int parent
    ) {
        Category category = new Category();
        category.setName(name);
        if (parent != 0) {
            Category parentCategory = categoryService.read(parent);
            category.setParent(parentCategory);
        }
        categoryService.create(category);
        return "redirect:/login/main";
    }

    @RequestMapping(value = "/category_get", method = RequestMethod.GET)
    public String Category(ModelMap model) {
        model.addAttribute("categorys", categoryService.getCategories());
        return "category";
    }

    @RequestMapping(value = "/category_delete", method = RequestMethod.POST)
    public String deleteCategory(
            @RequestParam int idCategory
    ) {
        categoryService.delete(categoryService.read(idCategory));
        return "redirect:/login/main";
    }

    @RequestMapping(value = "/category_edit", method = RequestMethod.POST)
    public String editCategory(
            @RequestBody CategoryDTO dto
    ) {
        categoryService.update(mapper.map(dto, Category.class));
        return "redirect:/login/main";
    }

///////////////// USER

    @RequestMapping(value = "/user_edit", method = RequestMethod.POST)
    public String editUser(
            @RequestBody UserDTO dto
    ) {
        User user = mapper.map(dto, User.class);
        user.setPassword(userService.read(user.getId()).getPassword());
        user.setDisable(userService.read(user.getId()).getDisable());
        userService.update(user);
        return "redirect:/login/main";
    }

    @RequestMapping(value = "/user_disable", method = RequestMethod.POST)
    public String deleteUser(
            @RequestParam int idUser
    ) {
        User user = userService.read(idUser);
        if (user.getDisable()) {
            user.setDisable(false);
        } else {
            user.setDisable(true);
        }
        userService.disableUser(user);
        return "redirect:/login/main";
    }

    @RequestMapping(value = "/user_get", method = RequestMethod.GET)
    public String user(ModelMap model) {
        model.addAttribute("users", userService.getUsers());
        model.addAttribute("roles", roleService.getRoles());
        return "user";
    }

/////////////////   PRODUCT

    @RequestMapping(value = "/product_add", method = RequestMethod.POST)
    public String addProduct(
            @RequestParam String addCodeProductModal,
            @RequestParam String addNameProductModal,
            @RequestParam int addCategoryProductModal,
            @RequestParam String addDescriptionProductModal,
            @RequestParam Double addPriceProductModal,
            @RequestParam int addBrandProductModal,
            @RequestParam MultipartFile addFileProductModal,
            @RequestParam int addAttributeProductModal,
            @RequestParam int addCountProductModal,
            HttpServletRequest request
    ) {

        Product product = new Product();
        product.setCode(addCodeProductModal);
        product.setName(addNameProductModal);
        product.setCategory(categoryService.read(addCategoryProductModal));
        product.setDescription(addDescriptionProductModal);
        product.setPrice(addPriceProductModal);
        product.setBrand(brandService.read(addBrandProductModal));
        product.setDisable(false);
        try {
            byte[] bytes = addFileProductModal.getBytes();
            // Create the file on server
            String path = request.getSession().getServletContext().getRealPath("/sources")+"\\img\\";
            File serverFile = new File(path + addCodeProductModal + ".jpg" );
            BufferedOutputStream stream = new BufferedOutputStream(
                    new FileOutputStream(serverFile));
            stream.write(bytes);
            stream.close();
        } catch (Exception e) {
            return "You failed to upload " + addCodeProductModal + " => " + e.getMessage();
        }
        productService.create(product);
        ProductAttribute productAttribute = new ProductAttribute();
        productAttribute.setAttribute(attributeService.read(addAttributeProductModal));
        productAttribute.setValue(addCountProductModal);
        productAttribute.setProduct(product);
        productAttributeService.create(productAttribute);
        return "redirect:/login/main";
    }

    @RequestMapping(value = "/product_details/{id}", method = RequestMethod.GET)
    public @ResponseBody int ProductDetails(@PathVariable int id,
                                 ModelMap model) {
        model.addAttribute("attributes", attributeService.getAttributes());
        model.addAttribute("brands", brandService.getBrands());
        model.addAttribute("categorys", categoryService.getCategories());
        model.addAttribute("products", productService.getProducts());
        model.addAttribute("productAttribute",productAttributeService.getProductAttributeByProduct(productService.read(id)));
        ProductAttribute pa = productAttributeService.getProductAttributeByProduct(productService.read(id));

        return pa.getValue();
    }

    @RequestMapping(value = "/product_get", method = RequestMethod.GET)
    public String Product(ModelMap model) {
        model.addAttribute("attributes", attributeService.getAttributes());
        model.addAttribute("brands", brandService.getBrands());
        model.addAttribute("categorys", categoryService.getCategories());
        model.addAttribute("products", productService.getProducts());
    //    model.addAttribute("productAttribute",productAttributeService.getAll());
        return "product";
    }
/*
    @RequestMapping(value = "/product_editAttribute", method = RequestMethod.POST)
    public String addAttributeInProduct(
            @RequestParam int idProduct,
            @RequestParam int attributeProductModal,
            @RequestParam int attributeValueProductModal
    ) {
        Product product = productService.read(idProduct);
        if (attributeProductModal != 0) {
            Attribute attribute = attributeService.read(attributeProductModal);
            ProductAttribute productAttribute = productAttributeService.getProductAttributeByProduct(product);
            for (ProductAttribute productAttribute : listProductAttribute){
                if(productAttribute.getAttribute().equals(attribute)){
                    productAttribute.setValue(attributeValueProductModal);
                    productAttributeService.update(productAttribute);
                    return "redirect:/login/main";
                }
            }
            ProductAttribute productAttribute = new ProductAttribute();
            productAttribute.setProduct(product);
            productAttribute.setAttribute(attributeService.read(attributeProductModal));
            productAttribute.setValue(attributeValueProductModal);
            productAttributeService.create(productAttribute);
        }
        return "redirect:/login/main";
    }
*/
    @RequestMapping(value = "/product_delete", method = RequestMethod.POST)
    public String deleteProduct(
            @RequestParam int idProduct,
            @RequestParam String _csrf
    ) {
        productService.delete(productService.read(idProduct));
        return "redirect:/login/main";
    }

    @RequestMapping(value = "/product_edit", method = RequestMethod.POST)
    public String editProduct(
            @RequestBody ProductDTO dto
            ){
        ProductAttribute productAttribute =
                productAttributeService.getProductAttributeByProduct(productService.read(dto.getId()));
        productAttribute.setValue(dto.getCount());
        productService.update(mapper.map(dto, Product.class));
        productAttributeService.update(productAttribute);
        return "redirect:/login/main";
    }

/////////////////   BRAND

    @RequestMapping(value = "/brand_add", method = RequestMethod.POST)
    public  String addBrand(
            @RequestBody BrandDTO dto
    ) {
        brandService.create(mapper.map(dto, Brand.class));
        return "redirect:/login/main";
    }

    @RequestMapping(value = "/brand_get", method = RequestMethod.GET)
    public String Brand(ModelMap model) {
        model.addAttribute("brands", brandService.getBrands());
        return "brand";
    }

    @RequestMapping(value = "/brand_delete", method = RequestMethod.POST)
    public String deleteBrand(
            @RequestParam int idBrand
    ) {
        brandService.delete(brandService.read(idBrand));
        return "redirect:/login/main";
    }

    @RequestMapping(value = "/brand_edit", method = RequestMethod.POST)
    public String editBrands(
            @RequestBody BrandDTO dto
    ) {
        brandService.update(mapper.map(dto, Brand.class));
        return "redirect:/login/main";
    }

///////////////// CATEGORY

@RequestMapping(value = "/attribute_add", method = RequestMethod.POST)
public String addAttribute(
        @RequestBody AttributeDTO dto
) {
    attributeService.create(mapper.map(dto, Attribute.class));
    return "redirect:/login/main";
}

    @RequestMapping(value = "/attribute_get", method = RequestMethod.GET)
    public String attribute(ModelMap model) {
        model.addAttribute("attributes", attributeService.getAttributes());
        return "attribute";
    }

    @RequestMapping(value = "/attribute_delete", method = RequestMethod.POST)
    public String deleteAttribute(
            @RequestParam int idAttribute
    ) {
        attributeService.delete(attributeService.read(idAttribute));
        return "redirect:/login/main";
    }

    @RequestMapping(value = "/attribute_edit", method = RequestMethod.POST)
    public String editAttribute(
            @RequestBody AttributeDTO dto
    ) {
        attributeService.update(mapper.map(dto, Attribute.class));
        return "redirect:/login/main";
    }


}
