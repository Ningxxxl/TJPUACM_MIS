package cn.ningxy.dao;

import cn.ningxy.bean.CheckinData;

import java.util.ArrayList;

/**
 * @Author: ningxy
 * @Description:
 * @Date: 2018-04-29 11:29
 **/
public interface ICheckinDao {

    /**
    * @Author: ningxy
    * @Description: 获取今日打卡列表
    * @params: []
    * @return: java.util.ArrayList<cn.ningxy.bean.CheckinData>
    * @Date: 2018/4/29 下午2:21
    */
    public ArrayList<CheckinData> getCheckinList() throws Exception;

    /**
    * @Author: ningxy
    * @Description: 获取总打卡排名列表
    * @params: [pageNow, pageSize]
    * @return: java.util.ArrayList<cn.ningxy.bean.CheckinData>
    * @Date: 2018/5/10 下午9:18
    */
    public ArrayList<CheckinData> getCheckinRank(int pageNow, int pageSize) throws Exception;

    /**
    * @Author: ningxy
    * @Description: 获取总打卡排名的数据行数
    * @params: []
    * @return: int
    * @Date: 2018/5/10 下午9:08
    */
    public int getCheckinQuantity();
}
