<%@page contentType="text/html" pageEncoding="UTF-8"
        language="java" import="java.util.List, java.util.ArrayList, Lab_2.AreaCheckServlet"
        session="true"
%>
<%@ page import="Lab_2.Point" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="js/click.js"></script>
    <script src="js/graph.js"></script>
    <script src="js/send.js"></script>
    <title>Lab work 2</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body >
<main>


<script>
    // здесь все относительно нормально


    function drawAllDots() {
        <%
            ArrayList history =(ArrayList) session.getAttribute("history");
            if(history!=null){
                for (Object item : history ) {
                    Point point = (Point) item;
        %>
        drawDot(<%=point.x%>, <%=point.y%>, <%=point.R%>, document.getElementById("R").value);
        <%
                }
            }
        %>
    }

</script>
    <header id="header">
        <div class="head">Группа P3212</div>
        <div class="head">Ибраимов Эдем, Морозов Иван</div>
        <div class="head">Вариант 40192</div>
    </header>

    <div class="wrapper">
        <div class="left-column">
            <canvas id="canvas" onclick="clickHandler(event)" width="400" height="400">
            </canvas>
        </div>
        <div class="right-column">
            <form id="main_form" method="post" onsubmit="return false;" >

                <p>Выберите X</p>
                <label>-2<input type="radio"   name="X" value="-2"></label>
                <label>-1.5<input type="radio"   name="X" value="-1.5"></label>
                <label>-1<input type="radio"  name="X" value="-1"></label>
                <label>-0.5<input type="radio"  name="X" value="-0.5"></label>
                <label>0<input type="radio"  name="X" value="0" checked></label>
                <label>0.5<input type="radio"  name="X" value="0.5"></label>
                <label>1<input type="radio"  name="X" value="1"></label>
                <label>1.5<input type="radio"  name="X" value="1.5"></label>
                <label>2<input type="radio"   name="X" value="2"></label>

                <br><br>
                <p>Выберите Y</p>
                <input type="text" name="Y" id="Y"  onchange="isValid();"  placeholder="{-3 .. 5}" />
                <br><br>


                <p>Выберите R</p>
                <button type="button" id="1" name="R" value="1" onclick="buttonClick(1)">1</button>
                <button type="button" id="2" name="R" value="2" onclick="buttonClick(2)">2</button>
                <button type="button" id="3" name="R" value="3" onclick="buttonClick(3)">3</button>
                <button type="button" id="4" name="R" value="4" onclick="buttonClick(4)">4</button>
                <button type="button" id="5" name="R" value="5" onclick="buttonClick(5)">5</button>

                <input id="R" name="R" type="hidden" value="nk">

                <script>
                    window.onload = function () {
                        drawGraph( document.getElementById("R").value);
                    }
                </script>

                <br><br>
                <div class="flex">
                    <input class="download" id="btn" onclick="getRows(event)" type="button"  value="Проверить">
                </div>
            </form>

        </div>
    </div>
    <div id="errors">

    </div>
    <div id="result_form">
        <table id='points'>
            <tbody>
            <tr>
                <th>X</th>
                <th>Y</th>
                <th>R</th>
                <th>Результат</th>
                <th>Время</th>
                <th>Время работы</th>
            </tr>
            </tbody>
                <%
                    if (history != null) {
                        Collections.reverse(history);
                        for (Object item : history ) {
                            Point point = (Point) item;
                %>
                <tr>
                    <td><%=point.x%></td>
                    <td><%=point.y%></td>
                    <td><%=point.R%></td>
                    <td><%=point.isInArea%></td>
                    <td><%=point.time%></td>
                    <td><%=point.execTime%></td>
                </tr>
                <%
                        }
                        Collections.reverse(history);
                    }
                %>
        </table>
    </div>
</main>

<script type="text/javascript">
    function buttonClick(id) {
        document.getElementById("errors").innerHTML = "";
        let i;
        for (i = 1; i <= 5; i++ ) {
            if (i === id) {
                document.getElementById(i).style.color = '#fc0707';
            } else {
                document.getElementById(i).style.color = '#000000';
            }
        }
        document.getElementById("R").value = document.getElementById(id).value;
        drawGraph(id);
    }
    function newRow(input) {
        let row = document.createElement("tr");
        let table = document.getElementById("points");
        let secondRow = table.children[1];
        table.insertBefore(row, secondRow);
        // Создаем ячейки в вышесозданной строке
        // и добавляем тd
        let td1 = document.createElement("td");
        let td2 = document.createElement("td");
        let td3 = document.createElement("td");
        let td4 = document.createElement("td");
        let td5 = document.createElement("td");
        let td6 = document.createElement("td");

        row.appendChild(td1);
        row.appendChild(td2);
        row.appendChild(td3);
        row.appendChild(td4);
        row.appendChild(td5);
        row.appendChild(td6);
        // Наполняем ячейки
        td1.innerHTML = input["X"];
        td2.innerHTML = input["Y"];
        td3.innerHTML = input["R"];
        td4.innerHTML = input["result"];
        td5.innerHTML = input["time"];
        td6.innerHTML = input["work_time"];
    }
    function isValid () {
        let message;

        let Yinput = document.getElementById("Y");
        let Y = Yinput.value.replace(",", ".");
        document.getElementById("Y").value =  Y.toString();
        if (Y < -5 || Y > 5 || isNaN(Y) || Y == "" || Y.length > 7){
            message = "Некорректно задано значение Y";
        }
        if (message) {
            document.getElementById("errors").innerHTML = message;
            Yinput.style.backgroundColor = '#FF4136';
            setTimeout(function(){
                Yinput.value = "";
                Yinput.style.backgroundColor = 'white';}, 300);
            return false;
        } else {
            document.getElementById("errors").innerHTML = "";
            Yinput.style.backgroundColor = 'white';
            return true;
        }

    }

</script>
</body>

</html>
