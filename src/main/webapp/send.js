function getRows(event) {
    if (isValid()) {
        let data;
        data = {
            "X": 1, //$("form :radio[name=X]:checked").val(),
            "Y": $("#main_form").find('input[name=Y]').val(),
            "R": $("#main_form").find('input[name=R]').val()
        };
        console.log(data);
        $.ajax
        ({
            type: "POST",
            data: data,
            url: 'control',
            success: function (serverData) {
                console.log(serverData);
                newRow(serverData);
            }
        });
    }
}