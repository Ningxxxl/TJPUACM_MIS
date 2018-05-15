package cn.ningxy.service;

import cn.ningxy.bean.CheckinData;

import javax.servlet.ServletRequest;
import java.util.ArrayList;

/**
 * @Author: ningxy
 * @Description:
 * @Date: 2018-04-29 11:26
 **/
public interface ICheckinService {

    /**
     * @Author: ningxy
     * @Description: 获取今日打卡列表
     * @params: []
     * @return: java.util.ArrayList<cn.ningxy.bean.CheckinData>
     * @Date: 2018/4/29 下午2:20
     */
    public ArrayList<CheckinData> getCheckinList() throws Exception;

    /**
    * @Author: ningxy
    * @Description: 分页获取总打卡排名
    * @params: [pageNow, pageSize]
    * @return: java.util.ArrayList<cn.ningxy.bean.CheckinData>
    * @Date: 2018/5/10 下午9:28
    */
    public ArrayList<CheckinData> getCheckinRank(int pageNow, int pageSize) throws Exception;

    /**
    * @Author: ningxy
    * @Description: 检查签到IP是否合法
    * @params: [servletRequest]
    * @return: boolean
    * @Date: 2018/4/30 下午3:46
    */
    public boolean CheckIPAddr(ServletRequest servletRequest);

    /**
    * @Author: ningxy
    * @Description: 获取总打卡排名的数据行数
    * @params: []
    * @return: int
    * @Date: 2018/5/15 下午1:46
    */
    public int getCheckinQuantity();
}
