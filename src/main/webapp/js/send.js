function getRows() {
    if (isValid()) {
        if ($("#main_form").find('input[name=R]').val() === "nk") {
            document.getElementById("errors").innerHTML = "Не указан радиус";
            return false;
        }
        let x = $("form :radio[name=X]:checked").val();
        let y = $("#main_form").find('input[name=Y]').val();
        let R = $("#main_form").find('input[name=R]').val();

        let data = {
            "X": x,
            "Y": y,
            "R": R
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
        drawDot(x, y, R, R);
    }
}