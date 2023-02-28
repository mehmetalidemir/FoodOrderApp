# Getir Sepeti
 
<p align="center">
  <a href="https://github.com/mehmetalidemir/FoodOrderApp">
    <img src="https://i.imgur.com/H6gJa7v.png" alt="Logo" width="100" height="100">
  </a>
  <h3 align="center">Food Order App</h3>
  </p>
</p>


## Table Of Contents

* [About the Project](#about-the-project)
* [Features](#features)
* [Video](#video)
* [Built With](#built-with)
* [Web Services](#web-services)

## About The Project

This application is a food ordering application that allows users to browse. The app uses a remote database accessible via web services to retrieve information about available dishes and their prices. Users can add meals to their shopping cart, adjust the quantity, and remove them from the cart. The app also features a search function to help users quickly find the desired meal.

## Features
The application includes the following features:

* Listing meals
* Viewing meal details
* Selecting meal quantity
* Adding meals to the cart
* Viewing the contents of the cart
* Removing meals from the cart

## Video

https://user-images.githubusercontent.com/64283995/221839866-c46e8d74-1caa-44da-81af-b2d261803cc7.mov

## Built With

This application was built using Swift and storyboard for the user interface design. It utilizes the VIPER architecture pattern to organize the code and ensure scalability and maintainability. The app also includes localization functionality for multiple languages.

To retrieve and manipulate data, the project uses web services hosted online. The APIs are accessed through ready-made web services, and the app consumes their JSON responses to display the required information. The images for the food items are also hosted online and can be accessed through their respective URLs.


## Web Services

The application uses the following web services to interact with the online database:

* Get all meals: http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php
* Add a meal to the cart: http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php
* Get meals in the cart: http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php
* Remove a meal from the cart: http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php
* Get meal images: http://kasimadalan.pe.hu/yemekler/resimler/{meal_image_name}






