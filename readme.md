## Project Setup
### Install Java
You should have Java runtime (**>=1.7**) installed in your system and the java executable should be inside your **PATH**.

To verify your java is installed correctly, open a terminal/shell/cmd and execute following command:

    java -version

If the command gives output similar to following, then java is set up correctly.

    java version "1.8.0_45"
    Java(TM) SE Runtime Environment (build 1.8.0_45-b15)
    Java HotSpot(TM) 64-Bit Server VM (build 25.45-b02, mixed mode)

### Install Python
You need to install python in your system to use Robot libraries written using Python.
#### Windows
For windows, you should install **python3.8** version. You can download the installer from https://www.python.org/downloads/release/python-3810/. 
After installation is finished, you need to set the installation directory path in the file **config.txt** in the **scripts** folder.
#### Initial set up for Python Libraries
Run **python_robot_init.bat** under **scripts** folder. 
A folder named **pythonenv** will be created upon sucessful execution.
Beware, the script requires you to have internet connection to download required python package from pypi.

#### Start up RIDE
You can click **start_ride.bat** under **scripts** folder to start RIDE.

## Project Structure

### Folders belong to automation kit project

**properties**: Stores property files required for Robot libraries and variable files used in test suites. It's recommended to use yaml format for variable files.

**testdata**: Stores data files for test suites. Should include feed data, input data for test cases, etc.

**testsuite**: Stores test suites. Test suites stored as files should use **.robot** as suffix.

### Folders generated from nxl-robot-libraries project

**lib**: The lib folder stores Java Robot Libraries. (jars)

**libdoc**: Stores documentation files for Robot Libraries. HTML files and Markdown files are for human read, xml files are for RIDE keyword auto completion.

**pythonenv**: Generated by **python_robot_init.bat** script, stores python runtime for RIDE.

**resources**: Stores some common resource files (contain keywords).

**results**: The default location used by **run_test** script for storing test results.

**scripts**: Stores necessary scripts.

## Useful Docs or Links

* Under **libdoc** folder, the **lib_readme.md** contains descriptions for included robot libraries.
* [Robot Framework official website](http://robotframework.org/)
  - [User Guide](http://robotframework.org/robotframework/#user-guide)
  - [Quick Start Guide](https://github.com/robotframework/QuickStartGuide/blob/master/QuickStart.rst)
* [Code Centric Blog](https://blog.codecentric.de/en) You can search Robot Framework to get relevant blogs.

## Best Practice for Writing Test Cases

You are strongly recommended to read and follow the practices described in articles listed below:

* [How To Write Good Test Cases from Robot framework wiki](https://code.google.com/p/robotframework/wiki/HowToWriteGoodTestCases).
* [Writing Maintainable Automated
Acceptance Tests](http://dhemery.com/pdf/writing_maintainable_automated_acceptance_tests.pdf)
* [Anatomy of a good acceptance test](http://gojko.net/2010/06/16/anatomy-of-a-good-acceptance-test/)

# Robot Framework Documentation

## 1. Run test cases
#### 1.1 Jython Robot: the script within the folder ```C:\Users\lqin\workspace\QA-Automation\automation-kit\scripts``` 
> This should be used for any test cases that uses Java libraries, e.g. NXLPDP
```
    run_tests.bat -option test_cases\suites
```
#### 2.2 Python robot: Use the script within the folder ```C:\Users\lqin\workspace\QA-Automation\automation-kit\pythonenv\Scripts```
> This should be used for any test cases that use only python libraries, e.g. RequestsLibrary
```
    robot.bat -option test_cases\suites
```

## 2. Ways to select test cases
#### 2.1 By name of test suites and test cases
Test suites and test cases can be selected by their names with the command line options --suite (-s) and --test (-t), respectively. Both of these options can be used several times to select several test suites or cases. Arguments to these options are case- and space-insensitive, and there can also be simple patterns matching multiple names. If both the --suite and --test options are used, only test cases in matching suites with matching names are selected.
```--test example
    --test mytest --test yourtest
    --test example*
    --test mysuite.mytest
    --test *.suite.mytest
    --suite example-??
    --suite mysuite --test mytest --test your*
```

#### 2.2 By directory
When given a path to folder as option, all test cases within the folder will be executed in sequence determined in the directory.
```
    --suite C:\Users\lqin\workspace\QA-Automation\automation-kit\testsuite\01__Console\02__Api
```
#### 2.3 By tag names
It is possible to include and exclude test cases by tag names with the --include (-i) and --exclude (-e) options, respectively. If the --include option is used, only test cases having a matching tag are selected, and with the --exclude option test cases having a matching tag are not. If both are used, only tests with a tag matching the former option, and not with a tag matching the latter, are selected.
```
    --include <tag_name> e.g. --include Priority/1 
    --exclude <tag_name> e.g. --exclude Severity/Critical
```
Both --include and --exclude can be used several times to match multiple tags. In that case a test is selected if it has a tag that matches any included tags, and also has no tag that matches any excluded tags.
In addition to specifying a tag to match fully, it is possible to use tag patterns where * and ? are wildcards and AND, OR, and NOT operators can be used for combining individual tags or patterns together:
```
    --include fooANDbar e.g. --include Priority/1ANDMode/Full
    --exclude xxORyyORzz e.g. --exclude Priority/2ORMode/Full
    --include fooNOTbar  e.g. --include Priority/1NOTSeverity/Critical
```

## 3. Tags
> The list is a sample and to be revised.
~~~
    Priority: Priority of test cases or suites e.g. Priority/1
    Severity: Severity of test cases e.g. Severity/Critical
    Type: Type of test to be performed e.g. Type/Sanity, Type/Smoke
    Mode: Mode of test e.g. Mode/Full
~~~

## 4. User keywords management
>Location: Resources folder in the automation directory. In my case it is located at
``` 
    C:\Users\lqin\workspace\QA-Automation\automation-kit\resources
```
>To edit keywords in RIDE: Right click *External Resources*, then *add resources*, navigate to the resources folder to add.

>To use keywords: Click add resource to a test suite. 
```
    resource common_keywords.robot           #if placed right under resources folder
    resource common/comon_keywords.robot     #if contained in a sub-folder within resources
```

## 5. Variables management
Variables are stored in yaml format.
>Location: Property folder in the automation directory. In my case it is located at
``` 
    C:\Users\lqin\workspace\QA-Automation\automation-kit\properties
```

>To use these variables: Click add variables to a test suite. 
```
    Variables ${PROP_DIR}/variables/common_variables.yaml         
```
> If two variable are imported from two variable files. The first one will have preceedence over the rest. If two files are imported in the following order:
``` 
    Variables ..\\file1.yaml (containing variable ${name} = Steve Jobs)
    Variables ..\\file2.yaml (containing variable ${name} = LeBron James)
   ``` 
   The value assigned to ${name} will be "Steve Jobs"

## 6. Naming Conventions
>Suite Names: use the "lower_case_with_underscores".

>Test Steps: use the "Given/When/Then".

>Keyword Names: use the "Cap Words" style.

>Global General Variable Names: use the "${CapWords}".

>Page Elements Variable Names: use the "${CapWords Locator}". NOTE: the "Locator" includes "Locator", "ID", "Name", "Text", "Class", etc.