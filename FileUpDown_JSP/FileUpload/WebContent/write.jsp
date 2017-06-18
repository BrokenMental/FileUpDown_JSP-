<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>write.jsp</title>
<script language="javascript" type="text/javascript">
function formCheck() {
	var length = document.forms[0].length - 1;
	for (var i = 0; i < length; i++) {
		if (document.forms[0][i].value == null
				|| document.forms[0][i].value == "") {
			alert(document.forms[0][i].name + "을/를 입력하세요.");
			document.forms[0][i].focus();
			return;
		}
	}
}

extArray = new Array(".mp3");

function LimitAttach(form, file) {
	allowSubmit = false;
	if(!file) return;
	while (file.indexOf("\\")!= -1)
	file = file.slice(file.indexOf("\\") +1);
	ext = file.slice(file.indexOf(".")).toLowerCase();
	for(var i = 0; i< extArray.length; i++){
		if(extArray[i] == ext) {allowSubmit = true; break; }
	}
	if(allowSubmit){
		form.submit();
	}else{
		alert("업로드 가능한 확장자는 mp3 입니다.");
		return;
	}
}
</script>
</head>
<body>
	<form action="write_ok.jsp" method="post" enctype="multipart/form-data">
		<table border="1" style="border-collapse: collapse;">
			<tr>
				<td>작성자 : <input type="text" name="writer" /><br /></td>
			</tr>
			<tr>
				<td>공유번호 : <input type="text" name="port" /><br /></td>
			</tr>
			<tr>
				<td>파일추가 : <input type="file" name="filename"><br /></td>
			</tr>
			<tr>
				<td>날짜 : <input type="text" name="date" /><br /></td>
			</tr>
			<tr>
				<td align="right"><input type="button" value="취소" onClick="history.back()" />
					<input type="button" value="확인" onClick="javascript:formCheck();LimitAttach(this.form,this.form.filename.value)"/></td>
			</tr>
		</table>
	</form>
</body>
</html>