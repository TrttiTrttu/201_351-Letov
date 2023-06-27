#include "authManager.h"


authManager::authManager(QString kositl)
{

}

bool authManager::checkPin(QString pin)
{
    bool res =  pin == this->mPin;
    return res;

}

void authManager::onCheckPin(QString pin)
{
    qDebug() << pin;
    bool res = checkPin(pin);
    qDebug() << res;
    emit pinChecked(res);
}
