<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="SeedData.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
        function SaveAddressData() {
            var formattedAddress = response.results[0].formatted_address;
            var latitude = response.results[0].geometry.location.lat;
            var longitude = response.results[0].geometry.location.lng;

            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "WebForm1.aspx/InsertAddressData",
                data: "{'formattedAddress':'" + formattedAddress + "','latitude':'" + latitude + "','longitude':'" + longitude + "'}",
                success: function (Record) {
                    if (Record.d == true) {
                        $('#Result').text("Data Inserted.");
                    }
                    else {
                        $('#Result').text("Data Not Inserted.");
                    }
                },
                Error: function (textMsg) {
                    $('#Result').text("Error: " + Error);
                }
            });
        }

        $(document).ready(function () {
            $('#btnGetWeather').click(function () {
                var resultElement = $('#resultDiv');                
                var requestData = $('#txtAddress').val();
                $.ajax({
                    url: 'https://maps.googleapis.com/maps/api/geocode/json?address='+requestData+'&key=AIzaSyAnkNz_LwkyLkH5eosMfJNMNn0CZCcSCyU',
                    method: 'get',
                    data: { address: requestData },
                    dataType: 'json',
                    success: function (response) {
                        console.log(response);
                        console.log(response.results[0].formatted_address);
                        console.log(response.results[0].geometry.location.lat);
                        console.log(response.results[0].geometry.location.lng);
                        if (response.message != null) {
                            resultElement.html(response.message);
                        }
                        else {
                            SaveAddressData();
                            resultElement.html('Formatted Address: ' + response.results[0].formatted_address + '<br/>'
                                + 'Latitude: ' + response.results[0].geometry.location.lat + '</br>'
                                + 'Longitude:' + response.results[0].geometry.location.lng);
                        }
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            });
        });
    </script>
</head>
<body style="font-family:Arial">
    <h3 id="Result"></h3> 
    <table>
        <tr>
            <td>Address</td>
            <td><input type="text" id="txtAddress" /></td>
        </tr>
    </table>
    <input type="button" id="btnGetWeather" value="Get Address Data">
    <br /><br />
    <div id="resultDiv">
    </div>
</body>
</html>
