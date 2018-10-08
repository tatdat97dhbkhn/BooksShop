$(document).on('turbolinks:load', function(){
  setTimeout(function(){
    $('#flash').remove();
  }, 3000);

  $('.rmv_book').click(function(){
    var book_id = $(this).siblings('.book_id').val();
    delete_record('books', book_id);
  });

  $('.rmv_author').click(function(){
    var author_id = $(this).siblings('.author_id').val();
    delete_record('authors', author_id);
  });

  $('.rmv_category').click(function(){
    var category_id = $(this).siblings('.category_id').val();
    delete_record('categories', category_id);
  });

  function delete_record(table, id){
    var flag = confirm('Do you want to delete '+ table + ' ?');
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

  $('.slect_form_category').change(function(){
    getParams();
  });

  $('.slect_form_author').change(function(){
    getParams();
  });

  $('.slect_form_price').change(function(){
    getParams();
  });

  $('.slect_form_date').change(function(){
    getParams();
  });

  function getParams(){
    var category_id = $('.slect_form_category').val();
    var author_id = $('.slect_form_author').val();
    var price = $('.slect_form_price').val();
    var public_date = $('.slect_form_date').val();

    $.ajax({
      url: '/select_search',
      method: 'get',
      data: {author_id: author_id, category_id: category_id, price: price, public_date: public_date},
      dataType: 'json',
      success: function(data){
        $('.result_book').html(data.html);
        $('.slide_ruby').remove();
      }
    });
  }

  $('#search_book').keyup(function(){
    var content_search = $(this).val();
    $.ajax({
      url: '/search_book',
      method: 'get',
      data: {name_search: content_search},
      dataType: 'json',
      success: function(data){
        $('.result_book').html(data.html);
        $('.slide_ruby').remove();
      }
    });
  });

  function admin_search(content, table, search_cate){
    $.ajax({
      url: '/admin_search',
      method: 'get',
      data: {search: content, table: table, search_cate: search_cate},
      dataType: 'json',
      success: function(data){
        $('.result_search').html(data.html);
      }
    });
  }

  $('#search_cate').keyup(function(){
    var content = $(this).val();
    var table = $(this).siblings('.table_cate').val();
    admin_search(content, table, '');
  });

  $('#book_search').keyup(function(){
    var content = $(this).val();
    var table = $(this).siblings('.table_book').val();
    var search_cate = $('.slect_admin_category').val();
    admin_search(content, table, search_cate);
  });

  $('#author_search').keyup(function(){
    var content = $(this).val();
    var table = $(this).siblings('.table_author').val();
    admin_search(content, table, '');
  });

  $('.slect_admin_category').change(function(){
    var search_cate = this.value;
    var content = $('#book_search').val();
    admin_search(content, 'book', search_cate);
  });
});
