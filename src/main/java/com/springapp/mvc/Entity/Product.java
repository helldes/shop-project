package com.springapp.mvc.Entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by helldes on 20.02.2015.
 */
@Entity
@Table(name = "PRODUCT")
public class Product implements Serializable {
    @Id
    @GeneratedValue
    @Column(name = "PRODUCT_ID")
    private int id;

    @Column(name = "NAME")
    private String name;

    @ManyToOne
    @JoinColumn(name = "CATEGORY")
    private Category category;

    @Column(name = "DESCRIPTION")
    private String description;

    @ManyToOne
    @JoinColumn(name = "BRAND")
    private Brand brand;

    @JoinColumn(name = "PRICE")
    private Double price;

    @JoinColumn(name = "IMAGE_NAME")
    private String imageName;

    @JoinColumn(name = "CODE")
    private String code;

    @JoinColumn(name = "DISABLE")
    private Boolean disable;

    @OneToMany(mappedBy = "pk.product", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<ProductAttribute> productAttributes;

    @OneToMany(mappedBy = "pk.product", fetch = FetchType.LAZY)
    private List<OrderDetails> orderDetailses;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Boolean getDisable() {
        return disable;
    }

    public void setDisable(Boolean disable) {
        this.disable = disable;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public List<ProductAttribute> getProductAttributes() {
        return productAttributes;
    }

    public void setProductAttributes(List<ProductAttribute> productAttributes) {
        this.productAttributes = productAttributes;
    }

    public List<OrderDetails> getOrderDetailses() {
        return orderDetailses;
    }

    public void setOrderDetailses(List<OrderDetails> orderDetailses) {
        this.orderDetailses = orderDetailses;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}