function getRows(event) {
    if (isValid()) {
        if ($("#main_form").find('input[name=R]').val() === "nk") {
            document.getElementById("errors").innerHTML = "Не указан радиус";
            return false;
        }
        let data;
        data = {
            "X": $("form :radio[name=X]:checked").val(),
            "Y": $("#main_form").find('input[name=Y]').val(),
            "R": $("#main_form").find('input[name=R]').val()
        };
        $.ajax
        ({
            type: "POST",
            data: data,
            url: 'control',
            success: function (serverData) {
                newRow(serverData);
            }
        });
    }
}