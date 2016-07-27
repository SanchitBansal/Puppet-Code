# Puppet Code: Manifests and Modules
Every organization need some tool to manage their production from single source and there are many configuration management tool to solve make life easy. Puppet is one of them, and this repo has been created to share my puppet modules which could be useful for you.

## Hieradata
It is always a good practice to separate configuration data from code to make things easy. Here hieradata is segregating the same. We can make many different yaml files to define different values of variables for different environments. Here we have segregated yaml files based on OS environment.

>```To make it work, one need to define hierarchy in hiera.yaml```

## Manifests
Manifests are composed of puppet code having .pp as their extension. The default file is site.pp but to manage multiple environments/datacenters we can keep multiple site.pp with different names in version control system and then rename it while deploying code on production.

## Modules
It is considered best practice to use modules to organize almost all of your Puppet manifests. It has specific directory structure containing multiple manifests, facts, files, templates etc.

## Roles
Designing modules and including them directly to the nodes is the common flaw which most of the users do. This may work but when dealing with large and complex infrastructures this becomes cumbersome and you end up with a lot of node level logic in your manifests. It is always a best practice to make roles and assign them to node.

### Version
Puppet master - 4.3.2  
Puppet agent - 4.4.1
