# CRUD API for Eletronic Shop

This is a CRUD API that lists eletronic products aimling serve a Eletronic Shop Products.

To run the project, clone it to your local repository and use the command:

```rails s``` 

## Requirements

Each product should has name, details, category_id, measure_id, stock, value, highlight and an image field.

category_id and measure_id are references to Categories and Measures tables on SQLITE3.

## Routes

### GET - Returns all data on database.
All products: ```localhost:3000/products```
<br>
All measures: ```localhost:3000/measures```
<br>
All categories: ```localhost:3000/categories```

**Required header: application/json**
  
### GET - Filter params
You can use *by_name* and *order* params to get specific results from database.
<br>
- **by_name:** any string can be used here, if nothing were found at the database, an empty array should be returned.
- **order:** *asc* or *desc* can be used, the array will be sorted by the value key. The default value is *desc*.

**Required header: application/json**
```localhost:3000/products?by_name="example"&order=asc```

### POST - Creates a product in the database
Every post requisition should be made to ```localhost:3000/products``` with a object called *product* containing the following keys:

- name: string(required)
- details: string(optional)
- stock: integer (required)
- value: float (required)
- highlight: boolean (required)
- category_id: integer (required)
- measure_id: integer (required)
- image: file.png (optional)

**Required header: multipart/form-data**

### PATCH/PUT - Edits a product in the database
Every PATCH/PUT requisition should be made to ```localhost:3000/products/id``` with a object called *product* containing the following keys:

- name: string(required)
- details: string(optional)
- stock: integer (required)
- value: float (required)
- highlight: boolean (required)
- category_id: integer (required)
- measure_id: integer (required)
- image: file.png (optional)

Even if you didn't updated all fields, they should be send on the requisition, otherwise you'll receive a message of missing parameter.

**Required header: multipart/form-data**

### DELETE - delete a specific product in the database
Every DELETE requisition should be made to ```localhost:3000/products/id```.

**Required header: application/json**