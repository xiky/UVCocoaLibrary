引入动态库步骤：
1）设置头文件包含 进入Build Settings->Header Search Paths->增加路径 $(SRCROOT)/../UVCocoaLibrary
2) 设置动态库链接 进入Build Phases->Link Binary With Libraries->点增加按钮，在列表中选择liUVCocoaLibrary.a
3) 进入Build Settings->Other Linker Flags->增加-ObjC -all_load -force_load三项


所需框架：
1）libsqlite3.dylib
2）MobileCoreServices