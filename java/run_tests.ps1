# Get the directory of the script (now running from selenium_template/java/) 
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent 
 
# Move one level up to selenium_template 
$rootDir = Split-Path -Path $scriptDir -Parent 
 
# Get the list of changed files in the current commit (relative to selenium_template) 
$changedFiles = git -C $rootDir diff --name-only HEAD~1 HEAD 
 
# Filter test files for Java 
$javaTestFiles = $changedFiles | Where-Object { $_ -like "java/src/test/java/tests/*.java" } 
 
# Function to run Java tests 
function Run-JavaTests($testFiles) { 
    if ($testFiles.Count -gt 0) { 
        Write-Host "Running Java tests for the following files:" 
        $testClasses = @() 
        foreach ($testFile in $testFiles) { 
            $className = ($testFile -replace "^java/src/test/java/", "" -replace ".java$", "" -replace "/", ".") 
            $testClasses += $className 
            Write-Host "Will run test: $className" 
        } 
 
        $testClassesString = $testClasses -join "," 
 
        # Run Maven clean install with specific test classes, properly escaped 
        $mvnCommand = "mvn clean install '-Dtest=$testClassesString'" 
        Write-Host "Executing: $mvnCommand" 
        Invoke-Expression $mvnCommand 
 
        # Ensure we're back in the original script directory (selenium_template/java) 
        Set-Location -Path $scriptDir 
    } else { 
        Write-Host "No Java test files were modified. Skipping Java test run." 
    } 
} 
 
# Run Java tests 
Run-JavaTests $javaTestFiles