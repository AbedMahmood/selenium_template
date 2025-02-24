## Version Compatibilities

1) The python version is minimalist and stable. No unforseen compability issues arising. Using latest selenium and msedgedriver available for download as of February 2025.

2) For Java setup, the following are compatible jdk-1.8, selenium-java-4.9.1, TestNG-6.14.13, maven-3.9.9, maven-surefire-plugin-3.0.0-M5

## Extending
These are barebone projects, initial setup is complete, extend the project to suit your needs.

### Continuous Integration

> cd selenium_template

> .\run_tests.ps1

#### Running the application

1) Start server

> pip intall flask

> flask run

2) python 

> cd python 

> pip install -r requirements.txt

> pytest --junitxml=reports/report.xml

3) Java 

> cd java

> mvn clean install