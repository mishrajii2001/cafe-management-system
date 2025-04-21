package com.cafe.model;

public class MenuItem {
    private int itemId;
    private String itemName;
    private String category;
    private double price;

    // Existing constructor with ID
    public MenuItem(int itemId, String itemName, String category, double price) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.category = category;
        this.price = price;
    }

    // New constructor without ID (for demo/mock menu items)
    public MenuItem(String itemName, String category, double price) {
        this.itemName = itemName;
        this.category = category;
        this.price = price;
    }

    public int getItemId() { return itemId; }
    public String getItemName() { return itemName; }
    public String getCategory() { return category; }
    public double getPrice() { return price; }
}
