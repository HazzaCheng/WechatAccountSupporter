package net.sklcc;

import cn.gsdata.index.ApiSdk;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Hazza on 2016/8/7.
 */
public class Deleter {
    private static final String urlSource = "jdbc:mysql://10.10.65.172:3306/wsa?useUnicode=true&characterEncoding=utf-8";
    private static final String userSource = "wechat";
    private static final String passSource = "sklcc";
    private static final String urlDest = "jdbc:mysql://139.196.188.70:3306/wsa?useUnicode=true&characterEncoding=utf-8";
    private static final String userDest = "wsa";
    private static final String passDest = "sklcc";

    private final static String appId = "aJ2Vx03fS7j4LdxeSrb5";
    private final static String appKey = "zgaWRumyOf586J7z7uiH9E2D4";

    private int getId(String accountId) throws SQLException {
        DBUtil db = new DBUtil(urlSource, userSource, passSource);
        String sql = "SELECT id FROM wsa_official_account WHERE official_account = " + "'" + accountId + "'";
        ResultSet rs = db.getConnection().createStatement().executeQuery(sql);
        while (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }

    private void gsdataDelete(int id, int group_id) {
        String groupId = GroupUtil.getGroupId(group_id);
        String apiUrl = "http://open.gsdata.cn/api/wx/wxapi/del_nickname_In_group";

        ApiSdk apiSdk = ApiSdk.getApiSdk(appId,appKey);
        Map<String, Object> map = new HashMap<>();

        map.put("group_id" , groupId);
        map.put("nickname_id", id);

        String jsonReturned = apiSdk.callInterFace(apiUrl, map);
        System.out.println(jsonReturned);
    }

    public void doDelete(String accountId, int group_id) throws SQLException {
        /*------gsdata operation-------*/
        int id = getId(accountId);
        gsdataDelete(id, group_id);

        /*------database operation-------*/
        DBUtil dbSource = new DBUtil(urlSource, userSource, passSource);
        DBUtil dbDest = new DBUtil(urlDest, userDest, passDest);

        //get old accounts string
        Connection connectionSource = dbSource.getConnection();
        Connection connectionDest = dbDest.getConnection();

        String sql = "SELECT official_accounts FROM wsa_group WHERE id = " + group_id;
        ResultSet rs = connectionSource.createStatement().executeQuery(sql);
        rs.next();
        String official_accounts = rs.getString(1);
        //check whether contains account
        boolean flag = false;
        ArrayList<String> accounts = new ArrayList<>();
        for (String param : official_accounts.split(",")) {
            if (param.equals(accountId)) {
                flag = true;
            } else {
                accounts.add(param);
            }
        }
        //assemble new accounts string
        if (flag) {
            String newOfficial_accounts = "";
            for (int i = 0;i < accounts.size();++i) {
                newOfficial_accounts += accounts.get(i);
                if (i < accounts.size() - 1) {
                    newOfficial_accounts += ",";
                }
            }
            //delete account from wsa_group
            sql = "UPDATE wsa_group SET official_accounts = " + "'" + newOfficial_accounts + "'" +
                    "WHERE id = " + group_id;
            Statement staSource = connectionSource.createStatement();
            Statement staDest = connectionDest.createStatement();

            staSource.executeUpdate(sql);
            staDest.executeUpdate(sql);
            //delete account from wsa_official_account
            sql = "DELETE FROM wsa_official_account WHERE official_account = " + "'" + accountId + "'";
            staSource.executeUpdate(sql);
            staDest.executeUpdate(sql);

            staSource.close();
            staDest.close();
        } else {
            System.out.println("Sorry, this group doesn't include this account.");
        }
        rs.close();
        dbSource.close();
        dbDest.close();

        System.out.println("Delete " + accountId + " successfully");
    }

    public static void main(String[] args) {
        Deleter deleter = new Deleter();

        deleter.gsdataDelete(107562, 10);
    }
}
