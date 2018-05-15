package cn.ningxy.dao;

import cn.ningxy.bean.CheckinData;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * @Author: ningxy
 * @Description:
 * @Date: 2018-04-29 12:18
 **/
public class CheckinDao implements ICheckinDao {
    /**
     * @Author: ningxy
     * @Description: 获取今日打卡列表
     * @params: []
     * @return: java.util.ArrayList<cn.ningxy.bean.CheckinData>
     * @Date: 2018/4/29 下午2:21
     */
    @Override
    public ArrayList<CheckinData> getCheckinList() throws Exception {

        String sql = "SELECT users.username, checkin.checkin_date, checkin.checkin_time " +
                "FROM users INNER JOIN checkin " +
                "ON checkin.user_id = users.user_id " +
                "WHERE checkin_date = CURRENT_DATE ;";

        Connection connection = new ConnectDB().getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        ResultSet resultSet = null;

        try {
            resultSet = preparedStatement.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        ArrayList<CheckinData> checkinList = new ArrayList<>();

        while (resultSet.next()) {
            String userName = resultSet.getString(1);
            String checkinDate = resultSet.getString(2);
            String checkinTime = resultSet.getString(3);
            checkinList.add(new CheckinData(userName, checkinDate, checkinTime));
        }
        try {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return checkinList;
    }

    /**
     * @Author: ningxy
     * @Description: 获取总打卡排名列表
     * @params: [pageNow, pageSize]
     * @return: java.util.ArrayList<cn.ningxy.bean.CheckinData>
     * @Date: 2018/5/10 下午9:18
     */
    @Override
    public ArrayList<CheckinData> getCheckinRank(int pageNow, int pageSize) throws Exception {

        String sql = "SELECT\n" +
                "\tA.username,\n" +
                "\tB.cnt \n" +
                "FROM\n" +
                "\tusers AS A\n" +
                "\tINNER JOIN ( SELECT user_id, COUNT( * ) cnt FROM checkin GROUP BY user_id ) AS B ON A.user_id = B.user_id \n" +
                "ORDER BY\n" +
                "\tB.cnt DESC\n" +
                "LIMIT ?, ?;";

        Connection connection = new ConnectDB().getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        preparedStatement.setInt(1, (pageNow - 1) * pageSize);
        preparedStatement.setInt(2, pageSize);

        ResultSet resultSet = null;

        try {
            resultSet = preparedStatement.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        ArrayList<CheckinData> result = new ArrayList<>();

        while (resultSet.next()) {
            String userName = resultSet.getString(1);
            int frequency = Integer.valueOf(resultSet.getString(2));
//            System.out.println("CheckinDao | " + userName + ", " + frequency);
            result.add(new CheckinData(userName, frequency));
        }

        try {
            resultSet.close();
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    /**
     * @Author: ningxy
     * @Description: 获取总打卡排名的数据行数
     * @params: []
     * @return: int
     * @Date: 2018/5/10 下午9:08
     */
    @Override
    public int getCheckinQuantity() {

        String sql = "SELECT COUNT(A.user_id) FROM (SELECT user_id FROM checkin GROUP BY user_id) A;";

        Connection connection = new ConnectDB().getConnection();

        int res = 0;

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.next();
            res = resultSet.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return res;
    }
}
