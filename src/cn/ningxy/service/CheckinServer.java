package cn.ningxy.service;

import cn.ningxy.bean.CheckinData;
import cn.ningxy.dao.CheckinDao;
import cn.ningxy.util.IPUtil;
import cn.ningxy.util.ImportantInfo;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

/**
 * @Author: ningxy
 * @Description:
 * @Date: 2018-04-29 14:03
 **/
public class CheckinServer implements ICheckinService {

    /**
     * @Author: ningxy
     * @Description: 获取今日打卡列表
     * @params: []
     * @return: java.util.ArrayList<cn.ningxy.bean.CheckinData>
     * @Date: 2018/4/29 下午2:20
     */
    @Override
    public ArrayList<CheckinData> getCheckinList() throws Exception {
        return new CheckinDao().getCheckinList();
    }

    /**
     * @Author: ningxy
     * @Description: 分页获取总打卡排名
     * @params: [pageNow, pageSize]
     * @return: java.util.ArrayList<cn.ningxy.bean.CheckinData>
     * @Date: 2018/5/10 下午9:28
     */
    @Override
    public ArrayList<CheckinData> getCheckinRank(int pageNow, int pageSize) throws Exception {
        return new CheckinDao().getCheckinRank(pageNow, pageSize);
    }

    /**
     * @param servletRequest
     * @Author: ningxy
     * @Description: 检查签到IP是否合法
     * @params: [servletRequest]
     * @return: boolean
     * @Date: 2018/4/30 下午3:46
     */
    @Override
    public boolean CheckIPAddr(ServletRequest servletRequest) {
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
//        读取客户端IP
//        String remoteIP = servletRequest.getRemoteAddr();
        String remoteIP = IPUtil.getIPAddr(httpServletRequest);
        System.out.println("CheckinServer | [" + remoteIP + "] IP获取结果");
//        判断客户端IP是否受限
        if (remoteIP.equals(ImportantInfo.LEGAL_IP)) {
            System.out.println("CheckinServer | [" + remoteIP + "] IP合法");
            return true;
        } else {
            System.out.println("CheckinServer | [" + remoteIP + "] IP非法");
            return false;
        }
    }

    /**
     * @Author: ningxy
     * @Description: 获取总打卡排名的数据行数
     * @params: []
     * @return: int
     * @Date: 2018/5/15 下午1:46
     */
    @Override
    public int getCheckinQuantity() {
        return new CheckinDao().getCheckinQuantity();
    }
}
