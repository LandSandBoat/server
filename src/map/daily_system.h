#ifndef _DAILYSYSTEM_H
#define _DAILYSYSTEM_H
#include "map.h"

namespace daily
{
    uint16 SelectItem(CCharEntity* player, uint8 dial);
    void   LoadDailyItems();
    void   UpdateDailyTallyPoints();
} // namespace daily

#endif //_DAILYSYSTEM_H
