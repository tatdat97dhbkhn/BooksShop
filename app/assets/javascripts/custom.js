$(document).on('turbolinks:load', function(){
  setTimeout(function(){
    $('#flash').remove();
  }, 3000);

  $('.rmv_book').click(function(){
    var book_id = $(this).siblings('.book_id').val();
    delete_record("books", book_id);
  });

  $('.rmv_author').click(function(){
    var author_id = $(this).siblings('.author_id').val();
    delete_record("authors", author_id);
  });

  $('.rmv_category').click(function(){
    var category_id = $(this).siblings('.category_id').val();
    delete_record("categories", category_id);
  });

  function delete_record(table, id){
    var flag = confirm("Do you want to delete "+ table + " ?");
    if(flag == true){
      $.ajax({
        url: '/'+table+'/'+id,
        method: 'delete',
        data: {id: id},
        dataType: 'json',
        success: function(data){
          $('#'+table+'_'+id).remove();
        }
      });
    }
  }
});
