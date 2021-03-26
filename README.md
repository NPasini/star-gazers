# Star Gazers Application

This iOS Application display the list of Star Gazers of a selected repository. 

## Getting Started

To get the most updated version of the code, download the last commit in the master branch.

### Prerequisites

This project has been created using XCode 12.4.

## Organization of the Project

gazers is the main target, which is structured in the following way:

* Page Folder: this folder contain all the files related to the pages (repository selector page and star gazers list page) here you can find ViewControllers, ViewModels, Views and all related files;
* Dependency Injection: is the folder containing the definitions of the services that will be injected and their registration;
* API: contains the implementation of the service called to retrieve the data;
* Service: this folder contains the implementation of the Network Connection Service which monitors the availability of the network connection and teh Navigation service which enables the navigation between scrreens;
* Utilities: in this folder you can find some Extensions, the definition of the Errors used and protocols.

The Test targets for Unit tests and UI tests contains several test for the pages and the logics implemented.

## Dependencies ##
The dependencies are managed using both CocoaPods and Swift Package Manager. The dependencies used are:

* [OSLogger](https://github.com/NPasini/OSLogger): which contains my custom implementation of a logger based on os.log;
* [Network Manager](https://github.com/NPasini/NetworkManager): which is my custom implementation of the Network Manager based on URLSession.
* ReactiveSwift
* ReactiveCocoa;
* SDWebImage;
* Swinject;
* Quick;
* Nimble.

## Author ##

**Nicolò Pasini**



