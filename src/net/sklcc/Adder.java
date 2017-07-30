package net.sklcc;

import cn.gsdata.index.ApiSdk;
import org.json.JSONObject;

import java.sql.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Hazza on 2016/8/7.
 */
public class Adder {
    private static final String urlSource = "jdbc:mysql://10.10.65.172:3306/wsa?useUnicode=true&characterEncoding=utf-8";
    private static final String userSource = "wechat";
    private static final String passSource = "sklcc";
    private static final String urlDest = "jdbc:mysql://139.196.188.70:3306/wsa?useUnicode=true&characterEncoding=utf-8";
    private static final String userDest = "wsa";
    private static final String passDest = "sklcc";

    private final static String appId = "aJ2Vx03fS7j4LdxeSrb5";
    private final static String appKey = "zgaWRumyOf586J7z7uiH9E2D4";
    private final static String apiUrl = "http://open.gsdata.cn/api/wx/wxapi/nickname_one";

    private void gsdataAdd(String wx_name, String wx_nickname, int group_id) {
        String groupId = GroupUtil.getGroupId(group_id);
        String apiUrl = "http://open.gsdata.cn/api/wx/wxapi/add_wx_to_group2";

        ApiSdk apiSdk = ApiSdk.getApiSdk(appId,appKey);
        Map<String, Object> map = new HashMap<>();

        map.put("groupid" , groupId);
        String WxAccountList = "[{ \"wx_nickname\" :\"" + wx_nickname + "\", \"wx_name\" :\"" + wx_name + "\" }]";
        map.put("WxAccountList", WxAccountList);

        String jsonReturned = apiSdk.callInterFace(apiUrl, map);
        System.out.println(jsonReturned);
    }

    public void doAdd(String accountId, int group_id) {
        //get account's information
        ApiSdk apiSdk = ApiSdk.getApiSdk(appId,appKey);
        Map<String, Object> map = new HashMap<>();
        map.put("wx_name", accountId);

        String jsonReturned = apiSdk.callInterFace(apiUrl, map);
//        System.out.println(jsonReturned);
        JSONObject jsonObject = new JSONObject(jsonReturned);
        JSONObject accountInfo = jsonObject.getJSONObject("returnData");

        int id = (int) accountInfo.get("id");
        String official_account = (String) accountInfo.get("wx_name");
        String nickname = (String) accountInfo.get("wx_nickname");
        String biz = (String) accountInfo.get("wx_biz");
        int type = (int) accountInfo.get("wx_type");
        String qr_code = "无";
        if (accountInfo.has("wx_qrcode")) {
            qr_code = (String) accountInfo.get("wx_qrcode");
        }
        String description = "无";
        if (accountInfo.has("wx_note")) {
            description = (String) accountInfo.get("wx_note");
        }
        String authentication = "未认证";
        if (accountInfo.has("wx_vip")) {
            authentication = (String) accountInfo.get("wx_vip");
        }
        String authentication_info = "无";
        if (accountInfo.has("wx_vip_note")) {
            authentication_info = (String) accountInfo.get("wx_vip_note");
        }

        //String authentication_info = (String) accountInfo.get("wx_vip_note");


        System.out.println("id: " + id);
        System.out.println("official_account: " + official_account);
        System.out.println("nickname: " + nickname);
        System.out.println("biz: " + biz);
        System.out.println("type: " + type);
        System.out.println("qr_code: " + qr_code);
        System.out.println("description: " + description);
        System.out.println("authentication: " + authentication);
        System.out.println("authentication_info: " + authentication_info);

        //*----gsdata operation------*//*
        gsdataAdd(official_account, nickname, group_id);

        //*----database operation------*//*
        DBUtil dbSource = new DBUtil(urlSource, userSource, passSource);
        DBUtil dbDest = new DBUtil(urlDest, userDest, passDest);
        //add account to wsa_group
        Connection connectionSource = dbSource.getConnection();
        Connection connectionDest = dbDest.getConnection();
        Statement sta = null;
        PreparedStatement pres = null;
        String sql = "UPDATE wsa_group SET official_accounts = CONCAT(official_accounts, " +
                "'," + official_account + "')" + "WHERE id = " + group_id;
        try {
            sta = connectionSource.createStatement();
            sta.executeUpdate(sql);
            sta = connectionDest.createStatement();
            sta.executeUpdate(sql);
            sta.close();
            //add account to wsa_official_account
            sql = "INSERT INTO wsa_official_account(id, official_account, nickname, biz, type, qr_code, description, authentication, authentication_info) " +
                    "VALUES(?,?,?,?,?,?,?,?,?)";
            pres = connectionSource.prepareStatement(sql);
            pres.setInt(1, id);
            pres.setString(2, official_account);
            pres.setString(3, nickname);
            pres.setString(4, biz);
            pres.setInt(5, type);
            pres.setString(6, qr_code);
            pres.setString(7, description);
            pres.setString(8, authentication);
            pres.setString(9, authentication_info);

            pres.addBatch();
            pres.executeBatch();

            pres = connectionDest.prepareStatement(sql);
            pres.setInt(1, id);
            pres.setString(2, official_account);
            pres.setString(3, nickname);
            pres.setString(4, biz);
            pres.setInt(5, type);
            pres.setString(6, qr_code);
            pres.setString(7, description);
            pres.setString(8, authentication);
            pres.setString(9, authentication_info);

            pres.addBatch();
            pres.executeBatch();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                pres.close();
                sta.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            dbSource.close();
            dbDest.close();
        }

        System.out.println("Add " + accountId + " successfully");
    }

    private void batchAdd(String filePath) {
        List<String> accounts = ReadExcel.readAccountsFromExcel(filePath);
        try {
            for (String account: accounts) {
                doAdd(account, 12);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws SQLException {
        Adder adder = new Adder();
        //adder.doAdd("吴江东太湖生态旅游度假区", 2);
        //System.out.println( adder.getGroupId(10));
        //System.out.println(adder.getGroupName(2));
        //adder.doAdd("linghubay", 8);
        //adder.gsdataAdd("botaihu", "人民日报", 10);
        adder.batchAdd("C:\\Users\\Krystal\\Desktop\\accounts.xls");
    }
}
