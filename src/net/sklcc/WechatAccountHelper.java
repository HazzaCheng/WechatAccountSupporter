package net.sklcc;

import java.sql.SQLException;
import java.util.Scanner;

/**
 * Created by Hazza on 2016/8/7.
 */
public class WechatAccountHelper {

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        Adder adder = new Adder();
        Deleter deleter = new Deleter();

        while (true) {
            System.out.println("------------Welcome-------------");
            System.out.println("------------Add account(press 1)-------------");
            System.out.println("------------Delete account(press 2)-------------");
            System.out.println("------------Quit(press 0)-------------");
            System.out.println("Please choose:");

            int choice = in.nextInt();
            in.nextLine();
            if (choice == 1) {
                System.out.println("Please enter the wx_name(English,not nickname):");
                String accountId = in.nextLine();
                System.out.println("Please enter the group number(1-11):");
                int group_id = in.nextInt();
                try {
                    adder.doAdd(accountId, group_id);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if (choice == 2) {
                System.out.println("Please enter the wx_name(in English,not nickname):");
                String accountId = in.nextLine();
                System.out.println("Please enter the group number(1-10):");
                int group_id = in.nextInt();
                try {
                    deleter.doDelete(accountId, group_id);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } else {
                System.exit(0);
            }
        }
    }
}
