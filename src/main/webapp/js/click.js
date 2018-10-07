// обработка нажатия на картинку - все работает
function clickHandler(event){
    var x = event.pageX;
    var y = event.pageY;

    var canvas = document.getElementById("canvas");
    var canvasRect = canvas.getBoundingClientRect();
    var headerRect = document.getElementById("header").getBoundingClientRect();

    var r = document.getElementById("R").value;

    if ($("#main_form").find('input[name=R]').val() === "nk") {
        document.getElementById("errors").innerHTML = "Не указан радиус";
        return;
    }
    if(isFinite(+r)){
        // Coordinates for a plot
        let xP = ((x-canvasRect.left)-canvasRect.width/2);
        let yP = (canvasRect.height/2-((y-canvasRect.top+headerRect.top)));

        let xCoordinate = (4*r*xP/canvasRect.width).toFixed(3);
        let yCoordinate = (4*r*yP/canvasRect.height).toFixed(3);

        drawDot(xCoordinate, yCoordinate, r, r);

        $.ajax
        ({
            type: "POST",
            data:{
                "X": xCoordinate,
                "Y": yCoordinate,
                "R": r
            },
            url: 'control',
            success: function (serverData) {
                newRow(serverData);
            }
        });


    }
}
