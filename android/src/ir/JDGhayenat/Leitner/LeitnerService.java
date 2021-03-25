package ir.JDGhayenat.Leitner;

import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import org.qtproject.qt5.android.bindings.QtService;

public class LeitnerService extends QtService {

    private static LeitnerService m_instance;
    private static NotificationManager m_notificationManager;
    private static Notification.Builder m_builder;

    @Override
    public void onCreate() {
        m_instance = this;
        super.onCreate();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
    }

    public static void notify(Context context, int iD, String title, String message) {
        try {
            // Obtain NotificationManager system service in order to show the notification
            //m_notificationManager = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
            m_notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);

            m_builder = new Notification.Builder(context)
                                .setSmallIcon(android.R.drawable.ic_dialog_info)
                                .setContentTitle(title)
                                .setContentText(message)
                                .setAutoCancel(true);

                        m_notificationManager.notify(iD, m_builder.build());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
