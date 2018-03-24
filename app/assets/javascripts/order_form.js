// $(document).on('turbolinks:load', function() {
//     var num = 0;
//   $('.plus').on('click', function(){
//     num++;
//     $(this).prev().val(num);
//     console.log("aaa");
//     var array = [];
//     for(var i=0; i < $(".ticket-item-menu").length; i++){
//     var item_price = $(".ticket-item-menu").eq(i).data("price");
//     var item_select = $("select option:selected").eq(i).val();
//     array.push(item_price * item_select);
//     $(".item-price-total").eq(i).val(array[i]);
//     }

//     var total = 0;
//     for(var j = 0; j < array.length; j++){
//       total += array[j];
//     }

//     $("#item-price-total").val(total);
//     });
//   $('.minus').on('click', function(){
//     num--;　num > 0;
//     if(num < 0) num = 0;
//     $(this).prev().prev().val(num);
//     console.log("aaa");
//     var array = [];
//     for(var i=0; i < $(".ticket-item-menu").length; i++){
//     var item_price = $(".ticket-item-menu").eq(i).data("price");
//     var item_select = $("select option:selected").eq(i).val();
//     array.push(item_price * item_select);
//     $(".item-price-total").eq(i).val(array[i]);
//     }

//     var total = 0;
//     for(var j = 0; j < array.length; j++){
//       total += array[j];
//     }

//     $("#item-price-total").val(total);
//     });

// });
