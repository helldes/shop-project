package com.springapp.mvc.Entity;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by helldes on 22.02.2015.
 */
@Entity
@Table(name = "ORDER_DETAILS")
@AssociationOverrides({
        @AssociationOverride(name = "pk.product",
                joinColumns = @JoinColumn(name = "PRODUCT_ID")),
        @AssociationOverride(name = "pk.orders",
                joinColumns = @JoinColumn(name = "ORDER_ID")) })
public class OrderDetails implements Serializable {

    private OrderDetailsID pk = new OrderDetailsID();

    @Id
    @Column(name = "ID")
    private int id;

    @Column(name = "QUANTITY")
    private int quantity;

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    @EmbeddedId
    public OrderDetailsID getPk() {
        return pk;
    }

    public void setPk(OrderDetailsID pk) {
        this.pk = pk;
    }


    @Transient
    public Product getProduct(){
        return getPk().getProduct();
    }

    public void  setProduct(Product product){
        getPk().setProduct(product);
    }

    @Transient
    public Orders getOrders(){
        return  getPk().getOrders();
    }

    public void setOrders (Orders orders){
        getPk().setOrders(orders);
    }
}
