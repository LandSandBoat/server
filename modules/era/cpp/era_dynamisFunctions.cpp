/*************************************
 *  Used for the 75 Cap Dynamis
 *  Used to handle hourglass functions.
 *************************************/
#include "map/utils/moduleutils.h"
#include <algorithm>

#include "common/logging.h"
#include "common/sql.h"
#include "map/entities/mobentity.h"
#include "map/item_container.h"
#include "map/items/item_furnishing.h"
#include "map/lua/lua_item.h"
#include "map/lua/luautils.h"
#include "map/packets/inventory_assign.h"
#include "map/packets/inventory_finish.h"
#include "map/packets/inventory_item.h"
#include "map/utils/charutils.h"
#include "map/utils/itemutils.h"

namespace
{
    constexpr uint16 HOURGLASS_ID = 4237;

    uint32 currentEpoch()
    {
        return static_cast<uint32>(time(nullptr));
    }
}; // namespace

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

                ref<uint8>(PItem->m_extra, 0x02)  = 1;
                ref<uint32>(PItem->m_extra, 0x04) = PEntity->id;
                ref<uint32>(PItem->m_extra, 0x0C) = currentEpoch();
                ref<uint8>(PItem->m_extra, 0x10)  = zoneID;
                ref<uint32>(PItem->m_extra, 0x14) = dynamistoken;
                charutils::AddItem(PCharEntity, LOC_INVENTORY, PItem);
            }
        };

        /* player:updateHourglass(dynamistoken, timepoint)
                                                   v----------object------------v  v------param0-----v  v----param1----v */
        lua["CBaseEntity"]["updateHourglass"] = [](CLuaBaseEntity* PLuaBaseEntity, uint32 dynamistoken, uint32 timepoint)
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
                PCharEntity->getStorage(LOC_INVENTORY)->ForEachItem([&PCharEntity, &dynamistoken, &timepoint, &numitemsupdated](CItem* PItem)
                                                                    {
                    if (PItem != nullptr && PItem->getID() == HOURGLASS_ID && ref<uint32>(PItem->m_extra, 0x14) == dynamistoken)
                    {
                        ref<uint32>(PItem->m_extra, 0x08) = timepoint; // Update hourglass timestamp.
                        PCharEntity->pushPacket(new CInventoryItemPacket(PItem, LOC_INVENTORY, PItem->getSlotID()));
                        ++numitemsupdated;
                    } });
                if (numitemsupdated)
                {
                    PCharEntity->pushPacket(new CInventoryFinishPacket());
                }
            }
            return;
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

                    ref<uint8>(PItem->m_extra, 0x02)  = 1;
                    ref<uint32>(PItem->m_extra, 0x04) = originalregistrant;
                    ref<uint32>(PItem->m_extra, 0x0C) = currentEpoch();
                    ref<uint8>(PItem->m_extra, 0x10)  = zoneID;
                    ref<uint32>(PItem->m_extra, 0x14) = dynamistoken;

                    charutils::AddItem(PCharEntity, LOC_INVENTORY, PItem);
                    ++i;
                }
            }
            return;
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
                    if (PItem != nullptr && PItem->getID() == HOURGLASS_ID && ref<uint32>(PItem->m_extra, 0x14) == dynamistoken)
                    {
                        return true;
                    }
                };
                return false;
            }
            return false;
        };

        lua["CBaseEntity"]["setMobType"] = [](CLuaBaseEntity* PLuaBaseEntity, uint8 mobType)
        {
            TracyZoneScoped;

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();

            if (PEntity->objtype != TYPE_MOB)
            {
                return;
            }

            auto* PMob = static_cast<CMobEntity*>(PEntity);

            if (mobType >= MOBTYPE_NORMAL && mobType <= MOBTYPE_EVENT)
            {
                PMob->m_Type = mobType;
            }
        };

        lua["CBaseEntity"]["getDynaInstance"] = [this](CLuaBaseEntity* PLuaBaseEntity)
        {
            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
            auto         PChar   = dynamic_cast<CCharEntity*>(PEntity);

            if (PChar && PChar != nullptr)
            {
                auto query = "SELECT MAX(instanceid) FROM dynamis_participants WHERE charid = %u";

                if (sql->Query(query, PChar->id) != SQL_ERROR && sql->NumRows() > 0 && sql->NextRow() != SQL_ERROR)
                {
                    return sql->GetUIntData(0);
                }
            }

            return (uint32)-1;
        };

        // Register Dynamis Instance
        lua["RegisterDynamisInstance"] = [this](uint32 zoneid, uint32 charid)
        {
            uint32 instID = 0;
            auto   query  = "SELECT MAX(instanceid) FROM dynamis_instances";

            if (sql->Query(query) == SQL_SUCCESS && sql->NumRows() > 0 && sql->NextRow() != SQL_ERROR)
            {
                instID = sql->GetUIntData(0) + 1;
            }
            else
            {
                instID = 1;
            }

            query = "INSERT INTO dynamis_instances VALUES (%u, %u, %u)";
            if (sql->Query(query, instID, zoneid, charid) == SQL_ERROR)
            {
                instID = -1;
            }

            return instID;
        };

        // Add Dynamis Participant
        lua["AddDynamisParticipant"] = [this](uint32 instanceId, uint32 playerId)
        {
            const char* query = "INSERT INTO dynamis_participants VALUES (%u, %u)";
            return sql->Query(query, instanceId, playerId) != SQL_ERROR;
        };

        // Reset All Dynamis Participants
        lua["ResetDynamisInstance"] = [this](uint32 instanceId)
        {
            std::vector<std::string> participants;

            auto query = "SELECT charid FROM dynamis_participants WHERE instanceid = %u";
            if (sql->Query(query, instanceId) != SQL_ERROR && sql->NumRows() > 0 && sql->NextRow() != SQL_ERROR)
            {
                participants.push_back(fmt::format("{}", sql->GetUIntData(0)));
            }

            // Reset all Participants
            if (!participants.empty())
            {
                std::string charids = "";
                for_each(participants.begin(), participants.end(), [&charids](const std::string& charid)
                         { charids += charid; });

                query = "UPDATE char_vars SET value = %u "
                        "WHERE charid IN (%s) AND varname = '%s'";

                sql->Query(query, 73, charids, "DynaReservationStart");
            }
        };

        lua["SaveDynamisSnapshot"] = [this](uint32 instanceId, sol::table indicies)
        {
            auto query = "DELETE FROM dynamis_instance_state WHERE instanceid = %u";
            if (sql->Query(query, instanceId) == SQL_ERROR)
            {
                ShowDebug(fmt::format("Era Dynamis: ERROR! Failed to clear dynamis_instance_state for instanceID: {}", instanceId));
            }

            for (const auto& kvp : indicies)
            {
                if (kvp.second.as<uint32>() == 0)
                {
                    continue;
                }

                query = "INSERT INTO dynamis_instance_state VALUES (%u, %u)";
                if (sql->Query(query, instanceId, kvp.second.as<uint32>()) == SQL_ERROR)
                {
                    ShowDebug(fmt::format("Era Dynamis: ERROR! Failed to save dynamis state for instanceID: {} mobIndex: {}", instanceId, kvp.second.as<uint32>()));
                }
            }
        };

        lua["LoadDynamisSnapshot"] = [this](uint32 instanceId)
        {
            sol::table mobIndicies;
            auto       query = "SELECT mobindex FROM dynamis_instance_state WHERE instanceid = %u";
            if (sql->Query(query, instanceId) != SQL_ERROR && sql->NumRows() > 0)
            {
                while (sql->NextRow() != SQL_ERROR)
                {
                    mobIndicies.add(sql->GetUIntData(0));
                }
            }
            return mobIndicies;
        };
    }
};

REGISTER_CPP_MODULE(DynaFuncModule);
