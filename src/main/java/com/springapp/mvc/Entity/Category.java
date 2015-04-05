package com.springapp.mvc.Entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by helldes on 20.02.2015.
 */
@Entity
@Table(name = "CATEGORY")
public class Category implements Serializable {
    @Id
    @GeneratedValue
    @Column(name = "CATEGORY_ID")
    private int id;

    @Column(name = "NAME")
    private String name;

    @Column(name = "PARENT")
    private Category parent;

    @ManyToMany(cascade = {CascadeType.ALL})
    @JoinTable(name="CATEGORY_ATTRIBUTE",
            joinColumns={@JoinColumn(name="CATEGORY_ID")},
            inverseJoinColumns={@JoinColumn(name="ATTRIBUTE_ID")})
    private List<Attribute> attributes;

    @OneToMany(mappedBy = "category")
    private List<Product> products;

    public Category getParent() {
        return parent;
    }

    public void setParent(Category parent) {
        this.parent = parent;
    }

    public List<Attribute> getAttributes() {
        return attributes;
    }

    public void setAttributes(List<Attribute> attributes) {
        this.attributes = attributes;
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
