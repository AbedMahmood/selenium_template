function showAlert() {
    alert("This is a test alert!");
}
function changeText() {
    document.getElementById("dynamic-text").innerText = "Text Changed!";
}

document.getElementById("test-form").addEventListener("submit", async function(event) {
    event.preventDefault(); // Prevent the default form submission

    const formData = {
        username: document.getElementById("username").value,
        password: document.getElementById("password").value,
        email: document.getElementById("email").value
    };

    try {
        const response = await fetch("/submit", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(formData)
        });

        const result = await response.json();

        // Display result message
        alert(result.message);
    } catch (error) {
        alert("An error occurred. Please try again.");
    }
});