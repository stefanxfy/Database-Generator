package fai.web.kit;

import fai.app.*;
import fai.cli.*;
import fai.comm.util.*;
import fai.web.*;
import fai.web.inf.*;

@Kit(Kit.Type.SYS)
public class Sys${className}Impl extends CorpKitImpl implements Sys${className} {

    public int add${methodName}(int aid, Param info) throws Exception {
        return add${methodName}(aid, info, null);
    }

    public int add${methodName}(int aid, Param info, Ref<Integer> idRef) throws Exception{
        int rt = Errno.OK;

        if (info == null || info.isEmpty()) {
            rt = Errno.ARGS_ERROR;
            App.logErr(rt, "add${methodName} info is null err");
            return rt;
        }

        // 创建cli
        ${cliName}Cli cli = createCli();

        rt = cli.add${methodName}(aid, info, idRef);
        if (rt != Errno.OK) {
            App.logErr(rt, "add${methodName}  error;aid=%s, info=%s;", aid, info);
            return rt;
        }

        Log.logStd("add${methodName} success;aid=%s, info=%s;", aid, info);
        return rt;
    }

    public int set${methodName}(int aid, int id, ParamUpdater updater) throws Exception {
        int rt = Errno.OK;
        if (aid < 1 || id < 1 || updater == null || updater.isEmpty()) {
            rt = Errno.ARGS_ERROR;
            App.logErr(rt, "args err;aid=%s, id=%s;", aid, id);
            return rt;
        }

        // 创建cli
        ${cliName}Cli cli = createCli();

        rt = cli.set${methodName}(aid, id, updater);
        if (rt != Errno.OK) {
            App.logErr(rt, "set${methodName} error;aid=%s, id=%s;", aid, id);
            return rt;
        }

        Log.logStd("set${methodName} success;aid=%s, id=%s;", aid, id);
        return rt;
    }

    public Param get${methodName}(int aid, int id) throws Exception {
        int rt = Errno.OK;
        Param info = new Param();
        if (aid < 1 || id < 1) {
            return info;
        }

        // 创建cli
        ${cliName}Cli cli = createCli();

        rt = cli.get${methodName}(aid, id, info);
        if (rt != Errno.OK) {
            throw new WebException(rt, "get${methodName} error");
        }

        // 如果不存在的时候
        if (info == null || info.isEmpty()) {
            return new Param();
        }

        return info;
    }

    public FaiList<Param> get${methodName}List(int aid, SearchArg searchArg) throws Exception {
        int rt = Errno.OK;
        FaiList<Param> infoList = new FaiList<Param>();

        // 创建cli
        ${cliName}Cli cli = createCli();

        rt = cli.get${methodName}List(aid, searchArg, infoList);
        if (rt != Errno.OK && rt != Errno.NOT_FOUND) {
            throw new WebException(rt, "search error");
        }

        return infoList;

    }

    private ${cliName}Cli createCli() throws Exception {
        ${cliName}Cli cli = new ${cliName}Cli(Core.getFlow());
            if (!cli.init()) {
            throw new WebException("${cliName}Cli init error");
        }
        return cli;
    }
}
