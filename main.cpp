#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QObject>
#include <QTimer>
#include <QRandomGenerator>


// hier wird Fake ARduino erzeugt
class FakeArduino : public QObject {
    Q_OBJECT
public:
    FakeArduino(QObject* parent = nullptr) : QObject(parent) {
        connect(&timer, &QTimer::timeout, this, &FakeArduino::generateValue);
        timer.start(500);  // alle 500 ms ein neuer Wert
    }

signals:
    void valueChanged(int value);

private slots:
    void generateValue() {
        int fakeValue = QRandomGenerator::global()->bounded(1024);  // 0–1023
        emit valueChanged(fakeValue);
    }

private:
    QTimer timer;
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    FakeArduino fakeArduino;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("arduinoReader", &fakeArduino);
    engine.loadFromModule("Sonnenblume_morphen", "Main");

    return app.exec();
}

#include "main.moc"
