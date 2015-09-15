exists(../common.pri) {
    #For case:
    #  someone want to copy all file in the src/ directory
    #  to their project src/ directory and they does not like
    #  the common.pri file.
    #In this case:
    #  they can just include this file (qextserialport.pri) too.
    include(../common.pri)
}
INCLUDEPATH += $$PWD
DEPENDPATH += $$PWD

qextserialport-library:!qextserialport-buildlib {
    # Using QextSerialPort as shared or static library.
    LIBS += -L$$QEXTSERIALPORT_LIBDIR -l$$QEXTSERIALPORT_LIBNAME
   !qextserialport-static: DEFINES += QEXTSERIALPORT_USING_SHARED
} else {
    # Building library(shared or static)
    # or including source files
    HEADERS                += $$PWD/types.h

    # For building shared library only
    contains(TEMPLATE, .*lib):contains(CONFIG, shared): DEFINES += QEXTSERIALPORT_BUILD_SHARED
}

macx:LIBS              += -framework IOKit -framework CoreFoundation
win32:LIBS             += -lsetupapi -ladvapi32 -luser32
