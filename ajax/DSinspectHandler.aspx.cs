using CommonDB;
using System;
//引入命名空间
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class ajax_DSinsHandler : System.Web.UI.Page {
	protected void Page_Load(object sender, EventArgs e) {
		switch (Request["action"]) {

			case ("DSinsReadbyDay"): {//DSins操作，从数据库里读取数据
				DSins dsinsRead = new DSins(Request["time"], "", Request["workshop"],"");
					string sRes = dsinsRead.ReadFromDBbyDay();
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("DSinsDel"): {//DSins操作，从数据库里读取数据
					DSins dsinsRead = new DSins(Request["time"], "", Request["workshop"], "");
					string sRes = dsinsRead.Del();
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("DSSave"): {//DSins操作，存入一行数据
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					DSins dsinsSave = new DSins(Request["time"], "", Request["workshop"], Request["JSONDATA"]);
					string sRes = dsinsSave.SaveToDB(Request["total"]);
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("DSReadTotalCol"): {//DSins操作，读取total 时间 车间对照表
					DSins dsinsSave = new DSins(Request["time"], "","", "");
					string sRes = dsinsSave.ReadTotalCol();
					Response.Write(sRes);
					Response.End();
					break;
				}
			default: { break; }
		}
	}
}
public class DSins {
	private string _Time;
	private string _Editor;
	private string _Jsondata;
	private string _Workshop;

	public DSins(string time, string editor,string workshop, string jsondata) {
		_Time = time;
		_Editor = editor;
		_Workshop = workshop;
		_Jsondata = jsondata;
	}
	public string ReadFromDBbyDay() {
		string ret;
		DataTable retDT;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand =
			@"SELECT 
				[data]
			FROM [EPInfoSystem].[dbo].[DustSourceRecord]
			WHERE [time] LIKE'" + this._Time + "%' AND [workshop]='"+this._Workshop+"'";
		DBOper dbcom = new DBOper(source, DBcommand);
		retDT = dbcom.ReturnDataSet();
		if (retDT.Rows.Count==0) {//没有数据
			ret = ReadListByWS();
		}
		else {//有一个数据
			ret = retDT.Rows[0][0].ToString();
		}
		return ret;
	}
	public string ReadListByWS() {
		string _ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"SELECT 
					 [区域]
					,[粉尘源]
				FROM [EPInfoSystem].[dbo].[DustSourceList]
				WHERE  [车间]='" + this._Workshop + "'";
		DBOper dbcom = new DBOper(source, DBcommand);
		_ret = dbcom.ReturnJson();
		return _ret;
	}
	public string SaveToDB(string total) {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"SELECT 
									[total]
									FROM [EPInfoSystem].[dbo].[DustSourceRecord]
								WHERE [time] LIKE'" + this._Time + "%' AND [workshop]='" + this._Workshop + "'";		
		DBOper dbcom=new DBOper(source,DBcommand);

		ret =dbcom.ReturnJson();
		if (ret=="[]"){//没有这个数据，用insert
			ret=InsertDB(total);
			return "保存成功" + ret;
		}
		else{//有这个数据，用update
			ret=UpdateDB(total);
			return "修改成功" + ret;
		}
		
	}
	public string InsertDB(string total) {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"INSERT INTO [EPInfoSystem].[dbo].[DustSourceRecord]
								([time]
								,[workshop]
								,[data]
								,[total])
							 VALUES
								('" + _Time + @"'
								,'" + _Workshop + @"'
								,'" + _Jsondata + @"'
								,'" + total + "')";
		ret = DBOper.ReturnRows(source, DBcommand);
		return  ret;
	}
	public string UpdateDB(string total) {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"UPDATE [EPInfoSystem].[dbo].[DustSourceRecord]
								SET 
								[data] = '" +this._Jsondata + @"'
								,[total]='"+total+@"'
								WHERE [time] LIKE'" + this._Time + "%' AND [workshop]='" + this._Workshop + "'";

		DBOper DBop = new DBOper(source, DBcommand);
		ret = DBop.ReturnRows();
		return ret;
		
	}

	public string Del() {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"DELETE FROM [EPInfoSystem].[dbo].[DustSourceRecord]
								WHERE [time] LIKE'" + this._Time + "%' AND [workshop]='" + this._Workshop + "'";		
		DBOper dbcom = new DBOper(source, DBcommand);

		ret = dbcom.ReturnJson();
		return "删除结果"+ret;
	}
	public string ReadTotalCol() {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = "[dbo].[LoadDSinsTotal]";


		DBOper DBop = new DBOper(source, DBcommand);
		SqlParameter[] _value = new SqlParameter[1];
		_value[0] = new SqlParameter("_time", this._Time);
		ret = DBop.ProcedureReturnJSON(_value);
		return ret;
		
	}
}