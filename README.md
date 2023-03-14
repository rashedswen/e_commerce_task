
#Introduction

A warehouse manager is facing difficulties properly tracking their inventory of goods coming in and out of their warehouse. You are asked to develop a mobile solution using Flutter that can efficiently solve this issue.

##User Stories

You should develop your solution to cover all of these requirements.

As a warehouse manager, I want to register items to my inventory system, so that I can use them to create transactions.
As a warehouse manager, I want to delete items from my inventory system, so that I can remove discontinued items.
As a warehouse manager, I want to create transactions (inbound or outbound) from the predefined items I added (user story #1).
As a warehouse manager, I want to search and filter my transactions based on:
Quantity
Date created
Type (inbound and outbound)
As a warehouse manager, I want to click a transaction to view the transaction details, so that I can be well informed about it.
Functional Requirements

Use Hive package to save and retrieve data. You may use the following structure for your models:
json
Copy code
"items": [
    {
      "id": 1,
      "name": "Barbican Beer Drink",
      "price": "92.61",
      "sku": "PRO-SA3",
      "description": "320 × 6 ml",
      "image": ""
    },
    {
      "id": 2,
      "name": "Afia Corn Oil",
      "price": "12.13",
      "sku": "PRO-SA2",
      "description": "6 x 320 ml",
      "image": ""
    }
],

"transactions": [
    {
      "id": 1,
      "type": "inbound",
      "itemId": 2,
      "quantity": 45,
      "inbound_at": "2012-02-27 11:00:00",
      "outbound_at": "2012-02-27 13:27:00"
    }
]
Use Flutter's provider for state management.
Without using a third-party package, develop a toast message (not snackBar) service to display to the user when they perform any CRUD action.
Write unit tests.
Use proper routing and screen management.
Create small, reusable components.
Screens

Using the design below, you are required to develop 3 main screens:

A transactions screen (main screen)
An items screen
A transaction details screen
Figma Link: https://www.figma.com/file/oYCQsSB9DX2MPNv8kGdsq5/Untitled?node-id=0%3A1

##To run the project locally, follow these steps:

Clone the repository to your local machine.
Open the project in your preferred IDE.
Install dependencies using flutter pub get.
Run the app using flutter run.
##Demo

![IMAGE 1444-08-22 04:48:35](https://user-images.githubusercontent.com/38612386/224871197-ebf03d5a-f168-4b69-92a6-8c10b3a6d41f.jpg)

![IMAGE 1444-08-22 04:49:19](https://user-images.githubusercontent.com/38612386/224871336-3a1f4e4c-36fb-4f48-a3f3-d7c41b44d731.jpg)

![IMAGE 1444-08-22 04:49:25](https://user-images.githubusercontent.com/38612386/224871348-bcba804a-aa42-43dc-a112-e84b30bd9e8f.jpg)
![IMAGE 1444-08-22 04:49:30](https://user-images.githubusercontent.com/38612386/224871361-5e65ee28-796a-4e52-adae-ef50e9883dd2.jpg)
