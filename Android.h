#ifndef ANDROID_H
#define ANDROID_H
#include <QString>
#include <QtAndroid>

void cnf(){
    QtAndroid::runOnAndroidThread([=]()
    {
        QAndroidJniObject window = QtAndroid::androidActivity().callObjectMethod("getWindow", "()Landroid/view/Window;");
        window.callMethod<void>("addFlags", "(I)V", 0x80000000);
        window.callMethod<void>("clearFlags", "(I)V", 0x04000000);
        window.callMethod<void>("setStatusBarColor", "(I)V", 0xFF00B193); // Desired statusbar color
        window.callMethod<void>("setNavigationBarColor", "(I)V", 0xFF00B193); // Desired statusbar color
    });
}
bool permit(QString name){
    auto  result = QtAndroid::checkPermission(QString("android.permission."+name));
    if(result == QtAndroid::PermissionResult::Denied){
        QtAndroid::PermissionResultMap resultHash = QtAndroid::requestPermissionsSync(QStringList({"android.permission."+name}));
        if(resultHash["android.permission."+name] == QtAndroid::PermissionResult::Denied)
            return 0;
    }
    return 1;
}
#endif // ANDROID_H
