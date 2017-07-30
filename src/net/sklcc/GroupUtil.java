package net.sklcc;

import cn.gsdata.index.ApiSdk;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Hazza on 2016/8/8.
 */
public class GroupUtil {
    private final static String appId = "aJ2Vx03fS7j4LdxeSrb5";
    private final static String appKey = "zgaWRumyOf586J7z7uiH9E2D4";
    private final static String apiUrl = "http://open.gsdata.cn/api/wx/wxapi/group_name";

    private static String getGroupName(int group_id) {
       /* DBUtil db = new DBUtil(urlSource, userSource, passSource);
        String sql = "SELECT name FROM wsa_group WHERE id = " + group_id;
        ResultSet rs = db.getConnection().createStatement().executeQuery(sql);
        rs.next();
        String groupName = rs.getString(1);
        if (groupName.equals("县市区发布类")) {
            groupName = "发布";
        } else if (groupName.equals("媒体类")) {
            groupName = "媒体";
        } else if (groupName.equals("政务类")) {
            groupName = "政务";
        }
        return groupName;*/
        String groupName = "";
        switch (group_id) {
            case 1:
                groupName = "发布";
                break;
            case 2:
                groupName = "自媒体";
                break;
            case 3:
                groupName = "政务";
                break;
            case 4:
                groupName = "媒体";
                break;
            case 5:
                groupName = "生活类号";
                break;
            case 6:
                groupName = "服务号";
                break;
            case 7:
                groupName = "旅游局";
                break;
            case 8:
                groupName = "酒店";
                break;
            case 9:
                groupName = "景区";
                break;
            case 10:
                groupName = "度假区";
                break;
            case 11:
                groupName = "苏州建行";
                break;
            case 12:
                groupName = "志愿者组织";
                break;
            default:
                System.out.println("Sorry,this group doesn't exist!");
        }

        return groupName;
    }

    public static String getGroupId(int group_id) {
        String groupName = getGroupName(group_id);

        ApiSdk apiSdk = ApiSdk.getApiSdk(appId,appKey);
        Map<String, Object> map = new HashMap<>();
        String jsonReturned = apiSdk.callInterFace(apiUrl, map);

        String regex = "\"groupid\" :(\\d*),\n" +
                "         \"groupname\" :\"" + groupName + "\",";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(jsonReturned);
        while (matcher.find()) {
            return matcher.group(1).toString();
        }

        return "";
    }

}
