/* Author:
Makarov Andrey
*/
$(document).ready(function(){
	var menuIsCollapsed = 0;
	
	$("#index-Menu-ep").mouseover(function(){
		$(this).addClass("index-Menu-ep-state-hover");
	});
	$("#index-Menu-ep").mouseout(function(){
		$(this).removeClass("index-Menu-ep-state-hover");
	});
	
	
	$("#index-Menu-ep").click(function(){
		if (menuIsCollapsed == 1) {
			$(".second-Panel").slideDown(300, function(){
				$(".third-Panel").slideDown(300, function(){
					menuIsCollapsed = 0;
					$("#index-Menu-ep").html('Скрыть меню');
				});
			});
		} else {
			$(".third-Panel").slideUp(300, function(){
				$(".second-Panel").slideUp(300, function(){
					menuIsCollapsed = 1;
					$("#index-Menu-ep").html('Показать меню');
				});
			});

		}
	});
});






