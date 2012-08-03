/* Author:
 Makarov Andrey
 */
$(document).ready(function(){
    var menuIsCollapsed = 0;
    var relationBoxIsCollapsed = 1;
    var knwLevelBoxIsCollapsed = 1;
    var problemRelationBoxIsCollapsed = 1;

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
        $(".q-paragraph-relation-box").css("border", "1px solid #dad8ef");
    });
    $(".q-paragraph-relation-box-switcher").mouseout(function(){
        $(this).css("color", "#8279c6");
        $(".q-paragraph-relation-box").css("border", "1px solid #e6e5ef");
    });

    $(".q-paragraph-relation-box-title").mouseover(function(){
        $(".q-paragraph-relation-box-switcher").css("color", "#8d84d7");
        $(".q-paragraph-relation-box").css("border", "1px solid #e0deef");
        $(".q-paragraph-relation-box").css("background-color", "#f7f5fd");
    });
    $(".q-paragraph-relation-box-title").mouseout(function(){
        $(".q-paragraph-relation-box-switcher").css("color", "#8279c6");
        $(".q-paragraph-relation-box").css("border", "1px solid #e6e5ef");
        $(".q-paragraph-relation-box").css("background-color", "#fbfaff");
    });



    $(".q-paragraph-knw-level-box-switcher").mouseover(function(){
        $(this).css("color", "#8d84d7");
        $(".q-paragraph-knw-level-box").css("border", "1px solid #dad8ef");
    });
    $(".q-paragraph-knw-level-box-switcher").mouseout(function(){
        $(this).css("color", "#8279c6");
        $(".q-paragraph-knw-level-box").css("border", "1px solid #e6e5ef");
    });

    $(".q-paragraph-knw-level-box-title").mouseover(function(){
        $(".q-paragraph-knw-level-box-switcher").css("color", "#8d84d7");
        $(".q-paragraph-knw-level-box").css("border", "1px solid #e0deef");
        $(".q-paragraph-knw-level-box").css("background-color", "#f7f5fd");
    });
    $(".q-paragraph-knw-level-box-title").mouseout(function(){
        $(".q-paragraph-knw-level-box-switcher").css("color", "#8279c6");
        $(".q-paragraph-knw-level-box").css("border", "1px solid #e6e5ef");
        $(".q-paragraph-knw-level-box").css("background-color", "#fbfaff");
    });



    $(".q-problem-relation-box-switcher").mouseover(function(){
        $(this).css("color", "#8d84d7");
        $(".q-problem-relation-box").css("border", "1px solid #dad8ef");
    });
    $(".q-problem-relation-box-switcher").mouseout(function(){
        $(this).css("color", "#8279c6");
        $(".q-problem-relation-box").css("border", "1px solid #e6e5ef");
    });

    $(".q-problem-relation-box-title").mouseover(function(){
        $(".q-problem-relation-box-switcher").css("color", "#8d84d7");
        $(".q-problem-relation-box").css("border", "1px solid #e0deef");
        $(".q-problem-relation-box").css("background-color", "#f7f5fd");
    });
    $(".q-problem-relation-box-title").mouseout(function(){
        $(".q-problem-relation-box-switcher").css("color", "#8279c6");
        $(".q-problem-relation-box").css("border", "1px solid #e6e5ef");
        $(".q-problem-relation-box").css("background-color", "#fbfaff");
    });




    $(".tree-map-discipline-block").mouseover(function(){
        $(this).css("border", "1px solid #e0deef");
        $(this).css("background-color", "#f7f5fd");
    });
    $(".tree-map-discipline-block").mouseout(function(){
        $(this).css("border", "1px solid #e6e5ef");
        $(this).css("background-color", "#fbfaff");
    });
    $(".tree-map-discipline-block").click(function(){
        window.location.replace($(this).find('h3').find('a').attr("href"));
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



    $(".q-paragraph-knw-level-box-switcher").click(function(){
        if (knwLevelBoxIsCollapsed == 1) {
            $(".q-paragraph-knw-level-box-items").slideDown(300, function(){
                knwLevelBoxIsCollapsed = 0;
                $(".q-paragraph-knw-level-box-switcher").html('Свернуть');
            });
        } else {
            $(".q-paragraph-knw-level-box-items").slideUp(300, function(){
                knwLevelBoxIsCollapsed = 1;
                $(".q-paragraph-knw-level-box-switcher").html('Развернуть');
            });
        }
    });

    $(".q-paragraph-knw-level-box-title").click(function(){
        if (knwLevelBoxIsCollapsed == 1) {
            $(".q-paragraph-knw-level-box-items").slideDown(300, function(){
                knwLevelBoxIsCollapsed = 0;
                $(".q-paragraph-knw-level-box-switcher").html('Свернуть');
            });
        } else {
            $(".q-paragraph-knw-level-box-items").slideUp(300, function(){
                knwLevelBoxIsCollapsed = 1;
                $(".q-paragraph-knw-level-box-switcher").html('Развернуть');
            });
        }
    });


    $(".q-problem-relation-box-switcher").click(function(){
        if (problemRelationBoxIsCollapsed == 1) {
            $(".q-problem-relation-box-items").slideDown(300, function(){
                problemRelationBoxIsCollapsed = 0;
                $(".q-problem-relation-box-switcher").html('Свернуть');
            });
        } else {
            $(".q-problem-relation-box-items").slideUp(300, function(){
                problemRelationBoxIsCollapsed = 1;
                $(".q-problem-relation-box-switcher").html('Развернуть');
            });
        }
    });

    $(".q-problem-relation-box-title").click(function(){
        if (problemRelationBoxIsCollapsed == 1) {
            $(".q-problem-relation-box-items").slideDown(300, function(){
                problemRelationBoxIsCollapsed = 0;
                $(".q-problem-relation-box-switcher").html('Свернуть');
            });
        } else {
            $(".q-problem-relation-box-items").slideUp(300, function(){
                problemRelationBoxIsCollapsed = 1;
                $(".q-problem-relation-box-switcher").html('Развернуть');
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

    $(".qtest-question-block").click(function(){
        //alert($(this).attr('id'));
        $("div[id^='problem-']").hide();
        $("#problem-"+$(this).attr('id')).fadeIn();
    });

    $(".qtest-question-block").mouseover(function(){
        $(this).css("border", "1px solid #e0deef");
        $(this).css("background-color", "#f7f5fd");
    });
    $(".qtest-question-block").mouseout(function(){
        $(this).css("border", "1px solid #e6e5ef");
        $(this).css("background-color", "#fbfaff");
    });

    $("div [class*='qmatrix-unit-cell-']").mouseover(function(){
        var row = $(this).attr('data-row');
        var column = $(this).attr('data-column');
        $("div[data-row='"+row+"'][data-type!='rel']").css("background-color", "#fcffe1");
        $("div[data-column='"+column+"'][data-type!='rel']").css("background-color", "#fcffe1");
    });
    $("div [class*='qmatrix-unit-cell-']").mouseout(function(){
        var row = $(this).attr('data-row');
        var column = $(this).attr('data-column');
        $("div [data-row='"+row+"'][data-type!='rel']").css("background-color", "#f3f3f3");
        $("div [data-column='"+column+"'][data-type!='rel']").css("background-color", "#f3f3f3");
    });
});






