# Get the directory of the script
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

# Get the list of changed files in the current commit
$changedFiles = git diff --name-only HEAD~1 HEAD

# Filter test files for both Python and Java
$pythonTestFiles = $changedFiles | Where-Object { $_ -like "python/tests/test*.py" }
$javaTestFiles = $changedFiles | Where-Object { $_ -like "java/src/test/java/tests/*.java" }

# Base directories for the tests
$pythonBaseDir = Join-Path $scriptDir "python"
$javaBaseDir = Join-Path $scriptDir "java"

# Function to run Python tests
function Run-PythonTests($testFiles, $baseDir) {
    if ($testFiles.Count -gt 0) {
        Write-Host "Running Python tests for the following files:"
        foreach ($testFile in $testFiles) {
            $relativeTestFile = $testFile -replace "^python/", ""
            $absoluteTestFile = Join-Path $baseDir $relativeTestFile

            if (Test-Path $absoluteTestFile) {
                Write-Host "Running test: $absoluteTestFile"
                pytest $absoluteTestFile
            } else {
                Write-Host "Test file not found: $absoluteTestFile"
            }
        }
    } else {
        Write-Host "No Python test files were modified. Skipping Python test run."
    }
}

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
 
        # Change to the Java project directory
        Push-Location -Path (Join-Path $scriptDir "java")
 
        # Run Maven clean install with specific test classes, properly escaped
        $mvnCommand = "mvn clean install '-Dtest=$testClassesString'"
        Write-Host "Executing: $mvnCommand"
        Invoke-Expression $mvnCommand
 
        # Change back to the original directory after Maven finishes
        Pop-Location
 
        # Ensure we're back in the original script directory (selenium_template)
        Set-Location -Path $scriptDir
    } else {
        Write-Host "No Java test files were modified. Skipping Java test run."
    }
}


# Run Python tests
Run-PythonTests $pythonTestFiles $pythonBaseDir

# Run Java tests
Run-JavaTests $javaTestFiles