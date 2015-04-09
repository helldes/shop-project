package com.springapp.mvc.Entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by helldes on 20.02.2015.
 */
@Entity
@Table(name = "ATTRIBUTE")
public class Attribute implements Serializable {
    @Id
    @GeneratedValue
    @Column(name = "ATTRIBUTE_ID")
    private int id;

    @Column(name = "NAME")
    private String name;

    @Column(name = "SIZE")
    private String size;

    @Column(name = "DESCRIPTION")
    private String description;

    @OneToMany(mappedBy = "pk.attribute", fetch = FetchType.LAZY)
    private List<ProductAttribute> productAttributes;

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

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<ProductAttribute> getProductAttributes() {
        return productAttributes;
    }

    public void setProductAttributes(List<ProductAttribute> productAttributes) {
        this.productAttributes = productAttributes;
    }

}