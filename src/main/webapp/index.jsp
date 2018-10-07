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
    <title>php + js</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body >
<main>
    <header>
        <div class="head">Группа P3212</div>
        <div class="head">Ибраимов Эдем</div>
        <div class="head">Вариант 28205</div>
    </header>

    <div class="wrapper">
        <div class="left-column">
            <img id="img_task" src="img/areas.png">
            <canvas id="graph">

            </canvas>

        </div>
        <div class="right-column">
            <%--action="control" method="get" onsubmit="return isValid();"--%>
            <form id="main_form"  >

                <p>Выберите X</p>
                <label>-4<input type="radio"   name="X" value="-2"></label>
                <label>-3<input type="radio"   name="X" value="-1.5"></label>
                <label>-2<input type="radio"  name="X" value="-1"></label>
                <label>-1<input type="radio"  name="X" value="-0.5"></label>
                <label>0<input type="radio"  name="X" value="0" checked></label>
                <label>1<input type="radio"  name="X" value="0.5"></label>
                <label>2<input type="radio"  name="X" value="1"></label>
                <label>3<input type="radio"  name="X" value="1.5"></label>
                <label>4<input type="radio"   name="X" value="2"></label>

                <br><br>
                <p>Выберите Y</p>
                <input type="text" name="Y" id="Y"  onchange="return isValid();"  placeholder="{-3 .. 5}" />
                <br><br>


                <p>Выберите R</p>
                <button type="button" id="1" name="R" value="1" onclick="buttonClick(1)">1</button>
                <button type="button" id="2" name="R" value="2" onclick="buttonClick(2)">2</button>
                <button type="button" id="3" name="R" value="3" onclick="buttonClick(3)">3</button>
                <button type="button" id="4" name="R" value="4" onclick="buttonClick(4)">4</button>
                <button type="button" id="5" name="R" value="5" onclick="buttonClick(5)">5</button>


                <label for="R"></label>
                <input id="R" type="text" name="R" hidden><br>

                <br><br>
                <div class="flex">
                    <input class="download" id="btn" type="submit"   value="Проверить">
                    <input class="download" id="cancel" type="submit"    value="Очистить">

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
            <%--<jsp:useBean id='myAttribute' class='Lab_2.AreaCheckServlet' scope='session'/>--%>
                <%
                    ArrayList history =(ArrayList) session.getAttribute("history");
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
                    <td>2121</td>
                    <td>1212</td>
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
        let i;
        for (i = 1; i <= 5; i++ ) {
            if (i === id) {
                document.getElementById(i).style.color = '#fc0707';
                document.getElementById(i).style.background = '#ffffff';
            } else {document.getElementById(i).style.color = '#000000';}
        }
        document.getElementById("R").value = document.getElementById(id).value;
    }

    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('cancel').addEventListener('click', function(e){
            e.preventDefault();
            clear();
            location.reload();
            return false;
        });
    });
    function clear() {
        let req = new XMLHttpRequest;
        req.open('POST','clear.php');
        req.send(null);
    }

    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('btn').addEventListener('click', function (e) {
            e.preventDefault();
            if (isValid()) {
                let data;
                data = {
                    "X": $("form :radio[name=X]:checked").val(),
                    "Y": $("#main_form").find('input[name=Y]').val(),
                    "R": $("#main_form").find('input[name=R]').val()
                };
                console.log("sds");
                $.ajax
                ({
                    type: "POST",
                    data: data,
                    url: 'control',
                    success: function (serverData) {
                       // console.log(serverData);
                        newRow(serverData);
                    }
                });
            }
        });
    });

    function submit(e) {
        e.preventDefault();
        if (isValid()) {
            let data;
            data = {
                "X": $("form :radio[name=X]:checked").val(),
                "Y": $("#main_form").find('input[name=Y]').val(),
                "R": $("form :radio[name=R]:checked").val()
            };
            fetch('control', { method: 'POST', body: data, credentials: 'include' })
                .then(function(response) {
                    if (response.status !== 200) {
                        console.log('любимый сервер вернул ' +  response.status);
                        return;
                    }
                    response.json().then(function(data) {
                        newRow(data);
                    });
                });
        }
        return false;
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
        if (Y < -5 || Y > 5 || isNaN(Y) || Y === "" || Y.length > 7){
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
