var Poller = {
  poll: function(poll_url, numPolls, timeInMs){
    if(typeof(numPolls)==='undefined') numPolls = 1000;
    if(typeof(timeInMs)==='undefined') timeInMs = 5000;
    $.get(poll_url, function(data) {
      data = JSON.parse(data);
      if(data.editors > 1){
        $(".edit_notice").fadeIn();
        $(".concurrent_editors").html(data.editors - 1);
      } else {
        $(".edit_notice").fadeOut();
      }
      if (numPolls>0){
        //we wait for 5 seconds and call the poll again.
         setTimeout(function() {
           Poller.poll(poll_url, (numPolls - 1), timeInMs);
         }, timeInMs);
      }else{
        // we reached the limit of times we polled the server
        // and we inform the customer/user that,
                                      // we couldn't confirm that the
        // action has been completed
      }

    });
  }
}
