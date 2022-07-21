# Merchant-Disbursement-service

Provides functionality to calculate merchant disbursements on a weekly basis. Futhermore, a restful API-endpoint to query weekly merchant disbursements is also provided. 

## Requirements 

1. Ruby 2.6.6 
2. Rails 6.0.1
3. postgresql 

## How to run 

### Docker 

This app is dockerized to enable both ease of installation and execution on either Linux, mac or windows. To install/run on Linux, make sure to have both docker and docker-compose installed on your machine and follow the instructions below:

1. $ git clone https://github.com/harryobas/merchant-disbursement-service.git
2. $ cd merchant-disbursement-service
3. $ sudo docker-compose build
4. $ sudo docker-compose up -d
5. $ sudo docker-compose exec web rails db:seed


## API Endpoint(s) 

### `GET /disbursements/search`: search merchant disbursements
   - Request body:

  ```
  {
    "merchant_id": string,
    "week": string  
   }

  ```
  - Response

    - 200 Ok
    ```
     { 
       "id": integer
       "amount": number,
       "fee": number,
       "week": integer, 
       "merchant_id": integer
     }
    ```

## Addendum 

### Testing with httpie 

- Search/query merchant disbursements for a given week

```
http GET localhost:3000/disbursements/search \
merchant_id=1
week=3

```
