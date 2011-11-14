/* Author:
 Makarov Andrey
 */
$(document).ready(function(){
    var menuIsCollapsed = 0;
    var relationBoxIsCollapsed = 1;

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

    $(".q-paragraph-relation-box-switcher").mouseover(function(){
        $(this).css("color", "#8d84d7");
    });
    $(".q-paragraph-relation-box-switcher").mouseout(function(){
        $(this).css("color", "#8279c6");
    });


    $(".q-paragraph-relation-box-switcher").click(function(){
        if (relationBoxIsCollapsed == 1) {
            $(".q-paragraph-relation-box-items").slideDown(300, function(){
                relationBoxIsCollapsed = 0;
                $(".q-paragraph-relation-box-switcher").html('Свернуть');
            });
        } else {
           $(".q-paragraph-relation-box-items").slideUp(300, function(){
                relationBoxIsCollapsed = 1;
                $(".q-paragraph-relation-box-switcher").html('Развернуть');
           });
        }
    });

    $(".q-paragraph-relation-box-title").click(function(){
        if (relationBoxIsCollapsed == 1) {
            $(".q-paragraph-relation-box-items").slideDown(300, function(){
                relationBoxIsCollapsed = 0;
                $(".q-paragraph-relation-box-switcher").html('Свернуть');
            });
        } else {
           $(".q-paragraph-relation-box-items").slideUp(300, function(){
                relationBoxIsCollapsed = 1;
                $(".q-paragraph-relation-box-switcher").html('Развернуть');
           });
        }
    });

   /*
    $(".paragraph-unit").mouseover(function(){
        $(this).addClass("p-highlight");
    });
    $(".paragraph-unit").mouseout(function(){
        $(this).removeClass("p-highlight");
    });
    */
});






