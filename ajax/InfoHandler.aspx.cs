using CommonDB;
using System;
//引入命名空间
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public partial class ajax_InfoHandler : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		switch (Request["action"]) {
			case ("NewInfoSub"): {//NewInfoSub操作，写数据到数据库
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					NewInfo newInfosub = new NewInfo(Request["time"], Request["classify"], Request["editor"], Request["title"], Request["container"],Request["classifyN"]);
					string sRes = newInfosub.InsertDB();
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("ReadAccessName"): {//NewInfoSub操作,读一类文章，不读内容
				string sRes = NewInfo.ReadNameListByClass(Request["classify"],Request["limit"]);
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("ReadAccess"): {//NewInfoSub操作，读一篇文章
					string sRes = NewInfo.ReadAccess(Request["order"], Request["classify"]);
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("AccesssDel"): {//NewInfoSub操作，del一篇文章
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					string sRes = NewInfo.DelAccess( Request["Id"]);
					Response.Write(sRes);
					Response.End();
					break;
				}
			default: { break; }
		}
    }
}
public class NewInfo {
	private string _Time;
	private string _Classify;
	private string _Editor;
	private string _Title;
	private string _Container;
	private string _ClassifyN;

	public NewInfo(string time, string classify, string editor, string title, string container,string classifyN) {
		this._Time = time;
		this._Editor = editor;
		this._Classify = classify;
		this._Title = title;
		this._Container = container;
		this._ClassifyN=classifyN;
	}
	public string InsertDB() {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"INSERT INTO [EPInfoSystem].[dbo].[NewInfo]
								([ClassifyN]
								,[时间]
								,[分类]
								,[作者]
								,[标题]
								,[内容])
							 VALUES
								('" + this._ClassifyN + @"'
								,'" + this._Time + @"'
								,'" + this._Classify + @"'
								,'" + this._Editor + @"'
								,'" + this._Title + @"'
								,'" + this._Container + "')";
		ret = DBOper.ReturnRows(source, DBcommand);
		return "保存结果为："+ret;
	}
	public static string ReadNameListByClass(string classify, string limit) {
		string ret;
		if (limit == "-1") { limit = "99999"; }
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"SELECT TOP "+limit+@" 
									[Id]
									,[时间]     
									,[标题]
								FROM [EPInfoSystem].[dbo].[NewInfo]
								WHERE [分类]='"+classify+@"' 
								ORDER BY [时间] DESC";
		ret = DBOper.ReturnJson(source, DBcommand);
		return ret;
	}
	public static string ReadAccess(string order, string classify) {
		string ret;
		string DBcommand;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		if (order == "-1") {
			 DBcommand = @"SELECT TOP 1
									 [时间]   
									,[标题]
									,[内容]
									,[Id]
								FROM [EPInfoSystem].[dbo].[NewInfo]
								WHERE [分类]='" + classify + @"' 
								order by [时间] desc";
		}
		else {
			 DBcommand = @"SELECT 
									 [时间]   
									,[标题]
									,[内容]
									,[Id]
								FROM [EPInfoSystem].[dbo].[NewInfo]
								WHERE [Id]=" + order;
		}
		
		ret = DBOper.ReturnJson(source, DBcommand);
		return ret;
	}
	public static string DelAccess(string id) {
		string ret;
		
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"delete [EPInfoSystem].[dbo].[NewInfo]
								where [id]=" + id;
		ret = DBOper.ReturnJson(source, DBcommand);
		return ret;
	}

}