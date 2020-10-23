${gen.setType("inf")}
package ${entity.packages.inf};

import fai.comm.util.*;

/**
 * inf：${entity.comment}
 *
 * @author ${developer.author}
 * @date ${date.toString("yyyy-MM-dd HH:mm:ss")}
 */
public interface ${entity.name} extends CorpKit {

    /**
     * 业务处理：保存添加 <strong>${entity.comment}</strong>
     *
     * @param info ${entity.comment}
     * @return 请求处理结果
     */
    int add${entity.name}(Param info) throws Exception;

    /**
     * 业务处理：保存添加 <strong>${entity.comment}</strong>
     *
     * @param info ${entity.comment}
     * @param idRef 返回值封装
     * @return 请求处理结果
     */
    int add${entity.name}(Param info, Ref<Integer> idRef) throws Exception;

    /**
     * 业务处理：修改更新 <strong>${entity.comment}</strong>
     *
     * @param id   主键ID
     * @param updater 更新的操作封装
     * @return 请求处理结果
     */
    int update${entity.name}(int id, ParamUpdater updater) throws Exception;


    /**
     * 业务处理：删除 <strong>${entity.comment}</strong>
     *
     * @param id   主键ID
     * @param matcher 选择条件封装
     * @return 请求处理结果
     */
    int del${entity.name}(int id, ParamMatcher matcher) throws Exception;


    /**
     * 业务处理：获取一条记录 <strong>${entity.comment}</strong>
     *
     * @param id   主键ID
     * @return 一条记录
     */
    Param get${entity.name}(int id) throws Exception;


    /**
     * 业务处理：获取记录集 <strong>${entity.comment}</strong>
     *
     * @param searchArg 查询条件封装
     * @return 记录集
     */
    FaiList<Param> get${entity.name}List(SearchArg searchArg) throws Exception;


}