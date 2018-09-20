using CommonDB;
using System;
//引入命名空间
using System.Configuration;
public partial class ajax_DRashHandler : System.Web.UI.Page {
	protected void Page_Load(object sender, EventArgs e) {

		switch (Request["action"]) {

			case ("DRashRead"): {//DRASH操作，从数据库里读取数据

					DRash draRead = new DRash(Request["time"], "", "");
					string sRes = draRead.ReadFromDB();
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("DRashSave"): {
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					DRash drasave = new DRash(Request["time"], "zztdan", Request["JSONDATA"]);
					string sRes = drasave.SaveToDB();
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("DRashUpdate"): {
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					DRash draupdate = new DRash(Request["time"], "zztdan", Request["JSONDATA"]);
					string sRes = draupdate.UpdateDB();
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("DRashDel"): {
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					DRash dradel = new DRash(Request["time"], "", "");
					string sRes = dradel.DelDB();
					Response.Write(sRes);
					Response.End();
					break;
				}
			default: { break; }
		}
	}
}

public class DRash {
	private string _Time;
	private string _Editor;
	private string _Jsondata;
	public DRash(string time, string editor, string jsondata) {
		_Time = time;
		_Editor = editor;
		_Jsondata = jsondata;
	}
	public string ReadFromDB() {
		return staticReadFromDB(_Time);
	}
	public static string staticReadFromDB(string _time) {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand =
			@"SELECT 
				[日期],
			    [数据]
			FROM [EPInfoSystem].[dbo].[DRash]
			WHERE [日期] LIKE'" + _time + "%'";
		DBOper dbcom = new DBOper(source, DBcommand);
		ret = dbcom.ReturnJson();
		return ret;
	}
	public string SaveToDB() {
		return staticSaveToDB(_Time, _Jsondata);
	}
	public static string staticSaveToDB(string _time, string _jsondata) {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"INSERT INTO [EPInfoSystem].[dbo].[DRash]
           ([日期]
           ,[修改人]
           ,[数据])
     VALUES
           ('" + _time + "'"
	   + ",'zztdan'"
		+ ",'" + _jsondata + "')";
		ret = DBOper.ReturnRows(source, DBcommand);
		return "修改成功" + ret;
	}
	public string UpdateDB() {
		return staticUpdateDB(_Time, _Jsondata);
	}
	public static string staticUpdateDB(string _time, string _jsondata) {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"
UPDATE [EPInfoSystem].[dbo].[DRash]
   SET 
      [数据] = '" + _jsondata + "'"
+ " WHERE [日期]='" + _time + "'";

		DBOper DBop = new DBOper(source, DBcommand);
		ret = "修改成功" + DBop.ReturnRows();
		return ret;
	}
	public string DelDB() {
		return staticDelDB(_Time);
	}
	public static string staticDelDB(string _time) {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"DELETE FROM [EPInfoSystem].[dbo].[DRash]
							 WHERE [日期]='" + _time + "'";
		DBOper DBop = new DBOper(source, DBcommand);
		ret = "删除成功" + DBop.ReturnRows();
		return ret;
	}
}