$(document).on('turbolinks:load', function() {
  $("select").change(function(){
    var array = [];
    for(var i=0; i < $(".ticket-item-menu").length; i++){
    var item_price = $(".ticket-item-menu").eq(i).data("price");
    var item_select = $("select option:selected").eq(i).val();
    array.push(item_price * item_select);
    $(".item-price-total").eq(i).val(array[i]);
    }

    var total = 0;
    for(var j = 0; j < array.length; j++){
      total += array[j];
    }

    $("#item-price-total").val(total);
  });
});
