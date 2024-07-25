using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ShellLinks;
using IWshRuntimeLibrary;
using System.IO;

using System.Collections;
using System.Configuration;
using System.Data;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;


using System.Net;


public partial class LiveTracking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //Get
            Update(Environment.SpecialFolder.DesktopDirectory, "http://182.18.162.51/VYS/LiveTracking.aspx", "VYSHNAVID TRACKING", true);
        }
        catch (Exception ex)
        {
            Err_msg.Text = ex.ToString();
        }

    }

    public void Update(Environment.SpecialFolder folder, string TargetPathName, string LinkPathName, bool install)
    {
        // Get some file and directory information
        Update(Environment.GetFolderPath(folder), TargetPathName, LinkPathName, install);
    }


    public void Update(string DirectoryPath, string TargetPathName, string LinkPathName, bool Create)
    {
        //  DirectoryPath = "http://182.18.162.51/BACKUP";
        // DirectoryPath = @"\\182.18.162.51/BACKUP";
        DirectoryPath = @"C:\BACKUP";
        // Get some file and directory information
        DirectoryInfo SpecialDir = new DirectoryInfo(DirectoryPath);
        // First get the filename for the original file and create a new file
        // name for a link in the Startup directory
        //
        FileInfo OriginalFile = new FileInfo(LinkPathName);
        string NewFileName = SpecialDir.FullName + "\\" + OriginalFile.Name + ".lnk";
        // string NewFileName1 = "http://182.18.162.51/BACKUP/" + @"/" + OriginalFile.Name + ".lnk";

        FileInfo LinkFile = new FileInfo(NewFileName);

        if (Create) // If the link doesn't exist, create it
        {
            if (LinkFile.Exists) return; // We're all done if it already exists
            //Place a shortcut to the file in the special folder 
            try
            {

                //KS
                // object shDesktop = (object)"http://182.18.162.51/BILL VYSHNAVI/";
                // WshShell shell1 = new WshShell();
                // string shortcutAddress = (string)shell1.SpecialFolders.Item(ref shDesktop) + @"\Server.lnk";
                // string shortcutAddress = (string)shell1.SpecialFolders.Item(ref shDesktop) + "Server.lnk";
                //  IWshShortcut shortcut = (IWshShortcut)shell1.CreateShortcut(NewFileName1.ToString());
                // IWshShortcut shortcut = (IWshShortcut)shell1.CreateShortcut("http://182.18.162.51/BACKUP/Servers.lnk");                
                // shortcut.IconLocation = "http://182.18.162.51/fp/images/favicon.ico";
                // shortcut.TargetPath = TargetPathName;                
                // shortcut.Save();
                //KS

                // Create a shortcut in the special folder for the file
                // Making use of the Windows Scripting Host
                WshShell shell = new WshShell();
                IWshShortcut link = (IWshShortcut)shell.CreateShortcut(LinkFile.FullName);
                link.IconLocation = "http://182.18.162.51/fp/images/gotracking.ico";
                //  link.Arguments = "arg1 arg2";
                  link.Description = "KS";
                //  link.TargetPath = @"C:\Program Files\MorganTechSpace\MyAppSettings.exe";
                link.TargetPath = TargetPathName;
                link.WorkingDirectory = @"C:\BILL VYSHNAVI"; ;
                link.Save();
                //Download
                //string MFileName = @"C:/BACKUP/" + OriginalFile.Name + ".lnk";
                //System.IO.FileInfo file = new System.IO.FileInfo(MFileName);
                //if (System.IO.File.Exists(MFileName.ToString()))
                //{
                //    //
                //    FileStream sourceFile = new FileStream(file.FullName, FileMode.Open);
                //    float FileSize;
                //    FileSize = sourceFile.Length;
                //    byte[] getContent = new byte[(int)FileSize];
                //    sourceFile.Read(getContent, 0, (int)sourceFile.Length);
                //    sourceFile.Close();
                //    //
                //    Response.ClearContent(); // neded to clear previous (if any) written content
                //    Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
                //    Response.AddHeader("Content-Length", file.Length.ToString());
                //    Response.ContentType = "text/plain";
                //    Response.BinaryWrite(getContent);
                //    //  System.IO.File.Delete(file.FullName.ToString());
                //    Response.Flush();
                //    Response.End();

                // }

            }
            catch
            {
                //    Err_msg.Text = string.Empty;
                //    Err_msg.Text = ex.ToString();
                //    //MessageBox.Show("Unable to create link in special directory: "+NewFileName,
                //    //    "Shell Link Error",MessageBoxButtons.OK,MessageBoxIcon.Error);
            }
        }
        else // otherwise delete it from the startup directory
        {
            if (!LinkFile.Exists) return; // It doesn't exist so we are done!
            try
            {
                LinkFile.Delete();
            }
            catch (Exception ex)
            {
                //MessageBox.Show("Error deleting link in special directory: "+NewFileName,
                //    "Shell Link Error",MessageBoxButtons.OK,MessageBoxIcon.Error);
            }
        }
    }


    public void Downl()
    {
        //Download
        //
        //   string MFileName = @"C:/BILL VYSHNAVI/" + ccode + "_" + "_" + pcode + CurrentCreateFolderName + "/" + ccode + "_" + pcode + "_" + "RoutewiseAbstract.pdf";
        string MFileName = @"C:\BACKUP\VYSHNAVID TRACKING.lnk";
        System.IO.FileInfo file = new System.IO.FileInfo(MFileName);
        if (System.IO.File.Exists(MFileName.ToString()))
        {
            //
            FileStream sourceFile = new FileStream(file.FullName, FileMode.Open);
            float FileSize;
            FileSize = sourceFile.Length;
            byte[] getContent = new byte[(int)FileSize];
            sourceFile.Read(getContent, 0, (int)sourceFile.Length);
            sourceFile.Close();
            //
            Response.ClearContent(); // neded to clear previous (if any) written content
            Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
            Response.AddHeader("Content-Length", file.Length.ToString());
            Response.ContentType = "text/plain";
            Response.BinaryWrite(getContent);
            System.IO.File.Delete(file.FullName.ToString());
            Response.Flush();
            Response.End();

        }

        //
    }

    protected void btn_Click(object sender, EventArgs e)
    {
        try
        {

            // Download
            string MFileName = @"C:/BACKUP/VYSHNAVID TRACKING.lnk";
            System.IO.FileInfo file = new System.IO.FileInfo(MFileName);
            if (System.IO.File.Exists(MFileName.ToString()))
            {
                //
                FileStream sourceFile = new FileStream(file.FullName, FileMode.Open);
                float FileSize;
                FileSize = sourceFile.Length;
                byte[] getContent = new byte[(int)FileSize];
                sourceFile.Read(getContent, 0, (int)sourceFile.Length);
                sourceFile.Close();
                //
                Response.ClearContent(); // neded to clear previous (if any) written content
                Response.AddHeader("Content-Disposition", "attachment; filename=" + "ks.lnk");
                Response.AddHeader("Content-Length", file.Length.ToString());
                Response.ContentType = "Shortcut/.lnk";
                Response.BinaryWrite(getContent);
                
                System.IO.File.Delete(file.FullName.ToString());
              //  Response.Flush();
               // Response.End();
            }
        }
        catch (Exception ex)
        {
        }

    }
}