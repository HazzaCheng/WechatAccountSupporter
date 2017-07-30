package net.sklcc;

import cn.gsdata.index.ApiSdk;
import org.json.JSONObject;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

/**
 * Created by Hazza on 2016/8/12.
 */
public class test {
    private static final String urlSource = "jdbc:mysql://10.10.65.172:3306/wsa?useUnicode=true&characterEncoding=utf-8";
    private static final String userSource = "wechat";
    private static final String passSource = "sklcc";

    private static final String urlDest = "jdbc:mysql://139.196.188.70:3306/wsa?useUnicode=true&characterEncoding=utf-8";
    private static final String userDest = "wsa";
    private static final String passDest = "sklcc";

    public static void main(String[] args) throws SQLException {
//        DBUtil dbSource = new DBUtil(urlSource, userSource, passSource);
        DBUtil dbSource = new DBUtil(urlDest, userDest, passDest);


        Connection conn = dbSource.getConnection();
        Statement sta = conn.createStatement();
        ResultSet rs = sta.executeQuery("SELECT official_accounts FROM wsa_group WHERE id = 12");
        if (rs.next()) {
            String[] accounts = rs.getString(1).split(",");
            Set<String> set = new HashSet<>();
            for (String account: accounts) {
                set.add(account);
            }
            int count = 0;
            for (String account: accounts) {
                rs = sta.executeQuery("SELECT * FROM wsa_official_account WHERE official_account = '" + account +"'");
                if (!rs.next()) {
                    System.out.println(account);
                    ++count;
                }
            }
            System.out.println("Find " + count);
        }

        dbSource.close();
    }

}
