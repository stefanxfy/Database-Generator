package fai.web.kit;

import fai.app.*;
import fai.cli.*;
import fai.comm.util.*;
import fai.web.*;
import fai.web.inf.*;

@Kit(Kit.Type.CORP)
public class ${className}Impl extends CorpKitImpl implements ${className} {

    public int add${methodName}(Param info) throws Exception {
        return add${methodName}(info, null);
    }

    public int add${methodName}(Param info, Ref<Integer> idRef) throws Exception{
        int rt = Errno.OK;

        if (info == null || info.isEmpty()) {
            rt = Errno.ARGS_ERROR;
            App.logErr(rt, "add${methodName} info is null err");
            return rt;
        }

        // 创建cli
        ${cliName}Cli cli = createCli();

        rt = cli.add${methodName}(m_aid, info, idRef);
            if (rt != Errno.OK) {
            App.logErr(rt, "add${methodName}  error;aid=%s, info=%s;", m_aid, info);
            return rt;
        }

        Log.logStd("add${methodName} success;aid=%s, info=%s, c", m_aid, info);
        return rt;
    }

    public int set${methodName}(int id, ParamUpdater updater) throws Exception {
        int rt = Errno.OK;
        if (id < 1 || updater == null || updater.isEmpty()) {
            rt = Errno.ARGS_ERROR;
            App.logErr(rt, "args err;aid=%s, id=%s;", m_aid, id);
            return rt;
        }

        // 创建cli
        ${cliName}Cli cli = createCli();

        rt = cli.set${methodName}(m_aid, id, updater);
        if (rt != Errno.OK) {
            App.logErr(rt, "set${methodName} error;aid=%s, id=%s;", m_aid, id);
            return rt;
        }

        Log.logStd("set${methodName} success;aid=%s, id=%s;", m_aid, id);
        return rt;
    }

    public Param get${methodName}(int id) throws Exception {
        int rt = Errno.OK;
        Param info = new Param();
        if (id < 1) {
            return info;
        }

        // 创建cli
        ${cliName}Cli cli = createCli();

        rt = cli.get${methodName}(m_aid, id, info);
        if (rt != Errno.OK) {
            throw new WebException(rt, "get${methodName} error");
        }

        // 如果不存在的时候
        if (info == null || info.isEmpty()) {
            return new Param();
        }

        return info;
    }

    public FaiList<Param> get${methodName}List(SearchArg searchArg) throws Exception {
        int rt = Errno.OK;
        FaiList<Param> infoList = new FaiList<Param>();

        if (searchArg == null) {
            rt = Errno.ARGS_ERROR;
            throw new WebException(rt, "searchArg error");
        }
        if (searchArg.matcher == null) {
            searchArg.matcher = new ParamMatcher();
        }

        // 只允许查自己的
        SearchArg searchArgTmp = new SearchArg();
        searchArgTmp.matcher = new ParamMatcher(${methodName}Def.Info.AID, ParamMatcher.EQ, m_aid);
        searchArg.matcher.and(searchArgTmp.matcher);

        // 创建cli
        ${cliName}Cli cli = createCli();

        rt = cli.get${methodName}List(m_aid, searchArg, infoList);
        if (rt != Errno.OK && rt != Errno.NOT_FOUND) {
            throw new WebException(rt, "search error");
        }

        return infoList;

    }

    private ${cliName}Cli createCli() throws Exception {
        <#if isAuth == true>
        // 安全校验，判断操作用户是否跟登录用户一致
        Auth.checkSessionTs(m_aid, true);

        </#if>
        ${cliName}Cli cli = new ${cliName}Cli(Core.getFlow());
            if (!cli.init()) {
            throw new WebException("${cliName}Cli init error");
        }
        return cli;
    }
}
