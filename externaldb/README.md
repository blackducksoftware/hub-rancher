# Deploying HUB on Rancher/Cattle with External Postgres Database

## Activate Rancher Secrets serivce for your environment

Rancher Secrets has to ve running in your environment. Secrets are going to be used to manage passwords necessary for authenticating with the database.

## Configure the external database instance

External database chould have blackduck user set up as adminstrator. It has to have Create Role and Create DB roles.


Execute database configuration script

'''
$ cat external-postgres-init.pgsql | psql -h hubdb.c7zis2ewum4b.us-east-1.rds.amazonaws.com -U blackduck postgres 
Password for user blackduck: 
CREATE DATABASE
CREATE DATABASE
CREATE DATABASE
CREATE ROLE
CREATE ROLE
You are now connected to database "bds_hub" as user "blackduck".
CREATE EXTENSION
CREATE SCHEMA
GRANT
GRANT
GRANT
ALTER DEFAULT PRIVILEGES
ALTER DEFAULT PRIVILEGES
You are now connected to database "bds_hub_report" as user "blackduck".
GRANT
ALTER DEFAULT PRIVILEGES
GRANT
ALTER DEFAULT PRIVILEGES
ALTER DEFAULT PRIVILEGES
You are now connected to database "bdio" as user "blackduck".
GRANT
$ 
'''

Log into the database and set passwords for blackduck_user and blackduck_reporter


## Optional restore database if necessary

## Prepare deployment files

Modify docker-compose.yml file to reflect database configuration


Set environment variabmes for webapp,   as following:

'''
      HUB_POSTGRES_ADMIN: blackduck
      HUB_POSTGRES_ENABLE_SSL: 'false'
      HUB_POSTGRES_HOST: <postgres FDQN goes here>
      HUB_POSTGRES_PORT: '5432'
      HUB_POSTGRES_USER: blackduck_user
'''


Create secrets with passwords for blackduck and blackduck_user
'''
      rancher secrets create HUB_POSTGRES_ADMIN_PASSWORD_FILE - <<< admin_user_password
      rancher secrets create HUB_POSTGRES_USER_PASSWORD_FILE - <<< hubuser_password
'''

Alternatively secrets could be created from Rancher UI

## Deploy stack using provided deployment files

