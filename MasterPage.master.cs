using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;
using System.Net.Mail;
using System.IO;
using System.Web.Security;
using System.Net;
using System.Net.NetworkInformation;
    

public partial class MasterPage : System.Web.UI.MasterPage
{
    MySqlCommand cmd;
    string UserName = "";
    int zoomlevel = 4;
    VehicleDBMgr vdm;
    DataDownloader ddwnldr;
    //
    NetworkInterface networkInterface;
    long lngBytesSend = 0;
    long lngBtyesReceived = 0;

    long speed = 0;
    string adapter = "";

    protected void Page_Load(object sender, EventArgs e)
    {
       
        KS.ImageUrl = "~/Images/Vyshnavilogo.png";
       
        if (Session["field1"] == null)
            Response.Redirect("Login.aspx");
        else
        {
            //vdm.UserName = Session["field1"].ToString();
            UserName = Session["field1"].ToString();
            vdm = new VehicleDBMgr();
            vdm.InitializeDB();

            if (!this.IsPostBack)
            {
                if (!Page.IsCallback)
                {
                    lblMessage.Text = " " + UserName;
                   // InternetSpeed();
                }
            }
        }
    }
    //protected void btn_Speed_Click(object sender, EventArgs e)
    //{

    //}

    private void InternetSpeed()
    {
        try
        {
            
            //double[] speeds = new double[5];
            //for (int i = 0; i < 5; i++)
            //{
            //    int jQueryFileSize = 261; //Size of File in KB.
            //    WebClient client = new WebClient();
            //    DateTime startTime = DateTime.Now;
            //    client.DownloadFile("http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.js", Server.MapPath("~/jQuery.js"));
            //    DateTime endTime = DateTime.Now;
            //    speeds[i] = Math.Round((jQueryFileSize / (endTime - startTime).TotalSeconds));
            //}
            //lblDownloadSpeed.Text = string.Format("Download Speed: {0}KB/s", speeds.Average());  

            //
            System.Net.NetworkInformation.NetworkInterface[] nics = null;
            nics = System.Net.NetworkInformation.NetworkInterface.GetAllNetworkInterfaces();

            foreach (System.Net.NetworkInformation.NetworkInterface net in NetworkInterface.GetAllNetworkInterfaces())
            {
                if (net.Name.Contains("Wireless") || net.Name.Contains("WiFi") || net.Name.Contains("802.11") || net.Name.Contains("Wi-Fi"))
                {
                    speed = net.Speed;
                    adapter = net.Name;
                    networkInterface = net;
                    break;
                }
            }
            string temp;
            if (speed == 0)
            {
                temp = "There is currently no Wi-Fi connection";
                foreach (NetworkInterface currentNetworkInterface in NetworkInterface.GetAllNetworkInterfaces())
                    if (currentNetworkInterface.Name.ToLower() == "local area connection")
                    {
                        networkInterface = currentNetworkInterface;
                        break;
                    }
                    else
                    {
                        speed = currentNetworkInterface.Speed;
                        networkInterface = currentNetworkInterface;
                        break;
                    }

                IPv4InterfaceStatistics interfaceStatistic = networkInterface.GetIPv4Statistics();

                int bytesSentSpeed = (int)(interfaceStatistic.BytesSent - lngBytesSend) / 1;
                int bytesReceivedSpeed = (int)(interfaceStatistic.BytesReceived - lngBtyesReceived) / 1;

                adapter = networkInterface.Name;
               // lblSpeed.Text = (networkInterface.Speed / 1000000).ToString() + " Mbps on " + adapter;

              //  lblPacketReceived.Text = ((interfaceStatistic.UnicastPacketsReceived) / 1).ToString() + " Mbps";
               // lblPacketSend.Text = ((interfaceStatistic.UnicastPacketsSent) / 1).ToString() + " Mbps";

              //  lblUpload.Text = (bytesSentSpeed).ToString() + " Bytes / s";
               // lblDownLoad.Text = (bytesReceivedSpeed).ToString() + " Bytes / s ";

                lngBytesSend = interfaceStatistic.BytesSent;
                lngBtyesReceived = interfaceStatistic.BytesReceived;
            }
            else
            {
                foreach (System.Net.NetworkInformation.NetworkInterface net in NetworkInterface.GetAllNetworkInterfaces())
                {
                    if (net.Name.Contains("Wireless") || net.Name.Contains("WiFi") || net.Name.Contains("802.11") || net.Name.Contains("Wi-Fi"))
                    {

                        temp = "Current Wi-Fi Speed: " + (speed / 1000000) + "Mbps on " + adapter;
                      //  lblSpeed.Text = temp;


                        IPv4InterfaceStatistics interfaceStatistic = networkInterface.GetIPv4Statistics();

                        int bytesSentSpeed = (int)(interfaceStatistic.BytesSent - lngBytesSend) / 1;
                        int bytesReceivedSpeed = (int)(interfaceStatistic.BytesReceived - lngBtyesReceived) / 1;

                      //  lblSpeed.Text = (networkInterface.Speed / 1000000).ToString() + " Mbps";

                     //   lblPacketReceived.Text = ((interfaceStatistic.UnicastPacketsReceived) / 1).ToString() + " Mbps";
                      //  lblPacketSend.Text = ((interfaceStatistic.UnicastPacketsSent) / 1).ToString() + " Mbps";

                       // lblUpload.Text = (bytesSentSpeed).ToString() + " Bytes / s";
                       // lblDownLoad.Text = (bytesReceivedSpeed).ToString() + " Bytes / s ";

                        lngBytesSend = interfaceStatistic.BytesSent;
                        lngBtyesReceived = interfaceStatistic.BytesReceived;
                    }
                }

            }

        }
        catch (Exception ex)
        {

        }
        //
    }

}
