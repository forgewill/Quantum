$(document).ready(function(){

	$("#quantumLogoImage").mouseover(function (){
		var image_src = $(this).attr("src");
		image_src = image_src.split(".png").join("_hover.png");
		$(this).attr("src",image_src);
	});	
	$("#quantumLogoImage").mouseout(function (){
		var image_src = $(this).attr("src");
		image_src = image_src.split("_hover.png").join(".png");
		$(this).attr("src",image_src);
	});
	
	//Register button events handlers	
	$(".registerButton").mouseover(function (){
		var image_src = $(this).attr("src");
		image_src = image_src.split(".png").join("_hover.png");
		$(this).attr("src",image_src);
	});	
	$(".registerButton").mouseout(function (){
		var image_src = $(this).attr("src");
		image_src = image_src.split("_hover.png").join(".png");
		$(this).attr("src",image_src);
	});
	
	//Input fields events handlers	
	$(".input-defaultField").focus(function(){
		$(this).parent().addClass("field-focus");
		$(this).parent().parent().find(".field-Label").addClass("field-Label-focus", 250);
	});
   
	$(".input-defaultField").blur(function(){
		$(this).parent().removeClass("field-focus");
		$(this).parent().parent().find(".field-Label").removeClass("field-Label-focus", 250);
	}); 
     
	$(".input-defaultField").mouseover(function(){
		$(this).parent().addClass("field-hover");
		$(this).parent().parent().find(".field-Label").addClass("field-Label-hover", 250);
	}); 
	
	$(".input-defaultField").mouseout(function(){
		$(this).parent().removeClass("field-hover");
		$(this).parent().parent().find(".field-Label").removeClass("field-Label-hover", 250);
	});

});