<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="javascript">
            function validateForm()
            {
            	if(confirm("Báº¥m vÃ o nÃºt OK Äá» tiáº¿p tá»¥c") == true){
                    document.getElementById("demo").innerHTML = 
                    "Báº¡n muá»n tiáº¿p tá»¥c";
                    return true;
                }
            	else{
                    document.getElementById("demo").innerHTML = 
                    "Báº¡n khÃ´ng muá»n tiáº¿p tá»¥c";
                    return false;
                }
            }
        </script>
</head>
<body>
<table>
<tr><td>Môn thi</td><td>Mã đề</td><td>Năm học</td><td>Điểm</td><td>Ngày làm bài</td><td></td></tr>
<tr><td>Vật lý</td><td>123</td><td>2017</td><td>8.00</td><td>22/11/2017</td><td><input type='submit' value='Xem chi tiết'></td></tr>

</table>

<!-- <p id="demo"></p>
    <button type="button" onclick="return validateForm()">Click vÃ o ÄÃ¢y</button>
        <form method="post" action="testttt" onsubmit="return validateForm()">
            Username: <input type="text" name="username" id="username" value=""/> <br/><br/>
            Password: <input type="password" name="password" id="password" value=""/> <br/><br/>
            <input type="submit" name="login" value="Login"/>
        </form> -->
</body>
</html>