###1、安装tcl编写源文件
```
#include <tcl/tcl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int PowObjCmd(ClientData clientData, Tcl_Interp *interp, int objc, Tcl_Obj *CONST objv[]) {
  Tcl_Obj*  resultptr;
  double    x,y,result;
  int       error;

  if (objc != 3) {
    Tcl_WrongNumArgs(interp,2,objv, "Usage : pow x y");
    return TCL_ERROR;
  }

  error = Tcl_GetDoubleFromObj(interp, objv[1], &x);
  if (error != TCL_OK) return error;
  
  error = Tcl_GetDoubleFromObj(interp, objv[2], &y);
  if (error != TCL_OK) return error;
  
  result = pow(x,y);
  resultptr = Tcl_GetObjResult(interp);
  Tcl_SetDoubleObj(resultptr,result);

  return TCL_OK;
}

int Example_Init(Tcl_Interp *interp) {
  Tcl_CreateObjCommand(interp, "pow", PowObjCmd, (ClientData) NULL, (Tcl_CmdDeleteProc *) NULL);
  return TCL_OK;
}
```

###2、编译动态库文件
```
gcc -fPIC -shared -o libhello.so hello.c -ltcl
```
###3、调用自定义命令，根据load指令后的寻找入口函数，如Example_Init
```
takchi@ubuntu:~$ tclsh
% load ./libtcl.so Example
% pow 3 9
```
