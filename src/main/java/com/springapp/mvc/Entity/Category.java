package com.springapp.mvc.Entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "CATEGORY")
public class Category implements Serializable {
    @Id
    @GeneratedValue
    @Column(name = "CATEGORY_ID")
    private int id;

    @Column(name = "NAME")
    private String name;

    @Column(name = "PARENT", columnDefinition = "LONGBLOB")
    private Category parent;

    @OneToMany(mappedBy = "category")
    private List<Product> products;

    public Category getParent() {
        return parent;
    }

    public void setParent(Category parent) {
        this.parent = parent;
    }

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
