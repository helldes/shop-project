package com.springapp.mvc.Entity;


import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by helldes on 20.02.2015.
 */
@Entity
@Table(name = "BRAND")
public class Brand implements Serializable {
    @Id
    @GeneratedValue
    @Column(name = "BRAND_ID")
    private int id;

    @Column(name = "NAME")
    private String name;

    @OneToMany(mappedBy = "brand")
    private List<Product> products;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

}