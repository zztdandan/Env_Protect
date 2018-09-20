using CommonDB;
using JSONConvertHelper;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
//引入命名空间
using System.Configuration;
//引入命名空间
using System.Data;
using OperRecord;


public partial class ajax_CheckInfoHandler : System.Web.UI.Page {
	protected void Page_Load(object sender, EventArgs e) {
		
		switch (Request["action"]) {

			case ("LoadPDDRbyMon"): {//读取粉尘操作

					string sRes = CheckInfo.InfoLoadByMon(Request["time"], "粉尘采样");
					Response.Write(sRes);
					Response.End();
					break;

				}
			case ("SceInsCall"): {//现场检查结果查询
				string sRes = CheckInfo.InfoLoadByStartEnd(Request["starttime"], Request["endtime"], Request["fac"], "现场检查");
					string kRes = CheckInfo.AnalyseCheckInfo(sRes);
					Response.Write(kRes);
					Response.End();
					break;
				}
			case ("REctifyCall"): {//整改情况查询
				string sRes = CheckInfo.InfoLoadByStartEnd(Request["starttime"], Request["endtime"],Request["fac"], "整改情况");
					string kRes = CheckInfo.AnalyseCheckInfo(sRes);
					Response.Write(kRes);
					Response.End();
					break;
				}
			case ("ListStatusCall"): {//读取创建好的挂牌
					ListStatus createstatus = new ListStatus(Request["time"], Request["fac"]);
					string sRes = createstatus.ReadStatus();
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("SAECall"): {//环境污染事故查询
					string sRes = CheckInfo.InfoLoadByMon(Request["time"], "环境污染事故");
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("SavePDDR"): {//存储粉尘检查
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					CheckInfo checkInfosub = new CheckInfo(Request["time"], Request["fac"], Request["type"], Request["pass"], Request["JSONDATA"]);
					string sRes = checkInfosub.InfoSave();
					Response.Write(sRes);
					Response.End();
					break;
				}

			case ("SaveInfo"): {//存储其他挂牌结果
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					CheckInfo checkInfosub = new CheckInfo(Request["time"], Request["fac"], Request["type"], Request["pass"], Request["detail"]);
					string sRes = checkInfosub.InfoSave();
					Response.Write(sRes);
					Response.End();
					break;
				}
			case ("DelCheckInfo"): {//删除其他挂牌结果
				   OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					string sRes = CheckInfo.InfoDel(Request["id"]);
					Response.Write(sRes);
					Response.End();
					break;
				}

			case ("CreateListStatus"): {//创建月度挂牌
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					ListStatus createstatus = new ListStatus(Request["time"], "");
					createstatus.DelStatus();
					string sRes = createstatus.CreateStatus();
					Response.Write(sRes);
					Response.End();
					break;
				}
			
			case ("ManualList"): {//手动挂牌
				OperRecord.OperRecord.SaveOper(Request["action"], Request.Cookies["username"].Value, Request.UserHostAddress);
					string sRes = ListStatus.ManualList(Request["time"], Request["ruleid"]);
					Response.Write(sRes);
					Response.End();
					break;
				}
			default: { break; }
		}
	}
}
public class CheckInfo {
	private string _Time;
	private string _Factory;
	private string _Type;
	private string _Pass;
	private string _Jsondata;
	private string _Realtime;
	private string _Counttime;
	private struct CheckInfoDetail {
		private string _time;
		private string _fac;
		private bool _pass;
		private string _detail;
		private string _id;

		public CheckInfoDetail(string time, string fac, string pass, string detail, string id) {
			this._time = time;
			this._fac = fac;
			if (pass == "false" || pass == "False") { this._pass = false; }
			else { this._pass = true; }
			this._detail = detail;
			this._id = id;
		}
		public string Time { get { return this._time; } }
		public string Fac { get { return this._fac; } }
		public bool Pass { get { return this._pass; } }
		public string Detail { get { return this._detail; } }
		public string Id { get { return this._id; } }
	}
	private class CheckInfoListbyFac {
		public List<CheckInfoDetail> InfoList;
		public CheckInfoListbyFac() {
			InfoList = new List<CheckInfoDetail>();
		}
		public int TotalNum {
			get {
				int num = 0;
				foreach (CheckInfoDetail info in this.InfoList) {
					num++;
				}
				return num;
			}
		}
		public int PassNum {
			get {
				int num = 0;
				foreach (CheckInfoDetail info in this.InfoList) {
					if (info.Pass == true) { num++; }
				}
				return num;
			}
		}
		public string Name { get { return this.InfoList[0].Fac; } }
	}
	public CheckInfo(string time, string fac, string type, string pass, string JSONDATA) {
		this._Time = time;
		this._Type = type;
		this._Factory = fac;
		this._Pass = pass;
		this._Jsondata = JSONDATA;
		this._Realtime = time;
		DateTime dt = new DateTime();
		dt = DateTime.Parse(time);

		this._Counttime = dt.AddDays(2).ToString("yyyy-MM-dd hh:mm");//本句话控制要求的统计时间和真实时间的关系！！
	}
	public string InfoSave() {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"INSERT INTO [EPInfoSystem].[dbo].[CheckInfo]
								([真实时间]
								,[统计时间]	
								,[车间]
								,[检查类型]
								,[合格]
								,[详情])
							VALUES
								('" + this._Realtime + @"'
								,'" + this._Counttime + @"'
								,'" + this._Factory + @"'
								,'" + this._Type + @"'
								," + this._Pass + @"
								,'" + this._Jsondata + "')";
		ret = DBOper.ReturnRows(source, DBcommand);
		return "保存结果为：" + ret;
	}
	public static string InfoDel(string id) {
		string ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"DELETE FROM [EPInfoSystem].[dbo].[CheckInfo]
									 WHERE [Id]=" + id;
		ret = DBOper.ReturnRows(source, DBcommand);
		return ret;
	}

	public static string AnalyseCheckInfo(string jsonobj) {
		List<CheckInfoListbyFac> Slist = new List<CheckInfoListbyFac>();
		JArray SceInsList = JArray.Parse(jsonobj);
		foreach (JObject i in SceInsList) {
			CheckInfoDetail newinfo = new CheckInfoDetail(i["时间"].ToString(), i["车间"].ToString(), i["合格"].ToString(), i["详情"].ToString(), i["Id"].ToString());
			int hasname = Slist.FindIndex(delegate(CheckInfoListbyFac sch) { return sch.Name == newinfo.Fac; });
			if (hasname == -1) {//新的车间
				CheckInfoListbyFac newfac = new CheckInfoListbyFac();
				newfac.InfoList.Add(newinfo);
				Slist.Add(newfac);
			}
			else {
				Slist[hasname].InfoList.Add(newinfo);
			}
		}
		return JsonConvertHelper.SerializeObject(Slist);
	}
	public static string InfoLoadByMon(string mon, string type) {
		string _ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"SELECT 
							[真实时间] as [时间],
							[车间],
							[合格],    
							[详情],
							[Id]
				FROM [EPInfoSystem].[dbo].[CheckInfo]
				where [统计时间] LIKE '" + mon + "%' AND [检查类型]='" + type + @"'
				Order by [真实时间]";
		DBOper dbcom = new DBOper(source, DBcommand);
		_ret = dbcom.ReturnJson();
		return _ret;
	}
	public static string InfoLoadByStartEnd(string starttime,string endtime,string fac,string type) {
		string _ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"SELECT 
							[真实时间] as [时间],
							[车间],
							[合格],    
							[详情],
							[Id]
				FROM [EPInfoSystem].[dbo].[CheckInfo]
				where ([真实时间] BETWEEN '" + starttime + @"' AND '" + endtime + @"') AND [检查类型]='" + type + @"' AND [车间] LIKE'"+fac+@"%'
				Order by [真实时间]";
		DBOper dbcom = new DBOper(source, DBcommand);
		_ret = dbcom.ReturnJson();
		return _ret;
	}
}

public class ListStatus {
	private string _Time;
	private string _Fac;
	private string _MonthstatusStr;
	private class ListStatusbyRule {
		public string RuleId;
		private string _Time;//时间（月）
		private string _Factory;//车间
		private string _Type;//检查项目
		private string _RuleType;//规则类型
		public float _Threshold;//阀值
		public string Time { get { return this._Time; } }
		public string Factory { get { return this._Factory; } }
		public string Type { get { return this._Type; } }
		public string RuleType { get { return this._RuleType; } }
		public float ThresHold { get { return this._Threshold; } }
		public float CollectionValue { get; set; }//参加挂牌的检查项目有多少个
		public bool IfAuto { get; set; }//是否自动挂牌
		public bool ListValue { get; set; }//挂牌结果为何
		public ListStatusbyRule(string ruleid, string time, string Factory, string type, string ruletype, float threshold, bool ifAuto) {
			this.RuleId = ruleid;
			this._Time = time;
			this._Factory = Factory;
			this._Type = type;
			this._RuleType = ruletype;
			this._Threshold = threshold;
			this.IfAuto = ifAuto;
		}

		public void GetCValueFromDB() {
			string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
			if (this._RuleType == "TotalNumLess" || this._RuleType == "TotalNumGreater") {//表示只需要获得返回的行数
				DataTable retDT;
				string DBcommand = @"SELECT
									[合格]
								FROM [EPInfoSystem].[dbo].[CheckInfo]
									WHERE [统计时间] LIKE'" + this._Time + "%'AND [车间]='" + this._Factory + "' AND [检查类型]='" + this._Type + "'";
				DBOper dbcom = new DBOper(source, DBcommand);
				retDT = dbcom.ReturnDataSet();
				this.CollectionValue = retDT.Rows.Count;
			}
			else if (this._RuleType == "PerGreater" || this._RuleType == "PerLess") {
				DataTable retDT1;
				DataTable retDT2;
				float ret1, ret2;
				string DBcommand1 = @"SELECT
									[合格]
								FROM [EPInfoSystem].[dbo].[CheckInfo]
									WHERE [统计时间] LIKE'" + this._Time + "%'AND [车间]='" + this._Factory + "' AND [检查类型]='" + this._Type + "'";
				DBOper dbcom1 = new DBOper(source, DBcommand1);
				retDT1 = dbcom1.ReturnDataSet();
				string DBcommand2 = @"SELECT
									[合格]
								FROM [EPInfoSystem].[dbo].[CheckInfo]
									WHERE [统计时间] LIKE'" + this._Time + "%'AND [车间]='" + this._Factory + "' AND [检查类型]='" + this._Type + "' AND [合格]= 1";
				DBOper dbcom2 = new DBOper(source, DBcommand2);
				retDT2 = dbcom2.ReturnDataSet();
				ret1 = (float)retDT1.Rows.Count;
				ret2 = (float)retDT2.Rows.Count;
				if (ret1 == 0) {
					this.CollectionValue = -1;
				}
				else {
					this.CollectionValue = ret2 / ret1;
				}
			}


		}
		public bool SetListValue() {
			if (!this.IfAuto) {
				return true;
			}
			if (this.CollectionValue == -1) { return true; }//当该数据没测时为绿牌
			if (this._RuleType == "TotalNumLess" || this._RuleType == "PerLess") {//当小于等于阀值时为绿牌
				if (this.CollectionValue <= this._Threshold) {
					return true;
				}
				else return false;
			}
			else if (this._RuleType == "TotalNumGreater" || this._RuleType == "PerGreater") {//当大于等于阀值时为绿牌
				if (this.CollectionValue >= this._Threshold) {
					return true;
				}
				else return false;
			}
			else return true;
		}

	}
	private struct ListStatusByFac {
		private string _Factory_Name;
		public List<ListStatusbyRule> Factory_List_Status;//本厂挂牌详细情况
		private string _List_Time;
		public string ListTime { get { return this._List_Time; } }
		public string FactoryName { get { return this._Factory_Name; } }
		public bool Factory_List_Result {//本厂根据挂牌细则得出的厂级挂牌结果，使用一票否决制,有一项根据规则得出的挂牌结果不合格则不合格
			get {
				bool ResBool = true;
				foreach (ListStatusbyRule status in Factory_List_Status) {
					if (status.ListValue == false) {
						ResBool = false;
						break;
					}
				}
				return ResBool;
			}
		}
		public ListStatusByFac(string name, string time) {
			this._Factory_Name = name;
			this._List_Time = time;
			this.Factory_List_Status = new List<ListStatusbyRule>();
		}

	}
	public ListStatus(string time, string fac) {
		this._Time = time;
		this._Fac = fac;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"SELECT
							[RuleId]
							,[时间]
							,[车间]
							,[项目]
							,[规则类]
							,[阀值]
							,[采集值]
							,[自动]
							,[挂牌]
						FROM [EPInfoSystem].[dbo].[ListStatus]
						WHERE [时间] LIKE'" + this._Time + "%' AND [车间] LIKE '" + this._Fac + @"%'
						ORDER BY [RuleId]";
		DBOper dbcom = new DBOper(source, DBcommand);
		this._MonthstatusStr = dbcom.ReturnJson();
	}

	private Dictionary<string, ListStatusByFac> BuildMonthObj(JArray Monthstatusjarr) {
		Dictionary<string, ListStatusByFac> MonthstatusObj = new Dictionary<string, ListStatusByFac>();
		foreach (JObject statusobj in Monthstatusjarr) {
			string ObjFactory = statusobj["车间"].ToString();
			string ObjTime = statusobj["时间"].ToString();
			string KeyStr = ObjFactory + "|" + ObjTime;
			ListStatusbyRule newLStatu = new ListStatusbyRule(statusobj["RuleId"].ToString(), ObjTime, ObjFactory, statusobj["项目"].ToString(), statusobj["规则类"].ToString(), float.Parse(((JValue)statusobj["阀值"]).Value.ToString()), (bool)(((JValue)statusobj["自动"]).Value));
			newLStatu.CollectionValue = float.Parse(((JValue)statusobj["采集值"]).Value.ToString());
			newLStatu.ListValue = (bool)(((JValue)statusobj["挂牌"]).Value);
			if (MonthstatusObj.ContainsKey(KeyStr)) {//有这个车间
				MonthstatusObj[KeyStr].Factory_List_Status.Add(newLStatu);
			}
			else {//暂时没有这个车间
				ListStatusByFac newfac = new ListStatusByFac(ObjFactory, ObjTime);
				newfac.Factory_List_Status.Add(newLStatu);
				MonthstatusObj.Add(KeyStr, newfac);
			}
		}
		return MonthstatusObj;
	}
	public void DelStatus() {
		string _ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"DELETE FROM [EPInfoSystem].[dbo].[ListStatus]
							WHERE [时间]='" + this._Time + "'";
		DBOper dbcom = new DBOper(source, DBcommand);
		_ret = dbcom.ReturnRows();
		this._MonthstatusStr = "[]";
	}
	public string CreateStatus() {
		string DBcommand;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		JArray Monthstatusjarr = JArray.Parse(this._MonthstatusStr);
		Dictionary<string, ListStatusByFac> MonthstatusObj = BuildMonthObj(Monthstatusjarr);
		string ListRulesStr = this.ReadRules();
		JArray LRulesObj = JArray.Parse(ListRulesStr);
		foreach (JObject Ruleobj in LRulesObj) {
			//看Monthstatus有没有这个规则结果。如果有，那么更新则使用update语句，如果没有这个Id的规则结果，则使用insert语句
			string ObjFactory = Ruleobj["车间"].ToString();
			string ObjTime = this._Time;
			string KeyStr = ObjFactory + "|" + ObjTime;
			string Objid = Ruleobj["RuleId"].ToString();
			int hasrule;
			if (MonthstatusObj.ContainsKey(KeyStr)) {
				hasrule = MonthstatusObj[KeyStr].Factory_List_Status.FindIndex(delegate(ListStatusbyRule sch) { return sch.RuleId == Objid; });
			}
			else hasrule = -1;
			//不管有没有这个规则，都需要先实例化由rule生成的规则结果类，以录入或覆盖原来的规则
			ListStatusbyRule newLStatu = new ListStatusbyRule(Ruleobj["RuleId"].ToString(), ObjTime, ObjFactory, Ruleobj["项目"].ToString(), Ruleobj["规则"].ToString(), float.Parse(((JValue)Ruleobj["阀值"]).Value.ToString()), true);
			newLStatu.GetCValueFromDB();
			newLStatu.ListValue = newLStatu.SetListValue();
			int ifauto;
			int lvalue;
			if (newLStatu.IfAuto) { ifauto = 1; } else { ifauto = 0; }
			if (newLStatu.ListValue) { lvalue = 1; } else { lvalue = 0; }
			if (hasrule == -1) {//没有这个规则				
				if (MonthstatusObj.ContainsKey(KeyStr)) {//有车间无规则，直接在车间里面加这个规则
					MonthstatusObj[KeyStr].Factory_List_Status.Add(newLStatu);
				}
				else {//规则车间都没有
					ListStatusByFac newfac = new ListStatusByFac(ObjFactory, ObjTime);
					newfac.Factory_List_Status.Add(newLStatu);
					MonthstatusObj.Add(KeyStr, newfac);

				}
				DBcommand =
								   @"INSERT INTO [EPInfoSystem].[dbo].[ListStatus]
											   ([时间]
											   ,[车间]
											   ,[项目]
											   ,[RuleId]
											   ,[规则类]
											   ,[阀值]
											   ,[采集值]
											   ,[自动]
											   ,[挂牌])
										 VALUES
											   ('" + this._Time + @"'
											   ,'" + ObjFactory + @"'
											   ,'" + newLStatu.Type + @"'
											   ,'" + newLStatu.RuleId + @"'
											   ,'" + newLStatu.RuleType + @"'
											   ,'" + newLStatu.ThresHold + @"'
											   ,'" + newLStatu.CollectionValue + @"'
											   ," + ifauto + @"
											   ," + lvalue + @"
												)";
			}
			else {//有这个规则，修改Month类中的这个规则，然后使用update语句而不是insert			
				MonthstatusObj[KeyStr].Factory_List_Status[hasrule] = newLStatu;
				DBcommand = @"
								UPDATE [EPInfoSystem].[dbo].[ListStatus]
								   SET 
									   [车间] = '" + ObjFactory + @"'
									  ,[项目] = '" + newLStatu.Type + @"'									
									  ,[规则类] = '" + newLStatu.RuleType + @"'
									  ,[阀值] = " + newLStatu.ThresHold + @"
									  ,[采集值] =" + newLStatu.CollectionValue + @"
									  ,[自动] = " + ifauto + @"
									  ,[挂牌] = " + lvalue + @"
								 WHERE [时间] ='" + this._Time + "'AND [RuleId]=" + newLStatu.RuleId;
			}
			DBOper dbcom = new DBOper(source, DBcommand);
			string _ret = dbcom.ReturnRows();
		}
		return JsonConvertHelper.SerializeObject(MonthstatusObj);
	}

	public string ReadStatus() {
		JArray Monthstatusjarr = JArray.Parse(this._MonthstatusStr);
		Dictionary<string, ListStatusByFac> MonthstatusObj = BuildMonthObj(Monthstatusjarr);
		return JsonConvertHelper.SerializeObject(MonthstatusObj);
	}
	public string ReadRules() {
		string _ret;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		string DBcommand = @"SELECT [RuleId]
							,[车间]
							,[项目]
							,[规则]
							,[阀值]
						FROM [EPInfoSystem].[dbo].[ListRule]";
		DBOper dbcom = new DBOper(source, DBcommand);
		_ret = dbcom.ReturnJson();
		return _ret;
	}
	public static string ManualList(string time, string RuleId) {
		string DBcommand;
		string source = ConfigurationManager.ConnectionStrings["EPInfoSys"].ConnectionString.ToString();
		DBcommand = @"
								UPDATE [EPInfoSystem].[dbo].[ListStatus]
								   SET [自动] = 0
									  ,[挂牌] = ([挂牌]+1)%2
								 WHERE [时间] ='" + time + "'AND [RuleId]=" + RuleId;

		DBOper dbcom = new DBOper(source, DBcommand);
		string _ret = dbcom.ReturnRows();
		return _ret;
	}
}