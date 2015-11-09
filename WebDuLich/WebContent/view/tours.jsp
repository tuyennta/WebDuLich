<%@page import="model.ModelPost"%>
<%@page import="dto.dtoPost"%>
<%@page import="model.ModelUser"%>
<%@page import="model.ModelLocation"%>
<%@page import="dto.dtoLocation"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	List<dtoLocation> listLocation = null;
	ModelLocation mdLocation = new ModelLocation();
	listLocation = mdLocation.getAllLocation();

	List<String> listCompany = null;
	ModelUser mdUser = new ModelUser();
	listCompany = mdUser.getAllCompanyName();

	List<dtoPost> listPost = null;
	ModelPost mdPost = new ModelPost();
	listPost = mdPost.getAllPostByCategory("1", 10, 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Tour mới</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="view/resource/lib/jquery-2.1.4.min.js"></script>
<link href="view/resource/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript"
	src="view/resource/bootstrap/js/bootstrap.min.js"></script>
<link href="view/resource/css/css_home.css" rel="stylesheet">
<link href="view/resource/css/view-tour.css" rel="stylesheet">
<script type="text/javascript" src="view/resource/lib/tour-utility.js"></script>
<script src="view/resource/lib/jquery-sign-in.min.js"></script>
</head>
<body>
	<!-- body header -->
	<jsp:include page="body-header.jsp"></jsp:include>
	<!-- body content -->
	<div class="container" style="width: 80%">

		<div class="separator">
			<h3>TOUR MỚI</h3>
		</div>
		<br> <br>
		<div class="panel panel-body">
			<lable class="text-left"> <i>Tùy chọn tìm kiếm</i></lable>
			<center>
				<form action="" style="margin: 10px" class="form" role="form">
					<div class="form-group">
						<table width="80%">
							<thead>
								<tr>
									<td style="padding-left: 25px;"><label for="price">Giá
											tour</label></td>
									<td style="padding-left: 25px;"><label for="place">Tỉnh
											thành</label></td>
									<td style="padding-left: 25px;"><label for="tourist">Công
											ty lữ hành</label></td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td style="padding-left: 25px;"><select
											class="form-control " id="price">
											<option>Giá tour</option>
											<option>10$</option>
											<option>100$</option>
											<option>1000$</option>
										</select></td>

									<td style="padding-left: 25px;"><select
											class="form-control " id="place">
											<option>Tỉnh thành</option>
											<%
												for (dtoLocation location : listLocation) {
													out.write("<option value = '" + location.getLocationId() + "'>"
															+ location.getName() + "</option>");
												}
											%>
										</select></td>

									<td style="padding-left: 25px;"><select
											class="form-control " id="tourist">
											<option>Công ty lữ hành</option>
											<%
												for (String company : listCompany) {
													out.write("<option value = '" + company + "'>" + company
															+ "</option>");
												}
											%>
										</select></td>
									<td><div class="btn-group" style="float: right">
											<button type="button" id="btnSearch" class="btn btn-primary">Tìm
												kiếm</button>
										</div></td>
								</tr>
							</tbody>
						</table>
					</div>
				</form>
			</center>
		</div>
		<hr>
		<br>
		<!-- list tour -->
		<ul class='list-inline' style='margin: 0 auto; width: 100%;'>
			<%
				for (dtoPost post : listPost) {
					out.write("<li class='post'style = 'width:50%'> ");
					out.write("<div class = 'panel'style = 'width:100%'> ");
					out.write("<div class = 'panel-body'");
					out.write("<div id='carousel-" + post.getPostId()
							+ "' class='carousel slide'data-ride='carousel'>");
					out.write("<div class='carousel-inner'role='listbox'>");
					List<String> listSrc = mdPost.getImagesFromPost(
							post.getPostId(), 3);
					int i = 0;
					for (String src : listSrc) {
						if (++i == 1)
							out.write("<div class='active item'><img class='img-responsive' width = '100%'alt='not found'src='"
									+ src + "'></div>");
						else
							out.write("<div class='item'><img class='img-responsive' width = '100%' alt='not found'src='"
									+ src + "'></div>");
					}
					out.write("</div></div>");
					out.write("<div class = 'panel-footer'>");
					out.write("<div style='font-size: 17px;'>");
					out.write("<a href='" + request.getContextPath()
							+ "/postdetail?cate=1&post=" + post.getPostId() + "'> "
							+ post.getTitle() + " </a>");
					out.write("<table width='100%' style = 'margin-top:10px;'><tr>");
					out.write("<td><p data-toggle='tooltip' title='Giá tour "
							+ post.getPrice()
							+ "'><span class='glyphicon glyphicon-usd' style='color: #3399FF'></span> "
							+ post.getPrice() + "</p><td>");
					out.write("<td><p data-toggle='tooltip' title='"
							+ post.getViews()
							+ " người đã xem'><span class='glyphicon glyphicon-eye-open' style='color: #3399FF'></span> "
							+ post.getViews() + "</p></td>");
					out.write("<td><p data-toggle='tooltip' title='Đã có "
							+ post.getBuys()
							+ " người mua tuor này'><span class='glyphicon glyphicon-shopping-cart'	style='color: #3399FF'></span> "
							+ post.getBuys() + "</p></td></tr></table>");
					out.write("</div></div></div></li>");
				}
			%>
		</ul>
	</div>
	<!-- pagination -->
	<nav>
	<ul class="pagination pull-right">
		<li>
			<a href="#" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
			</a>
		</li>
		<li>
			<a href="#">1</a>
		</li>
		<li>
			<a href="#">2</a>
		</li>
		<li>
			<a href="#" aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
			</a>
		</li>
	</ul>
	</nav>
	<!-- body footer -->
	<jsp:include page="body-footer.jsp"></jsp:include>
	<!-- go to top button -->
	<span class="top"></span>
</body>
</html>