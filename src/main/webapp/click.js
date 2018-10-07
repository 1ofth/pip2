// обработка нажатия на картинку - все работает
function clickHandler(event){
    var x = event.pageX;
    var y = event.pageY;

    var canvas = document.getElementById("canvas");
    var canvasRect = canvas.getBoundingClientRect();
    var headerRect = document.getElementById("header").getBoundingClientRect();

    var r = document.getElementById("R").value;

    if(!isFinite(+r)){
        // Coordinates can not be counted
        console.log("R is not entered!");
    } else {
        // Coordinates for a plot
        let xP = ((x-canvasRect.left)-canvasRect.width/2);
        let yP = (canvasRect.height/2-((y-canvasRect.top+headerRect.top)));

        let xCoordinate = (4*r*xP/canvasRect.width).toFixed(3);
        let yCoordinate = (4*r*yP/canvasRect.height).toFixed(3);
        console.log(xCoordinate + "  " + yCoordinate);

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
