// Copyright (c) 2011-2014, Zhejiang XXXX Technologies Co., Ltd. All rights reserved.
// --------------------------------------------------------------------------------
//  UVLog.h
//
// Project Code: UVCocoaLibrary
// Module Name:
// Date Created: 2013-11-19
// Author: chenjiaxin/00891
// Description:日志类
//
// --------------------------------------------------------------------------------
// Modification History
// DATE        NAME             DESCRIPTION
// --------------------------------------------------------------------------------
//
#ifndef UVCocoaLibrary_UVLog_h
#define UVCocoaLibrary_UVLog_h

#define UVLog(fmt, ...) NSLog((@"[%s:%d]:" fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);

#endif
