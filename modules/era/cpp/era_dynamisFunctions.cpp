/*************************************
*  Used for the 75 Cap Dynamis
*  Used to handle hourglass functions.
*************************************/

#include "map/utils/moduleutils.h"

#include "common/logging.h"
#include "common/sql.h"
#include "map/lua/luautils.h"
#include "map/utils/itemutils.h"
#include "map/lua/lua_item.h"
#include "map/utils/itemutils.h"
#include "map/item_container.h"
#include "map/packets/inventory_assign.h"
#include "map/packets/inventory_finish.h"
#include "map/packets/inventory_item.h"
#include "map/items/item_furnishing.h"
#include "map/utils/charutils.h"


namespace
{
    constexpr uint16 HOURGLASS_ID = 4237;

    uint32 currentEpoch()
    {
        return static_cast<uint32>(time(nullptr));
    }
};

class DynaFuncModule : public CPPModule
{
    void OnInit() override
    {
        /* player:createHourglass(zoneID, dynamistoken)
                                                v------------object------------v v--param0--v  v-------param1-----v */
        lua["CBaseEntity"]["createHourglass"] = [](CLuaBaseEntity* PLuaBaseEntity, uint8 zoneID, uint32 dynamistoken)
        {
            TracyZoneScoped;

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
            if (PEntity->objtype != TYPE_PC)
            {
                return;
            }

            auto* PCharEntity = static_cast<CCharEntity*>(PEntity);

            if (PCharEntity != nullptr)
            {
                CItem* PItem = itemutils::GetItem(HOURGLASS_ID);
                PItem->setQuantity(1);

                ref<uint8>(PItem->m_extra,  0x02) = 1;
                ref<uint32>(PItem->m_extra, 0x04) = PEntity->id;
                ref<uint32>(PItem->m_extra, 0x0C) = currentEpoch();
                ref<uint8>(PItem->m_extra,  0x10) = zoneID;
                ref<uint32>(PItem->m_extra, 0x14) = dynamistoken;
                charutils::AddItem(PCharEntity, LOC_INVENTORY, PItem);
                printf("Dynamis Token: %i", PItem->m_extra[0x14]);
            }
        };

        /* player:updateHourglass(dynamistoken, timepoint)
                                                   v----------object------------v  v------param0-----v  v----param1----v */
        lua["CBaseEntity"]["updateHourglass"] = [](CLuaBaseEntity* PLuaBaseEntity, uint8 zoneID, uint32 timepoint)
        {
            TracyZoneScoped;

            if (PLuaBaseEntity == nullptr)
            {
                return;
            }

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();

            if (PEntity->objtype != TYPE_PC)
            {
                return;
            }

            
            if (auto* PCharEntity = static_cast<CCharEntity*>(PEntity))
            {
                uint8 numitemsupdated = 0;
                PCharEntity->getStorage(LOC_INVENTORY)->ForEachItem([&PCharEntity, &zoneID, &timepoint, &numitemsupdated](CItem* PItem)
                {
                    if (PItem != nullptr && PItem->getID() == HOURGLASS_ID && PItem->m_extra[0x10] == zoneID)
                    {
                        ref<uint32>(PItem->m_extra, 0x08) = timepoint; // Update hourglass timestamp.
                        PCharEntity->pushPacket(new CInventoryItemPacket(PItem, LOC_INVENTORY, PItem->getSlotID()));
                        ++numitemsupdated;
                    }
                });
                if (numitemsupdated)
                {
                    PCharEntity->pushPacket(new CInventoryFinishPacket());
                }
            }
        };

        lua["CBaseEntity"]["duplicateHourglass"] = [](CLuaBaseEntity* PLuaBaseEntity, uint8 zoneID, uint32 dynamistoken, uint8 originalregistrant)
        {
            TracyZoneScoped;

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
            if (PEntity->objtype != TYPE_PC)
            {
                return;
            }

            auto* PCharEntity = static_cast<CCharEntity*>(PEntity);

            if (PCharEntity != nullptr)
            {
                int i = 1;
                while (i <= 2)
                {
                    CItem* PItem = itemutils::GetItem(HOURGLASS_ID);
                    PItem->setQuantity(1);

                    ref<uint8>(PItem->m_extra,  0x02) = 1;
                    ref<uint32>(PItem->m_extra, 0x04) = originalregistrant;
                    ref<uint32>(PItem->m_extra, 0x0C) = currentEpoch();
                    ref<uint8>(PItem->m_extra,  0x10) = zoneID;
                    ref<uint32>(PItem->m_extra, 0x14) = dynamistoken;
                    charutils::AddItem(PCharEntity, LOC_INVENTORY, PItem);
                    ++i;
                }
            }
        };

        /* player:validateHourglass() - Used to update hourglasses in a loop to minimize SQL queries, only updates timepoint. Can only be run while in dynamis.
                                                   v----------object------------v  v------param0-----v */
        lua["CBaseEntity"]["validateHourglass"] = [](CLuaBaseEntity* PLuaBaseEntity, uint32 dynamistoken)
        {
            TracyZoneScoped;

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();

            if (PEntity->objtype != TYPE_PC)
            {
                return false;
            }

            if (auto* PCharEntity = static_cast<CCharEntity*>(PEntity))
            {
                CItemContainer* PContainer = PCharEntity->getStorage(LOC_INVENTORY);
                for (int slotIndex = 1; slotIndex <= PContainer->GetSize(); ++slotIndex)
                {
                    CItem* PItem = PContainer->GetItem(slotIndex);
                    if (PItem != nullptr && PItem->getID() == HOURGLASS_ID && PItem->m_extra[0x14] == dynamistoken)
                    {
                        return true;
                    }
                };
                return false;
            }
            return false;
        };

        lua["CBaseEntity"]["getHourglassRegistrant"] = [](CLuaItem* PLuaBaseItem)
        {
            TracyZoneScoped;
            return PLuaBaseItem->GetItem()->m_extra[0x04];
        };

        /*item:getHourglassZone() - Returns a value for the zoneID from the hourglass' m_extra.
                                                   v-------object------v */
        lua["CBaseEntity"]["getHourglassZone"] = [](CLuaItem* PLuaBaseItem)
        {
            TracyZoneScoped;
            return PLuaBaseItem->GetItem()->m_extra[0x10];
        };

        /*item:getHourglassTimePoint() - Returns a value for the timepoint from the hourglass' m_extra.
                                                       v-------object------v */
        lua["CBaseEntity"]["getHourglassTimePoint"] = [](CLuaItem* PLuaBaseItem)
        {
            TracyZoneScoped;
            return PLuaBaseItem->GetItem()->m_extra[0x0C];
        };

        lua["CBaseEntity"]["setMobType"] = [](CLuaBaseEntity* PLuaBaseEntity, uint8 mobType)
       {
           TracyZoneScoped;

           CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();

            if (PEntity->objtype != TYPE_MOB)
            {   
                return 0;
            }

            CMobEntity* PMob = static_cast<CMobEntity*>(PEntity);

           if (PMob->m_Type >= MOBTYPE_NORMAL && PMob->m_Type <= MOBTYPE_EVENT)
            {
                PMob->m_Type = mobType;
            }
            
            return 0;
       };

    }
};

REGISTER_CPP_MODULE(DynaFuncModule);