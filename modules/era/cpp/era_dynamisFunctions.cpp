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
    /* In Lua, the ':' function calling syntax is just syntactic sugar for:
         function(object, param0, param1, ...)
     This is what will be required if you want to inject your own bindings.
                        v------------object------------v v--param0--v  v-------param1-----v */
    void createHourglass(CLuaBaseEntity* PLuaBaseEntity, uint8 zoneID, uint32 dynamistoken)
    {
        TracyZoneScoped;

        CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
        if (PEntity->objtype != TYPE_PC)
        {
            printf("Not a PC");
            return;
        }

        auto ret = sql->Query("SELECT value FROM server_variables WHERE name = '[DYNA]Token_%s' LIMIT 1;", zoneID);
        printf("Token Found");
        if (ret != SQL_ERROR && sql->NumRows() && sql->NextRow())
        {
            // auto res = sql->GetUIntData(0);
            // if (res == HOURGLASS_ID)
            // {
                printf("Valid Token");
                CItem* PItem = itemutils::GetItem(HOURGLASS_ID);
                PItem->setQuantity(1);

                ref<uint8>(PItem->m_extra,  0x02) = 1;
                ref<uint32>(PItem->m_extra, 0x04) = PEntity->id;
                ref<uint32>(PItem->m_extra, 0x0C) = currentEpoch();
                ref<uint8>(PItem->m_extra,  0x10) = zoneID;
                ref<uint32>(PItem->m_extra, 0x14) = dynamistoken;
            // }
        }
    }

    /* Used to update hourglasses in a loop to minimize SQL queries, only updates timepoint. Can only be run while in dynamis.
                         v----------object------------v  v------param0-----v  v----param1----v */
    void updateHourglass(CLuaBaseEntity* PLuaBaseEntity, uint32 dynamistoken, uint32 timepoint)
    {
        TracyZoneScoped;

        CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
        auto Zone = PEntity->loc.zone;

        if (PEntity->objtype != TYPE_PC || Zone->GetType() != ZONE_TYPE::DYNAMIS)
        {
            return;
        }

        auto zoneID = Zone->GetID();

        if (auto* PCharEntity = static_cast<CCharEntity*>(PEntity))
        {
            CItemContainer* PContainer = PCharEntity->getStorage(LOC_INVENTORY);
            uint8 numitemsupdated = 0;
            for (int slotIndex = 1; slotIndex <= PContainer->GetSize(); ++slotIndex)
            {
                CItem* PItem = PContainer->GetItem(slotIndex);
                if (PItem != nullptr && PItem->getID() == HOURGLASS_ID && PItem->m_extra[0x14] == dynamistoken && (PItem->m_extra[0x08] != timepoint || PItem->m_extra[0x10] != zoneID))
                {
                    ref<uint32>(PItem->m_extra,  0x08) = timepoint; // Update hourglass timestamp.
                    ref<uint8>(PItem->m_extra,  0x10) = zoneID; // Auto correct for the small chance an incorrect zone was set.
                    PCharEntity->pushPacket(new CInventoryItemPacket(PItem, LOC_INVENTORY, PItem->getSlotID()));
                    ++numitemsupdated;
                }
            };
            if (numitemsupdated)
            {
                PCharEntity->pushPacket(new CInventoryFinishPacket());
            }
        }
    }

    /* Used to update hourglasses in a loop to minimize SQL queries, only updates timepoint. Can only be run while in dynamis.
                           v----------object------------v  v------param0-----v */
    bool validateHourglass(CLuaBaseEntity* PLuaBaseEntity, uint32 dynamistoken)
    {
        TracyZoneScoped;

        CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
        auto Zone = PEntity->loc.zone;

        if (PEntity->objtype != TYPE_PC || Zone->GetType() != ZONE_TYPE::DYNAMIS)
        {
            return false;
        }

        auto zoneID = Zone->GetID();

        if (auto* PCharEntity = static_cast<CCharEntity*>(PEntity))
        {
            CItemContainer* PContainer = PCharEntity->getStorage(LOC_INVENTORY);
            uint8 numitemsupdated = 0;
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
    }

    void OnInit() override
    {
        // player:createHourglass(zoneID, dynamistoken)
        lua["CBaseEntity"]["createHourglass"] = &DynaFuncModule::createHourglass;

        // player:updateHourglass(dynamistoken, timepoint)
        lua["CBaseEntity"]["updateHourglass"] = &DynaFuncModule::updateHourglass;

        // player:validateHourglass(dynamistoken)
        lua["CBaseEntity"]["validateHourglass"] = &DynaFuncModule::validateHourglass;

        /* item:getHourglassToken() - Returns a value for the timepoint from the hourglass' m_extra.
                                                   v--------object------v */
        lua["CBaseItem"]["getHourglassToken"] = [](CLuaItem* PLuaBaseItem)
        {
            TracyZoneScoped;
            return PLuaBaseItem->GetItem()->m_extra[0x14];
        };

        /*item:getHourglassZone() - Returns a value for the zoneID from the hourglass' m_extra.
                                                   v-------object------v */
        lua["CBaseItem"]["getHourglassZone"] = [](CLuaItem* PLuaBaseItem)
        {
            TracyZoneScoped;
            return PLuaBaseItem->GetItem()->m_extra[0x10];
        };

        /*item:getHourglassTimePoint() - Returns a value for the timepoint from the hourglass' m_extra.
                                                       v-------object------v */
        lua["CBaseItem"]["getHourglassTimePoint"] = [](CLuaItem* PLuaBaseItem)
        {
            TracyZoneScoped;
            return PLuaBaseItem->GetItem()->m_extra[0x0C];
        };

    }
};

REGISTER_CPP_MODULE(DynaFuncModule);