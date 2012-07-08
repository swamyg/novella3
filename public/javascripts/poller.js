var Poller = {
  poll: function(poll_url, numPolls, timeInMs){
    console.log("being polling --- "+poll_url);
    if(typeof(numPolls)==='undefined') numPolls = 100;
    if(typeof(timeInMs)==='undefined') timeInMs = 5000;
    $.get(poll_url, function(data) {
      $("#concurrent_editors").html(data.editors);
      if (numPolls>0){
        //we wait for 5 seconds and call the poll again.
         console.log("TIME IN MS ----> "+timeInMs);
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
//    $.ajax({
//      type: 'POST',
//      url: poll_url,
//      dataType:'json',
//      timeout: 5000,
//      cache: false,
//      data:{
//        // Here you include the data used in the poll of the user i.e id,actcion.
//
//      },
//      success: function(data, textStatus){
//        console.log("data -----------.>"+data);
//        //I assume the server will reply with success variable with content true for
//                          // for action done or false for no.
//        console.log(" VISITORS--------> "+data.visitors);
//        console.log("numpolls --------> "+ numPolls);
//        console.log("time in ms -------->"+timeInMs);
//        if (numPolls>0){
//          //we wait for 5 seconds and call the poll again.
//           console.log("TIME IN MS ----> "+timeInMs);
//           setTimeout(function() {
//             Poller.poll(poll_url, (numPolls - 1), timeInMs);
//           }, timeInMs);
//        }else{
//          // we reached the limit of times we polled the server
//          // and we inform the customer/user that,
//                                        // we couldn't confirm that the
//          // action has been completed
//        }
//      },
//      error: function (XMLHttpRequest, textStatus, errorThrown) {
//        //show an error message
//      }
//    });
  }
}
