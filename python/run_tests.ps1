# Generate reports for each test suite 
Get-ChildItem -Path tests -Filter "*.py" | ForEach-Object { 
    $test_name = $_.BaseName 
    $report_name = "reports/${test_name}_report.xml" 
    $html_report_name = "reports/${test_name}_report.html" 

    # Skip generating report for __init__test.xml 
    if ($test_name -ne "__init__") { 
        # Run pytest and generate XML report 
        pytest $_.FullName --junitxml=$report_name 

        # Convert XML report to HTML 
        junit2html $report_name $html_report_name 
    } 
    else { 
        Write-Host "Skipping report generation for '__init__' test." 
    } 
}