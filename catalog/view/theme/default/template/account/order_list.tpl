<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?></h1>
      <?php if ($orders) { ?>
      <div class="table-responsive">
        <table class="table table-bordered table-hover">
          <thead>
            <tr>
              <td class="text-right"><?php echo $column_order_id; ?></td>
              <td class="text-left"><?php echo $column_customer; ?></td>
              <td class="text-right"><?php echo $column_product; ?></td>
              <td class="text-left"><?php echo $column_status; ?></td>
              <td class="text-right"><?php echo $column_total; ?></td>
              <td class="text-left"><?php echo $column_date_added; ?></td>
              <!--frd-->
              <td class="text-left"><?php echo $column_awb; ?></td>
              <!--frd-->
              <td></td>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($orders as $order) { ?>
            <tr>
              <td class="text-right">#<?php echo $order['order_id']; ?></td>
              <td class="text-left"><?php echo $order['name']; ?></td>
              <td class="text-right"><?php echo $order['products']; ?></td>
              <td class="text-left"><?php echo $order['status']; ?></td>
              <td class="text-right"><?php echo $order['total']; ?></td>
              <td class="text-left"><?php echo $order['date_added']; ?></td>
              <!--frd-->
              <td class="text-left"><button class="btn btn-info" id="awbsearch<?php echo $order['order_id'];?>"><?php echo $order['couriername'] . '/' . $order['awbnumber']; ?></button></td>
              <!---->
              <td class="text-right"><a href="<?php echo $order['view']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-info"><i class="fa fa-eye"></i></a></td>
            </tr>
            <script type="text/javascript"><!--
            $('#awbsearch<?php echo $order['order_id'];?>').on('click', function() {
              $.ajax({
                url: 'index.php?route=account/order/awbpro',
                type: 'post',
                data: 'kurir=<?php echo $order['couriername'];?>&awb=<?php echo $order['awbnumber']?>',
                dataType: 'json',
                beforeSend: function() {
                  $('#awbsearch<?php echo $order['order_id'];?>').button('loading');
                },
                complete: function() {
                  $('#awbsearch<?php echo $order['order_id'];?>').button('reset');
                },
                success: function(json) {
                  $('.alert, .text-danger').remove();
                  if (json['error']) {
        				        if (json['error']['warning']) {
  					              $('.breadcrumb').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
  					              $('html, body').animate({ scrollTop: 0 }, 'slow');
        				        }

        				        if (json['error']['awb']) {
        					        $('#awbsearch<?php echo $order['order_id'];?>').after('<div class="text-danger">' + json['error']['awb'] + '</div>');
        				        }
                				if (json['error']['courier']) {
                          $('#awbsearch<?php echo $order['order_id'];?>').after('<div class="text-danger">' + json['error']['courier'] + '</div>');
                				}
                  }
                  if (json['data']) {
                    $('#modal-shipping').remove();
                    html  = '<div id="modal-shipping" class="modal">';
                    html += '  <div class="modal-dialog">';
                    html += '    <div class="modal-content">';
                    html += '      <div class="modal-header">';
                    html += '        <h2 class="modal-title">' + json['heading_title1'] + '</h2>';
                    html += '      </div>';
                    html += '      <div class="modal-body">';

                    html += '<table class="table table-bordered">';
                    html += '<thead>';
                    html += ' <tr>'
                    html += '   <td colspan="2"><strong>' + json['heading_title2'] + '</strong></td>';
                    html += ' </tr>';
                    html += '</thead>';
                    html += '<tbody>';
                    html += ' <tr>';
                    html += '   <td>' + json['entry_awbnumber'] + '</td>';
                    html += '   <td>' + json['data']['awbnumber'] + '</td>';
                    html += ' </tr>';
                    html += ' <tr>';
                    html += '   <td>' + json['entry_couriername'] + '</td>';
                    html += '   <td>' + json['data']['couriername'] + '</td>';
                    html += ' </tr>';
                    html += ' <tr>';
                    html += '   <td>' + json['entry_service'] + '</td>';
                    html += '   <td>' + json['data']['servicecode'] + '</td>';
                    html += ' </tr>';
                    html += ' <tr>';
                    html += '   <td>' + json['entry_status'] + '</td>';
                    html += '   <td><strong>' + json['data']['status'] + '</strong></td>';
                    html += ' </tr>';
                    html += ' <tr>';
                    html += '   <td>' + json['entry_awbdate'] + '</td>';
                    html += '   <td>' + json['data']['awbdate'] + '</td>';
                    html += ' </tr>';
                    html += ' <tr>';
                    html += '   <td>' + json['entry_shippername'] + '</td>';
                    html += '   <td>' + json['data']['shippername'] + '</td>';
                    html += ' </tr>';
                    html += ' <tr>';
                    html += '   <td>' + json['entry_receivername'] + '</td>';
                    html += '   <td>' + json['data']['receivername'] + '</td>';
                    html += ' </tr>';
                    html += '</tbody>';
                    html += '</table>';

                    html += '<table class="table table-bordered">';
                    html += '<thead>';
                    html += ' <tr>'
                    html += '   <td colspan="2"><strong>' + json['heading_title3'] + '</strong></td>';
                    html += ' </tr>';
                    html += '</thead>';
                    html += '<tbody>';
                    html += ' <tr>';
                    html += '   <td><strong>' + json['column_date'] + '</strong></td>';
                    html += '   <td><strong>' + json['column_desc'] + '</strong></td>';
                    html += ' </tr>';

                    //for ( var i = 0, l = json['data']['manifest'].length; i < l; i++ ) {
                      html += ' <tr>';
                      html += '   <td>' + json['data']['manifest'][0]['date'] + ' ' + json['data']['manifest'][0]['time'] + '</td>';
                      html += '   <td>' + json['data']['manifest'][0]['desc'] + ' [' + json['data']['manifest'][0]['city'] + '] '+ '</td>';
                      html += ' </tr>';
                    //}
                    html += '</tbody>';
                    html += '</table>';

                    html += '      </div>';
                    html += '      <div class="modal-footer">';
                    html += '        <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo 'Close'; ?></button>';


                    html += '      </div>';
                    html += '    </div>';
                    html += '  </div>';
                    html += '</div> ';

                    $('body').append(html);

                    $('#modal-shipping').modal('show');
                  }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                  alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
              });
            });
            </script>
            <?php } ?>
          </tbody>
        </table>
      </div>
      <div class="row">
        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
      </div>
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <?php } ?>
      <div class="buttons clearfix">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
