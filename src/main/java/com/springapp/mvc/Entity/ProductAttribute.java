package com.springapp.mvc.Entity;

import javax.persistence.*;

/**
 * Created by helldes on 21.02.2015.
 */
/*
@Entity
@Table(name = "PRODUCT_ATTRIBUTE")
@IdClass(ProductAttributeID.class)
public class ProductAttribute {

    @Id
    private int product_id;

    @Id
    private int attribute_id;

    @Column(name = "VALUE")
    private String value;

    @ManyToOne
    @PrimaryKeyJoinColumn(name = "PRODUCT_ID", referencedColumnName = "PRODUCT_ID")
    private Product product;

    @ManyToOne
    @PrimaryKeyJoinColumn(name = "ATTRIBUTE_ID", referencedColumnName = "ATTRIBUTE_ID")
    private Attribute attribute;
}
*/
@Entity
@Table(name = "PRODUCT_ATTRIBUTE")
@AssociationOverrides({
        @AssociationOverride(name = "pk.product",
                joinColumns = @JoinColumn(name = "PRODUCT_ID")),
        @AssociationOverride(name = "pk.attribute",
                joinColumns = @JoinColumn(name = "ATTRIBUTE_ID")) })
public class ProductAttribute implements java.io.Serializable{

    private ProductAttributeID pk = new ProductAttributeID();

    @Column(name = "VALUE")
    private int value;

    @EmbeddedId
    public ProductAttributeID getPk() {
        return pk;
    }

    public void setPk(ProductAttributeID pk) {
        this.pk = pk;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    @Transient
    public Product getProduct(){
        return getPk().getProduct();
    }

    public void  setProduct(Product product){
        getPk().setProduct(product);
    }

    @Transient
    public Attribute getAttribute(){
        return  getPk().getAttribute();
    }

    public void setAttribute(Attribute attribute){
        getPk().setAttribute(attribute);
    }
}