using CommonDB;
using System;
using System.Configuration;

public partial class ajax_CMhandler : System.Web.UI.Page {
	protected void Page_Load(object sender, EventArgs e) {
		string sRes;
		switch (Request["action"]) {
			case ("CMRead"): {//CM操作，从数据库里读取数据(按时间和类型)
				CMResultDB cmread = new CMResultDB(Request["time"], Request["type"], "", "", "");
					sRes = cmread.ReadFromDBByTime();
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("CMReadDetail"): {//CM操作，从数据库里读取数据(按监测点名称和时间，数据唯一)
					CMResultDB cmread = new CMResultDB(Request["time"], "",Request["name"], "", "");
					sRes = cmread.ReadDetailFromDB();
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("CMInsert"): {//CM操作，添加新项
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					CMResultDB cmsave = new CMResultDB(Request["time"], Request["type"],Request["name"],"zztdan", Request["JSONDATA"]);
					sRes = cmsave.SaveToDB();
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("CMUpdate"): {//CM操作，改变旧数据
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
				CMResultDB cmupdate = new CMResultDB(Request["time"], Request["type"], Request["name"], "zztdan", Request["JSONDATA"]);
					sRes = cmupdate.UpdateDB();
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("CMDel"): {//CM操作，改变旧数据
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					CMResultDB cmupdate = new CMResultDB(Request["time"], Request["type"], Request["name"], "zztdan","");
					sRes = cmupdate.DelDB();
					Response.Write(sRes);
					Response.End();
					break;
				}			
			default: { break; }
		}
	}
}

public class CMResultDB {
	private string _Time;
	private string _Type;
	private string _Name;
	private string _Editor;
	private string _Jsondata;
	public CMResultDB(string time, string type, string name,string editor, string jsondata) {
		_Time = time;
		_Name = name;
		_Type = type;
		_Editor = editor;
		_Jsondata = jsondata;
	}
	public string ReadDetailFromDB() {
		string _ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand =
			@"SELECT 
				*
				FROM [EPInfoSystem].[dbo].[CMresult]
				WHERE [日期] LIKE'" + this._Time + "%'  AND [监测点]='"+this._Name+"'";
		DBOper dbcom = new DBOper(source, DBcommand);
		_ret = dbcom.ReturnJson();
		return _ret;
	}

	public string ReadFromDBByTime( ) {
		string _ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand =
			@"SELECT 
				*
				FROM [EPInfoSystem].[dbo].[CMresult]
				WHERE [日期] LIKE'" + this._Time + "%'  AND [类型]='" + this._Type + "'";
		DBOper dbcom = new DBOper(source, DBcommand);
		_ret = dbcom.ReturnJson();
		return _ret;
	}

	public string SaveToDB() {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"INSERT INTO [EPInfoSystem].[dbo].[CMresult]
							([日期]
							,[监测点]
							,[类型]
							,[修改人]
							,[数据])
						VALUES
							('"+ this._Time+@"'
							,'"+this._Name+@"'
							,'"+this._Type+@"'
							,'"+this._Editor+@"'
							,'"+this._Jsondata+"')";
		ret = DBOper.ReturnRows(source, DBcommand);
		return "修改成功" + ret;

	}
	public string UpdateDB() {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"
							UPDATE [EPInfoSystem].[dbo].[CMresult]
							SET 
								[数据] = '"+this._Jsondata+@"'
							WHERE [日期]='"+this._Time+"' AND [监测点]='"+this._Name+"'";

		DBOper DBop = new DBOper(source, DBcommand);
		ret = "修改成功" + DBop.ReturnRows();
		return ret;		
	}
	public string DelDB() {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"
							DELETE FROM [EPInfoSystem].[dbo].[CMresult]							
							WHERE [日期]='" + this._Time + "' AND [监测点]='" + this._Name + "'";

		DBOper DBop = new DBOper(source, DBcommand);
		ret = "删除成功" + DBop.ReturnRows();
		return ret;		
	}
}