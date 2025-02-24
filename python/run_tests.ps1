# Get the list of changed files in the current commit 
$changedFiles = git diff --name-only HEAD~1 HEAD 
 
# Filter Python test files 
$pythonTestFiles = $changedFiles | Where-Object { $_ -like "python/tests/test*.py" } 
 
# Correct base directory for Python tests (should be "python" only, no double 'python') 
$pythonBaseDir = "D:\Projects\selenium\python"  # Directly set the base directory to your root folder 
 
# Ensure the reports directory exists 
$pythonReportsDir = Join-Path $pythonBaseDir "reports" 
 
if (!(Test-Path $pythonReportsDir)) { 
    Write-Host "Creating Python reports directory: $pythonReportsDir" 
    New-Item -ItemType Directory -Path $pythonReportsDir 
} 
 
# Function to run Python tests and generate reports 
function Run-PythonTests($testFiles, $baseDir, $reportsDir) { 
    if ($testFiles.Count -gt 0) { 
        Write-Host "Running Python tests for the following files:" 
        foreach ($testFile in $testFiles) { 
            # Adjust path to avoid having "python" or "tests" twice 
            $relativeTestFile = $testFile -replace "^python/tests/", ""  # Remove the "python/tests/" prefix from the path 
 
            # Join it correctly with the base directory, no need for additional "tests" folder 
            $absoluteTestFile = Join-Path $baseDir "tests" $relativeTestFile 
            $testName = [System.IO.Path]::GetFileNameWithoutExtension($absoluteTestFile) 
 
            if (Test-Path $absoluteTestFile) { 
                Write-Host "Running test: $absoluteTestFile" 

                # Define report filenames 
                $reportFile = Join-Path $reportsDir "${testName}_report.xml" 
                $htmlReportFile = Join-Path $reportsDir "${testName}_report.html" 
 
                # Run pytest with JUnit XML report 
                pytest $absoluteTestFile --junitxml=$reportFile 
 
                # Convert XML report to HTML (if available) 
                if (Get-Command "junit2html" -ErrorAction SilentlyContinue) { 
                    junit2html $reportFile $htmlReportFile 
                    Write-Host "HTML report generated: $htmlReportFile" 
                } else { 
                    Write-Host "JUnit2HTML tool not found, skipping HTML conversion." 
                } 
            } else { 
                Write-Host "Test file not found: $absoluteTestFile" 
            } 
        } 
    } else { 
        Write-Host "No Python test files were modified. Skipping Python test run." 
    } 
} 
 
# Run Python tests and generate reports inside python/reports 
Run-PythonTests $pythonTestFiles $pythonBaseDir $pythonReportsDir