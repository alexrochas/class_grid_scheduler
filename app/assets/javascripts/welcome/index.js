function Class(class_div) {
    this.code = class_div.find("[name='code']").val();
    this.name = class_div.find("[name='name']").val();
    this.points = class_div.find("[name='points']").val();
    this.teacher = class_div.find("[name='teacher']").val();
};

function Config(config_div) {
    this.points_per_day = config_div.find("[name='points_per_day']").val();
    this.week_days = config_div.find("[name='week_days']").val();
};

function Request(classes, config) {
    this.config = config;
    this.classes = classes;

    this.toJson = function() {
        var data = {};
        data.config = {
            points_per_day: config.points_per_day,
            week_days: config.week_days
        };

        data.classes = [];
        $.each(classes, function(index, class_) {
            data.classes.push({
                code: class_.code,
                name: class_.name,
                points: class_.points,
                teacher: class_.teacher
            });
        });

        return data;
    };
};

function Grid(grid) {
    this.grid = grid;

    this.html = function() {
        var table = $("table");

    }
};

$(document).ready(function() {
    var class_component = $(".class").clone();

    $("#more-classes").on('click', function() {
        $("#classes").append(class_component.clone());
    });

    $("#generate-grid").on('click', function() {
        var classes = [];
        $(".class").each(function(index) {
            classes[index] = (new Class($(this)));
        });

        $("#grids").empty();
        var config = new Config($("#config"));

        var request = new Request(classes, config);
        console.log(JSON.stringify(request.toJson()));

        $.post( "/scheduler/schedule", {data: JSON.stringify(request.toJson())}, function(data) {
            console.log("Returned " + data);
            console.log(data.grids);

            $.each(data.grids, function(index, element) {
                var grid = $("<div class='grid' style='width:100px, float:left'/>");
                $.each(element, function(index, day_) {
                    console.log("Day");
                    var day = $("<div class='day'/>");
                    console.log(day_);
                    $.each(day_.classes, function(index, class_){
                        console.log("Classes")
                        var class_div = $("<div style='border:1px solid black' class='well'/>");
                        var p = $("<p/>");
                        p.append("Code:");
                        p.text(class_.code);
                        class_div.append(p);
                        var p = $("<p/>");
                        p.append("Name:");
                        p.text(class_.name);
                        class_div.append(p);
                        var p = $("<p/>");
                        p.append("Points:");
                        p.text(class_.points);
                        class_div.append(p);
                        day.append(class_div);
                    });
                    grid.append(day);
                });
                $("#grids").append(grid);
            });

        }, "json").fail(function(XMLHttpRequest, textStatus, errorThrown) {
            console.log(errorThrown);
            alert(textStatus);
        });
    });
});
