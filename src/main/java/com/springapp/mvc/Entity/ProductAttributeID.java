package com.springapp.mvc.Entity;

import javax.persistence.Embeddable;
import javax.persistence.ManyToOne;

/**
 * Created by helldes on 21.02.2015.
 */
/*
public class ProductAttributeID implements Serializable {
    private int product_id;
    private  int attribute_id;

    public int hashCode() {
        return (int)(product_id + attribute_id);
    }

    public boolean equals(Object object) {
        if (object instanceof ProductAttributeID) {
            ProductAttributeID otherId = (ProductAttributeID) object;
            return (otherId.product_id == this.product_id) && (otherId.attribute_id == this.attribute_id);
        }
        return false;
    }
}
*/
@SuppressWarnings("serial")
@Embeddable
public class ProductAttributeID implements java.io.Serializable {

    private Product product;
    private Attribute attribute;

    @ManyToOne
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @ManyToOne
    public Attribute getAttribute() {
        return attribute;
    }

    public void setAttribute(Attribute attribute) {
        this.attribute = attribute;
    }
    @Override
    public int hashCode() {
        return (product.hashCode() + attribute.hashCode());
    }
    @Override
    public boolean equals(Object object) {
        if (object instanceof ProductAttributeID) {
            ProductAttributeID otherId = (ProductAttributeID) object;
            return (otherId.product == this.product) && (otherId.attribute == this.attribute);
        }
        return false;
    }
}