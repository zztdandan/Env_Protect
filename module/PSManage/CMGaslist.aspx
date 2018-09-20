<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CMGaslist.aspx.cs" Inherits="module_PSManage_CMlist" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../bootstrap3/js/bootstrap.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
        <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="/bootstrap3/js/respond.min.js"></script>
        <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="/bootstrap3/js/respond.min.js"></script>
    <script src="../../datatables/js/jquery.dataTables.min.js"></script>
    <link href="../../datatables/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="../../css/mycss.css" rel="stylesheet" />
    <script src="../../JavaScript/CookieFunc.js"></script>
    <title></title>
    <style type="text/css">
        table.tableizer-table {
            border: 1px solid #ccc;
            font-family: Arial,Helvetica,sans-serif;
            font-size: 12px;
            white-space: nowrap;
            width: 100%;
        }

        .tableizer-table td {
            padding: 4px;
            margin: 3px;
            border: 1px solid #ccc;
        }

        .tableizer-table th {
            background-color: #104e8b;
            color: #fff;
            font-weight: bold;
             border: 1px solid #ffffff;
        }
    </style>
    <script>

    </script>
</head>
<body>
    <div class="samplearea">

        <table class="tableizer-table table">
            <thead>
                <tr class="tableizer-firstrow">
                    <th rowspan="2">序号</th>
                    <th rowspan="2">区域</th>
                    <th rowspan="2">环保设施名称</th>
                    <th colspan="5">风机铭牌参数</th>
                   
                    <th colspan="5">电机铭牌参数</th>
                    
                    <th>实际工作电流</th>
                    <th colspan="12">除尘器技术参数</th>
                    
                    <th rowspan="2">投运时间</th>
                    <th rowspan="2">除尘范围</th>
                    <th rowspan="2">除尘点数</th>
                    <th colspan="2">烟囱</th>
                    
                </tr>
                <tr>
                    
                    <th>型号</th>
                    <th>流量（m3/h)</th>
                    <th>全压（Pa）</th>
                    <th>转速（r/min）</th>
                    <th>厂家</th>
                    <th>型号</th>
                    <th>功率（kw）</th>
                    <th>额定电压 （v）</th>
                    <th>额定电流 （A）</th>
                    <th>厂家</th>
                    <th>&nbsp;</th>
                    <th>型号</th>
                    <th>箱体结构</th>
                    <th>反吹方式</th>
                    <th>滤袋材质</th>
                    <th>滤袋规格（mm）</th>
                    <th>滤袋数量（条）</th>
                    <th>过滤面积（m2）</th>
                    <th>理论过滤风速 （m/min）</th>
                    <th>最近一次整体更换滤袋时间</th>
                    <th>进出口总压差（Pa）</th>
                    <th>正常生产时每天收集除尘灰数量（t）</th>
                    <th>厂家</th>
                   
                    <th>直径（m）</th>
                    <th>高度（m）</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td rowspan="9">出铁场除尘</td>
                    <td>1#A高炉罐位除尘系统</td>
                    <td>Y4－73 №22D</td>
                    <td>346000</td>
                    <td>3962</td>
                    <td>960</td>
                    <td>江阴 鼓风机厂</td>
                    <td>YKK500－4－6</td>
                    <td>630</td>
                    <td>10k</td>
                    <td>46.1</td>
                    <td>西安西玛电机（集团）</td>
                    <td>31</td>
                    <td>XLDM4200</td>
                    <td>2排1风道12室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>1800</td>
                    <td>4239</td>
                    <td>1.36 </td>
                    <td>2013.8</td>
                    <td>2250</td>
                    <td>12</td>
                    <td>张家港市中新环保设备有限公司</td>
                    <td>2003年9月</td>
                    <td>1#A高炉罐位、撇渣器、炉顶。</td>
                    <td>5个点（3个同时）</td>
                    <td>2.5</td>
                    <td>40</td>
                </tr>
                <tr>
                    <td>2</td>

                    <td>1#A高炉铁口除尘系统</td>
                    <td>Y4－73 №22D</td>
                    <td>346000</td>
                    <td>3962</td>
                    <td>960</td>
                    <td>沈阳 风机厂</td>
                    <td>YKK5004－6</td>
                    <td>630</td>
                    <td>10k</td>
                    <td>46</td>
                    <td>长沙电机厂</td>
                    <td>21</td>
                    <td>CDL－6</td>
                    <td>2排1风道12室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>1800</td>
                    <td>4239</td>
                    <td>1.36 </td>
                    <td>2013.10 </td>
                    <td>2420</td>
                    <td>1</td>
                    <td>西江造船 </td>
                    <td>2004年10月</td>
                    <td>1#A高炉铁口顶吸、铁口侧吸。</td>
                    <td>6个点（3个同时）</td>
                    <td>2.5</td>
                    <td>25</td>
                </tr>
                <tr>
                    <td>3</td>

                    <td>1#B高炉炉前除尘系统</td>
                    <td>Y4－2×80 24F</td>
                    <td>902000</td>
                    <td>4403</td>
                    <td>960</td>
                    <td>重庆通用工业（集团）</td>
                    <td>YKK710－6</td>
                    <td>2000</td>
                    <td>10k</td>
                    <td>143</td>
                    <td>重庆赛力盟 电机公司</td>
                    <td>69</td>
                    <td>CDLS－8</td>
                    <td>4排2风道32室</td>
                    <td>定压/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>4800</td>
                    <td>11304</td>
                    <td>1.33 </td>
                    <td>2013.11</td>
                    <td>1900</td>
                    <td>10</td>
                    <td>泊头钢花</td>
                    <td>2009年5月</td>
                    <td>1#B高炉铁口顶吸、铁口侧吸、罐位、撇渣器、炉顶。</td>
                    <td>11个点（6个同时）</td>
                    <td>4.5</td>
                    <td>25</td>
                </tr>
                <tr>
                    <td>4</td>

                    <td>2#高炉炉前除尘系统（2台风机）</td>
                    <td>Y5－2×48 №24F</td>
                    <td>712000×2</td>
                    <td>5325</td>
                    <td>730</td>
                    <td>金通灵风机有限公司</td>
                    <td>YKK710－8</td>
                    <td>1600×2</td>
                    <td>10k</td>
                    <td>112.3 117.1</td>
                    <td>卧龙电气（1#） 佳木斯电机（2#）</td>
                    <td>85（1#） 84（2#）</td>
                    <td>CDLS―12</td>
                    <td>4排2风道48室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>7200</td>
                    <td>16956</td>
                    <td>1.40 </td>
                    <td>未换过</td>
                    <td>1530</td>
                    <td>28</td>
                    <td>泊头钢花</td>
                    <td>2012年10月</td>
                    <td>2#高炉铁口顶吸、铁口侧吸、罐位、撇渣器、渣沟、炉顶。</td>
                    <td>25个点（9个同时）</td>
                    <td>4</td>
                    <td>40</td>
                </tr>
                <tr>
                    <td>5</td>

                    <td>3#高炉炉前除尘系统</td>
                    <td>Y5－2×51 29F</td>
                    <td>1006000</td>
                    <td>4750</td>
                    <td>730</td>
                    <td>金通灵风机有限公司</td>
                    <td>YKK800－8W</td>
                    <td>2240</td>
                    <td>10k</td>
                    <td>158.3</td>
                    <td>佳木斯电机</td>
                    <td>84</td>
                    <td>CDL－18</td>
                    <td>2排1风道36室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>5400</td>
                    <td>12717</td>
                    <td>1.32 </td>
                    <td>2014.4</td>
                    <td>2300</td>
                    <td>15</td>
                    <td>泊头钢花</td>
                    <td>2008年10月</td>
                    <td>3#高炉铁口顶吸、铁口侧吸、罐位、撇渣器、炉顶。</td>
                    <td>9个点（5个同时）</td>
                    <td>5</td>
                    <td>25</td>
                </tr>
                <tr>
                    <td>6</td>

                    <td>4#高炉炉前除尘系统</td>
                    <td>Y5－2×51 29F</td>
                    <td>1006000</td>
                    <td>4750</td>
                    <td>730</td>
                    <td>金通灵风机有限公司</td>
                    <td>YKK800－8</td>
                    <td>2240</td>
                    <td>10k</td>
                    <td>158</td>
                    <td>上海电气 上海电机厂</td>
                    <td>63</td>
                    <td>CDL－18</td>
                    <td>2排1风道36室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>5400</td>
                    <td>12717</td>
                    <td>1.32 </td>
                    <td>2014.1</td>
                    <td>2340</td>
                    <td>11</td>
                    <td>泊头钢花</td>
                    <td>2008年3月</td>
                    <td>4#高炉铁口顶吸、铁口侧吸、罐位、撇渣器、炉顶。</td>
                    <td>9个点（5个同时）</td>
                    <td>5</td>
                    <td>40</td>
                </tr>
                <tr>
                    <td>7</td>

                    <td>5#高炉炉前除尘系统</td>
                    <td>Y4－2×80 №24.5F</td>
                    <td>900000</td>
                    <td>5800</td>
                    <td>960</td>
                    <td>重庆通用工业（集团）</td>
                    <td>YKK710－6</td>
                    <td>2240</td>
                    <td>6k</td>
                    <td>261.7</td>
                    <td>湘潭电机集团有限公司</td>
                    <td>147</td>
                    <td>CDLS－8</td>
                    <td>4排2风道32室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>4800</td>
                    <td>11304</td>
                    <td>1.33 </td>
                    <td>2013.8</td>
                    <td>1060</td>
                    <td>8</td>
                    <td>泊头钢花</td>
                    <td>2008年6月</td>
                    <td>5#高炉铁口顶吸、罐位、撇渣器、炉顶。</td>
                    <td>7个点（4个同时）</td>
                    <td>4.5</td>
                    <td>40</td>
                </tr>
                <tr>
                    <td>8</td>

                    <td>6#高炉罐位除尘系统</td>
                    <td>Y4－73 28D</td>
                    <td>500000</td>
                    <td>3844</td>
                    <td>730</td>
                    <td>四平市宏生鼓风机有限公司</td>
                    <td>YKK560－6－8</td>
                    <td>800</td>
                    <td>6k</td>
                    <td>99.1</td>
                    <td>西安西玛电机（集团）</td>
                    <td>83</td>
                    <td>CDL－9</td>
                    <td>2排1风道18室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>130×6000</td>
                    <td>2700</td>
                    <td>6613</td>
                    <td>1.26 </td>
                    <td>2014.6</td>
                    <td>3390</td>
                    <td>3</td>
                    <td>上海泰山</td>
                    <td>2005年9月</td>
                    <td>6#高炉罐位、撇渣器。</td>
                    <td>4个点（2个同时）</td>
                    <td>3</td>
                    <td>40</td>
                </tr>
                <tr>
                    <td>9</td>

                    <td>6#高炉铁口除尘系统</td>
                    <td>Y4－73－12 №28D</td>
                    <td>500000</td>
                    <td>3844</td>
                    <td>730</td>
                    <td>沈阳风机厂</td>
                    <td>YKK560－6－8</td>
                    <td>800</td>
                    <td>6k</td>
                    <td>99.1</td>
                    <td>西安西玛电机（集团）</td>
                    <td>90</td>
                    <td>CDL－9</td>
                    <td>2排1风道18室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>2700</td>
                    <td>6358</td>
                    <td>1.31 </td>
                    <td>2011.5</td>
                    <td>2950</td>
                    <td>14</td>
                    <td>泊头钢花</td>
                    <td>2005年5月</td>
                    <td>6#高炉铁口顶吸、炉顶。</td>
                    <td>3个点（2个同时）</td>
                    <td>3</td>
                    <td>25</td>
                </tr>
                <tr>
                    <td>10</td>
                    <td rowspan="8">矿槽 除尘</td>
                    <td>1#A高炉矿槽除尘系统（2套箱体）</td>
                    <td>G4－73－11 22D</td>
                    <td>405000</td>
                    <td>5433</td>
                    <td>960</td>
                    <td>沈阳风机厂</td>
                    <td>YKK5602－6</td>
                    <td>800</td>
                    <td>10k</td>
                    <td>57.4</td>
                    <td>江西特种电机股份有限公司</td>
                    <td>43</td>
                    <td>CDL―5 CDY―1.5</td>
                    <td>2排1风道10室 1排1风道3室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000 125×7500</td>
                    <td>1950</td>
                    <td>4845</td>
                    <td>1.39 </td>
                    <td>2015.6</td>
                    <td>3100</td>
                    <td>48</td>
                    <td>西江造船 泊头钢花</td>
                    <td>2003年9月</td>
                    <td>1#A高炉矿槽槽上、槽下、主皮带。</td>
                    <td>65个点</td>
                    <td>2.4</td>
                    <td>30</td>
                </tr>
                <tr>
                    <td>11</td>

                    <td>1#B高炉矿槽除尘系统</td>
                    <td>Y4－73－11 20D</td>
                    <td>211470~ 320610</td>
                    <td>5740~ 3870</td>
                    <td>960</td>
                    <td>江阴 鼓风机厂</td>
                    <td>YKK5003－6</td>
                    <td>560</td>
                    <td>10k</td>
                    <td>41.2</td>
                    <td>西安西玛电机（集团）</td>
                    <td>30</td>
                    <td>CDL－6</td>
                    <td>2排1风道12室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>1800</td>
                    <td>4239</td>
                    <td>1.26 </td>
                    <td>2014.11</td>
                    <td>2120</td>
                    <td>46</td>
                    <td>西江造船 </td>
                    <td>2004年3月</td>
                    <td>1#B高炉矿槽槽上、槽下、主皮带。</td>
                    <td>65个点</td>
                    <td>2.4</td>
                    <td>30</td>
                </tr>
                <tr>
                    <td>12</td>

                    <td>2#高炉焦槽除尘除尘系统</td>
                    <td>G4－73－12 №29.5D</td>
                    <td>520000</td>
                    <td>4315</td>
                    <td>596</td>
                    <td>沈阳风机厂</td>
                    <td>YKK6301－10</td>
                    <td>800</td>
                    <td>6k</td>
                    <td>102.1</td>
                    <td>西安西玛电机（集团）</td>
                    <td>73</td>
                    <td>CDL－8</td>
                    <td>2排1风道16室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>2400</td>
                    <td>5652</td>
                    <td>1.53 </td>
                    <td>2014.12 </td>
                    <td>2410</td>
                    <td>59</td>
                    <td>泊头钢花</td>
                    <td>2006年6月</td>
                    <td>2#高炉焦槽槽下、2#高炉主皮带、供料2#汽车料台周边区域皮带转运站。</td>
                    <td>121个点</td>
                    <td>3.5</td>
                    <td>30</td>
                </tr>
                <tr>
                    <td>13</td>

                    <td>2#高炉矿槽除尘除尘系统</td>
                    <td>G4－73－12 №29.5D</td>
                    <td>702000</td>
                    <td>6278</td>
                    <td>745</td>
                    <td>沈阳风机厂</td>
                    <td>YKK710－8</td>
                    <td>1600</td>
                    <td>6k</td>
                    <td>112.3</td>
                    <td>卧龙电气武汉电机有限公司</td>
                    <td>75</td>
                    <td>CDL－14</td>
                    <td>2排1风道28室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>4200</td>
                    <td>9891</td>
                    <td>1.18 </td>
                    <td>2012.11 </td>
                    <td>1440</td>
                    <td>64</td>
                    <td>泊头钢花</td>
                    <td>2012年9月</td>
                    <td>2#高炉矿槽槽下、2#高炉矿槽槽上、2#高炉焦槽槽上、供料2#矿槽周边区域皮带转运站</td>
                    <td>64个点</td>
                    <td>4</td>
                    <td>30</td>
                </tr>
                <tr>
                    <td>14</td>

                    <td>3#高炉矿槽除尘系统</td>
                    <td>Y4－73 29.5F</td>
                    <td>638000</td>
                    <td>5372</td>
                    <td>730</td>
                    <td>金通灵风机有限公司</td>
                    <td>YKK710－8</td>
                    <td>1600</td>
                    <td>10k</td>
                    <td>118</td>
                    <td>上海电气 上海电机厂</td>
                    <td>70</td>
                    <td>CDL－11</td>
                    <td>2排1风道22室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>3300</td>
                    <td>7772</td>
                    <td>1.35 </td>
                    <td>2011.9 </td>
                    <td>2310</td>
                    <td>92</td>
                    <td>泊头钢花</td>
                    <td>2008年5月</td>
                    <td>3#高炉矿槽槽上、槽下、主皮带</td>
                    <td>73个点</td>
                    <td>4</td>
                    <td>25</td>
                </tr>
                <tr>
                    <td>15</td>

                    <td>4#高炉矿槽除尘系统</td>
                    <td>Y4－73 29.5F</td>
                    <td>638000</td>
                    <td>5372</td>
                    <td>730</td>
                    <td>金通灵风机有限公司</td>
                    <td>YKK710－8</td>
                    <td>1600</td>
                    <td>10k</td>
                    <td>118</td>
                    <td>上海电气 上海电机厂</td>
                    <td>70</td>
                    <td>CDL－11</td>
                    <td>2排1风道22室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>3300</td>
                    <td>7772</td>
                    <td>1.35 </td>
                    <td>2011.8 </td>
                    <td>1900</td>
                    <td>88</td>
                    <td>泊头钢花</td>
                    <td>2008年1月</td>
                    <td>4#高炉矿槽槽上、槽下、主皮带</td>
                    <td>59个点</td>
                    <td>4</td>
                    <td>25</td>
                </tr>
                <tr>
                    <td>16</td>

                    <td>5#高炉矿槽除尘系统</td>
                    <td>G4－73－12 №25D</td>
                    <td>388000</td>
                    <td>4776</td>
                    <td>730</td>
                    <td>沈阳风机厂</td>
                    <td>YKK560－2－8</td>
                    <td>710</td>
                    <td>6k</td>
                    <td>88.1</td>
                    <td>西安电机厂</td>
                    <td>52</td>
                    <td>CDL－6</td>
                    <td>2排1风道12室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>1800</td>
                    <td>4239</td>
                    <td>1.53 </td>
                    <td>2015.60 </td>
                    <td>2230</td>
                    <td>22</td>
                    <td>西江造船 </td>
                    <td>2005年5月</td>
                    <td>5#高炉矿槽槽上、槽下、5#及6#高炉主皮带</td>
                    <td>63个点</td>
                    <td>2.5</td>
                    <td>25</td>
                </tr>
                <tr>
                    <td>17</td>

                    <td>6#高炉矿槽除尘系统</td>
                    <td>G4－73 25D</td>
                    <td>388000</td>
                    <td>4776</td>
                    <td>730</td>
                    <td>四平市宏生鼓风机有限公司</td>
                    <td>YKK710－6</td>
                    <td>800</td>
                    <td>6k</td>
                    <td>88.1</td>
                    <td>柳州市上科电气机械制造有限公司</td>
                    <td>71</td>
                    <td>CDL－6</td>
                    <td>2排1风道12室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>1800</td>
                    <td>4239</td>
                    <td>1.53 </td>
                    <td>2013.10 </td>
                    <td>2640</td>
                    <td>62</td>
                    <td>西江造船 </td>
                    <td>2005年9月</td>
                    <td>6#高炉矿槽槽上、槽下、主皮带</td>
                    <td>61个点</td>
                    <td>2.5</td>
                    <td>25</td>
                </tr>
                <tr>
                    <td>18</td>
                    <td rowspan="4">供料皮带集中除尘</td>
                    <td>球团集中除尘除尘系统</td>
                    <td>Y4－73 18D</td>
                    <td>185650</td>
                    <td>4305</td>
                    <td>960</td>
                    <td>江苏金通灵流体机械科技股份有限公司</td>
                    <td>YKK4006－6</td>
                    <td>355</td>
                    <td>6k</td>
                    <td>37.5</td>
                    <td>江西特种电机股份有限公司</td>
                    <td>29</td>
                    <td>CDL－4</td>
                    <td>2排1风道8室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>1200</td>
                    <td>2826</td>
                    <td>1.09 </td>
                    <td>未换过</td>
                    <td>1590</td>
                    <td>5</td>
                    <td>泊头钢花</td>
                    <td>2013年10月</td>
                    <td>三焦线4条皮带、一球线5条皮带、二球线3条皮带、新矿线5条皮带、5#汽车料台、一球15#下2#炉14#皮带。</td>
                    <td>51个点</td>
                    <td>2.2</td>
                    <td>23</td>
                </tr>
                <tr>
                    <td>19</td>

                    <td>四焦集中除尘系统</td>
                    <td>G4－73－11 12D</td>
                    <td>97554</td>
                    <td>3650</td>
                    <td>1450</td>
                    <td>长沙华中 工业风机厂</td>
                    <td>Y2315L1－4</td>
                    <td>160</td>
                    <td>380</td>
                    <td>287</td>
                    <td>上海大速电机有限公司</td>
                    <td>160</td>
                    <td>CDY－1.5</td>
                    <td>三箱体</td>
                    <td>定时/离线</td>
                    <td>550g/m2防静电涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>432</td>
                    <td>1017</td>
                    <td>1.60 </td>
                    <td>2014.3 </td>
                    <td>&nbsp;</td>
                    <td>4</td>
                    <td>西江造船 </td>
                    <td>2005年11月</td>
                    <td>四焦线6条皮带。</td>
                    <td>18个点</td>
                    <td>1.3</td>
                    <td>21</td>
                </tr>
                <tr>
                    <td>20</td>

                    <td>3#360烧结集中除尘系统</td>
                    <td>G4－73－12 №18D</td>
                    <td>185650</td>
                    <td>4305</td>
                    <td>960</td>
                    <td>沈阳风机厂</td>
                    <td>YKK450－6</td>
                    <td>315</td>
                    <td>10k</td>
                    <td>23.9</td>
                    <td>江苏航天动力机电有限公司</td>
                    <td>18</td>
                    <td>CDY－4</td>
                    <td>1排1风道8室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>1200</td>
                    <td>2826</td>
                    <td>1.09 </td>
                    <td>未换过</td>
                    <td>1940</td>
                    <td>41</td>
                    <td>泊头钢花</td>
                    <td>2012年 11月</td>
                    <td>返烧线3条皮带、一焦线3条皮带、5#6#炉供料5条皮带、2#炉供料烧结7条皮带、5#炉返矿3条皮带。</td>
                    <td>42个点</td>
                    <td>2.1</td>
                    <td>26</td>
                </tr>
                <tr>
                    <td>21</td>

                    <td>三焦集中除尘系统</td>
                    <td>Y4－73 №14D</td>
                    <td>138164</td>
                    <td>3079</td>
                    <td>1460</td>
                    <td>贵州省 鼓风机厂</td>
                    <td>Y355M－4</td>
                    <td>220</td>
                    <td>380</td>
                    <td>407</td>
                    <td>重庆赛力盟 电机公司</td>
                    <td>330</td>
                    <td>CDY－2.5</td>
                    <td>1排1风道5室</td>
                    <td>定时/离线</td>
                    <td>550g/m2防静电涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>750</td>
                    <td>1766</td>
                    <td>1.30 </td>
                    <td>未换过</td>
                    <td>&nbsp;</td>
                    <td>5</td>
                    <td>泊头钢花</td>
                    <td>2015年 1月</td>
                    <td>三焦1#皮带、三焦2#皮带及延长线、三焦3#皮带、三焦4#皮带（机尾）、四焦11#皮带（机头）、A区6#皮带（机头）、A区7#皮带（机尾）。</td>
                    <td>17个点（其中最多12个点同时开）</td>
                    <td>1.8</td>
                    <td>22</td>
                </tr>
                <tr>
                    <td>22</td>
                    <td rowspan="11">供料皮带转运站除尘</td>
                    <td>1#A炉19#皮带转运站除尘系统</td>
                    <td>4－72－12 №16D</td>
                    <td>51000</td>
                    <td>2842</td>
                    <td>1450</td>
                    <td>&nbsp;</td>
                    <td>Y250M－4</td>
                    <td>55</td>
                    <td>380</td>
                    <td>102.5</td>
                    <td>长沙电机厂</td>
                    <td>&nbsp;</td>
                    <td>CDY－1</td>
                    <td>双箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>288</td>
                    <td>678</td>
                    <td>1.25 </td>
                    <td>未换过</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>西江造船 </td>
                    <td>2003年10月</td>
                    <td>四焦19#皮带（机头）、四焦20#皮带（机尾）、5#炉15#皮带（机头）、二烧7#皮带（机尾）。</td>
                    <td>4个点</td>
                    <td>1.1</td>
                    <td>3</td>
                </tr>
                <tr>
                    <td>23</td>

                    <td>三烧1#皮带转运站除尘系统</td>
                    <td>4－72－12 №8C</td>
                    <td>22600</td>
                    <td>3067</td>
                    <td>1800</td>
                    <td>长沙华中 工业风机厂</td>
                    <td>YE3－200L－4</td>
                    <td>30</td>
                    <td>380</td>
                    <td>56.6</td>
                    <td>河南豫通电机股份公司</td>
                    <td>20</td>
                    <td>CDD－1</td>
                    <td>单箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>150</td>
                    <td>353</td>
                    <td>1.07 </td>
                    <td>2014.12 </td>
                    <td>&nbsp;</td>
                    <td>6</td>
                    <td>泊头钢花</td>
                    <td>2005年9月</td>
                    <td>三烧1#下三烧2#皮带、5#炉返矿Ⅵ皮带落返矿Ⅶ皮带。</td>
                    <td>4个点</td>
                    <td>1</td>
                    <td>16</td>
                </tr>
                <tr>
                    <td>24</td>

                    <td>四烧2#皮带转运站除尘系统</td>
                    <td>4－72－12 №8C</td>
                    <td>22600</td>
                    <td>3067</td>
                    <td>1800</td>
                    <td>长沙华中 工业风机厂</td>
                    <td>YX8－200L－4</td>
                    <td>30</td>
                    <td>380</td>
                    <td>56</td>
                    <td>江苏大中地脚股份公司</td>
                    <td>19</td>
                    <td>CDD－1</td>
                    <td>单箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>150</td>
                    <td>353</td>
                    <td>1.07 </td>
                    <td>2014.2 </td>
                    <td>&nbsp;</td>
                    <td>1</td>
                    <td>泊头钢花</td>
                    <td>2005年9月</td>
                    <td>四烧1#下三烧2#皮带、四烧2#下三烧2#皮带、四烧2#下四烧3#皮带。</td>
                    <td>5个点</td>
                    <td>1</td>
                    <td>16</td>
                </tr>
                <tr>
                    <td>25</td>

                    <td>四烧3#皮带转运站除尘系统</td>
                    <td>G4－73－11 №10D</td>
                    <td>31554</td>
                    <td>3301</td>
                    <td>1450</td>
                    <td>长沙华中 工业风机厂</td>
                    <td>Y250M－4</td>
                    <td>55</td>
                    <td>380</td>
                    <td>102</td>
                    <td>江西特种电机股份有限公司</td>
                    <td>61</td>
                    <td>CDD－1</td>
                    <td>单箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>150</td>
                    <td>353</td>
                    <td>1.49 </td>
                    <td>2014.3 </td>
                    <td>&nbsp;</td>
                    <td>1.5</td>
                    <td>泊头钢花</td>
                    <td>2005年9月</td>
                    <td>四烧3#下四烧5#皮带、四烧4#下四烧5#皮带、5#炉返矿Ⅴ皮带下返矿Ⅵ皮带。</td>
                    <td>5个点</td>
                    <td>1.2</td>
                    <td>15</td>
                </tr>
                <tr>
                    <td>26</td>

                    <td>一焦6#皮带转运站除尘系统</td>
                    <td>4－72－12 №8C</td>
                    <td>27450</td>
                    <td>2930</td>
                    <td>1800</td>
                    <td>长沙华中 工业风机厂</td>
                    <td>Y200L2－2</td>
                    <td>37</td>
                    <td>380</td>
                    <td>69.8</td>
                    <td>长沙电机厂</td>
                    <td>41</td>
                    <td>CDD－1</td>
                    <td>单箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>150</td>
                    <td>353</td>
                    <td>1.30 </td>
                    <td>2014.10 </td>
                    <td>&nbsp;</td>
                    <td>2</td>
                    <td>泊头钢花</td>
                    <td>2005年9月</td>
                    <td>一焦6#下一焦8#皮带、一焦焦炭取样。</td>
                    <td>3个点</td>
                    <td>1.2</td>
                    <td>15</td>
                </tr>
                <tr>
                    <td>27</td>

                    <td>A区7#皮带转运站除尘系统</td>
                    <td>G4－73 №11D</td>
                    <td>47427</td>
                    <td>3986</td>
                    <td>1450</td>
                    <td>湖北双剑 鼓风机</td>
                    <td>Y280S－4</td>
                    <td>75</td>
                    <td>380</td>
                    <td>188</td>
                    <td>西门子电机（中国）</td>
                    <td>96</td>
                    <td>CDY－1</td>
                    <td>双箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>300</td>
                    <td>707</td>
                    <td>1.12 </td>
                    <td>2012.2 </td>
                    <td>&nbsp;</td>
                    <td>2</td>
                    <td>泊头钢花</td>
                    <td>2008年7月</td>
                    <td>A区7#下A区8#皮带、一焦8#下A区8#皮带。</td>
                    <td>6个点</td>
                    <td>1.3</td>
                    <td>15</td>
                </tr>
                <tr>
                    <td>28</td>

                    <td>A区8#皮带转运站除尘系统</td>
                    <td>G4－73 №11D</td>
                    <td>47427</td>
                    <td>3986</td>
                    <td>1450</td>
                    <td>湖北双剑 鼓风机</td>
                    <td>Y280S－4</td>
                    <td>75</td>
                    <td>380</td>
                    <td>188</td>
                    <td>西门子电机（中国）</td>
                    <td>88</td>
                    <td>CDY－1</td>
                    <td>双箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>300</td>
                    <td>707</td>
                    <td>1.12 </td>
                    <td>2013.2 </td>
                    <td>&nbsp;</td>
                    <td>4</td>
                    <td>泊头钢花</td>
                    <td>2008年7月</td>
                    <td>A区8#下9#皮带、返烧12#下13#皮带、二焦19#下焦炭1#皮带、焦炭1#下焦炭2#皮带。</td>
                    <td>7个点</td>
                    <td>1.3</td>
                    <td>15</td>
                </tr>
                <tr>
                    <td>29</td>

                    <td>A区9#皮带转运站除尘系统</td>
                    <td>G4－73 №11D</td>
                    <td>47427</td>
                    <td>3986</td>
                    <td>1450</td>
                    <td>湖北双剑 鼓风机</td>
                    <td>Y280S－4</td>
                    <td>75</td>
                    <td>380</td>
                    <td>188</td>
                    <td>西门子电机（中国）</td>
                    <td>76</td>
                    <td>CDY－1</td>
                    <td>双箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>300</td>
                    <td>707</td>
                    <td>1.12 </td>
                    <td>2014.4 </td>
                    <td>&nbsp;</td>
                    <td>6</td>
                    <td>泊头钢花</td>
                    <td>2008年7月</td>
                    <td>A区9#下10#皮带、返烧11#下12#皮带。</td>
                    <td>4个点</td>
                    <td>1.3</td>
                    <td>15</td>
                </tr>
                <tr>
                    <td>30</td>

                    <td>A区20#皮带转运站除尘系统</td>
                    <td>G4－73 №12D</td>
                    <td>83088</td>
                    <td>4366</td>
                    <td>1450</td>
                    <td>湖北双剑 鼓风机</td>
                    <td>Y315L1－4</td>
                    <td>160</td>
                    <td>380</td>
                    <td>288</td>
                    <td>西门子电机（中国）</td>
                    <td>210</td>
                    <td>CDY－1.5</td>
                    <td>三箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>450</td>
                    <td>1060</td>
                    <td>1.31 </td>
                    <td>2014.7 </td>
                    <td>&nbsp;</td>
                    <td>1</td>
                    <td>泊头钢花</td>
                    <td>2008年11月</td>
                    <td>A区20#皮带、A区21#皮带、A区22#皮带（机尾）。</td>
                    <td>16个点</td>
                    <td>1.3</td>
                    <td>20</td>
                </tr>
                <tr>
                    <td>31</td>

                    <td>焦炭2#皮带转运站除尘系统</td>
                    <td>8F6G－61－1№9C</td>
                    <td>27000</td>
                    <td>4000</td>
                    <td>1550</td>
                    <td>沈阳 鼓风机厂</td>
                    <td>Y225M－4</td>
                    <td>45</td>
                    <td>380</td>
                    <td>84.2</td>
                    <td>山东华普电机科技有限公司</td>
                    <td>50</td>
                    <td>FMQD84－4</td>
                    <td>双箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2防静电涤纶针刺毡</td>
                    <td>130×3200</td>
                    <td>336</td>
                    <td>438</td>
                    <td>1.03 </td>
                    <td>未换过</td>
                    <td>&nbsp;</td>
                    <td>3</td>
                    <td>泊头钢花</td>
                    <td>2013年4月</td>
                    <td>焦炭2#下焦炭3#皮带。</td>
                    <td>2个点</td>
                    <td>1</td>
                    <td>21</td>
                </tr>
                <tr>
                    <td>32</td>

                    <td>焦炭3#皮带转运站除尘系统</td>
                    <td>G4－73 №11D</td>
                    <td>58570</td>
                    <td>3840</td>
                    <td>1450</td>
                    <td>沈阳 鼓风机厂</td>
                    <td>Y280M－4</td>
                    <td>90</td>
                    <td>380</td>
                    <td>164</td>
                    <td>山东华普电机科技有限公司</td>
                    <td>123</td>
                    <td>CDY－X－2</td>
                    <td>双箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2防静电涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>600</td>
                    <td>1413</td>
                    <td>0.69 </td>
                    <td>未换过</td>
                    <td>&nbsp;</td>
                    <td>7</td>
                    <td>泊头钢花</td>
                    <td>2013年4月</td>
                    <td>焦炭3#下焦炭4#皮带、焦炭3#下一焦9#皮带、焦炭4#下三焦2#皮带。</td>
                    <td>5个点</td>
                    <td>1.2</td>
                    <td>22</td>
                </tr>
                <tr>
                    <td>33</td>
                    <td>5#6#炉主Ⅳ皮带转运站 除尘系统</td>
                    <td>&nbsp;</td>
                    <td>Y4－73－11 №11D</td>
                    <td>75141</td>
                    <td>3060</td>
                    <td>1450</td>
                    <td>长沙华中 工业风机厂</td>
                    <td>Y280S－4</td>
                    <td>90</td>
                    <td>380</td>
                    <td>139.7</td>
                    <td>&nbsp;</td>
                    <td>92</td>
                    <td>CDY－1</td>
                    <td>双箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>300</td>
                    <td>707</td>
                    <td>1.75 </td>
                    <td>2014.3 </td>
                    <td>&nbsp;</td>
                    <td>8.5</td>
                    <td>泊头钢花</td>
                    <td>2006年3月</td>
                    <td>5#高炉主Ⅳ皮带下主Ⅴ皮带、6#炉主Ⅳ下主Ⅴ皮带皮带、5#6#炉返矿Ⅳ皮带落返矿Ⅴ皮带。</td>
                    <td>6个点</td>
                    <td>1.3</td>
                    <td>21</td>
                </tr>
                <tr>
                    <td>34</td>
                    <td>铸铁机除尘系统</td>
                    <td>&nbsp;</td>
                    <td>Y4－73 №28D</td>
                    <td>455000</td>
                    <td>3932</td>
                    <td>730</td>
                    <td>沈阳 鼓风机厂</td>
                    <td>YKK560－8</td>
                    <td>800</td>
                    <td>6k</td>
                    <td>102</td>
                    <td>重庆赛力盟 电机公司</td>
                    <td>90</td>
                    <td>CDL－8</td>
                    <td>2排1风道16室</td>
                    <td>定时/离线</td>
                    <td>550g/m2普通涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>2400</td>
                    <td>5652</td>
                    <td>1.34 </td>
                    <td>未换过</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>泊头钢花原建，冶建九公司搬迁复建</td>
                    <td>2015年4月</td>
                    <td>新铸铁机房。</td>
                    <td>3个点</td>
                    <td>3</td>
                    <td>21</td>
                </tr>

            </tbody>
        
        </table>


        <p>以上除尘系统的除尘站由环水车间管理，除尘管网设备由高炉、供料车间管理</p>


        <p>以下除尘系统的除尘站和除尘管网设备均由喷吹车间管理</p>


        <table class="tableizer-table  table">
           <thead>
                <tr class="tableizer-firstrow">
                    <th rowspan="2">序号</th>
                    <th rowspan="2">区域</th>
                    <th rowspan="2">环保设施名称</th>
                    <th colspan="5">风机铭牌参数</th>
                   
                    <th colspan="5">电机铭牌参数</th>
                    
                    <th>实际工作电流</th>
                    <th colspan="12">除尘器技术参数</th>
                    
                    <th rowspan="2">投运时间</th>
                    <th rowspan="2">除尘范围</th>
                    <th rowspan="2">除尘点数</th>
                    <th colspan="2">烟囱</th>
                    
                </tr>
                <tr>
                    
                    <th>型号</th>
                    <th>流量（m3/h)</th>
                    <th>全压（Pa）</th>
                    <th>转速（r/min）</th>
                    <th>厂家</th>
                    <th>型号</th>
                    <th>功率（kw）</th>
                    <th>额定电压 （v）</th>
                    <th>额定电流 （A）</th>
                    <th>厂家</th>
                    <th>&nbsp;</th>
                    <th>型号</th>
                    <th>箱体结构</th>
                    <th>反吹方式</th>
                    <th>滤袋材质</th>
                    <th>滤袋规格（mm）</th>
                    <th>滤袋数量（条）</th>
                    <th>过滤面积（m2）</th>
                    <th>理论过滤风速 （m/min）</th>
                    <th>最近一次整体更换滤袋时间</th>
                    <th>进出口总压差（Pa）</th>
                    <th>正常生产时每天收集除尘灰数量（t）</th>
                    <th>厂家</th>
                   
                    <th>直径（m）</th>
                    <th>高度（m）</th>
                </tr>
            </thead>

            <tfoot></tfoot>
            <tbody>


                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>东部老喷煤系统上料皮带除尘系统</td>
                    <td>Y4－73 11D</td>
                    <td>47427</td>
                    <td>3986</td>
                    <td>1450</td>
                    <td>江阴 鼓风机厂</td>
                    <td>YQ280S－4</td>
                    <td>75</td>
                    <td>380</td>
                    <td>137.6</td>
                    <td>江阴大中电机制造有限公司</td>
                    <td>&nbsp;</td>
                    <td>CDY－1</td>
                    <td>双箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2防静电涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>300</td>
                    <td>706</td>
                    <td>1.12 </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>泊头钢花</td>
                    <td>2015年 4月</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>东部新喷煤系统上料皮带除尘系统</td>
                    <td>G4－73－12 №11D</td>
                    <td>47427</td>
                    <td>3986</td>
                    <td>1450</td>
                    <td>沈阳风机厂</td>
                    <td>Y2－280S4</td>
                    <td>75</td>
                    <td>380</td>
                    <td>140</td>
                    <td>山东华普电机科技有限公司</td>
                    <td>&nbsp;</td>
                    <td>CDY－1</td>
                    <td>双箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2防静电涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>300</td>
                    <td>706</td>
                    <td>1.12 </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>泊头钢花</td>
                    <td>2012年5月</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>西部喷煤系统上料皮带除尘系统</td>
                    <td>Y4－73 №11D</td>
                    <td>80570</td>
                    <td>2109</td>
                    <td>1450</td>
                    <td>长沙华中一鼓风机有限公司</td>
                    <td>YE2－280S－4</td>
                    <td>75</td>
                    <td>380</td>
                    <td>137.8</td>
                    <td>湖南精益电机制造有限公司</td>
                    <td>&nbsp;</td>
                    <td>CDY－1</td>
                    <td>双箱体</td>
                    <td>定时/在线</td>
                    <td>550g/m2防静电涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>300</td>
                    <td>706</td>
                    <td>1.90 </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>泊头钢花</td>
                    <td>2010年12月</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>A区喷煤系统上料皮带除尘系统</td>
                    <td>G4－73－11 №12D</td>
                    <td>97554</td>
                    <td>3550</td>
                    <td>1450</td>
                    <td>长沙华中 工业风机厂</td>
                    <td>Y315L1－4</td>
                    <td>160</td>
                    <td>380</td>
                    <td>289</td>
                    <td>长沙电机厂</td>
                    <td>&nbsp;</td>
                    <td>CDY－2</td>
                    <td>1排1风道4室</td>
                    <td>定时/在线</td>
                    <td>550g/m2防静电涤纶针刺毡</td>
                    <td>125×6000</td>
                    <td>600</td>
                    <td>1413</td>
                    <td>1.15 </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>泊头钢花</td>
                    <td>2008年10月</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
