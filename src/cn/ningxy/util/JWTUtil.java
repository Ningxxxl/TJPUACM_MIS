package cn.ningxy.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.apache.commons.codec.binary.Base64;

import javax.crypto.spec.SecretKeySpec;
import java.security.Key;
import java.util.Date;

/**
 * @Author: ningxy
 * @Description: JsonWebToken工具类
 * @Date: 2018-05-09 21:39
 **/
public class JWTUtil {
    private static final String SECRET = "RlVDS1lPVQ=!=sOP012bx*(#$la.>23ks#dn10(3KJHD!(*@gzMjYyN2I0J=+AOFW@($9sw_)#$";

//    private static final String EXP = "exp";

//    private static final String PAYLOAD = "payload";


    /**
     * @Author: ningxy
     * @Description: 由字符串生成加密key
     * @params: []
     * @return: javax.crypto.SecretKey
     * @Date: 2018/5/9 下午10:23
     */
    private static Key generalKey() {
        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;
        byte[] encodedKey = Base64.decodeBase64(SECRET);
        Key signingKey = new SecretKeySpec(encodedKey, signatureAlgorithm.getJcaName());
//        SecretKey secretKey = new SecretKeySpec(encodedKey, 0, encodedKey.length, "AES");
        return signingKey;
    }

    /**
     * @Author: ningxy
     * @Description: 创建JWT
     * @params: [id, subject, ttlMillis]
     * @return: java.lang.String
     * @Date: 2018/5/9 下午10:23
     */
    public static String createJWT(String subject, long ttlMillis) throws Exception {
        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;
        long nowMillis = System.currentTimeMillis();
        Date now = new Date(nowMillis);
        Key secretKey = generalKey();
        JwtBuilder jwtBuilder = Jwts.builder()
                .setIssuedAt(now)  //设置现在时间
                .setSubject(subject)  //设置抽象主题
                .signWith(signatureAlgorithm, secretKey);
        if (ttlMillis >= 0) {
            long expMillis = nowMillis + ttlMillis;
            Date exp = new Date(expMillis);
            jwtBuilder.setExpiration(exp);
        }
        return jwtBuilder.compact();
    }

    /**
     * @Author: ningxy
     * @Description: 解析jwt
     * @params: [jwt]
     * @return: io.jsonwebtoken.Claims
     * @Date: 2018/5/10 上午9:02
     */
    public static Claims praseJWT(String jwt) throws Exception {
        Key secretKey = generalKey();
        Claims claims = Jwts.parser()
                .setSigningKey(secretKey)
                .parseClaimsJws(jwt)
                .getBody();

        return claims;
    }
}
