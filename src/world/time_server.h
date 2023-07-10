#ifndef SERVER_TIME_SERVER_H
#define SERVER_TIME_SERVER_H

#include "../common/cbasetypes.h"
#include "../common/taskmgr.h"

int32 time_server(time_point tick, CTaskMgr::CTask* PTask);

#endif // SERVER_TIME_SERVER_H
