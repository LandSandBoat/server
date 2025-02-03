/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "common/async.h"
#include "common/blowfish.h"
#include "common/database.h"
#include "common/logging.h"
#include "common/md52.h"
#include "common/mmo.h"
#include "common/socket.h"
#include "common/taskmgr.h"
#include "common/timer.h"
#include "common/utils.h"
#include "common/version.h"

#include <cstring>
#include <utility>

#include "alliance.h"
#include "campaign_system.h"
#include "conquest_system.h"
#include "enmity_container.h"
#include "fishingcontest.h"
#include "item_container.h"
#include "latent_effect_container.h"
#include "linkshell.h"
#include "map.h"
#include "message.h"
#include "mob_modifier.h"
#include "monstrosity.h"
#include "notoriety_container.h"
#include "packet_system.h"
#include "party.h"
#include "recast_container.h"
#include "roe.h"
#include "spell.h"
#include "status_effect_container.h"
#include "trade_container.h"
#include "treasure_pool.h"
#include "unitychat.h"
#include "universal_container.h"
#include "zone.h"

#include "ai/ai_container.h"
#include "ai/states/death_state.h"

#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "entities/npcentity.h"
#include "entities/trustentity.h"

#include "items/item_flowerpot.h"
#include "items/item_shop.h"

#include "lua/luautils.h"

#include "packets/basic.h"
#include "packets/bazaar_check.h"
#include "packets/bazaar_close.h"
#include "packets/bazaar_confirmation.h"
#include "packets/bazaar_item.h"
#include "packets/bazaar_message.h"
#include "packets/bazaar_purchase.h"
#include "packets/blacklist_edit_response.h"
#include "packets/campaign_map.h"
#include "packets/change_music.h"
#include "packets/char.h"
#include "packets/char_abilities.h"
#include "packets/char_appearance.h"
#include "packets/char_check.h"
#include "packets/char_emote_list.h"
#include "packets/char_emotion.h"
#include "packets/char_emotion_jump.h"
#include "packets/char_equip.h"
#include "packets/char_health.h"
#include "packets/char_job_extra.h"
#include "packets/char_jobs.h"
#include "packets/char_mounts.h"
#include "packets/char_recast.h"
#include "packets/char_skills.h"
#include "packets/char_spells.h"
#include "packets/char_stats.h"
#include "packets/char_sync.h"
#include "packets/char_update.h"
#include "packets/chat_message.h"
#include "packets/chocobo_digging.h"
#include "packets/conquest_map.h"
#include "packets/cs_position.h"
#include "packets/currency1.h"
#include "packets/currency2.h"
#include "packets/downloading_data.h"
#include "packets/entity_update.h"
#include "packets/fish_ranking.h"
#include "packets/furniture_interact.h"
#include "packets/guild_menu_buy.h"
#include "packets/guild_menu_buy_update.h"
#include "packets/guild_menu_sell.h"
#include "packets/guild_menu_sell_update.h"
#include "packets/inventory_assign.h"
#include "packets/inventory_count.h"
#include "packets/inventory_finish.h"
#include "packets/inventory_item.h"
#include "packets/inventory_modify.h"
#include "packets/inventory_size.h"
#include "packets/jobpoint_details.h"
#include "packets/jobpoint_update.h"
#include "packets/linkshell_equip.h"
#include "packets/linkshell_message.h"
#include "packets/lock_on.h"
#include "packets/macroequipset.h"
#include "packets/map_marker.h"
#include "packets/menu_config.h"
#include "packets/menu_jobpoints.h"
#include "packets/menu_merit.h"
#include "packets/menu_raisetractor.h"
#include "packets/menu_unity.h"
#include "packets/merit_points_categories.h"
#include "packets/message_basic.h"
#include "packets/message_combat.h"
#include "packets/message_standard.h"
#include "packets/message_system.h"
#include "packets/monipulator1.h"
#include "packets/monipulator2.h"
#include "packets/party_define.h"
#include "packets/party_invite.h"
#include "packets/party_map.h"
#include "packets/party_search.h"
#include "packets/position.h"
#include "packets/release.h"
#include "packets/release_special.h"
#include "packets/roe_questlog.h"
#include "packets/roe_sparkupdate.h"
#include "packets/roe_update.h"
#include "packets/send_blacklist.h"
#include "packets/server_ip.h"
#include "packets/server_message.h"
#include "packets/shop_appraise.h"
#include "packets/shop_buy.h"
#include "packets/status_effects.h"
#include "packets/synth_suggestion.h"
#include "packets/trade_action.h"
#include "packets/trade_item.h"
#include "packets/trade_request.h"
#include "packets/trade_update.h"
#include "packets/wide_scan_track.h"
#include "packets/world_pass.h"
#include "packets/zone_in.h"
#include "packets/zone_visited.h"

#include "utils/auctionutils.h"
#include "utils/battleutils.h"
#include "utils/blacklistutils.h"
#include "utils/blueutils.h"
#include "utils/charutils.h"
#include "utils/dboxutils.h"
#include "utils/fishingutils.h"
#include "utils/gardenutils.h"
#include "utils/itemutils.h"
#include "utils/jailutils.h"
#include "utils/petutils.h"
#include "utils/puppetutils.h"
#include "utils/synthutils.h"
#include "utils/zoneutils.h"

uint8 PacketSize[512];

std::function<void(map_session_data_t* const, CCharEntity* const, CBasicPacket&)> PacketParser[512];

/************************************************************************
 *                                                                       *
 *  Display the contents of the incoming packet to the console.          *
 *                                                                       *
 ************************************************************************/

void PrintPacket(CBasicPacket& packet)
{
    std::string message;

    for (std::size_t idx = 0U; idx < packet.getSize(); idx++)
    {
        uint8 byte = *packet[idx];
        message.append(fmt::format("{:02x} ", byte));

        if (((idx + 1U) % 16U) == 0U)
        {
            message += "\n";
            ShowDebug(message.c_str());
            message.clear();
        }
    }

    if (!message.empty())
    {
        message += "\n";
        ShowDebug(message.c_str());
    }
}

namespace
{
    auto escapeString(const std::string_view str) -> std::string
    {
        // TODO: Replace with db::escapeString
        return _sql->EscapeString(str);
    }
} // namespace

/************************************************************************
 *                                                                       *
 *  Unknown Packet                                                       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x000(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    ShowWarning("parse: Unhandled game packet %03hX from user: %s", (data.ref<uint16>(0) & 0x1FF), PChar->getName());
}

/************************************************************************
 *                                                                       *
 *  Non-Implemented Packet                                               *
 *                                                                       *
 ************************************************************************/

void SmallPacket0xFFF_NOT_IMPLEMENTED(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    ShowWarning("parse: SmallPacket is not implemented Type<%03hX>", (data.ref<uint16>(0) & 0x1FF));
}

/************************************************************************
 *                                                                       *
 *  Log Into Zone                                                        *
 *                                                                       *
 *  Update session key and client port between zone transitions.         *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x00A(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    data.ref<uint32>(0x5C) = 0;

    if (PSession->blowfish.status == BLOWFISH_ACCEPTED && PChar->status == STATUS_TYPE::NORMAL) // Do nothing if character is zoned in
    {
        ShowWarning("packet_system::SmallPacket0x00A player '%s' attempting to send 0x00A when already logged in", PChar->getName());
        return;
    }

    /*
     * Handle out of sync zone correction..
     */
    if (data.ref<uint16_t>(0x02) > 1)
    {
        PSession->server_packet_id = data.ref<uint16_t>(0x02);

        // Clear all pending packets for this character.
        // This incoming 0x00A from the client wants us to set the starting sync count for all new packets to the sync count from 0x02.
        // If we do not do this, all further packets may be ignored by the client and will result in disconnection from the server.
        if (PChar)
        {
            PChar->clearPacketList();
        }
    }

    // No real distinction between these two states in the 0x00A handler --
    // Key is already assumed to be incremented correctly,
    // Pending zone is same process transfer, and waiting is new login or different process.
    if (PSession->blowfish.status == BLOWFISH_PENDING_ZONE || PSession->blowfish.status == BLOWFISH_WAITING) // Call zone in, etc, only once.
    {
        PSession->blowfish.status = BLOWFISH_ACCEPTED;
        PChar->clearPacketList();

        if (PChar->loc.zone != nullptr)
        {
            ShowError(fmt::format("{} sent 0x00A while their original zone wasn't wiped!", PChar->getName()));
            return;
        }

        PSession->shuttingDown = 0;

        uint16 destination = PChar->loc.destination;
        CZone* destZone    = zoneutils::GetZone(destination);

        if (destination >= MAX_ZONEID || destZone == nullptr)
        {
            // TODO: work out how to drop player in moghouse that exits them to the zone they were in before this happened, like we used to.
            ShowWarning("packet_system::SmallPacket0x00A player tried to enter zone that was invalid or out of range");
            ShowWarning("packet_system::SmallPacket0x00A dumping player `%s` to homepoint!", PChar->getName());
            charutils::HomePoint(PChar, true);
            return;
        }

        destZone->IncreaseZoneCounter(PChar);

        PChar->m_ZonesList[PChar->getZone() >> 3] |= (1 << (PChar->getZone() % 8));

        const char* fmtQuery = "UPDATE accounts_sessions SET targid = %u, server_addr = %u, client_port = %u, last_zoneout_time = 0 WHERE charid = %u";

        // Current zone could either be current zone or destination
        CZone* currentZone = zoneutils::GetZone(PChar->getZone());

        if (currentZone == nullptr)
        {
            ShowWarning("currentZone was null for Zone ID %d.", PChar->getZone());
            return;
        }

        _sql->Query(fmtQuery, PChar->targid, currentZone->GetIP(), PSession->client_port, PChar->id);

        fmtQuery  = "SELECT death FROM char_stats WHERE charid = %u";
        int32 ret = _sql->Query(fmtQuery, PChar->id);
        if (_sql->NextRow() == SQL_SUCCESS)
        {
            // Update the character's death timestamp based off of how long they were previously dead
            uint32 secondsSinceDeath = _sql->GetUIntData(0);
            if (PChar->health.hp == 0)
            {
                PChar->SetDeathTimestamp((uint32)time(nullptr) - secondsSinceDeath);
                PChar->Die(CCharEntity::death_duration - std::chrono::seconds(secondsSinceDeath));
            }
        }

        fmtQuery = "SELECT pos_prevzone FROM chars WHERE charid = %u";
        ret      = _sql->Query(fmtQuery, PChar->id);
        if (ret != SQL_ERROR && _sql->NextRow() == SQL_SUCCESS)
        {
            if (PChar->getZone() == _sql->GetUIntData(0))
            {
                PChar->loc.zoning = true;
            }
        }

        charutils::SaveCharPosition(PChar);
        charutils::SaveZonesVisited(PChar);
        charutils::SavePlayTime(PChar);

        if (PChar->m_moghouseID != 0)
        {
            PChar->m_charHistory.mhEntrances++;
            gardenutils::UpdateGardening(PChar, false);
        }
    }

    // Only release client from "Downloading Data" if the packet sequence came in without a drop on 0x00D
    // It is also possible that the client also never received our packets to release themselves from the loading screen.
    // TODO: Need further research into the relationship between 0x00D and 0x00A, if any.
    if (PChar->loc.zone != nullptr)
    {
        if (PChar->m_moghouseID != 0)
        {
            // Update any mannequins that might be placed on zonein
            // Build Mannequin model id list
            auto getModelIdFromStorageSlot = [](CCharEntity* PChar, uint8 slot) -> uint16
            {
                uint16 modelId = 0x0000;

                if (slot == 0)
                {
                    return modelId;
                }

                auto* PItem = PChar->getStorage(LOC_STORAGE)->GetItem(slot);
                if (PItem == nullptr)
                {
                    return modelId;
                }

                if (auto* PItemEquipment = dynamic_cast<CItemEquipment*>(PItem))
                {
                    modelId = PItemEquipment->getModelId();
                }

                return modelId;
            };

            for (auto safeContainerId : { LOC_MOGSAFE, LOC_MOGSAFE2 })
            {
                CItemContainer* PContainer = PChar->getStorage(safeContainerId);
                for (int slotIndex = 1; slotIndex <= PContainer->GetSize(); ++slotIndex)
                {
                    CItem* PContainerItem = PContainer->GetItem(slotIndex);
                    if (PContainerItem != nullptr && PContainerItem->isType(ITEM_FURNISHING))
                    {
                        auto* PFurnishing = static_cast<CItemFurnishing*>(PContainerItem);
                        if (PFurnishing->isInstalled() && PFurnishing->isMannequin())
                        {
                            auto*  PMannequin = PFurnishing;
                            uint16 mainId     = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 0]);
                            uint16 subId      = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 1]);
                            uint16 rangeId    = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 2]);
                            uint16 headId     = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 3]);
                            uint16 bodyId     = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 4]);
                            uint16 handsId    = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 5]);
                            uint16 legId      = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 6]);
                            uint16 feetId     = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 7]);
                            PChar->pushPacket<CInventoryCountPacket>(safeContainerId, slotIndex, headId, bodyId, handsId, legId, feetId, mainId, subId, rangeId);
                        }
                    }
                }
            }
        }

        PChar->pushPacket<CDownloadingDataPacket>();
        PChar->pushPacket<CZoneInPacket>(PChar, PChar->currentEvent);
        PChar->pushPacket<CZoneVisitedPacket>(PChar);
    }
}

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x000C
/************************************************************************
 *                                                                       *
 *  GP_CLI_COMMAND_GAMEOK                                                *
 *  Client is ready to receive packets from the server.                  *
 *  Before this packet is sent, all commands are blocked locally.        *
 ************************************************************************/

void SmallPacket0x00C(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->pushPacket<CInventorySizePacket>(PChar);
    PChar->pushPacket<CMenuConfigPacket>(PChar);
    PChar->pushPacket<CCharJobsPacket>(PChar);

    if (charutils::hasKeyItem(PChar, 2544))
    {
        // Only send Job Points Packet if the player has unlocked them
        PChar->pushPacket<CJobPointDetailsPacket>(PChar);
    }

    // TODO: While in mog house; treasure pool is not created.
    if (PChar->PTreasurePool != nullptr)
    {
        PChar->PTreasurePool->UpdatePool(PChar);
    }
    PChar->loc.zone->SpawnTransport(PChar);

    // respawn any pets from last zone
    if (PChar->loc.zone->CanUseMisc(MISC_PET) && !PChar->m_moghouseID)
    {
        if (PChar->shouldPetPersistThroughZoning())
        {
            petutils::SpawnPet(PChar, PChar->petZoningInfo.petID, true);
        }

        PChar->resetPetZoningInfo();
    }
}

/************************************************************************
 *                                                                       *
 *  Player Leaving Zone (Dezone)                                         *
 *  It is not reliable to recieve this packet, so do nothing.            *
 ************************************************************************/

void SmallPacket0x00D(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    std::ignore = data;
    std::ignore = PSession;
    std::ignore = PChar;
}

/************************************************************************
 *                                                                       *
 *  Player Information Request                                           *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x00F(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    charutils::SendKeyItems(PChar);
    charutils::SendQuestMissionLog(PChar);

    PChar->pushPacket<CCharSpellsPacket>(PChar);
    PChar->pushPacket<CCharMountsPacket>(PChar);
    PChar->pushPacket<CCharAbilitiesPacket>(PChar);
    PChar->pushPacket<CCharSyncPacket>(PChar);
    PChar->pushPacket<CBazaarMessagePacket>(PChar);
    PChar->pushPacket<CMeritPointsCategoriesPacket>(PChar);

    charutils::SendInventory(PChar);

    // Note: This sends the stop downloading packet!
    blacklistutils::SendBlacklist(PChar);
}

/************************************************************************
 *                                                                       *
 *  Player Zone Transition Confirmation                                  *
 *  First packet sent after transitioning zones or entering the game.    *
 *  Client confirming the zoning was successful, equips gear.            *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x011(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PSession->blowfish.status = BLOWFISH_ACCEPTED;
    PChar->status             = STATUS_TYPE::NORMAL;
    PChar->health.tp          = 0;

    for (uint8 i = 0; i < 16; ++i)
    {
        if (PChar->equip[i] != 0)
        {
            PChar->pushPacket<CEquipPacket>(PChar->equip[i], i, PChar->equipLoc[i]);
        }
    }

    PChar->PAI->QueueAction(queueAction_t(4000ms, false, zoneutils::AfterZoneIn));

    // TODO: kill player til theyre dead and bsod
    const char* fmtQuery = "SELECT version_mismatch FROM accounts_sessions WHERE charid = %u";
    int32       ret      = _sql->Query(fmtQuery, PChar->id);
    if (ret != SQL_ERROR && _sql->NextRow() == SQL_SUCCESS)
    {
        // On zone change, only sending a version message if mismatch
        // if ((bool)sql->GetUIntData(0))
        // PChar->pushPacket<CChatMessagePacket>(PChar, CHAT_MESSAGE_TYPE::MESSAGE_SYSTEM_1, "Server does not support this client version.");
    }
}

/************************************************************************
 *                                                                       *
 *  Player Sync                                                          *
 *  Updates the players position and other important information.        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x015(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    TracyZoneCString("Player Sync");

    if (PChar->status != STATUS_TYPE::SHUTDOWN && PChar->status != STATUS_TYPE::DISAPPEAR)
    {
        float  newX        = data.ref<float>(0x04);
        float  newY        = data.ref<float>(0x08);
        float  newZ        = data.ref<float>(0x0C);
        uint16 newTargID   = data.ref<uint16>(0x16);
        uint8  newRotation = data.ref<uint8>(0x14);

        // clang-format off
        bool moved =
            PChar->loc.p.x != newX ||
            PChar->loc.p.y != newY ||
            PChar->loc.p.z != newZ ||
            PChar->m_TargID != newTargID ||
            PChar->loc.p.rotation != newRotation;
        // clang-format on

        // Cache previous location
        PChar->m_previousLocation = PChar->loc;

        if (!PChar->isCharmed)
        {
            PChar->loc.p.x = newX;
            PChar->loc.p.y = newY;
            PChar->loc.p.z = newZ;

            PChar->loc.p.moving   = data.ref<uint16>(0x12);
            PChar->loc.p.rotation = newRotation;

            PChar->m_TargID = newTargID;
        }

        if (moved)
        {
            PChar->updatemask |= UPDATE_POS; // Indicate that we want to update this PChar's PChar->loc or targID

            // Calculate rough amount of steps taken
            if (PChar->m_previousLocation.zone->GetID() == PChar->loc.zone->GetID())
            {
                float distanceTravelled = distance(PChar->m_previousLocation.p, PChar->loc.p);
                PChar->m_charHistory.distanceTravelled += static_cast<uint32>(distanceTravelled);
            }
        }

        // Request updates for all entity types
        PChar->loc.zone->SpawnNPCs(PChar); // Some NPCs can move, some rotate when other players talk to them, always request NPC updates.
        PChar->loc.zone->SpawnMOBs(PChar);
        PChar->loc.zone->SpawnPETs(PChar);
        PChar->loc.zone->SpawnTRUSTs(PChar);
        PChar->requestedInfoSync = true; // Ask to update PCs during CZoneEntities::ZoneServer

        // clang-format off
        PChar->WideScanTarget.apply([&](const auto& wideScanTarget)
        {
            if (const auto* PWideScanEntity = PChar->GetEntity(wideScanTarget.targid, TYPE_MOB | TYPE_NPC))
            {
                PChar->pushPacket<CWideScanTrackPacket>(PWideScanEntity);

                if (PWideScanEntity->status == STATUS_TYPE::DISAPPEAR)
                {
                    PChar->WideScanTarget = std::nullopt;
                }
            }
            else
            {
                PChar->WideScanTarget = std::nullopt;
            }
        });
        // clang-format on
    }
}

/************************************************************************
 *                                                                       *
 *  Entity Information Request (Event NPC Information Request)           *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x016(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint16 targid = data.ref<uint16>(0x04);

    if (targid == PChar->targid)
    {
        PChar->updateCharPacket(PChar, ENTITY_SPAWN, UPDATE_ALL_CHAR);
        PChar->pushPacket<CCharUpdatePacket>(PChar);
    }
    else
    {
        CBaseEntity* PEntity = PChar->GetEntity(targid, TYPE_NPC | TYPE_PC);

        if (PEntity && PEntity->objtype == TYPE_PC)
        {
            // Char we want an update for
            CCharEntity* PCharEntity = dynamic_cast<CCharEntity*>(PEntity);
            if (PCharEntity)
            {
                if (!PCharEntity->m_isGMHidden)
                {
                    PChar->updateCharPacket(PCharEntity, ENTITY_SPAWN, UPDATE_ALL_CHAR);
                }
                else
                {
                    ShowError(fmt::format("Player {} requested information about a hidden GM ({}) using targid {}", PChar->getName(), PCharEntity->getName(), targid));
                }
            }
        }
        else
        {
            if (!PEntity)
            {
                PEntity = zoneutils::GetTrigger(targid, PChar->getZone());

                // PEntity->id will now be the full id of the entity we could not find
                ShowWarning(fmt::format("Server missing npc_list.sql entry <{}> in zone <{} ({})>",
                                        PEntity->id, zoneutils::GetZone(PChar->getZone())->getName(), PChar->getZone()));
            }

            // Special case for onZoneIn cutscenes in Mog House
            if (PChar->m_moghouseID &&
                PEntity->status == STATUS_TYPE::DISAPPEAR &&
                PEntity->loc.p.z == 1.5 &&
                PEntity->look.face == 0x52)
            {
                // Using the same logic as in ZoneEntities::SpawnConditionalNPCs:
                // Change the status of the entity, send the packet, change it back to disappear
                PEntity->status = STATUS_TYPE::NORMAL;
                PChar->updateEntityPacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
                PEntity->status = STATUS_TYPE::DISAPPEAR;
            }
            else
            {
                PChar->updateEntityPacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
            }
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Invalid NPC Information Response                                     *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x017(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint16 targid = data.ref<uint16>(0x04);
    uint32 npcid  = data.ref<uint32>(0x08);
    uint8  type   = data.ref<uint8>(0x12);

    ShowWarning("SmallPacket0x17: Incorrect NPC(%u,%u) type(%u)", targid, npcid, type);
}

/************************************************************************
 *                                                                       *
 *  Player Action                                                        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x01A(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    uint16 TargID = data.ref<uint16>(0x08);
    uint8  action = data.ref<uint8>(0x0A);

    // clang-format off
    position_t actionOffset =
    {
        data.ref<float>(0x10),
        data.ref<float>(0x14),
        data.ref<float>(0x18),
        0, // moving (packet only contains x/y/z)
        0, // rotation (packet only contains x/y/z)
    };
    // clang-format on

    constexpr auto actionToStr = [](uint8 actionIn)
    {
        switch (actionIn)
        {
            case 0x00:
                return "Trigger";
            case 0x02:
                return "Attack";
            case 0x03:
                return "Spellcast";
            case 0x04:
                return "Disengage";
            case 0x05:
                return "Call for Help";
            case 0x07:
                return "Weaponskill";
            case 0x09:
                return "Job Ability";
            case 0x0B:
                return "Homepoint";
            case 0x0C:
                return "Assist";
            case 0x0D:
                return "Raise";
            case 0x0E:
                return "Fishing";
            case 0x0F:
                return "Change Target";
            case 0x10:
                return "Ranged Attack";
            case 0x11:
                return "Chocobo Digging";
            case 0x12:
                return "Dismount";
            case 0x13:
                return "Tractor Menu";
            case 0x14:
                return "Complete Character Update";
            case 0x15:
                return "Ballista - Quarry";
            case 0x16:
                return "Ballista - Sprint";
            case 0x17:
                return "Ballista - Scout";
            case 0x18:
                return "Blockaid";
            case 0x19:
                return "Monstrosity Monster Skill";
            case 0x1A:
                return "Mounts";
            default:
                return "Unknown";
        }
    };

    // Monstrosity: Can't really do anything while under Gestation until you click it off.
    //            : MONs can trigger doors, so we'll handle that later.
    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_GESTATION) && action == 0x00)
    {
        return;
    }

    auto actionStr = fmt::format("Player Action: {}: {} (0x{:02X}) -> targid: {}", PChar->getName(), actionToStr(action), action, TargID);
    TracyZoneString(actionStr);
    ShowTrace(actionStr);
    DebugActions(actionStr);

    // Retrigger latents if the previous packet parse in this chunk included equip/equipset
    if (PChar->retriggerLatents)
    {
        for (uint8 equipSlotID = 0; equipSlotID < 16; ++equipSlotID)
        {
            if (PChar->equip[equipSlotID] != 0)
            {
                PChar->PLatentEffectContainer->CheckLatentsEquip(equipSlotID);
            }
        }
        PChar->retriggerLatents = false; // reset as we have retriggered the latents somewhere
    }

    switch (action)
    {
        case 0x00: // trigger
        {
            if (PChar->StatusEffectContainer->HasPreventActionEffect())
            {
                return;
            }

            if (PChar->m_Costume != 0 || PChar->animation == ANIMATION_SYNTH || (PChar->CraftContainer && PChar->CraftContainer->getItemsCount() > 0))
            {
                PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::STANDARD);
                return;
            }

            CBaseEntity* PNpc = nullptr;
            PNpc              = PChar->GetEntity(TargID, TYPE_NPC | TYPE_MOB);

            // MONs are allowed to use doors, but nothing else
            if (PChar->m_PMonstrosity != nullptr &&
                PNpc->look.size != 0x02 &&
                PChar->getZone() != ZONEID::ZONE_FERETORY &&
                !settings::get<bool>("main.MONSTROSITY_TRIGGER_NPCS"))
            {
                PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::STANDARD);
                return;
            }

            // NOTE: Moogles inside of mog houses are the exception for not requiring Spawned or Status checks.
            if (PNpc != nullptr && distance(PNpc->loc.p, PChar->loc.p) <= 6.0f && ((PNpc->PAI->IsSpawned() && PNpc->status == STATUS_TYPE::NORMAL) || PChar->m_moghouseID != 0))
            {
                PNpc->PAI->Trigger(PChar);
                PChar->m_charHistory.npcInteractions++;
            }

            // Releasing a trust
            // TODO: 0x0c is set to 0x1, not sure if that is relevant or not.
            if (auto* PTrust = dynamic_cast<CTrustEntity*>(PChar->GetEntity(TargID, TYPE_TRUST)))
            {
                PChar->RemoveTrust(PTrust);
            }

            if (!PChar->isNpcLocked())
            {
                PChar->eventPreparation->reset();
                PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::STANDARD);
            }
        }
        break;
        case 0x02: // attack
        {
            if (PChar->isMounted())
            {
                PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_MOUNTED);
            }

            PChar->PAI->Engage(TargID);
        }
        break;
        case 0x03: // spellcast
        {
            auto spellID = static_cast<SpellID>(data.ref<uint16>(0x0C));
            PChar->PAI->Cast(TargID, spellID);

            // target offset used only for luopan placement as of now
            if (spellID >= SpellID::Geo_Regen && spellID <= SpellID::Geo_Gravity)
            {
                // reset the action offset position to prevent other spells from using previous position data
                PChar->m_ActionOffsetPos = {};

                // Need to set the target position plus offset for positioning correctly
                auto* PTarget = dynamic_cast<CBattleEntity*>(PChar->GetEntity(TargID));

                if (PTarget != nullptr)
                {
                    PChar->m_ActionOffsetPos = {
                        PTarget->loc.p.x + actionOffset.x,
                        PTarget->loc.p.y + actionOffset.y,
                        PTarget->loc.p.z + actionOffset.z,
                        0, // packet only contains x/y/z
                        0, //
                    };
                }
            }
        }
        break;
        case 0x04: // disengage
        {
            if (!PChar->StatusEffectContainer->HasStatusEffect({ EFFECT_CHARM, EFFECT_CHARM_II }))
            {
                PChar->PAI->Disengage();
            }
        }
        break;
        case 0x05: // call for help
        {
            if (PChar->StatusEffectContainer->HasPreventActionEffect())
            {
                return;
            }

            if (auto* PMob = dynamic_cast<CMobEntity*>(PChar->GetBattleTarget()))
            {
                if (!PMob->GetCallForHelpFlag() && PMob->PEnmityContainer->HasID(PChar->id) && !PMob->m_CallForHelpBlocked)
                {
                    PMob->SetCallForHelpFlag(true);
                    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CMessageBasicPacket>(PChar, PChar, 0, 0, 19));
                    return;
                }
            }

            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, 22);
        }
        break;
        case 0x07: // weaponskill
        {
            if (!PChar->PAI->IsEngaged() && settings::get<bool>("map.PREVENT_UNENGAGED_WS")) // Prevent Weaponskill usage if player isn't engaged.
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_WS);
                return;
            }

            uint16 WSkillID = data.ref<uint16>(0x0C);
            PChar->PAI->WeaponSkill(TargID, WSkillID);
        }
        break;
        case 0x09: // jobability
        {
            uint16 JobAbilityID     = data.ref<uint16>(0x0C);
            uint8  currentAnimation = PChar->animation;

            if (currentAnimation != ANIMATION_NONE && currentAnimation != ANIMATION_ATTACK)
            {
                ShowWarning("SmallPacket0x01A: Player %s trying to use a Job Ability from invalid state", PChar->getName());
                return;
            }

            // Don't allow BST to use ready before level 25
            if (PChar->PPet != nullptr && (!charutils::hasAbility(PChar, ABILITY_READY) || !PChar->PPet->PAI->IsEngaged()))
            {
                if (JobAbilityID >= ABILITY_FOOT_KICK && JobAbilityID <= ABILITY_PENTAPECK) // Is this a BST ability?
                {
                    PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA2);
                    return;
                }
            }

            PChar->PAI->Ability(TargID, JobAbilityID);
        }
        break;
        case 0x0B: // homepoint
        {
            if (!PChar->isDead())
            {
                return;
            }

            if (PChar->m_PMonstrosity != nullptr)
            {
                auto type = data.ref<uint8>(0x0C);
                monstrosity::HandleDeathMenu(PChar, type);
                return;
            }

            PChar->setCharVar("expLost", 0);
            charutils::HomePoint(PChar, true);
        }
        break;
        case 0x0C: // assist
        {
            battleutils::assistTarget(PChar, TargID);
        }
        break;
        case 0x0D: // raise menu
        {
            if (!PChar->m_hasRaise)
            {
                return;
            }

            if (data.ref<uint8>(0x0C) == 0)
            { // ACCEPTED RAISE
                PChar->Raise();
            }
            else
            {
                PChar->m_hasRaise = 0;
            }
        }
        break;
        case 0x0E: // Fishing
        {
            if (PChar->StatusEffectContainer->HasPreventActionEffect())
            {
                return;
            }

            fishingutils::StartFishing(PChar);
        }
        break;
        case 0x0F: // change target
        {
            PChar->PAI->ChangeTarget(TargID);
        }
        break;
        case 0x10: // Ranged Attack
        {
            uint8 currentAnimation = PChar->animation;
            if (currentAnimation != ANIMATION_NONE && currentAnimation != ANIMATION_ATTACK)
            {
                ShowWarning("SmallPacket0x01A: Player %s trying to Ranged Attack from invalid state", PChar->getName());
                return;
            }

            PChar->PAI->RangedAttack(TargID);
        }
        break;
        case 0x11: // chocobo digging
        {
            // Mounted Check.
            if (!PChar->isMounted())
            {
                return;
            }

            // Gysahl Green Check.
            uint8 slotID = PChar->getStorage(LOC_INVENTORY)->SearchItem(4545);
            if (slotID == ERROR_SLOTID)
            {
                PChar->pushPacket<CMessageSystemPacket>(4545, 0, MsgStd::YouDontHaveAny);
                return;
            }

            // Consume Gysahl Green and push animation on dig attempt.
            if (luautils::OnChocoboDig(PChar))
            {
                charutils::UpdateItem(PChar, LOC_INVENTORY, slotID, -1);
                PChar->pushPacket<CInventoryFinishPacket>();
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CChocoboDiggingPacket>(PChar));
            }
        }
        break;
        case 0x12: // dismount
        {
            if (PChar->StatusEffectContainer->HasPreventActionEffect() || !PChar->isMounted())
            {
                return;
            }

            PChar->animation = ANIMATION_NONE;
            PChar->updatemask |= UPDATE_HP;
            PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_MOUNTED);
            // Workaround for a bug where dismounting out of update range would cause the character to stop rendering.
            PChar->loc.zone->UpdateCharPacket(PChar, ENTITY_UPDATE, UPDATE_HP);
        }
        break;
        case 0x13: // tractor menu
        {
            if (data.ref<uint8>(0x0C) == 0 && PChar->m_hasTractor != 0) // ACCEPTED TRACTOR
            {
                // PChar->PBattleAI->SetCurrentAction(ACTION_RAISE_MENU_SELECTION);
                PChar->loc.p           = PChar->m_StartActionPos;
                PChar->loc.destination = PChar->getZone();
                PChar->status          = STATUS_TYPE::DISAPPEAR;
                PChar->loc.boundary    = 0;
                PChar->clearPacketList();
                charutils::SendToZone(PChar, 2, zoneutils::GetZoneIPP(PChar->loc.destination));
            }

            PChar->m_hasTractor = 0;
        }
        break;
        case 0x14: // complete character update
        {
            if (PChar->m_moghouseID != 0) // TODO: For now this is only in the moghouse
            {
                PChar->loc.zone->SpawnConditionalNPCs(PChar);
            }
            else
            {
                PChar->requestedInfoSync = true;
                PChar->loc.zone->SpawnNPCs(PChar);
                PChar->loc.zone->SpawnMOBs(PChar);
                PChar->loc.zone->SpawnTRUSTs(PChar);
            }
        }
        break;
        case 0x15: // ballista - quarry
        case 0x16: // ballista - sprint
        case 0x17: // ballista - scout
            break;
        case 0x18: // blockaid
        {
            if (!PChar->StatusEffectContainer->HasStatusEffect(EFFECT_ALLIED_TAGS))
            {
                uint8 type = data.ref<uint8>(0x0C);

                if (type == 0x00 && PChar->getBlockingAid()) // /blockaid off
                {
                    // Blockaid canceled
                    PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::BlockaidCanceled);
                    PChar->setBlockingAid(false);
                }
                else if (type == 0x01 && !PChar->getBlockingAid()) // /blockaid on
                {
                    // Blockaid activated
                    PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::BlockaidActivated);
                    PChar->setBlockingAid(true);
                }
                else if (type == 0x02) // /blockaid
                {
                    // Blockaid is currently active/inactive
                    PChar->pushPacket<CMessageSystemPacket>(0, 0, PChar->getBlockingAid() ? MsgStd::BlockaidCurrentlyActive : MsgStd::BlockaidCurrentlyInactive);
                }
            }
            else
            {
                PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CannotUseCommandAtTheMoment);
            }
        }
        break;
        case 0x19: // Monstrosity Monster Skill
        {
            monstrosity::HandleMonsterSkillActionPacket(PChar, data);
        }
        break;
        case 0x1A: // mounts
        {
            uint8 MountID = data.ref<uint8>(0x0C);

            if (PChar->animation != ANIMATION_NONE)
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, 71);
            }
            else if (!PChar->loc.zone->CanUseMisc(MISC_MOUNT))
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
            }
            else if (PChar->GetMLevel() < 20)
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 20, 0, 773);
            }
            else if (charutils::hasKeyItem(PChar, 3072 + MountID))
            {
                if (PChar->PRecastContainer->HasRecast(RECAST_ABILITY, 256, 60))
                {
                    PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, 94);

                    // add recast timer
                    // PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, 202);
                    return;
                }

                if (PChar->hasEnmityEXPENSIVE())
                {
                    PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_YOUR_MOUNT_REFUSES);
                    return;
                }

                PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(
                                                                  EFFECT_MOUNTED,
                                                                  EFFECT_MOUNTED,
                                                                  MountID ? ++MountID : 0,
                                                                  0,
                                                                  1800,
                                                                  0,
                                                                  0x40), // previously known as nameflag "FLAG_CHOCOBO"
                                                              true);

                PChar->PRecastContainer->Add(RECAST_ABILITY, 256, 60);
                PChar->pushPacket<CCharRecastPacket>(PChar);

                luautils::OnPlayerMount(PChar);
            }
        }
        break;
        default:
        {
            ShowWarning(fmt::format("CLIENT {} PERFORMING UNHANDLED ACTION {} (0x{:02X})", PChar->getName(), actionStr, action));
            return;
        }
        break;
    }
}

/************************************************************************
 *                                                                       *
 *  World Pass                                                           *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x01B(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    // 0 - world pass, 2 - gold world pass; +1 - purchase

    PChar->pushPacket<CWorldPassPacket>(data.ref<uint8>(0x04) & 1 ? (uint32)xirand::GetRandomNumber(9999999999) : 0);
}

/************************************************************************
 *                                                                       *
 *  Unknown Packet                                                       *
 *  Assumed to be when a client is requesting missing information.       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x01C(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PrintPacket(data);
}

/************************************************************************
 *                                                                       *
 *  /volunteer packet                                                    *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x01E(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    // It sends out a packet of type 0x1E, where the body is a 4 - byte aligned string
    //
    // "/volunteer Volunteer what" without anything targeted results in:
    // 1E0A6405566F6C756E7465657220776861740000 -> Volunteer what\0\0
    //
    // "/volunteer I choose you" with a Savanna Rarab targeted results in:
    // 1E127505492063686F6F736520796F7520543120536176616E6E61205261726162000000 -> I choose you T1 Savanna Rarab\0\0\0
    //
    // "/volunteer hello" with no target -> 1e 06 17 00 68 65 6c 6c 6f 00 00 00
    // "/volunteer test" with no target -> 1e 06 92 00 74 65 73 74 00 00 00 00
    //
    // id - length - seq - 00 - content -- null terminators/padding

    const uint8 HEADER_LENGTH = 4;

    // clang-format off
    std::vector<char> chars;
    std::for_each(data[HEADER_LENGTH], data[HEADER_LENGTH] + (data.getSize() - HEADER_LENGTH), [&](char ch)
    {
        if (isascii(ch) && ch != '\0')
        {
            chars.emplace_back(ch);
        }
    });
    // clang-format on
    auto str = std::string(chars.begin(), chars.end());
    luautils::OnPlayerVolunteer(PChar, str);
}

/************************************************************************
 *                                                                       *
 *  Item Movement (Disposal)                                             *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x028(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    int32 quantity  = data.ref<uint8>(0x04);
    uint8 container = data.ref<uint8>(0x08);
    uint8 slotID    = data.ref<uint8>(0x09);

    CItem* PItem = PChar->getStorage(container)->GetItem(slotID);
    if (PItem == nullptr)
    {
        return;
    }

    uint16 ItemID = PItem->getID();

    if (container >= CONTAINER_ID::MAX_CONTAINER_ID)
    {
        ShowWarning("SmallPacket0x028: Invalid container ID passed to packet %u by %s", container, PChar->getName());
        return;
    }

    if (PItem->isSubType(ITEM_LOCKED))
    {
        ShowWarning("SmallPacket0x028: Attempt of removal of LOCKED item from slot %u", slotID);
        return;
    }

    if (PItem->isStorageSlip())
    {
        int slipData = 0;
        for (int i = 0; i < CItem::extra_size; i++)
        {
            slipData += PItem->m_extra[i];
        }

        if (slipData != 0)
        {
            PChar->pushPacket<CMessageStandardPacket>(MsgStd::CannotBeProcessed);
            return;
        }
    }

    // Break linkshell if the main shell was disposed of.
    CItemLinkshell* ItemLinkshell = dynamic_cast<CItemLinkshell*>(PItem);
    if (ItemLinkshell)
    {
        if (ItemLinkshell->GetLSType() == LSTYPE_LINKSHELL)
        {
            uint32      lsid       = ItemLinkshell->GetLSID();
            CLinkshell* PLinkshell = linkshell::GetLinkshell(lsid);
            if (!PLinkshell)
            {
                PLinkshell = linkshell::LoadLinkshell(lsid);
            }
            PLinkshell->BreakLinkshell();
            linkshell::UnloadLinkshell(lsid);
        }
    }

    // Linkshells (other than Linkpearls and Pearlsacks) and temporary items cannot be stored in the Recycle Bin.
    // TODO: Are there any special messages here?
    if (!settings::get<bool>("map.ENABLE_ITEM_RECYCLE_BIN") || PItem->isType(ITEM_LINKSHELL) || container == CONTAINER_ID::LOC_TEMPITEMS)
    {
        charutils::DropItem(PChar, container, slotID, quantity, ItemID);
        return;
    }

    // Otherwise, to the recycle bin!
    charutils::AddItemToRecycleBin(PChar, container, slotID, quantity);
}

/************************************************************************
 *                                                                       *
 *  Item Movement (Between Containers)                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x029(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint32 quantity       = data.ref<uint8>(0x04);
    uint8  FromLocationID = data.ref<uint8>(0x08);
    uint8  ToLocationID   = data.ref<uint8>(0x09);
    uint8  FromSlotID     = data.ref<uint8>(0x0A);
    uint8  ToSlotID       = data.ref<uint8>(0x0B);

    if (ToLocationID >= CONTAINER_ID::MAX_CONTAINER_ID || FromLocationID >= CONTAINER_ID::MAX_CONTAINER_ID)
    {
        return;
    }

    CItem* PItem = PChar->getStorage(FromLocationID)->GetItem(FromSlotID);

    if (PItem == nullptr || PItem->isSubType(ITEM_LOCKED))
    {
        if (PItem == nullptr)
        {
            ShowWarning("SmallPacket0x29: Trying to move nullptr item from location %u slot %u to location %u slot %u of quan %u ",
                        FromLocationID, FromSlotID, ToLocationID, ToSlotID, quantity);
        }
        else
        {
            ShowWarning("SmallPacket0x29: Trying to move LOCKED item %i from location %u slot %u to location %u slot %u of quan %u ",
                        PItem->getID(), FromLocationID, FromSlotID, ToLocationID, ToSlotID, quantity);
        }

        uint8 size = PChar->getStorage(FromLocationID)->GetSize();
        for (uint8 slotID = 0; slotID <= size; ++slotID)
        {
            CItem* PSlotItem = PChar->getStorage(FromLocationID)->GetItem(slotID);
            if (PSlotItem != nullptr)
            {
                PChar->pushPacket<CInventoryItemPacket>(PSlotItem, FromLocationID, slotID);
            }
        }
        PChar->pushPacket<CInventoryFinishPacket>();

        return;
    }

    if (PItem->getQuantity() - PItem->getReserve() < quantity)
    {
        ShowWarning("SmallPacket0x29: Trying to move too much quantity from location %u slot %u", FromLocationID, FromSlotID);
        return;
    }

    uint32 NewQuantity = PItem->getQuantity() - quantity;

    if (NewQuantity != 0) // split item stack
    {
        if (charutils::AddItem(PChar, ToLocationID, PItem->getID(), quantity) != ERROR_SLOTID)
        {
            charutils::UpdateItem(PChar, FromLocationID, FromSlotID, -(int32)quantity);
        }
    }
    else // move stack / combine items into stack
    {
        if (ToSlotID < 82) // 80 + 1
        {
            ShowDebug("SmallPacket0x29: Trying to unite items", FromLocationID, FromSlotID);
            CItem* PItem2 = PChar->getStorage(ToLocationID)->GetItem(ToSlotID);

            if ((PItem2 != nullptr) && (PItem2->getID() == PItem->getID()) && (PItem2->getQuantity() < PItem2->getStackSize()) &&
                !PItem2->isSubType(ITEM_LOCKED) && (PItem2->getReserve() == 0))
            {
                uint32 totalQty = PItem->getQuantity() + PItem2->getQuantity();
                uint32 moveQty  = 0;

                if (totalQty >= PItem2->getStackSize())
                {
                    moveQty = PItem2->getStackSize() - PItem2->getQuantity();
                }
                else
                {
                    moveQty = PItem->getQuantity();
                }
                if (moveQty > 0)
                {
                    charutils::UpdateItem(PChar, ToLocationID, ToSlotID, moveQty);
                    charutils::UpdateItem(PChar, FromLocationID, FromSlotID, -(int32)moveQty);
                }
            }

            return;
        }

        uint8 NewSlotID = PChar->getStorage(ToLocationID)->InsertItem(PItem);

        if (NewSlotID != ERROR_SLOTID)
        {
            const char* Query = "UPDATE char_inventory SET location = %u, slot = %u WHERE charid = %u AND location = %u AND slot = %u";

            if (_sql->Query(Query, ToLocationID, NewSlotID, PChar->id, FromLocationID, FromSlotID) != SQL_ERROR && _sql->AffectedRows() != 0)
            {
                PChar->getStorage(FromLocationID)->InsertItem(nullptr, FromSlotID);

                PChar->pushPacket<CInventoryItemPacket>(nullptr, FromLocationID, FromSlotID);
                PChar->pushPacket<CInventoryItemPacket>(PItem, ToLocationID, NewSlotID);
            }
            else
            {
                PChar->getStorage(ToLocationID)->InsertItem(nullptr, NewSlotID);
                PChar->getStorage(FromLocationID)->InsertItem(PItem, FromSlotID);
            }
        }
        else
        {
            // Client assumed the location was not full when it is
            // Resend the packets to inform the client of the storage sizes
            uint8 size = PChar->getStorage(ToLocationID)->GetSize();
            for (uint8 slotID = 0; slotID <= size; ++slotID)
            {
                CItem* PSlotItem = PChar->getStorage(ToLocationID)->GetItem(slotID);
                if (PSlotItem != nullptr)
                {
                    PChar->pushPacket<CInventoryItemPacket>(PSlotItem, ToLocationID, slotID);
                }
            }
            PChar->pushPacket<CInventoryFinishPacket>();

            ShowError("SmallPacket0x29: Location %u Slot %u is full", ToLocationID, ToSlotID);
            return;
        }
    }
    PChar->pushPacket<CInventoryFinishPacket>();
}

/************************************************************************
 *                                                                       *
 *  Trade Request                                                        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x032(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    // MONs can't trade
    if (PChar->m_PMonstrosity != nullptr)
    {
        return;
    }

    uint32 charid = data.ref<uint32>(0x04);
    uint16 targid = data.ref<uint16>(0x08);

    CCharEntity* PTarget = (CCharEntity*)PChar->GetEntity(targid, TYPE_PC);

    if ((PTarget != nullptr) && (PTarget->id == charid))
    {
        ShowDebug("%s initiated trade request with %s", PChar->getName(), PTarget->getName());

        // If the player is the same as the target, don't allow the trade
        if (PChar->id == PTarget->id)
        {
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, 155);
            return;
        }

        if (distance(PChar->loc.p, PTarget->loc.p) > 6.0f) // Tested as around 6.0' on retail
        {
            ShowWarning("%s trade request with %s was blocked. They are too far away!", PChar->getName(), PTarget->getName());
            PChar->pushPacket<CTradeActionPacket>(PTarget, 0x07);
            return;
        }

        // You must either both be outside (your_id == their_id == 0),
        // or in the same moghouse by invite (your_id == their_id)
        if (PChar->m_moghouseID != PTarget->m_moghouseID)
        {
            ShowError("%s trade request with %s was blocked. They have mismatching moghouse IDs!", PChar->getName(), PTarget->getName());
            PChar->pushPacket<CTradeActionPacket>(PTarget, 0x07);
            return;
        }

        // If either player is in prison don't allow the trade.
        if (jailutils::InPrison(PChar) || jailutils::InPrison(PTarget))
        {
            ShowError("%s trade request with %s was blocked. They are in prison!", PChar->getName(), PTarget->getName());
            PChar->pushPacket<CTradeActionPacket>(PTarget, 0x07);
            return;
        }

        // If either player is crafting, don't allow the trade request.
        if (PChar->animation == ANIMATION_SYNTH || (PChar->CraftContainer && PChar->CraftContainer->getItemsCount() > 0) ||
            PTarget->animation == ANIMATION_SYNTH || (PTarget->CraftContainer && PTarget->CraftContainer->getItemsCount() > 0))
        {
            ShowError("%s trade request with %s was blocked. They are synthing!", PChar->getName(), PTarget->getName());
            PChar->pushPacket<CTradeActionPacket>(PTarget, 0x07);
            return;
        }

        // check /blockaid
        if (charutils::IsAidBlocked(PChar, PTarget))
        {
            ShowDebug("%s is blocking trades", PTarget->getName());
            // Target is blocking assistance
            PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::TargetIsCurrentlyBlocking);
            // Interaction was blocked
            PTarget->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::BlockedByBlockaid);
            PChar->pushPacket<CTradeActionPacket>(PTarget, 0x07);
            return;
        }

        if (PTarget->TradePending.id == PChar->id)
        {
            ShowDebug("%s has already sent a trade request to %s", PChar->getName(), PTarget->getName());
            return;
        }

        if (!PTarget->UContainer->IsContainerEmpty())
        {
            PChar->pushPacket<CTradeActionPacket>(PTarget, 0x07);
            ShowDebug("%s's UContainer is not empty. %s cannot trade with them at this time", PTarget->getName(), PChar->getName());
            return;
        }

        auto lastTargetTradeTimeSeconds = std::chrono::duration_cast<std::chrono::seconds>(server_clock::now() - PTarget->lastTradeInvite).count();
        if ((PTarget->TradePending.targid != 0 && lastTargetTradeTimeSeconds < 60) || PTarget->UContainer->GetType() == UCONTAINER_TRADE)
        {
            // Can't trade with someone who's already got a pending trade before timeout
            PChar->pushPacket<CTradeActionPacket>(PTarget, 0x07);
            return;
        }

        // This block usually doesn't trigger,
        // The client is generally forced to send a trade cancel packet via a cancel yes/no menu,
        // resulting in an outgoing 0x033 with 0x04 set to 0x01 for their old trade target, but sometimes the menu does not happen and a cancel is sent instead.
        if (PChar->TradePending.id != 0)
        {
            // Tell previous trader we don't want their business
            CCharEntity* POldTradeTarget = (CCharEntity*)PChar->GetEntity(PChar->TradePending.id, TYPE_PC);
            if (POldTradeTarget && POldTradeTarget->id == PChar->TradePending.id)
            {
                POldTradeTarget->TradePending.clean();
                PChar->TradePending.clean();

                POldTradeTarget->pushPacket<CTradeActionPacket>(PChar, 0x07);
                PChar->pushPacket<CTradeActionPacket>(POldTradeTarget, 0x07);
                return;
            }
        }

        PChar->lastTradeInvite     = server_clock::now();
        PChar->TradePending.id     = charid;
        PChar->TradePending.targid = targid;

        PTarget->lastTradeInvite     = server_clock::now();
        PTarget->TradePending.id     = PChar->id;
        PTarget->TradePending.targid = PChar->targid;
        PTarget->pushPacket<CTradeRequestPacket>(PChar);
    }
}

/************************************************************************
 *                                                                       *
 *  Trade Request Action                                                 *
 *  Trade Accept / Request Accept / Cancel                               *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x033(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    // MONs can't trade
    if (PChar->m_PMonstrosity != nullptr)
    {
        return;
    }

    CCharEntity* PTarget = (CCharEntity*)PChar->GetEntity(PChar->TradePending.targid, TYPE_PC);

    if (PTarget != nullptr && PChar->TradePending.id == PTarget->id)
    {
        uint16 action = data.ref<uint8>(0x04);

        switch (action)
        {
            case 0x00: // request accepted
            {
                ShowDebug("%s accepted trade request from %s", PTarget->getName(), PChar->getName());
                if (PChar->TradePending.id == PTarget->id && PTarget->TradePending.id == PChar->id)
                {
                    if (PChar->UContainer->IsContainerEmpty() && PTarget->UContainer->IsContainerEmpty())
                    {
                        if (distance(PChar->loc.p, PTarget->loc.p) < 6)
                        {
                            PChar->UContainer->SetType(UCONTAINER_TRADE);
                            PChar->pushPacket<CTradeActionPacket>(PTarget, action);

                            PTarget->UContainer->SetType(UCONTAINER_TRADE);
                            PTarget->pushPacket<CTradeActionPacket>(PChar, action);
                            return;
                        }
                    }
                    PChar->TradePending.clean();
                    PTarget->TradePending.clean();

                    ShowDebug("Trade: UContainer is not empty");
                }
            }
            break;
            case 0x01: // trade cancelled
            {
                ShowDebug("%s cancelled trade with %s", PTarget->getName(), PChar->getName());
                if (PChar->TradePending.id == PTarget->id && PTarget->TradePending.id == PChar->id)
                {
                    if (PTarget->UContainer->GetType() == UCONTAINER_TRADE)
                    {
                        PTarget->UContainer->Clean();
                    }
                }
                if (PChar->UContainer->GetType() == UCONTAINER_TRADE)
                {
                    PChar->UContainer->Clean();
                }

                PTarget->TradePending.clean();
                PTarget->pushPacket<CTradeActionPacket>(PChar, action);

                PChar->TradePending.clean();
            }
            break;
            case 0x02: // trade accepted
            {
                ShowDebug("%s accepted trade with %s", PTarget->getName(), PChar->getName());
                if (PChar->TradePending.id == PTarget->id && PTarget->TradePending.id == PChar->id)
                {
                    PChar->UContainer->SetLock();
                    PTarget->pushPacket<CTradeActionPacket>(PChar, action);

                    if (PTarget->UContainer->IsLocked())
                    {
                        if (charutils::CanTrade(PChar, PTarget) && charutils::CanTrade(PTarget, PChar))
                        {
                            charutils::DoTrade(PChar, PTarget);
                            PTarget->pushPacket<CTradeActionPacket>(PTarget, 9);

                            charutils::DoTrade(PTarget, PChar);
                            PChar->pushPacket<CTradeActionPacket>(PChar, 9);
                        }
                        else
                        {
                            // Failed to trade
                            // Either players containers are full or illegal item trade attempted
                            ShowDebug("%s->%s trade failed (full inventory or illegal items)", PChar->getName(), PTarget->getName());
                            PChar->pushPacket<CTradeActionPacket>(PTarget, 1);
                            PTarget->pushPacket<CTradeActionPacket>(PChar, 1);
                        }
                        PChar->TradePending.clean();
                        PChar->UContainer->Clean();

                        PTarget->TradePending.clean();
                        PTarget->UContainer->Clean();
                    }
                }
            }
            break;
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Update Trade Item Slot                                               *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x034(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    // MONs can't trade
    if (PChar->m_PMonstrosity != nullptr)
    {
        return;
    }

    uint32 quantity    = data.ref<uint32>(0x04);
    uint16 itemID      = data.ref<uint16>(0x08);
    uint8  invSlotID   = data.ref<uint8>(0x0A);
    uint8  tradeSlotID = data.ref<uint8>(0x0B);

    CCharEntity* PTarget = (CCharEntity*)PChar->GetEntity(PChar->TradePending.targid, TYPE_PC);

    if (PTarget != nullptr && PTarget->id == PChar->TradePending.id)
    {
        if (!PChar->UContainer->IsSlotEmpty(tradeSlotID))
        {
            CItem* PCurrentSlotItem = PChar->UContainer->GetItem(tradeSlotID);
            if (quantity != 0)
            {
                ShowError("SmallPacket0x034: Player %s trying to update trade quantity of a RESERVED item! [Item: %i | Trade Slot: %i] ",
                          PChar->getName(), PCurrentSlotItem->getID(), tradeSlotID);
            }
            PCurrentSlotItem->setReserve(0);
            PChar->UContainer->ClearSlot(tradeSlotID);
        }

        CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotID);
        // We used to disable Rare/Ex items being added to the container, but that is handled properly else where now
        if (PItem != nullptr && PItem->getID() == itemID && quantity + PItem->getReserve() <= PItem->getQuantity())
        {
            // whoever commented above lied about ex items
            if (PItem->getFlag() & ITEM_FLAG_EX)
            {
                return;
            }

            if (PItem->isSubType(ITEM_LOCKED))
            {
                return;
            }

            // If item count is zero remove from container
            if (quantity > 0)
            {
                if (PItem->isType(ITEM_LINKSHELL))
                {
                    CItemLinkshell* PItemLinkshell  = static_cast<CItemLinkshell*>(PItem);
                    CItemLinkshell* PItemLinkshell1 = (CItemLinkshell*)PChar->getEquip(SLOT_LINK1);
                    CItemLinkshell* PItemLinkshell2 = (CItemLinkshell*)PChar->getEquip(SLOT_LINK2);
                    if ((!PItemLinkshell1 && !PItemLinkshell2) || ((!PItemLinkshell1 || PItemLinkshell1->GetLSID() != PItemLinkshell->GetLSID()) &&
                                                                   (!PItemLinkshell2 || PItemLinkshell2->GetLSID() != PItemLinkshell->GetLSID())))
                    {
                        PChar->pushPacket<CMessageStandardPacket>(MsgStd::LinkshellEquipBeforeUsing);
                        PItem->setReserve(0);
                        PChar->UContainer->SetItem(tradeSlotID, nullptr);
                    }
                    else
                    {
                        ShowInfo("%s->%s trade updating trade slot id %d with item %s, quantity %d", PChar->getName(), PTarget->getName(),
                                 tradeSlotID, PItem->getName(), quantity);
                        PItem->setReserve(quantity + PItem->getReserve());
                        PChar->UContainer->SetItem(tradeSlotID, PItem);
                    }
                }
                else
                {
                    ShowInfo("%s->%s trade updating trade slot id %d with item %s, quantity %d", PChar->getName(), PTarget->getName(),
                             tradeSlotID, PItem->getName(), quantity);
                    PItem->setReserve(quantity + PItem->getReserve());
                    PChar->UContainer->SetItem(tradeSlotID, PItem);
                }
            }
            else
            {
                ShowInfo("%s->%s trade updating trade slot id %d with item %s, quantity 0", PChar->getName(), PTarget->getName(),
                         tradeSlotID, PItem->getName());
                PItem->setReserve(0);
                PChar->UContainer->SetItem(tradeSlotID, nullptr);
            }
            ShowDebug("%s->%s trade pushing packet to %s", PChar->getName(), PTarget->getName(), PChar->getName());
            PChar->pushPacket<CTradeItemPacket>(PItem, tradeSlotID);
            ShowDebug("%s->%s trade pushing packet to %s", PChar->getName(), PTarget->getName(), PTarget->getName());
            PTarget->pushPacket<CTradeUpdatePacket>(PItem, tradeSlotID);

            PChar->UContainer->UnLock();
            PTarget->UContainer->UnLock();
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Trade Complete                                                       *
 *  Sent to complete the trade.                                          *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x036(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    // If PChar is invisible don't allow the trade
    if (PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE))
    {
        // "You cannot use that command while invisible."
        PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CannotWhileInvisible);
        return;
    }

    // MONs can't trade
    if (PChar->m_PMonstrosity != nullptr)
    {
        return;
    }

    uint32 npcid  = data.ref<uint32>(0x04);
    uint16 targid = data.ref<uint16>(0x3A);

    CBaseEntity* PNpc = PChar->GetEntity(targid, TYPE_NPC | TYPE_MOB);

    // Only allow trading with mobs if it's status is an NPC
    if (PNpc != nullptr && PNpc->objtype == TYPE_MOB && PNpc->status != STATUS_TYPE::NORMAL)
    {
        return;
    }

    if ((PNpc != nullptr) && (PNpc->id == npcid))
    {
        if (distance(PChar->loc.p, PNpc->loc.p) > 6.0f) // Tested as around 6.0' on retail
        {
            ShowError("Player %s trying to trade NPC %s from too far away! ", PChar->getName(), PNpc->getName());
            return;
        }

        uint8 numItems = data.ref<uint8>(0x3C);

        PChar->TradeContainer->Clean();

        for (int32 slotID = 0; slotID < numItems; ++slotID)
        {
            uint8  invSlotID = data.ref<uint8>(0x30 + slotID);
            uint32 Quantity  = data.ref<uint32>(0x08 + slotID * 4);

            CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotID);

            if (PItem == nullptr || PItem->getQuantity() < Quantity)
            {
                ShowError("Player %s trying to trade NPC %s with invalid item! ", PChar->getName(), PNpc->getName());
                return;
            }

            if (PItem->getReserve() > 0)
            {
                ShowError("Player %s trying to trade NPC %s with reserved item! ", PChar->getName(), PNpc->getName());
                return;
            }

            PItem->setReserve(Quantity);
            PChar->TradeContainer->setItem(slotID, PItem->getID(), invSlotID, Quantity, PItem);
        }

        luautils::OnTrade(PChar, PNpc);
        PChar->TradeContainer->unreserveUnconfirmed();
    }
}

/************************************************************************
 *                                                                       *
 *  Item Usage                                                           *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x037(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    // MONs can't use usable items
    if (PChar->m_PMonstrosity != nullptr)
    {
        return;
    }

    uint16 TargetID  = data.ref<uint16>(0x0C);
    uint8  SlotID    = data.ref<uint8>(0x0E);
    uint8  StorageID = data.ref<uint8>(0x10);

    if (StorageID >= CONTAINER_ID::MAX_CONTAINER_ID)
    {
        ShowError("Invalid storage ID passed to packet %u by %s", StorageID, PChar->getName());
        return;
    }

    if (PChar->m_moghouseID)
    {
        ShowError("Player trying to use item in moghouse %s", PChar->getName());
        return;
    }

    if (PChar->UContainer->GetType() != UCONTAINER_USEITEM)
    {
        PChar->PAI->UseItem(TargetID, StorageID, SlotID);
    }
    else
    {
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, 56);
    }
}

/************************************************************************
 *                                                                       *
 *  Sort Inventory                                                       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x03A(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    TracyZoneCString("Sort Inventory");

    uint8 container = data.ref<uint8>(0x04);

    if (container >= CONTAINER_ID::MAX_CONTAINER_ID)
    {
        ShowWarning("SmallPacket0x03A: Invalid container ID passed to packet %u by %s", container, PChar->getName());
        return;
    }

    CItemContainer* PItemContainer = PChar->getStorage(container);

    uint8 size = PItemContainer->GetSize();

    if (gettick() - PItemContainer->LastSortingTime < 1000)
    {
        if (settings::get<uint8>("map.LIGHTLUGGAGE_BLOCK") == (int32)(++PItemContainer->SortingPacket))
        {
            ShowWarning("lightluggage detected: <%s> will be removed from server", PChar->getName());
            charutils::ForceLogout(PChar);
        }
        return;
    }
    else
    {
        PItemContainer->SortingPacket   = 0;
        PItemContainer->LastSortingTime = gettick();
    }
    for (uint8 slotID = 1; slotID <= size; ++slotID)
    {
        CItem* PItem = PItemContainer->GetItem(slotID);

        if ((PItem != nullptr) && (PItem->getQuantity() < PItem->getStackSize()) && !PItem->isSubType(ITEM_LOCKED) && (PItem->getReserve() == 0))
        {
            for (uint8 slotID2 = slotID + 1; slotID2 <= size; ++slotID2)
            {
                CItem* PItem2 = PItemContainer->GetItem(slotID2);

                if ((PItem2 != nullptr) && (PItem2->getID() == PItem->getID()) && (PItem2->getQuantity() < PItem2->getStackSize()) &&
                    !PItem2->isSubType(ITEM_LOCKED) && (PItem2->getReserve() == 0))
                {
                    uint32 totalQty = PItem->getQuantity() + PItem2->getQuantity();
                    uint32 moveQty  = 0;

                    if (totalQty >= PItem->getStackSize())
                    {
                        moveQty = PItem->getStackSize() - PItem->getQuantity();
                    }
                    else
                    {
                        moveQty = PItem2->getQuantity();
                    }
                    if (moveQty > 0)
                    {
                        charutils::UpdateItem(PChar, (uint8)PItemContainer->GetID(), slotID, moveQty);
                        charutils::UpdateItem(PChar, (uint8)PItemContainer->GetID(), slotID2, -(int32)moveQty);
                    }
                }
            }
        }
    }
    PChar->pushPacket<CInventoryFinishPacket>();
}

/************************************************************************
 *                                                                       *
 *  Mannequin Equip                                                      *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x03B(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    TracyZoneCString("Mannequin Equip");

    // What are you doing?
    uint8 action = data.ref<uint8>(0x04);

    // Where is the mannequin?
    uint8 mannequinStorageLoc     = data.ref<uint8>(0x08);
    uint8 mannequinStorageLocSlot = data.ref<uint8>(0x0C);

    // Which slot on the mannequin?
    uint8 mannequinInternalSlot = data.ref<uint8>(0x0D);

    // Where is the item that is being equipped/unequipped?
    uint8 itemStorageLoc     = data.ref<uint8>(0x10);
    uint8 itemStorageLocSlot = data.ref<uint8>(0x14);

    // Validation
    if (action != 1 && action != 2 && action != 5)
    {
        ShowWarning("SmallPacket0x03B: Invalid action passed to Mannequin Equip packet %u by %s", action, PChar->getName());
        return;
    }

    if (mannequinStorageLoc != LOC_MOGSAFE && mannequinStorageLoc != LOC_MOGSAFE2)
    {
        ShowWarning("SmallPacket0x03B: Invalid mannequin location passed to Mannequin Equip packet %u by %s", mannequinStorageLoc, PChar->getName());
        return;
    }

    if (itemStorageLoc != LOC_STORAGE && action == 1) // Only valid for direct equip/unequip
    {
        ShowWarning("SmallPacket0x03B: Invalid item location passed to Mannequin Equip packet %u by %s", itemStorageLoc, PChar->getName());
        return;
    }

    if (mannequinInternalSlot >= 8)
    {
        ShowWarning("SmallPacket0x03B: Invalid mannequin equipment index passed to Mannequin Equip packet %u (range: 0-7) by %s", mannequinInternalSlot, PChar->getName());
        return;
    }

    auto* PMannequin = PChar->getStorage(mannequinStorageLoc)->GetItem(mannequinStorageLocSlot);
    if (PMannequin == nullptr)
    {
        ShowWarning("SmallPacket0x03B: Unable to load mannequin from slot %u in location %u by %s", mannequinStorageLocSlot, mannequinStorageLoc, PChar->getName());
        return;
    }

    auto setStatusOfStorageItemAtSlot = [](CCharEntity* PChar, uint8 slot, uint8 status) -> void
    {
        if (PChar == nullptr || slot == 0)
        {
            return;
        }

        auto* PItem = PChar->getStorage(LOC_STORAGE)->GetItem(slot);
        if (PItem == nullptr)
        {
            return;
        }

        PChar->pushPacket<CInventoryAssignPacket>(PItem, status);
    };

    switch (action)
    {
        case 1: // Equip
        {
            // Action 1 Unequip Hack: Does this need to exist?
            if (PMannequin->m_extra[10 + mannequinInternalSlot] == itemStorageLocSlot)
            {
                setStatusOfStorageItemAtSlot(PChar, itemStorageLocSlot, INV_NORMAL);
                PMannequin->m_extra[10 + mannequinInternalSlot] = 0;
            }
            else // Regular Logic
            {
                setStatusOfStorageItemAtSlot(PChar, itemStorageLocSlot, INV_MANNEQUIN);
                PMannequin->m_extra[10 + mannequinInternalSlot] = itemStorageLocSlot;
            }
            break;
        }
        case 2: // Unequip
        {
            setStatusOfStorageItemAtSlot(PChar, itemStorageLocSlot, INV_NORMAL);
            PMannequin->m_extra[10 + mannequinInternalSlot] = 0;
            break;
        }
        case 5: // Unequip All
        {
            for (uint8 i = 0; i < 8; ++i)
            {
                if (PMannequin->m_extra[10 + i] > 0)
                {
                    setStatusOfStorageItemAtSlot(PChar, PMannequin->m_extra[10 + i], INV_NORMAL);
                }
                PMannequin->m_extra[10 + i] = 0;
            }
            break;
        }
    }

    // Build Mannequin model id list
    auto getModelIdFromStorageSlot = [](CCharEntity* PChar, uint8 slot) -> uint16
    {
        uint16 modelId = 0x0000;

        if (slot == 0)
        {
            return modelId;
        }

        auto* PItem = PChar->getStorage(LOC_STORAGE)->GetItem(slot);
        if (PItem == nullptr)
        {
            return modelId;
        }

        if (auto* PItemEquipment = dynamic_cast<CItemEquipment*>(PItem))
        {
            modelId = PItemEquipment->getModelId();
        }

        return modelId;
    };

    uint16 mainId  = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 0]);
    uint16 subId   = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 1]);
    uint16 rangeId = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 2]);
    uint16 headId  = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 3]);
    uint16 bodyId  = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 4]);
    uint16 handsId = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 5]);
    uint16 legId   = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 6]);
    uint16 feetId  = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 7]);
    // 10 + 8 = Race
    // 10 + 9 = Pose

    // Write out to Mannequin
    char extra[sizeof(PMannequin->m_extra) * 2 + 1];
    _sql->EscapeStringLen(extra, (const char*)PMannequin->m_extra, sizeof(PMannequin->m_extra));

    const char* Query = "UPDATE char_inventory "
                        "SET "
                        "extra = '%s' "
                        "WHERE location = %u AND slot = %u AND charid = %u";

    auto ret  = _sql->Query(Query, extra, mannequinStorageLoc, mannequinStorageLocSlot, PChar->id);
    auto rows = _sql->AffectedRows();
    if (ret != SQL_ERROR && rows != 0)
    {
        PChar->pushPacket<CInventoryItemPacket>(PMannequin, mannequinStorageLoc, mannequinStorageLocSlot);
        PChar->pushPacket<CInventoryCountPacket>(mannequinStorageLoc, mannequinStorageLocSlot, headId, bodyId, handsId, legId, feetId, mainId, subId, rangeId);
        PChar->pushPacket<CInventoryFinishPacket>();
    }
    else
    {
        ShowError("SmallPacket0x03B: Problem writing Mannequin to database!");
    }
}

// GP_CLI_COMMAND_BLACK_LIST
// https://github.com/atom0s/XiPackets/tree/main/world/client/0x003C
// Client is asking for blist because it wasn't initialized correctly?
void SmallPacket0x03C(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    blacklistutils::SendBlacklist(PChar);
}

/************************************************************************
 *                                                                       *
 *  Incoming Blacklist Command                                           *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x03D(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    const auto name = escapeString(asStringFromUntrustedSource(data[0x08], 15));
    const auto cmd  = data.ref<uint8>(0x18);

    const auto sendFailPacket = [&]()
    {
        PChar->pushPacket<CBlacklistEditResponsePacket>(0, "", 0x02);
    };

    // Attempt to locate the character by their name
    const auto rset = db::preparedStmt("SELECT charid, accid FROM chars WHERE charname = ? LIMIT 1", name);
    if (!rset || rset->rowsCount() != 1 || !rset->next())
    {
        sendFailPacket();
        return;
    }

    uint32 charid = rset->get<uint32>("charid");
    uint32 accid  = rset->get<uint32>("accid");

    // User is trying to add someone to their blacklist
    if (cmd == 0x00)
    {
        // Attempt to add this person
        if (blacklistutils::AddBlacklisted(PChar->id, charid))
        {
            PChar->pushPacket<CBlacklistEditResponsePacket>(accid, name, cmd);
        }
        else
        {
            sendFailPacket();
        }
    }
    else if (cmd == 0x01) // User is trying to remove someone from their blacklist
    {
        // Attempt to remove this person
        if (blacklistutils::DeleteBlacklisted(PChar->id, charid))
        {
            PChar->pushPacket<CBlacklistEditResponsePacket>(accid, name, cmd);
        }
        else
        {
            sendFailPacket();
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Treasure Pool (Lot On Item)                                          *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x041(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    uint8 SlotID = data.ref<uint8>(0x04);

    if (SlotID >= TREASUREPOOL_SIZE)
    {
        ShowWarning("SmallPacket0x041: Invalid slot ID passed to packet %u by %s", SlotID, PChar->getName());
        return;
    }

    if (PChar->PTreasurePool != nullptr)
    {
        if (!PChar->PTreasurePool->HasLottedItem(PChar, SlotID))
        {
            PChar->PTreasurePool->LotItem(PChar, SlotID, xirand::GetRandomNumber(1, 1000)); // 1 ~ 998+1
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Treasure Pool (Pass Item)                                            *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x042(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    uint8 SlotID = data.ref<uint8>(0x04);

    if (SlotID >= TREASUREPOOL_SIZE)
    {
        ShowWarning("SmallPacket0x042: Invalid slot ID passed to packet %u by %s", SlotID, PChar->getName());
        return;
    }

    if (PChar->PTreasurePool != nullptr)
    {
        if (!PChar->PTreasurePool->HasPassedItem(PChar, SlotID))
        {
            PChar->PTreasurePool->PassItem(PChar, SlotID);
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Server Message Request                                               *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x04B(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint8  msgChunk      = data.ref<uint8>(0x04);  // The current chunk of the message to send (1 = start, 2 = rest of message)
    uint8  msgType       = data.ref<uint8>(0x06);  // 1 = Server message, 2 = Fishing Rank
    uint8  msgLanguage   = data.ref<uint8>(0x07);  // Language request id (2 = English, 4 = French)
    uint32 msgTimestamp  = data.ref<uint32>(0x08); // The message timestamp being requested
    uint32 msgOffset     = data.ref<uint32>(0x10); // The offset to start obtaining the server message
    uint32 msgRequestLen = data.ref<uint32>(0x14); // The total requested size of send to the client

    // uint8  msgUnknown1  = data.ref<uint8>(0x05);  // Unknown always 0
    // uint32 msgSizeTotal = data.ref<uint32>(0x0C); // The total length of the requested server message

    if (msgType == 1) // Standard Server Message
    {
        std::string loginMessage = luautils::GetServerMessage(msgLanguage);

        PChar->pushPacket<CServerMessagePacket>(loginMessage, msgLanguage, msgTimestamp, msgOffset);
        PChar->pushPacket<CCharSyncPacket>(PChar);

        // TODO: kill player til theyre dead and bsod
        const auto rset = db::preparedStmt("SELECT version_mismatch FROM accounts_sessions WHERE charid = (?)", PChar->id);
        if (rset && rset->rowsCount() > 0 && rset->next())
        {
            if (rset->get<bool>("version_mismatch"))
            {
                PChar->pushPacket<CChatMessagePacket>(PChar, CHAT_MESSAGE_TYPE::MESSAGE_SYSTEM_1, "Server does not support this client version.");
            }
        }
    }
    else if (msgType == 2) // Fish Ranking Packet
    {
        // The Message Chunk acts as a "sub-type" for the request
        // 1 = First packet of ranking table
        // 2 = Subsequent packet of ranking table
        // 10 = ???
        // 11 = ??? Prepare to withdraw?
        // 12 = Response to a fish submission (No ranking or score - both 0) - Before ranking
        // 13 = Fish Rank Self, including the score and rank (???) following fish submission (How is it ranked??)

        // Create a holding vector for entries to be transmitted
        std::vector<FishingContestEntry> entries;

        int   maxFakes     = settings::get<int>("main.MAX_FAKE_ENTRIES");
        uint8 realEntries  = fishingcontest::FishingRankEntryCount();
        uint8 fakeEntries  = realEntries >= maxFakes ? 0 : maxFakes - realEntries;
        uint8 totalEntries = realEntries + fakeEntries;
        uint8 entryVal     = 0;
        uint8 blockSize    = sizeof(FishingContestEntry); // Should be 36

        FishingContestEntry selfEntry = {};

        // Every packet has 6 blocks in it.  The first is always the "self" block of the requesting player
        // The next five blocks are the next entries in the leaderboard
        // Add the "Self" block for 0x1C - Either player data, or empty, depending on the chunk
        if (msgChunk != 2)
        {
            // Client requesting the fish ranking menu header - All empty timestamps
            // In either case, we need the "Fish Rank Self" block
            FishingContestEntry* PEntry = fishingcontest::GetPlayerEntry(PChar);

            // For any chunk, we include at least the char name and the total number of entries
            std::strncpy(selfEntry.name, PChar->name.c_str(), PChar->name.size());
            selfEntry.resultCount = totalEntries;

            if (PEntry != nullptr)
            {
                selfEntry.mjob        = PEntry->mjob;
                selfEntry.sjob        = PEntry->sjob;
                selfEntry.mlvl        = PEntry->mlvl;
                selfEntry.slvl        = PEntry->slvl;
                selfEntry.race        = PEntry->race;
                selfEntry.allegiance  = PEntry->allegiance;
                selfEntry.fishRank    = PEntry->fishRank;
                selfEntry.score       = PEntry->score;
                selfEntry.submitTime  = PEntry->submitTime;
                selfEntry.contestRank = PEntry->contestRank;
                selfEntry.share       = PEntry->share;
                selfEntry.dataset_b   = PEntry->dataset_b;
            }
            else // Builds header entry if the player has no submission
            {
                selfEntry.mjob       = static_cast<uint8>(PChar->GetMJob());
                selfEntry.sjob       = static_cast<uint8>(PChar->GetSJob());
                selfEntry.mlvl       = PChar->GetMLevel();
                selfEntry.slvl       = PChar->GetSLevel();
                selfEntry.race       = PChar->mainlook.race;
                selfEntry.allegiance = static_cast<uint8>(PChar->allegiance);
                selfEntry.fishRank   = PChar->RealSkills.rank[SKILLTYPE::SKILL_FISHING];
                selfEntry.submitTime = CVanaTime::getInstance()->getVanaTime();
            }
        }

        entries.push_back(selfEntry); // Adds empty entry if this isn't the first packet

        // Add the next five blocks until we are out of entries
        if (msgChunk == 1 || msgChunk == 2)
        {
            while (entries.size() <= (msgRequestLen / blockSize))
            {
                // Create a copy of the ranking entry and hold it in the local entry vector
                // This vector is cleared once the packets are sent
                uint8                position    = msgOffset / blockSize + entryVal++;
                FishingContestEntry* packetEntry = fishingcontest::GetFishRankEntry(position);
                if (packetEntry != nullptr)
                {
                    packetEntry->resultCount = totalEntries;
                    entries.push_back(*packetEntry);
                }
                else
                {
                    entries.emplace_back(FishingContestEntry{}); // Safety if there is no pointer but we need to fill the vector
                }
            }
        }

        PChar->pushPacket<CFishRankingPacket>(entries, msgLanguage, msgTimestamp, msgOffset, totalEntries, msgChunk);
        entries.clear();
    }
}

/************************************************************************
 *                                                                       *
 *  Delivery Box                                                         *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x04D(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    dboxutils::HandlePacket(PChar, data);
}

/************************************************************************
 *                                                                       *
 *  Auction House                                                        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x04E(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    auctionutils::HandlePacket(PChar, data);
}

/************************************************************************
 *                                                                       *
 *  Equipment Change                                                     *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x050(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (PChar->status != STATUS_TYPE::NORMAL)
    {
        return;
    }

    uint8 slotID      = data.ref<uint8>(0x04); // inventory slot
    uint8 equipSlotID = data.ref<uint8>(0x05); // charequip slot
    uint8 containerID = data.ref<uint8>(0x06); // container id

    bool isAdditionalContainer =
        containerID == LOC_MOGSATCHEL ||
        containerID == LOC_MOGSACK ||
        containerID == LOC_MOGCASE;

    bool isEquippableInventory =
        containerID == LOC_INVENTORY ||
        containerID == LOC_WARDROBE ||
        containerID == LOC_WARDROBE2 ||
        containerID == LOC_WARDROBE3 ||
        containerID == LOC_WARDROBE4 ||
        containerID == LOC_WARDROBE5 ||
        containerID == LOC_WARDROBE6 ||
        containerID == LOC_WARDROBE7 ||
        containerID == LOC_WARDROBE8 ||
        (settings::get<bool>("main.EQUIP_FROM_OTHER_CONTAINERS") &&
         isAdditionalContainer);

    bool isLinkshell =
        equipSlotID == SLOT_LINK1 ||
        equipSlotID == SLOT_LINK2;

    // Sanity check
    if (!isEquippableInventory && !isLinkshell)
    {
        return;
    }

    charutils::EquipItem(PChar, slotID, equipSlotID, containerID); // current
    PChar->RequestPersist(CHAR_PERSIST::EQUIP);
    luautils::CheckForGearSet(PChar); // check for gear set on gear change
    PChar->UpdateHealth();
    PChar->retriggerLatents = true; // retrigger all latents later because our gear has changed
}

/************************************************************************
 *                                                                       *
 *  Equip Macro Set                                                      *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x051(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (PChar->status != STATUS_TYPE::NORMAL)
    {
        return;
    }

    for (uint8 i = 0; i < data.ref<uint8>(0x04); i++)
    {
        uint8 slotID      = data.ref<uint8>(0x08 + (0x04 * i)); // inventory slot
        uint8 equipSlotID = data.ref<uint8>(0x09 + (0x04 * i)); // charequip slot
        uint8 containerID = data.ref<uint8>(0x0A + (0x04 * i)); // container id
        if (containerID == LOC_INVENTORY || containerID == LOC_WARDROBE || containerID == LOC_WARDROBE2 || containerID == LOC_WARDROBE3 ||
            containerID == LOC_WARDROBE4 || containerID == LOC_WARDROBE5 || containerID == LOC_WARDROBE6 || containerID == LOC_WARDROBE7 ||
            containerID == LOC_WARDROBE8)
        {
            charutils::EquipItem(PChar, slotID, equipSlotID, containerID);
        }
    }
    PChar->RequestPersist(CHAR_PERSIST::EQUIP);
    luautils::CheckForGearSet(PChar); // check for gear set on gear change
    PChar->UpdateHealth();
    PChar->retriggerLatents = true; // retrigger all latents later because our gear has changed
}

/************************************************************************
 *                                                                        *
 *  Add Equipment to set                                                 *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x052(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    // Im guessing this is here to check if you can use A Item, as it seems useless to have this sent to server
    // as It will check requirements when it goes to equip the items anyway
    // 0x05 is slot of updated item
    // 0x08 is info for updated item
    // 0x0C is first slot every 4 bytes is another set, in (01-equip 0-2 remve),(container),(ID),(ID)
    // in this list the slot of whats being updated is old value, replace with new in 116
    // Should Push 0x116 (size 68) in responce
    // 0x04 is start, contains 16 4 byte parts repersently each slot in order
    PChar->pushPacket<CAddtoEquipSet>(PChar, data);
}

/************************************************************************
 *                                                                        *
 *  LockStyleSet                                                          *
 *                                                                        *
 ************************************************************************/
void SmallPacket0x053(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint8 count = data.ref<uint8>(0x04);
    uint8 type  = data.ref<uint8>(0x05);

    if (type == 0 && PChar->getStyleLocked())
    {
        charutils::SetStyleLock(PChar, false);
        PChar->RequestPersist(CHAR_PERSIST::EQUIP);
    }
    else if (type == 1)
    {
        // The client sends this when logging in and zoning.
        PChar->setStyleLocked(true);
    }
    else if (type == 2)
    {
        PChar->pushPacket<CMessageStandardPacket>(PChar->getStyleLocked() ? MsgStd::StyleLockIsOn : MsgStd::StyleLockIsOff);
    }
    else if (type == 3)
    {
        charutils::SetStyleLock(PChar, true);

        // Build new lockstyle
        for (int i = 0; i < count; i++)
        {
            uint8  equipSlotId = data.ref<uint8>(0x09 + 0x08 * i);
            uint16 itemId      = data.ref<uint16>(0x0C + 0x08 * i);

            // Skip non-visible items
            if (equipSlotId > SLOT_FEET)
            {
                continue;
            }

            CItemEquipment* PItem = dynamic_cast<CItemEquipment*>(itemutils::GetItemPointer(itemId));
            if (PItem == nullptr || !(PItem->isType(ITEM_WEAPON) || PItem->isType(ITEM_EQUIPMENT)))
            {
                itemId = 0;
            }
            else if ((PItem->getEquipSlotId() & (1 << equipSlotId)) == 0) // item doesnt fit in slot
            {
                itemId = 0;
            }

            PChar->styleItems[equipSlotId] = itemId;
        }

        // Check if we need to remove conflicting slots. Essentially, packet injection shenanigan detector.
        for (int i = 0; i < 10; i++)
        {
            CItemEquipment* PItemEquipment = dynamic_cast<CItemEquipment*>(itemutils::GetItemPointer(PChar->styleItems[i]));

            if (PItemEquipment)
            {
                auto removeSlotID = PItemEquipment->getRemoveSlotId();

                for (uint8 x = 0; x < sizeof(removeSlotID) * 8; ++x)
                {
                    if (removeSlotID & (1 << x))
                    {
                        PChar->styleItems[x] = 0;
                    }
                }
            }
        }

        for (int i = 0; i < 10; i++)
        {
            // variable initialized here due to case/switch optimization throwing warnings inside the case
            CItemEquipment* PItem = PChar->getEquip((SLOTTYPE)i);

            switch (i)
            {
                case SLOT_MAIN:
                case SLOT_SUB:
                case SLOT_RANGED:
                case SLOT_AMMO:
                    charutils::UpdateWeaponStyle(PChar, i, PItem);
                    break;
                case SLOT_HEAD:
                case SLOT_BODY:
                case SLOT_HANDS:
                case SLOT_LEGS:
                case SLOT_FEET:
                    charutils::UpdateArmorStyle(PChar, i);
                    break;
            }
        }
        charutils::UpdateRemovedSlotsLookForLockStyle(PChar);
        PChar->RequestPersist(CHAR_PERSIST::EQUIP);
    }
    else if (type == 4)
    {
        charutils::SetStyleLock(PChar, true);
        charutils::UpdateRemovedSlotsLookForLockStyle(PChar);
        PChar->RequestPersist(CHAR_PERSIST::EQUIP);
    }

    if (type != 1 && type != 2)
    {
        PChar->pushPacket<CCharAppearancePacket>(PChar);
        PChar->pushPacket<CCharSyncPacket>(PChar);
    }
}

/*************************************************************************
 *                                                                       *
 *  Request synthesis suggestion                                         *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x058(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint16 skillID     = data.ref<uint16>(0x04);
    uint16 skillLevel  = data.ref<uint16>(0x06); // Player's current skill level (whole number only)
    uint8  requestType = data.ref<uint8>(0x0A);  // 02 is list view, 03 is recipe
    uint8  skillRank   = data.ref<uint8>(0x12);  // Requested Rank for item suggestions

    if (requestType == 2)
    {
        // For pagination, the client sends the range in increments of 16. (0..0x10, 0x10..0x20, etc)
        // uint16 resultMax  = data.ref<uint16>(0x0E); // Unused, maximum in range is always 16 greater
        uint16 resultMin = data.ref<uint16>(0x0C);

        PChar->pushPacket<CSynthSuggestionListPacket>(skillID, skillLevel, skillRank, resultMin);
    }
    else
    {
        uint16 selectedRecipeOffset = data.ref<uint16>(0x10);
        PChar->pushPacket<CSynthSuggestionRecipePacket>(skillID, skillLevel, skillRank, selectedRecipeOffset);
    }
}

/************************************************************************
 *                                                                       *
 *  Synthesis Complete                                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x059(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (PChar->animation == ANIMATION_SYNTH)
    {
        synthutils::sendSynthDone(PChar);
    }
}

/************************************************************************
 *                                                                       *
 *  Map Update (Conquest, Besieged, Campaign)                            *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x05A(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->pushPacket<CConquestPacket>(PChar);

    // TODO: This is unstable across multiple processes. Fix me.
    // CampaignState state = campaign::GetCampaignState();
    // PChar->pushPacket<CCampaignPacket>(PChar, state, 0);
    // PChar->pushPacket<CCampaignPacket>(PChar, state, 1);
}

/************************************************************************
 *                                                                       *
 *  Event Update (Completion or Update)                                  *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x05B(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    if (!PChar->isInEvent())
        return;

    auto Result  = data.ref<uint32>(0x08);
    auto EventID = data.ref<uint16>(0x12);

    if (PChar->currentEvent->eventId == EventID)
    {
        if (PChar->currentEvent->option != 0)
        {
            Result = PChar->currentEvent->option;
        }

        if (data.ref<uint8>(0x0E) != 0)
        {
            // If optional cutscene is started, we check to see if the selected option should lock the player
            if (Result != -1 && PChar->currentEvent->hasCutsceneOption(Result))
            {
                PChar->setLocked(true);
            }
            luautils::OnEventUpdate(PChar, EventID, Result);
        }
        else
        {
            luautils::OnEventFinish(PChar, EventID, Result);
            // reset if this event did not initiate another event
            if (PChar->currentEvent->eventId == EventID)
            {
                PChar->endCurrentEvent();
            }
        }
    }

    PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::EVENT);
    PChar->updatemask |= UPDATE_HP;
}

/************************************************************************
 *                                                                       *
 *  Event Update (Update Player Position)                                *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x05C(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    if (!PChar->isInEvent())
        return;

    auto Result  = data.ref<uint32>(0x14);
    auto EventID = data.ref<uint16>(0x1A);

    if (PChar->currentEvent->eventId == EventID)
    {
        bool updatePosition = false;

        if (data.ref<uint8>(0x1E) != 0)
        {
            // TODO: Currently the return value for onEventUpdate in Interaction Framework is not received.  Remove
            // the localVar check when this is resolved.

            int32  updateResult     = luautils::OnEventUpdate(PChar, EventID, Result);
            uint32 noPositionUpdate = PChar->GetLocalVar("noPosUpdate");
            updatePosition          = noPositionUpdate == 0 ? updateResult == 1 : false;

            PChar->SetLocalVar("noPosUpdate", 0);
        }
        else
        {
            PChar->m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
            updatePosition    = luautils::OnEventFinish(PChar, EventID, Result) == 1;
            if (PChar->currentEvent->eventId == EventID)
            {
                PChar->endCurrentEvent();
            }
        }

        if (updatePosition)
        {
            PChar->loc.p.x        = data.ref<float>(0x04);
            PChar->loc.p.y        = data.ref<float>(0x08);
            PChar->loc.p.z        = data.ref<float>(0x0C);
            PChar->loc.p.rotation = data.ref<uint8>(0x1F);
        }

        PChar->pushPacket<CCSPositionPacket>(PChar);
        PChar->pushPacket<CPositionPacket>(PChar);
    }
    PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::EVENT);
}

/************************************************************************
 *                                                                       *
 *  Emote (/jobemote [job])                                              *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x05D(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (jailutils::InPrison(PChar))
    {
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
        return;
    }

    auto const& TargetID    = data.ref<uint32>(0x04);
    auto const& TargetIndex = data.ref<uint16>(0x08);
    auto const& EmoteID     = data.ref<Emote>(0x0A);
    auto const& emoteMode   = data.ref<EmoteMode>(0x0B);

    // Invalid Emote ID.
    if (EmoteID < Emote::POINT || EmoteID > Emote::AIM)
    {
        return;
    }

    // Invalid Emote Mode.
    if (emoteMode < EmoteMode::ALL || emoteMode > EmoteMode::MOTION)
    {
        return;
    }

    const auto extra = data.ref<uint16>(0x0C);

    // Attempting to use bell emote without a bell.
    if (EmoteID == Emote::BELL)
    {
        auto IsBell = [](uint16 itemId)
        {
            // Dream Bell, Dream Bell +1, Lady Bell, Lady Bell +1
            return (itemId == 18863 || itemId == 18864 || itemId == 18868 || itemId == 18869);
        };

        // This is the actual observed behavior. Even with a different weapon type equipped,
        // having a bell in the lockstyle is sufficient. On the other hand, if any other
        // weapon is lockstyle'd over an equipped bell, the emote will be rejected.
        // For what it's worth, geomancer bells don't count as a bell for this emote.

        // Look for a bell in the style.
        auto mainWeapon = PChar->styleItems[SLOT_MAIN];
        if (mainWeapon == 0)
        {
            // Nothing equipped in the style, look at what's actually equipped.
            mainWeapon = PChar->getEquip(SLOT_MAIN) != nullptr
                             ? PChar->getEquip(SLOT_MAIN)->getID()
                             : 0;
        }

        if (!IsBell(mainWeapon))
        {
            // Bell not found.
            return;
        }

        if (extra < 0x06 || extra > 0x1e)
        {
            // Invalid note.
            return;
        }
    }
    // Attempting to use locked job emote.
    else if (EmoteID == Emote::JOB && extra && !(PChar->jobs.unlocked & (1 << (extra - 0x1E))))
    {
        return;
    }

    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CCharEmotionPacket>(PChar, TargetID, TargetIndex, EmoteID, emoteMode, extra));

    luautils::OnPlayerEmote(PChar, EmoteID);
}

/************************************************************************
 *                                                                       *
 *  Zone Line Request (Movement Between Zones)                           *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x05E(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    uint32 zoneLineID    = data.ref<uint32>(0x04);
    uint8  town          = data.ref<uint8>(0x16);
    uint8  requestedZone = data.ref<uint8>(0x17);

    uint16 startingZone = PChar->getZone();
    auto   startingPos  = PChar->loc.p;

    PChar->ClearTrusts();

    if (PChar->status == STATUS_TYPE::NORMAL)
    {
        PChar->status       = STATUS_TYPE::DISAPPEAR;
        PChar->loc.boundary = 0;

        // Exiting Mog House
        if (zoneLineID == 1903324538)
        {
            uint16 destinationZone = PChar->getZone();

            // Note: zone zero actually exists but is unused in retail, we should stop using zero someday.
            // If zero, return to previous zone otherwise, determine the zone
            if (requestedZone != 0)
            {
                switch (town)
                {
                    case 1:
                        destinationZone = requestedZone + ZONE_SOUTHERN_SANDORIA - 1;
                        break;
                    case 2:
                        destinationZone = requestedZone + ZONE_BASTOK_MINES - 1;
                        break;
                    case 3:
                        destinationZone = requestedZone + ZONE_WINDURST_WATERS - 1;
                        break;
                    case 4:
                        destinationZone = requestedZone + ZONE_RULUDE_GARDENS - 1;
                        break;
                    case 5:
                        destinationZone = requestedZone + (requestedZone == 1 ? ZONE_AL_ZAHBI - 1 : ZONE_AHT_URHGAN_WHITEGATE - 2);
                        break;
                }

                // Handle case for mog garden (Above addition does not work for this zone)
                if (requestedZone == 127)
                {
                    destinationZone = ZONE_MOG_GARDEN;
                }
                else if (requestedZone == 126) // Go to first floor from second
                {
                    destinationZone = PChar->getZone();
                }
                else if (requestedZone == 125) // Go to second floor from first
                {
                    destinationZone = PChar->getZone();
                }
            }

            bool moghouseExitRegular          = requestedZone == 0 && PChar->m_moghouseID > 0;
            bool requestedMoghouseFloorChange = startingZone == destinationZone && requestedZone >= 125 && requestedZone <= 127;
            bool moghouse2FUnlocked           = PChar->profile.mhflag & 0x20;
            auto startingRegion               = zoneutils::GetCurrentRegion(startingZone);
            auto destinationRegion            = zoneutils::GetCurrentRegion(destinationZone);
            auto moghouseExitRegions          = { REGION_TYPE::SANDORIA, REGION_TYPE::BASTOK, REGION_TYPE::WINDURST, REGION_TYPE::JEUNO, REGION_TYPE::WEST_AHT_URHGAN };
            auto moghouseSameRegion           = std::any_of(moghouseExitRegions.begin(), moghouseExitRegions.end(),
                                                            [&destinationRegion](REGION_TYPE acceptedReg)
                                                            { return destinationRegion == acceptedReg; });
            auto moghouseQuestComplete        = PChar->profile.mhflag & (town ? 0x01 << (town - 1) : 0);
            bool moghouseExitQuestZoneline    = moghouseQuestComplete &&
                                             startingRegion == destinationRegion &&
                                             PChar->m_moghouseID > 0 &&
                                             moghouseSameRegion &&
                                             !requestedMoghouseFloorChange;

            bool moghouseExitMogGardenZoneline = destinationZone == ZONE_MOG_GARDEN && PChar->m_moghouseID > 0;

            // Validate travel
            if (moghouseExitRegular || moghouseExitQuestZoneline || moghouseExitMogGardenZoneline)
            {
                PChar->m_moghouseID    = 0;
                PChar->loc.destination = destinationZone;
                PChar->loc.p           = {};

                // Clear Moghouse 2F tracker flag
                PChar->profile.mhflag &= ~(0x40);
            }
            else if (requestedMoghouseFloorChange)
            {
                PChar->loc.destination = destinationZone;
                PChar->loc.p           = {};

                if (moghouse2FUnlocked)
                {
                    // Toggle Moghouse 2F tracker flag
                    PChar->profile.mhflag ^= 0x40;
                }
                else
                {
                    PChar->status = STATUS_TYPE::NORMAL;
                    ShowWarning("SmallPacket0x05E: Moghouse 2F requested without it being unlocked: %s", PChar->getName());
                    return;
                }
            }
            else
            {
                PChar->status = STATUS_TYPE::NORMAL;
                ShowWarning("SmallPacket0x05E: Moghouse zoneline abuse by %s", PChar->getName());
                return;
            }
        }
        else
        {
            zoneLine_t* PZoneLine = PChar->loc.zone->GetZoneLine(zoneLineID);

            // Ensure the zone line exists
            if (PZoneLine == nullptr)
            {
                ShowError("SmallPacket0x5E: Zone line %u not found", zoneLineID);

                PChar->loc.p.rotation += 128;

                PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CouldNotEnter); // You could not enter the next area.
                PChar->pushPacket<CCSPositionPacket>(PChar);

                PChar->status = STATUS_TYPE::NORMAL;
                return;
            }
            else if (PChar->m_PMonstrosity != nullptr) // Not allowed to use zonelines while MON
            {
                PChar->loc.p.rotation += 128;

                PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CouldNotEnter); // You could not enter the next area.
                PChar->pushPacket<CCSPositionPacket>(PChar);

                PChar->status = STATUS_TYPE::NORMAL;
                return;
            }
            else
            {
                // Ensure the destination exists
                CZone* PDestination = zoneutils::GetZone(PZoneLine->m_toZone);
                if (PDestination && (PDestination->GetIP() == 0 || PDestination->GetPort() == 0))
                {
                    ShowDebug("SmallPacket0x5E: Zone %u closed to chars", PZoneLine->m_toZone);

                    PChar->loc.p.rotation += 128;

                    PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CouldNotEnter); // You could not enter the next area.
                    PChar->pushPacket<CCSPositionPacket>(PChar);

                    PChar->status = STATUS_TYPE::NORMAL;
                    return;
                }
                else if (PZoneLine->m_toZone == 0)
                {
                    // TODO: for entering another persons mog house, it must be set here
                    PChar->m_moghouseID    = PChar->id;
                    PChar->loc.p           = PZoneLine->m_toPos;
                    PChar->loc.destination = PChar->getZone();
                }
                else
                {
                    PChar->loc.destination = PZoneLine->m_toZone;
                    PChar->loc.p           = PZoneLine->m_toPos;
                }
            }
        }
        ShowInfo("Zoning from zone %u to zone %u: %s", PChar->getZone(), PChar->loc.destination, PChar->getName());
    }

    PChar->clearPacketList();

    if (PChar->loc.destination >= MAX_ZONEID)
    {
        ShowWarning("SmallPacket0x05E: Invalid destination passed to packet %u by %s", PChar->loc.destination, PChar->getName());
        PChar->loc.destination = startingZone;
        return;
    }

    auto   destination = PChar->loc.destination == 0 ? PChar->getZone() : PChar->loc.destination;
    uint64 ipp         = zoneutils::GetZoneIPP(destination);
    if (ipp == 0)
    {
        ShowWarning(fmt::format("Char {} requested zone ({}) returned IPP of 0", PChar->name, destination));
        PChar->loc.destination = startingZone;
        PChar->loc.p           = startingPos;

        PChar->loc.p.rotation += 128;

        PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CouldNotEnter); // You could not enter the next area.
        PChar->pushPacket<CCSPositionPacket>(PChar);

        PChar->status = STATUS_TYPE::NORMAL;

        return;
    }

    charutils::SendToZone(PChar, 2, ipp);
}

/************************************************************************
 *                                                                       *
 *  Event Update (String Update)                                         *
 *  Player sends string for event update.                                *
 *                                                                       *
 ************************************************************************/

// zone 245 cs 0x00C7 Password

void SmallPacket0x060(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    // TODO: This isn't going near the db, does this need to be escaped? It contains binary data?
    const auto updateString = asStringFromUntrustedSource(data[0x0C]);
    luautils::OnEventUpdate(PChar, updateString);

    PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::EVENT);
    PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::PLAYERINPUT);
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x061(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->pushPacket<CCharUpdatePacket>(PChar);
    PChar->pushPacket<CCharHealthPacket>(PChar);
    PChar->pushPacket<CCharStatsPacket>(PChar);
    PChar->pushPacket<CCharSkillsPacket>(PChar);
    PChar->pushPacket<CCharRecastPacket>(PChar);
    PChar->pushPacket<CMenuMeritPacket>(PChar);
    PChar->pushPacket<CMonipulatorPacket1>(PChar);
    PChar->pushPacket<CMonipulatorPacket2>(PChar);

    if (charutils::hasKeyItem(PChar, 2544))
    {
        // Only send Job Points Packet if the player has unlocked them
        PChar->pushPacket<CMenuJobPointsPacket>(PChar);
        PChar->pushPacket<CJobPointDetailsPacket>(PChar);
    }

    PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
    PChar->pushPacket<CCharJobExtraPacket>(PChar, false);
    PChar->pushPacket<CStatusEffectPacket>(PChar);
}

/************************************************************************
 *                                                                       *
 *  Chocobo Digging                                                      *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x063(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
}

/************************************************************************
 *                                                                       *
 *  Key Items (Mark As Seen)                                             *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x064(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint8 KeyTable = data.ref<uint8>(0x4A);

    if (KeyTable >= PChar->keys.tables.size())
    {
        return;
    }

    // Write 64 bytes to PChar->keys.tables[KeyTable].seenList (512 bits)
    // std::memcpy(&PChar->keys.tables[KeyTable].seenList, data[0x08], 0x40);
    for (int i = 0; i < 0x40; i++)
    {
        // copy each bit of byte into std::bit location
        PChar->keys.tables[KeyTable].seenList.set(i * 8 + 0, *data[0x08 + i] & 0x01);
        PChar->keys.tables[KeyTable].seenList.set(i * 8 + 1, *data[0x08 + i] & 0x02);
        PChar->keys.tables[KeyTable].seenList.set(i * 8 + 2, *data[0x08 + i] & 0x04);
        PChar->keys.tables[KeyTable].seenList.set(i * 8 + 3, *data[0x08 + i] & 0x08);
        PChar->keys.tables[KeyTable].seenList.set(i * 8 + 4, *data[0x08 + i] & 0x10);
        PChar->keys.tables[KeyTable].seenList.set(i * 8 + 5, *data[0x08 + i] & 0x20);
        PChar->keys.tables[KeyTable].seenList.set(i * 8 + 6, *data[0x08 + i] & 0x40);
        PChar->keys.tables[KeyTable].seenList.set(i * 8 + 7, *data[0x08 + i] & 0x80);
    }

    charutils::SaveKeyItems(PChar);
}

/************************************************************************
 *                                                                       *
 *  Fishing (Action) [Old fishing method packet! Still used.]            *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x066(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (settings::get<bool>("map.FISHING_ENABLE") && PChar->GetMLevel() >= settings::get<uint8>("map.FISHING_MIN_LEVEL"))
    {
        fishingutils::HandleFishingAction(PChar, data);
    }
}

/************************************************************************
 *                                                                       *
 *  Party Invite                                                         *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x06E(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint32 charid = data.ref<uint32>(0x04);
    uint16 targid = data.ref<uint16>(0x08);
    // cannot invite yourself
    if (PChar->id == charid)
    {
        return;
    }

    if (jailutils::InPrison(PChar))
    {
        // Initiator is in prison.  Send error message.
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
        return;
    }

    switch (data.ref<uint8>(0x0A))
    {
        case 0: // party - must by party leader or solo
            if (PChar->PParty == nullptr || PChar->PParty->GetLeader() == PChar)
            {
                if (PChar->PParty && PChar->PParty->IsFull())
                {
                    PChar->pushPacket<CMessageStandardPacket>(PChar, 0, 0, MsgStd::CannotInvite);
                    break;
                }
                CCharEntity* PInvitee = nullptr;
                if (targid != 0)
                {
                    CBaseEntity* PEntity = PChar->GetEntity(targid, TYPE_PC);
                    if (PEntity && PEntity->id == charid)
                    {
                        PInvitee = (CCharEntity*)PEntity;
                    }
                }
                else
                {
                    PInvitee = zoneutils::GetChar(charid);
                }
                if (PInvitee)
                {
                    ShowDebug("%s sent party invite to %s", PChar->getName(), PInvitee->getName());
                    // make sure invitee isn't dead or in jail, they aren't a party member and don't already have an invite pending, and your party is not full
                    if (PInvitee->isDead() || jailutils::InPrison(PInvitee) || PInvitee->InvitePending.id != 0 || PInvitee->PParty != nullptr)
                    {
                        ShowDebug("%s is dead, in jail, has a pending invite, or is already in a party", PInvitee->getName());
                        PChar->pushPacket<CMessageStandardPacket>(PChar, 0, 0, MsgStd::CannotInvite);
                        break;
                    }
                    // check /blockaid
                    if (PInvitee->getBlockingAid())
                    {
                        ShowDebug("%s is blocking party invites", PInvitee->getName());
                        // Target is blocking assistance
                        PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::TargetIsCurrentlyBlocking);
                        // Interaction was blocked
                        PInvitee->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::BlockedByBlockaid);
                        // You cannot invite that person at this time.
                        PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CannotInvite);
                        break;
                    }
                    if (PInvitee->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
                    {
                        ShowDebug("%s has level sync, unable to send invite", PInvitee->getName());
                        PChar->pushPacket<CMessageStandardPacket>(PChar, 0, 0, MsgStd::CannotInviteLevelSync);
                        break;
                    }

                    PInvitee->InvitePending.id     = PChar->id;
                    PInvitee->InvitePending.targid = PChar->targid;
                    PInvitee->pushPacket<CPartyInvitePacket>(charid, targid, PChar, INVITE_PARTY);
                    ShowDebug("Sent party invite packet to %s", PInvitee->getName());
                    if (PChar->PParty && PChar->PParty->GetSyncTarget())
                    {
                        PInvitee->pushPacket<CMessageStandardPacket>(PInvitee, 0, 0, MsgStd::LevelSyncWarning);
                    }
                }
                else
                {
                    ShowDebug("Building invite packet to send to lobby server from %s to (%d)", PChar->getName(), charid);
                    // on another server (hopefully)
                    uint8 packetData[12]{};
                    ref<uint32>(packetData, 0)  = charid;
                    ref<uint16>(packetData, 4)  = targid;
                    ref<uint32>(packetData, 6)  = PChar->id;
                    ref<uint16>(packetData, 10) = PChar->targid;
                    message::send(MSG_PT_INVITE, packetData, sizeof(packetData), std::make_unique<CPartyInvitePacket>(charid, targid, PChar, INVITE_PARTY));

                    ShowDebug("Sent invite packet to lobby server from %s to (%d)", PChar->getName(), charid);
                }
            }
            else // in party but not leader, cannot invite
            {
                ShowDebug("%s is not party leader, cannot send invite", PChar->getName());
                PChar->pushPacket<CMessageStandardPacket>(PChar, 0, 0, MsgStd::NotPartyLeader);
            }
            break;

        case 5: // alliance - must be unallied party leader or alliance leader of a non-full alliance
            if (PChar->PParty && PChar->PParty->GetLeader() == PChar &&
                (PChar->PParty->m_PAlliance == nullptr ||
                 (PChar->PParty->m_PAlliance->getMainParty() == PChar->PParty && !PChar->PParty->m_PAlliance->isFull())))
            {
                CCharEntity* PInvitee = nullptr;
                if (targid != 0)
                {
                    CBaseEntity* PEntity = PChar->GetEntity(targid, TYPE_PC);
                    if (PEntity && PEntity->id == charid)
                    {
                        PInvitee = (CCharEntity*)PEntity;
                    }
                }
                else
                {
                    PInvitee = zoneutils::GetChar(charid);
                }

                if (PInvitee)
                {
                    ShowDebug("%s sent alliance invite to %s", PChar->getName(), PInvitee->getName());
                    // check /blockaid
                    if (PInvitee->getBlockingAid())
                    {
                        ShowDebug("%s is blocking alliance invites", PInvitee->getName());
                        // Target is blocking assistance
                        PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::TargetIsCurrentlyBlocking);
                        // Interaction was blocked
                        PInvitee->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::BlockedByBlockaid);
                        // You cannot invite that person at this time.
                        PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CannotInvite);
                        break;
                    }
                    // make sure intvitee isn't dead or in jail, they are an unallied party leader and don't already have an invite pending
                    if (PInvitee->isDead() || jailutils::InPrison(PInvitee) || PInvitee->InvitePending.id != 0 || PInvitee->PParty == nullptr ||
                        PInvitee->PParty->GetLeader() != PInvitee || PInvitee->PParty->m_PAlliance)
                    {
                        ShowDebug("%s is dead, in jail, has a pending invite, or is already in a party/alliance", PInvitee->getName());
                        PChar->pushPacket<CMessageStandardPacket>(PChar, 0, 0, MsgStd::CannotInvite);
                        break;
                    }
                    if (PInvitee->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
                    {
                        ShowDebug("%s has level sync, unable to send invite", PInvitee->getName());
                        PChar->pushPacket<CMessageStandardPacket>(PChar, 0, 0, MsgStd::CannotInviteLevelSync);
                        break;
                    }

                    PInvitee->InvitePending.id     = PChar->id;
                    PInvitee->InvitePending.targid = PChar->targid;
                    PInvitee->pushPacket<CPartyInvitePacket>(charid, targid, PChar, INVITE_ALLIANCE);
                    ShowDebug("Sent party invite packet to %s", PInvitee->getName());
                }
                else
                {
                    ShowDebug("(Alliance) Building invite packet to send to lobby server from %s to (%d)", PChar->getName(), charid);

                    // on another server (hopefully)
                    uint8 packetData[12]{};
                    ref<uint32>(packetData, 0)  = charid;
                    ref<uint16>(packetData, 4)  = targid;
                    ref<uint32>(packetData, 6)  = PChar->id;
                    ref<uint16>(packetData, 10) = PChar->targid;
                    message::send(MSG_PT_INVITE, packetData, sizeof(packetData), std::make_unique<CPartyInvitePacket>(charid, targid, PChar, INVITE_ALLIANCE));

                    ShowDebug("(Alliance) Sent invite packet to lobby server from %s to (%d)", PChar->getName(), charid);
                }
            }
            break;

        default:
            ShowError("SmallPacket0x06E : unknown byte <%.2X>", data.ref<uint8>(0x0A));
            break;
    }
}

/************************************************************************
 *                                                                       *
 *  Party / Alliance Command 'Leave'                                     *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x06F(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (PChar->PParty)
    {
        switch (data.ref<uint8>(0x04))
        {
            case 0: // party - anyone may remove themself from party regardless of leadership or alliance
                if (PChar->PParty->m_PAlliance &&
                    PChar->PParty->HasOnlyOneMember()) // single member alliance parties must be removed from alliance before disband
                {
                    ShowDebug("%s party size is one", PChar->getName());
                    if (PChar->PParty->m_PAlliance->hasOnlyOneParty()) // if there is only 1 party then dissolve alliance
                    {
                        ShowDebug("%s alliance size is one party", PChar->getName());
                        PChar->PParty->m_PAlliance->dissolveAlliance();
                        ShowDebug("%s alliance is dissolved", PChar->getName());
                    }
                    else
                    {
                        ShowDebug("Removing %s party from alliance", PChar->getName());
                        PChar->PParty->m_PAlliance->removeParty(PChar->PParty);
                        ShowDebug("%s party is removed from alliance", PChar->getName());
                    }
                }
                ShowDebug("Removing %s from party", PChar->getName());
                PChar->PParty->RemoveMember(PChar);
                ShowDebug("%s is removed from party", PChar->getName());
                break;

            case 5: // alliance - any party leader in alliance may remove their party
                if (PChar->PParty->m_PAlliance && PChar->PParty->GetLeader() == PChar)
                {
                    ShowDebug("%s is leader of a party in an alliance", PChar->getName());
                    if (PChar->PParty->m_PAlliance->hasOnlyOneParty()) // if there is only 1 party then dissolve alliance
                    {
                        ShowDebug("One party in alliance, %s wants to dissolve the alliance", PChar->getName());
                        PChar->PParty->m_PAlliance->dissolveAlliance();
                        ShowDebug("%s has dissolved the alliance", PChar->getName());
                    }
                    else
                    {
                        ShowDebug("%s wants to remove their party from the alliance", PChar->getName());
                        PChar->PParty->m_PAlliance->removeParty(PChar->PParty);
                        ShowDebug("%s party is removed from the alliance", PChar->getName());
                    }
                }
                break;

            default:
                ShowError("SmallPacket0x06F : unknown byte <%.2X>", data.ref<uint8>(0x04));
                break;
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Party / Alliance Command 'Breakup'                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x070(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (PChar->PParty && PChar->PParty->GetLeader() == PChar)
    {
        switch (data.ref<uint8>(0x04))
        {
            case 0: // party - party leader may disband party if not an alliance member
                if (PChar->PParty->m_PAlliance == nullptr)
                {
                    ShowDebug("%s is disbanding the party (pcmd breakup)", PChar->getName());
                    PChar->PParty->DisbandParty();
                    ShowDebug("%s party has been disbanded (pcmd breakup)", PChar->getName());
                }
                break;

            case 5: // alliance - only alliance leader may dissolve the entire alliance
                if (PChar->PParty->m_PAlliance && PChar->PParty->m_PAlliance->getMainParty() == PChar->PParty)
                {
                    ShowDebug("%s is disbanding the alliance (acmd breakup)", PChar->getName());
                    PChar->PParty->m_PAlliance->dissolveAlliance();
                    ShowDebug("%s alliance has been disbanded (acmd breakup)", PChar->getName());
                }
                break;

            default:
                ShowError("SmallPacket0x070 : unknown byte <%.2X>", data.ref<uint8>(0x04));
                break;
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Party / Linkshell / Alliance Command 'Kick'                          *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x071(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    switch (data.ref<uint8>(0x0A))
    {
        case 0: // party - party leader may remove member of his own party
        {
            if (PChar->PParty && PChar->PParty->GetLeader() == PChar)
            {
                const auto charName = escapeString(asStringFromUntrustedSource(data[0x0C], 15));

                CCharEntity* PVictim = dynamic_cast<CCharEntity*>(PChar->PParty->GetMemberByName(charName));
                if (PVictim)
                {
                    ShowDebug("%s is trying to kick %s from party", PChar->getName(), PVictim->getName());
                    if (PVictim == PChar) // using kick on yourself, let's borrow the logic from /pcmd leave to prevent alliance crash
                    {
                        if (PChar->PParty->m_PAlliance &&
                            PChar->PParty->HasOnlyOneMember()) // single member alliance parties must be removed from alliance before disband
                        {
                            if (PChar->PParty->m_PAlliance->hasOnlyOneParty()) // if there is only 1 party then dissolve alliance
                            {
                                ShowDebug("One party in alliance, %s wants to dissolve the alliance", PChar->getName());
                                PChar->PParty->m_PAlliance->dissolveAlliance();
                                ShowDebug("%s has dissolved the alliance", PChar->getName());
                            }
                            else
                            {
                                ShowDebug("%s wants to remove their party from the alliance", PChar->getName());
                                PChar->PParty->m_PAlliance->removeParty(PChar->PParty);
                                ShowDebug("%s party is removed from the alliance", PChar->getName());
                            }
                        }
                    }

                    PChar->PParty->RemoveMember(PVictim);
                    ShowDebug("%s has removed %s from party", PChar->getName(), PVictim->getName());
                }
                else
                {
                    const auto victimName = escapeString(asStringFromUntrustedSource(data[0x0C], 15));

                    int32 ret = _sql->Query("SELECT charid FROM chars WHERE charname = '%s'", victimName);
                    if (ret != SQL_ERROR && _sql->NumRows() == 1 && _sql->NextRow() == SQL_SUCCESS)
                    {
                        uint32 id = _sql->GetUIntData(0);
                        if (_sql->Query("DELETE FROM accounts_parties WHERE partyid = %u AND charid = %u", PChar->id, id) == SQL_SUCCESS &&
                            _sql->AffectedRows())
                        {
                            ShowDebug("%s has removed %s from party", PChar->getName(), victimName);

                            uint8 reloadData[4]{};
                            if (PChar->PParty && PChar->PParty->m_PAlliance)
                            {
                                ref<uint32>(reloadData, 0) = PChar->PParty->m_PAlliance->m_AllianceID;
                                message::send(MSG_ALLIANCE_RELOAD, reloadData, sizeof(reloadData), nullptr);
                            }
                            else // No alliance, notify party.
                            {
                                ref<uint32>(reloadData, 0) = PChar->PParty->GetPartyID();
                                message::send(MSG_PT_RELOAD, reloadData, sizeof(reloadData), nullptr);
                            }

                            // Notify the player they were just kicked -- they are no longer in the DB and party/alliance reloads won't notify them.
                            ref<uint32>(reloadData, 0) = id;
                            message::send(MSG_PLAYER_KICK, reloadData, sizeof(reloadData), nullptr);
                        }
                    }
                }
            }
        }
        break;
        case 1: // linkshell
        {
            // Ensure the player has a linkshell equipped
            CItemLinkshell* PItemLinkshell = (CItemLinkshell*)PChar->getEquip(SLOT_LINK1);
            if (PChar->PLinkshell1 && PItemLinkshell)
            {
                const auto linkshellName = escapeString(asStringFromUntrustedSource(data[0x0C], 20));

                int8 packetData[29]{};
                ref<uint32>(packetData, 0) = PChar->id;
                std::memcpy(packetData + 0x04, linkshellName.data(), 20);
                ref<uint32>(packetData, 24) = PChar->PLinkshell1->getID();
                ref<uint8>(packetData, 28)  = PItemLinkshell->GetLSType();
                message::send(MSG_LINKSHELL_REMOVE, packetData, sizeof(packetData), nullptr);
            }
        }
        break;
        case 2: // linkshell2
        {
            // Ensure the player has a linkshell equipped
            CItemLinkshell* PItemLinkshell = (CItemLinkshell*)PChar->getEquip(SLOT_LINK2);
            if (PChar->PLinkshell2 && PItemLinkshell)
            {
                const auto linkshellName = escapeString(asStringFromUntrustedSource(data[0x0C], 20));

                int8 packetData[29]{};
                ref<uint32>(packetData, 0) = PChar->id;
                std::memcpy(packetData + 0x04, linkshellName.data(), 20);
                ref<uint32>(packetData, 24) = PChar->PLinkshell2->getID();
                ref<uint8>(packetData, 28)  = PItemLinkshell->GetLSType();
                message::send(MSG_LINKSHELL_REMOVE, packetData, sizeof(packetData), nullptr);
            }
        }
        break;
        case 5: // alliance - alliance leader may kick a party by using that party's leader as kick parameter
        {
            if (PChar->PParty && PChar->PParty->GetLeader() == PChar && PChar->PParty->m_PAlliance)
            {
                CCharEntity* PVictim = nullptr;
                for (std::size_t i = 0; i < PChar->PParty->m_PAlliance->partyList.size(); ++i)
                {
                    const auto charName = escapeString(asStringFromUntrustedSource(data[0x0C], 15));

                    PVictim = dynamic_cast<CCharEntity*>(PChar->PParty->m_PAlliance->partyList[i]->GetMemberByName(charName));
                    if (PVictim && PVictim->PParty && PVictim->PParty->m_PAlliance) // victim is in this party
                    {
                        ShowDebug("%s is trying to kick %s party from alliance", PChar->getName(), PVictim->getName());
                        // if using kick on yourself, or alliance leader using kick on another party leader - remove the party
                        if (PVictim == PChar || (PChar->PParty->m_PAlliance->getMainParty() == PChar->PParty && PVictim->PParty->GetLeader() == PVictim))
                        {
                            if (PVictim->PParty->m_PAlliance->hasOnlyOneParty()) // if there is only 1 party then dissolve alliance
                            {
                                ShowDebug("One party in alliance, %s wants to dissolve the alliance", PChar->getName());
                                PVictim->PParty->m_PAlliance->dissolveAlliance();
                                ShowDebug("%s has dissolved the alliance", PChar->getName());
                            }
                            else
                            {
                                PVictim->PParty->m_PAlliance->removeParty(PVictim->PParty);
                                ShowDebug("%s has removed %s party from alliance", PChar->getName(), PVictim->getName());
                            }
                        }
                        break; // we're done, break the for
                    }
                }
                if (!PVictim && PChar->PParty->m_PAlliance->getMainParty() == PChar->PParty)
                {
                    const auto victimName = escapeString(asStringFromUntrustedSource(data[0x0C], 15));

                    uint32 allianceID = PChar->PParty->m_PAlliance->m_AllianceID;

                    int32 ret = _sql->Query("SELECT charid FROM chars WHERE charname = '%s'", victimName);
                    if (ret != SQL_ERROR && _sql->NumRows() == 1 && _sql->NextRow() == SQL_SUCCESS)
                    {
                        uint32 charid = _sql->GetUIntData(0);
                        ret           = _sql->Query(
                            "SELECT partyid FROM accounts_parties WHERE charid = %u AND allianceid = %u AND partyflag & %d",
                            charid, PChar->PParty->m_PAlliance->m_AllianceID, PARTY_LEADER | PARTY_SECOND | PARTY_THIRD);
                        if (ret != SQL_ERROR && _sql->NumRows() == 1 && _sql->NextRow() == SQL_SUCCESS)
                        {
                            uint32 partyid = _sql->GetUIntData(0);
                            if (_sql->Query("UPDATE accounts_parties SET allianceid = 0, partyflag = partyflag & ~%d WHERE partyid = %u",
                                            PARTY_SECOND | PARTY_THIRD, partyid) == SQL_SUCCESS &&
                                _sql->AffectedRows())
                            {
                                ShowDebug("%s has removed %s party from alliance", PChar->getName(), victimName);

                                // notify party they were removed
                                uint8 removeData[4]{};
                                ref<uint32>(removeData, 0) = partyid;
                                message::send(MSG_PT_RELOAD, removeData, sizeof(removeData), nullptr);

                                // notify alliance a party was removed
                                ref<uint32>(removeData, 0) = allianceID;
                                message::send(MSG_ALLIANCE_RELOAD, removeData, sizeof(removeData), nullptr);
                            }
                        }
                    }
                }
            }
        }
        break;
        default:
        {
            ShowError("SmallPacket0x071 : unknown byte <%.2X>", data.ref<uint8>(0x0A));
        }
        break;
    }
}

/************************************************************************
 *                                                                       *
 *  Party Invite Response (Accept, Decline, Leave)                       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x074(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    CCharEntity* PInviter = zoneutils::GetCharFromWorld(PChar->InvitePending.id, PChar->InvitePending.targid);

    uint8 InviteAnswer = data.ref<uint8>(0x04);

    if (PInviter != nullptr)
    {
        if (InviteAnswer == 0)
        {
            ShowDebug("%s declined party invite from %s", PChar->getName(), PInviter->getName());

            // invitee declined invite
            PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::InvitationDeclined);
            PChar->InvitePending.clean();
            return;
        }

        // check for alliance invite
        if (PChar->PParty != nullptr && PInviter->PParty != nullptr)
        {
            // both invitee and and inviter are party leaders
            if (PInviter->PParty->GetLeader() == PInviter && PChar->PParty->GetLeader() == PChar)
            {
                ShowDebug("%s invited %s to an alliance", PInviter->getName(), PChar->getName());

                // the inviter already has an alliance and wants to add another party - only add if they have room for another party
                if (PInviter->PParty->m_PAlliance)
                {
                    // break if alliance is full or the inviter is not the leader
                    if (PInviter->PParty->m_PAlliance->isFull() || PInviter->PParty->m_PAlliance->getMainParty() != PInviter->PParty)
                    {
                        ShowDebug("Alliance is full, invite to %s cancelled", PChar->getName());
                        PChar->pushPacket<CMessageStandardPacket>(PChar, 0, 0, MsgStd::CannotBeProcessed);
                        PChar->InvitePending.clean();
                        return;
                    }

                    // alliance is not full, add the new party
                    PInviter->PParty->m_PAlliance->addParty(PChar->PParty);
                    PChar->InvitePending.clean();
                    ShowDebug("%s party added to %s alliance", PChar->getName(), PInviter->getName());
                    return;
                }
                else if (PChar->PParty->HasTrusts() || PInviter->PParty->HasTrusts())
                {
                    // Cannot form alliance if you have Trusts
                    PChar->pushPacket<CMessageStandardPacket>(PChar, 0, 0, MsgStd::TrustCannotJoinAlliance);
                    return;
                }
                else
                {
                    // party leaders have no alliance - create a new one!
                    ShowDebug("Creating new alliance");
                    PInviter->PParty->m_PAlliance = new CAlliance(PInviter);
                    PInviter->PParty->m_PAlliance->addParty(PChar->PParty);
                    PChar->InvitePending.clean();
                    ShowDebug("%s party added to %s alliance", PChar->getName(), PInviter->getName());
                    return;
                }
            }
        }

        // the rest is for a standard party invitation
        if (PChar->PParty == nullptr)
        {
            if (!(PChar->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC) && PChar->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_RESTRICTION)))
            {
                ShowDebug("%s is not under lvl sync or restriction", PChar->getName());
                if (PInviter->PParty == nullptr)
                {
                    ShowDebug("Creating new party");
                    PInviter->PParty = new CParty(PInviter);
                }
                if (PInviter->PParty->GetLeader() == PInviter)
                {
                    if (PInviter->PParty->IsFull())
                    { // someone else accepted invitation
                        // PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, 14); Don't think retail sends error packet to inviter on full pt
                        ShowDebug("Someone else accepted party invite, %s cannot be added to party", PChar->getName());
                        PChar->pushPacket<CMessageStandardPacket>(PChar, 0, 0, MsgStd::CannotBeProcessed);
                    }
                    else
                    {
                        ShowDebug("Added %s to %s's party", PChar->getName(), PInviter->getName());
                        PInviter->PParty->AddMember(PChar);
                    }
                }
            }
            else
            {
                PChar->pushPacket<CMessageStandardPacket>(PChar, 0, 0, MsgStd::CannotJoinLevelSync);
            }
        }
    }
    else
    {
        ShowDebug("(Party) Building invite packet to send to lobby server for %s", PChar->getName());

        uint8 packetData[13]{};
        ref<uint32>(packetData, 0)  = PChar->InvitePending.id;
        ref<uint16>(packetData, 4)  = PChar->InvitePending.targid;
        ref<uint32>(packetData, 6)  = PChar->id;
        ref<uint16>(packetData, 10) = PChar->targid;
        ref<uint8>(packetData, 12)  = InviteAnswer;

        PChar->InvitePending.clean();

        message::send(MSG_PT_INV_RES, packetData, sizeof(packetData), nullptr);

        ShowDebug("(Party) Sent invite packet to send to lobby server for %s", PChar->getName());
    }
    PChar->InvitePending.clean();
}

/************************************************************************
 *                                                                       *
 *  Party List Request                                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x076(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    if (PChar->PParty)
    {
        PChar->PParty->ReloadPartyMembers(PChar);
    }
    else
    {
        // previous CPartyDefine was dropped or otherwise didn't work?
        PChar->pushPacket<CPartyDefinePacket>(nullptr, false);
    }
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x077(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    switch (data.ref<uint8>(0x14))
    {
        case 0: // party
        {
            if (PChar->PParty != nullptr && PChar->PParty->GetLeader() == PChar)
            {
                const auto memberName = escapeString(asStringFromUntrustedSource(data[0x04], 15));
                const auto permission = data.ref<uint8>(0x15);

                ShowDebug(fmt::format("(Party) Altering permissions of {} to {}", memberName, permission));
                PChar->PParty->AssignPartyRole(memberName, permission);
            }
        }
        break;
        case 1: // linkshell
        {
            if (PChar->PLinkshell1 != nullptr)
            {
                const auto linkshellName = escapeString(asStringFromUntrustedSource(data[0x04], 20));
                const auto permission    = data.ref<uint8>(0x15);

                int8 packetData[29]{};
                ref<uint32>(packetData, 0) = PChar->id;
                std::memcpy(packetData + 0x04, linkshellName.data(), 20);
                ref<uint32>(packetData, 24) = PChar->PLinkshell1->getID();
                ref<uint8>(packetData, 28)  = permission;
                message::send(MSG_LINKSHELL_RANK_CHANGE, packetData, sizeof(packetData), nullptr);
            }
        }
        break;
        case 2: // linkshell2
        {
            if (PChar->PLinkshell2 != nullptr)
            {
                const auto linkshellName = escapeString(asStringFromUntrustedSource(data[0x04], 20));
                const auto permission    = data.ref<uint8>(0x15);

                int8 packetData[29]{};
                ref<uint32>(packetData, 0) = PChar->id;
                std::memcpy(packetData + 0x04, linkshellName.data(), 20);
                ref<uint32>(packetData, 24) = PChar->PLinkshell2->getID();
                ref<uint8>(packetData, 28)  = permission;
                message::send(MSG_LINKSHELL_RANK_CHANGE, packetData, sizeof(packetData), nullptr);
            }
        }
        break;
        case 5: // alliance
        {
            if (PChar->PParty && PChar->PParty->m_PAlliance && PChar->PParty->GetLeader() == PChar &&
                PChar->PParty->m_PAlliance->getMainParty() == PChar->PParty)
            {
                const auto memberName = escapeString(asStringFromUntrustedSource(data[0x04], 15));

                ShowDebug(fmt::format("(Alliance) Changing leader to {}", memberName));
                PChar->PParty->m_PAlliance->assignAllianceLeader(memberName);

                uint8 allianceData[4]{};
                ref<uint32>(allianceData, 0) = PChar->PParty->m_PAlliance->m_AllianceID;
                message::send(MSG_ALLIANCE_RELOAD, allianceData, sizeof(allianceData), nullptr);
            }
        }
        break;
        default:
        {
            ShowError("SmallPacket0x077 : changing role packet with unknown byte <%.2X>", data.ref<uint8>(0x14));
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Party Search                                                         *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x078(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->pushPacket<CPartySearchPacket>(PChar);
}

/************************************************************************
 *                                                                       *
 *  Vender Item Purchase                                                 *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x083(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint8 quantity   = data.ref<uint8>(0x04);
    uint8 shopSlotID = data.ref<uint8>(0x0A);

    // Prevent users from buying from invalid container slots
    if (shopSlotID > PChar->Container->getExSize() - 1)
    {
        ShowError("User '%s' attempting to buy vendor item from an invalid slot!", PChar->getName());
        return;
    }

    uint16 itemID = PChar->Container->getItemID(shopSlotID);
    uint32 price  = PChar->Container->getQuantity(shopSlotID); // We used the "quantity" to store the item's sale price

    CItem* PItem = itemutils::GetItemPointer(itemID);
    if (PItem == nullptr)
    {
        ShowWarning("User '%s' attempting to buy an invalid item from vendor!", PChar->getName());
        return;
    }

    // Prevent purchasing larger stacks than the actual stack size in database.
    if (quantity > PItem->getStackSize())
    {
        quantity = PItem->getStackSize();
    }

    CItem* gil = PChar->getStorage(LOC_INVENTORY)->GetItem(0);

    if ((gil != nullptr) && gil->isType(ITEM_CURRENCY))
    {
        if (gil->getQuantity() >= (price * quantity) && gil->getReserve() == 0)
        {
            uint8 SlotID = charutils::AddItem(PChar, LOC_INVENTORY, itemID, quantity);

            if (SlotID != ERROR_SLOTID)
            {
                charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -(int32)(price * quantity));
                ShowInfo("User '%s' purchased %u of item of ID %u [from VENDOR] ", PChar->getName(), quantity, itemID);
                PChar->pushPacket<CShopBuyPacket>(shopSlotID, quantity);
                PChar->pushPacket<CInventoryFinishPacket>();
            }
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Vendor Item Appraise                                                 *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x084(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (PChar->animation != ANIMATION_SYNTH && (PChar->CraftContainer && PChar->CraftContainer->getItemsCount() == 0))
    {
        uint32 quantity = data.ref<uint32>(0x04);
        uint16 itemID   = data.ref<uint16>(0x08);
        uint8  slotID   = data.ref<uint8>(0x0A);

        CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(slotID);
        if ((PItem != nullptr) && (PItem->getID() == itemID) && !(PItem->getFlag() & ITEM_FLAG_NOSALE))
        {
            quantity = std::min(quantity, PItem->getQuantity());
            // Store item-to-sell in the last slot of the shop container
            PChar->Container->setItem(PChar->Container->getExSize(), itemID, slotID, quantity);
            PChar->pushPacket<CShopAppraisePacket>(slotID, PItem->getBasePrice());
        }
        return;
    }
}

/************************************************************************
 *                                                                       *
 *  Vender Item Sell                                                     *
 *  Player selling an item to a vendor.                                  *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x085(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    // Retrieve item-to-sell from last slot of the shop's container
    uint32 quantity = PChar->Container->getQuantity(PChar->Container->getExSize());
    uint16 itemID   = PChar->Container->getItemID(PChar->Container->getExSize());
    uint8  slotID   = PChar->Container->getInvSlotID(PChar->Container->getExSize());

    CItem* gil   = PChar->getStorage(LOC_INVENTORY)->GetItem(0);
    CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(slotID);

    if (PItem != nullptr && (gil != nullptr && gil->isType(ITEM_CURRENCY)))
    {
        if (PChar->animation == ANIMATION_SYNTH || (PChar->CraftContainer && PChar->CraftContainer->getItemsCount() > 0))
        {
            ShowWarning("SmallPacket0x085: Player %s trying to sell while in the middle of a synth!", PChar->getName());
            return;
        }

        if (quantity < 1 || quantity > PItem->getStackSize()) // Possible exploit
        {
            ShowWarning("SmallPacket0x085: Player %s trying to sell invalid quantity %u of itemID %u [to VENDOR] ", PChar->getName(), quantity, PItem->getID());
            return;
        }

        if (PItem->isSubType(ITEM_LOCKED)) // Possible exploit
        {
            ShowWarning("SmallPacket0x085: Player %s trying to sell %u of a LOCKED item! ID %i [to VENDOR] ", PChar->getName(), quantity, PItem->getID());
            return;
        }

        if (PItem->getReserve() > 0) // Usually caused by bug during synth, trade, etc. reserving the item. We don't want such items sold in this state.
        {
            ShowError("SmallPacket0x085: Player %s trying to sell %u of a RESERVED(%u) item! ID %i [to VENDOR] ", PChar->getName(), quantity, PItem->getReserve(), PItem->getID());
            return;
        }

        const auto cost = quantity * PItem->getBasePrice();

        charutils::UpdateItem(PChar, LOC_INVENTORY, 0, cost);
        charutils::UpdateItem(PChar, LOC_INVENTORY, slotID, -(int32)quantity);
        ShowInfo("SmallPacket0x085: Player '%s' sold %u of itemID %u (Total: %u gil) [to VENDOR] ", PChar->getName(), quantity, itemID, cost);
        PChar->pushPacket<CMessageStandardPacket>(nullptr, itemID, quantity, MsgStd::Sell);
        PChar->pushPacket<CInventoryFinishPacket>();
        PChar->Container->setItem(PChar->Container->getSize() - 1, 0, -1, 0);
    }
}

/************************************************************************
 *                                                                       *
 *  Begin Synthesis                                                      *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x096(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (jailutils::InPrison(PChar))
    {
        // Prevent crafting in prison
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
        return;
    }

    // If the player is already crafting, don't allow them to craft.
    // This prevents packet injection based multi-craft, or time-based exploits.
    if (PChar->animation == ANIMATION_SYNTH || (PChar->CraftContainer && PChar->CraftContainer->getItemsCount() > 0))
    {
        return;
    }

    // Force full synth duration wait no matter the synth animation length
    // Thus players can synth on whatever fps they want
    if (PChar->m_LastSynthTime + 15s > server_clock::now())
    {
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, 94);
        return;
    }

    // NOTE: This section is intended to be temporary to ensure that duping shenanigans aren't possible.
    // It should be replaced by something more robust or more stateful as soon as is reasonable
    CCharEntity* PTarget = (CCharEntity*)PChar->GetEntity(PChar->TradePending.targid, TYPE_PC);

    // Clear pending trades on synthesis start
    if (PTarget && PChar->TradePending.id == PTarget->id)
    {
        PChar->TradePending.clean();
        PTarget->TradePending.clean();
    }

    // Clears out trade session and blocks synthesis at any point in trade process after accepting
    // trade request.
    if (PChar->UContainer->GetType() != UCONTAINER_EMPTY)
    {
        if (PTarget)
        {
            ShowDebug("%s trade request with %s was canceled because %s tried to craft.",
                      PChar->getName(), PTarget->getName(), PChar->getName());

            PTarget->TradePending.clean();
            PTarget->UContainer->Clean();
            PTarget->pushPacket<CTradeActionPacket>(PChar, 0x01);
            PChar->pushPacket<CTradeActionPacket>(PTarget, 0x01);
        }
        PChar->pushPacket<CMessageStandardPacket>(MsgStd::CannotBeProcessed);
        PChar->TradePending.clean();
        PChar->UContainer->Clean();
        return;
    }
    // End temporary additions

    PChar->CraftContainer->Clean();

    uint16 ItemID    = data.ref<uint32>(0x06);
    uint8  invSlotID = data.ref<uint8>(0x08);

    uint8 numItems = data.ref<uint8>(0x09);

    auto PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotID);
    if (!PItem || ItemID != PItem->getID() || PItem->getQuantity() == 0 || numItems > 8)
    {
        // Detect invalid crystal usage
        // Prevent crafting exploit to crash on container size > 8
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
        return;
    }

    PChar->CraftContainer->setItem(0, ItemID, invSlotID, 0);

    std::vector<uint8> slotQty(MAX_CONTAINER_SIZE);
    for (int32 SlotID = 0; SlotID < numItems; ++SlotID)
    {
        ItemID    = data.ref<uint16>(0x0A + SlotID * 2);
        invSlotID = data.ref<uint8>(0x1A + SlotID);

        slotQty[invSlotID]++;

        auto* PSlotItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotID);

        if (PSlotItem && PSlotItem->getID() == ItemID && slotQty[invSlotID] <= (PSlotItem->getQuantity() - PSlotItem->getReserve()))
        {
            PChar->CraftContainer->setItem(SlotID + 1, ItemID, invSlotID, 1);
        }
    }

    synthutils::startSynth(PChar);
}

/************************************************************************
 *                                                                        *
 *  Chocobo Race Data Request                                             *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x09B(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    // ShowInfo("SmallPacket0x09B");

    // NOTE: Can trigger with !cs 335 from Chocobo Circuit

    // 9B 06 96 04 03 00 00 00 02 00 00 00
    // auto data0 = data.ref<uint8>(0x03);
    // auto data1 = data.ref<uint8>(0x04);
    auto data2 = data.ref<uint8>(0x08);

    if (data2 == 0x01) // Check the tote board
    {
        auto packet = std::make_unique<CBasicPacket>();
        packet->setType(0x73);
        packet->setSize(0x48);

        packet->ref<uint8>(0x04) = 0x01;

        // Lots of look data, maybe?
        packet->ref<uint32>(0x08) = 0x003B4879;
        packet->ref<uint32>(0x10) = 0x00B1C350;
        // etc.

        PChar->pushPacket(std::move(packet));
    }
    else if (data2 == 0x02) // Talk to race official for racing data?
    {
        // Send Chocobo Race Data (4x 0x074)
        for (int idx = 0x01; idx <= 0x04; ++idx)
        {
            auto packet = std::make_unique<CBasicPacket>();
            packet->setType(0x74);
            packet->setSize(0xB3);

            packet->ref<uint8>(0x03) = 0x04;
            packet->ref<uint8>(0x04) = 0x03;

            packet->ref<uint8>(0x10) = idx;

            switch (idx)
            {
                /*
                [2023-11-13 12:33:14] Incoming packet 0x074:
                        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
                    -----------------------------------------------------  ----------------------
                    0 | 74 5A 98 04 03 00 00 00 00 00 00 00 00 00 00 00    0 | tZ..............
                    1 | 01 00 08 00 28 00 00 00 03 00 00 C0 00 00 00 00    1 | ....(...........
                    2 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    2 | ................
                    3 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    3 | ................
                    4 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    4 | ................
                    5 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    5 | ................
                    6 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    6 | ................
                    7 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    7 | ................
                    8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
                    9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
                    A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
                    B | 00 00 00 00 -- -- -- -- -- -- -- -- -- -- -- --    B | ....------------
                */
                case 0x01:
                {
                    packet->ref<uint8>(0x12) = 0x08;
                    packet->ref<uint8>(0x14) = 0x28; // Seen also as 0xC8
                    packet->ref<uint8>(0x18) = 0x03; // Seen also as 0x01
                    packet->ref<uint8>(0x1B) = 0xC0;
                    break;
                }
                /*
                [2023-11-13 12:33:14] Incoming packet 0x074:
                        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
                    -----------------------------------------------------  ----------------------
                    0 | 74 5A 98 04 03 00 00 00 00 00 00 00 00 00 00 00    0 | tZ..............
                    1 | 02 00 60 00 30 00 00 00 FF FF 00 00 00 02 24 13    1 | ..`.0.........$.
                    2 | 62 00 00 00 FF FF 40 40 00 82 02 15 41 00 00 00    2 | b.....@@....A...
                    3 | E0 C0 60 80 00 02 20 26 21 00 00 00 C0 80 C0 80    3 | ..`... &!.......
                    4 | 00 00 24 10 12 00 00 00 FF FF 80 00 00 02 40 10    4 | ..$...........@.
                    5 | 51 00 00 00 80 60 E0 C0 00 08 08 10 30 00 00 00    5 | Q....`......0...
                    6 | FF FF 00 00 00 0C 02 11 62 00 00 00 FF FF 40 40    6 | ........b.....@@
                    7 | 00 C6 20 22 00 00 00 00 00 00 00 00 00 00 00 00    7 | .. "............
                    8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
                    9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
                    A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
                    B | 00 00 00 00 -- -- -- -- -- -- -- -- -- -- -- --    B | ....------------
                */
                case 0x02:
                {
                    // Stat and other data starting at 0x12
                    packet->ref<uint8>(0x04) = 0x01;
                    packet->ref<uint8>(0x14) = 0x12;

                    packet->ref<uint32>(0x18) = 0x0080FFFF;
                    packet->ref<uint32>(0x1C) = 0x13000A00;

                    break;
                }
                /*
                [2023-11-13 12:33:14] Incoming packet 0x074:
                        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
                    -----------------------------------------------------  ----------------------
                    0 | 74 5A 98 04 03 00 00 00 00 00 00 00 00 00 00 00    0 | tZ..............
                    1 | 03 00 A0 00 00 00 00 00 49 72 69 73 00 00 00 00    1 | ........Iris....
                    2 | 00 00 00 00 00 00 00 00 00 00 00 00 53 61 64 64    2 | ............Sadd
                    3 | 6C 65 00 00 00 00 00 00 00 00 00 00 00 00 00 00    3 | le..............
                    4 | 43 79 63 6C 6F 6E 65 00 00 00 00 00 00 00 00 00    4 | Cyclone.........
                    5 | 00 00 00 00 50 72 69 6E 74 65 6D 70 73 00 00 00    5 | ....Printemps...
                    6 | 00 00 00 00 00 00 00 00 54 72 69 73 74 61 6E 00    6 | ........Tristan.
                    7 | 00 00 00 00 00 00 00 00 00 00 00 00 4F 75 74 6C    7 | ............Outl
                    8 | 61 77 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | aw..............
                    9 | 48 75 72 72 69 63 61 6E 65 00 00 00 00 00 00 00    9 | Hurricane.......
                    A | 00 00 00 00 52 61 67 69 6E 67 00 00 00 00 00 00    A | ....Raging......
                    B | 00 00 00 00 -- -- -- -- -- -- -- -- -- -- -- --    B | ....------------
                */
                case 0x03:
                {
                    // Name Data starting at 0x18
                    break;
                }
                /*
                [2023-11-13 12:33:15] Incoming packet 0x074:
                        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
                    -----------------------------------------------------  ----------------------
                    0 | 74 5A 99 04 03 00 00 00 00 00 00 00 00 00 00 00    0 | tZ..............
                    1 | 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    1 | ................
                    2 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    2 | ................
                    3 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    3 | ................
                    4 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    4 | ................
                    5 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    5 | ................
                    6 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    6 | ................
                    7 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    7 | ................
                    8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
                    9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
                    A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
                    B | 00 00 00 00 -- -- -- -- -- -- -- -- -- -- -- --    B | ....------------
                */
                case 0x04:
                {
                    packet->ref<uint8>(0x04) = 0x9B;
                    packet->ref<uint8>(0x05) = 0x60;
                    packet->ref<uint8>(0x06) = 0x04;
                    packet->ref<uint8>(0x07) = 0x01;
                    packet->ref<uint8>(0x08) = 0x9B;
                    packet->ref<uint8>(0x30) = 0x01;
                    break;
                }
                default:
                {
                    break;
                }
            }

            PChar->pushPacket(std::move(packet));
        }
    }
}

/************************************************************************
 *                                                                        *
 *  Guild Purchase                                                        *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x0AA(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint16 itemID   = data.ref<uint16>(0x04);
    uint8  quantity = data.ref<uint8>(0x07);

    if (!PChar->PGuildShop)
    {
        return;
    }

    CItem* PItem = itemutils::GetItemPointer(itemID);
    if (PItem == nullptr)
    {
        ShowWarning("User '%s' attempting to buy an invalid item from guild vendor!", PChar->getName());
        return;
    }

    uint8      shopSlotID = PChar->PGuildShop->SearchItem(itemID);
    CItemShop* item       = (CItemShop*)PChar->PGuildShop->GetItem(shopSlotID);
    CItem*     gil        = PChar->getStorage(LOC_INVENTORY)->GetItem(0);

    // Prevent purchasing larger stacks than the actual stack size in database.
    if (quantity > PItem->getStackSize())
    {
        quantity = PItem->getStackSize();
    }

    if (((gil != nullptr) && gil->isType(ITEM_CURRENCY)) && gil->getReserve() == 0 && item != nullptr && item->getQuantity() >= quantity)
    {
        if (gil->getQuantity() > (item->getBasePrice() * quantity))
        {
            uint8 SlotID = charutils::AddItem(PChar, LOC_INVENTORY, itemID, quantity);

            if (SlotID != ERROR_SLOTID)
            {
                charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -(int32)(item->getBasePrice() * quantity));
                ShowInfo("SmallPacket0x0AA: Player '%s' purchased %u of itemID %u [from GUILD] ", PChar->getName(), quantity, itemID);
                PChar->PGuildShop->GetItem(shopSlotID)->setQuantity(PChar->PGuildShop->GetItem(shopSlotID)->getQuantity() - quantity);
                PChar->pushPacket<CGuildMenuBuyUpdatePacket>(PChar, PChar->PGuildShop->GetItem(PChar->PGuildShop->SearchItem(itemID))->getQuantity(), itemID, quantity);
                PChar->pushPacket<CInventoryFinishPacket>();
            }
        }
    }
    // TODO: error messages!
}

/************************************************************************
 *                                                                       *
 *  Dice Roll                                                            *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0A2(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint16 diceroll = xirand::GetRandomNumber(1000);

    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CMessageStandardPacket>(PChar, diceroll, MsgStd::DiceRoll));
}

/************************************************************************
 *                                                                       *
 *  Guild Item Vendor Stock Request                                      *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0AB(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (PChar->PGuildShop != nullptr)
    {
        PChar->pushPacket<CGuildMenuBuyPacket>(PChar, PChar->PGuildShop);
    }
}

/************************************************************************
 *                                                                        *
 *  Sell items to guild                                                  *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x0AC(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (PChar->animation != ANIMATION_SYNTH && (PChar->CraftContainer && PChar->CraftContainer->getItemsCount() == 0))
    {
        if (PChar->PGuildShop != nullptr)
        {
            uint16     itemID     = data.ref<uint16>(0x04);
            uint8      slot       = data.ref<uint8>(0x06);
            uint8      quantity   = data.ref<uint8>(0x07);
            uint8      shopSlotID = PChar->PGuildShop->SearchItem(itemID);
            CItemShop* shopItem   = (CItemShop*)PChar->PGuildShop->GetItem(shopSlotID);
            CItem*     charItem   = PChar->getStorage(LOC_INVENTORY)->GetItem(slot);

            if (PChar->PGuildShop->GetItem(shopSlotID)->getQuantity() + quantity > PChar->PGuildShop->GetItem(shopSlotID)->getStackSize())
            {
                quantity = PChar->PGuildShop->GetItem(shopSlotID)->getStackSize() - PChar->PGuildShop->GetItem(shopSlotID)->getQuantity();
            }

            // TODO: add all sellable items to guild table
            if (quantity != 0 && shopItem && charItem && charItem->getQuantity() >= quantity)
            {
                if (charutils::UpdateItem(PChar, LOC_INVENTORY, slot, -quantity) == itemID)
                {
                    charutils::UpdateItem(PChar, LOC_INVENTORY, 0, shopItem->getSellPrice() * quantity);
                    ShowInfo("SmallPacket0x0AC: Player '%s' sold %u of itemID %u [to GUILD] ", PChar->getName(), quantity, itemID);
                    PChar->PGuildShop->GetItem(shopSlotID)->setQuantity(PChar->PGuildShop->GetItem(shopSlotID)->getQuantity() + quantity);
                    PChar->pushPacket<CGuildMenuSellUpdatePacket>(PChar, PChar->PGuildShop->GetItem(PChar->PGuildShop->SearchItem(itemID))->getQuantity(),
                                                                  itemID, quantity);
                    PChar->pushPacket<CInventoryFinishPacket>();
                }
            }
            // TODO: error messages!
        }
        return;
    }
}

/************************************************************************
 *                                                                       *
 *  Guild Item Vendor Stock Request                                      *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0AD(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (PChar->PGuildShop != nullptr)
    {
        PChar->pushPacket<CGuildMenuSellPacket>(PChar, PChar->PGuildShop);
    }
}

/************************************************************************
 *                                                                       *
 *  Chat Message                                                         *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0B5(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    char  message[256]    = {};
    uint8 messagePosition = 0x07;

    std::memcpy(&message, data[messagePosition], std::min(data.getSize() - messagePosition, sizeof(message)));

    if (data.ref<uint8>(0x06) == '!' && !jailutils::InPrison(PChar) && (CCommandHandler::call(lua, PChar, message) == 0 || PChar->m_GMlevel > 0))
    {
        // this makes sure a command isn't sent to chat
    }
    else if (data.ref<uint8>(0x06) == '#' && PChar->m_GMlevel > 0)
    {
        message::send(MSG_CHAT_SERVMES, nullptr, 0, std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SYSTEM_1, (const char*)data[0x07]));
    }
    else
    {
        if (jailutils::InPrison(PChar))
        {
            if (data.ref<uint8>(0x04) == MESSAGE_SAY)
            {
                if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_SAY"))
                {
                    // clang-format off
                    // NOTE: We capture rawMessage as a std::string because if we cast data[0x06] into a const char*, the underlying data might
                    //     : be gone by the time we action this lambda on the worker thread.
                    Async::getInstance()->submit([name = PChar->getName(), zoneId = PChar->getZone(), rawMessage = std::string((const char*)data[0x06])]()
                    {
                        const auto query = "INSERT INTO audit_chat (speaker, type, zoneid, message, datetime) VALUES(?, 'SAY', ?, ?, current_timestamp())";
                        if (!db::preparedStmt(query, name, zoneId, rawMessage))
                        {
                            ShowError("Failed to insert SAY audit_chat record for player '%s'", name);
                        }
                    });
                    // clang-format on
                }
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SAY, (const char*)data[0x06]));
            }
            else
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_IN_THIS_AREA);
            }
        }
        else
        {
            switch (data.ref<uint8>(0x04))
            {
                case MESSAGE_SAY:
                {
                    if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_SAY"))
                    {
                        // clang-format off
                        // NOTE: We capture rawMessage as a std::string because if we cast data[0x06] into a const char*, the underlying data might
                        //     : be gone by the time we action this lambda on the worker thread.
                        Async::getInstance()->submit([name = PChar->getName(), zoneId = PChar->getZone(), rawMessage = std::string((const char*)data[0x06])]()
                        {
                            const auto query = "INSERT INTO audit_chat (speaker, type, zoneid, message, datetime) VALUES(?, 'SAY', ?, ?, current_timestamp())";
                            if (!db::preparedStmt(query, name, zoneId, rawMessage))
                            {
                                ShowError("Failed to insert SAY audit_chat record for player '%s'", name);
                            }
                        });
                        // clang-format on
                    }
                    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SAY, (const char*)data[0x06]));
                }
                break;
                case MESSAGE_EMOTION:
                {
                    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, std::make_unique<CChatMessagePacket>(PChar, MESSAGE_EMOTION, (const char*)data[0x06]));
                }
                break;
                case MESSAGE_SHOUT:
                {
                    if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_SHOUT"))
                    {
                        // clang-format off
                        // NOTE: We capture rawMessage as a std::string because if we cast data[0x06] into a const char*, the underlying data might
                        //     : be gone by the time we action this lambda on the worker thread.
                        Async::getInstance()->submit([name = PChar->getName(), zoneId = PChar->getZone(), rawMessage = std::string((const char*)data[0x06])]()
                        {
                            const auto query = "INSERT INTO audit_chat (speaker, type, zoneid, message, datetime) VALUES(?, 'SHOUT', ?, ?, current_timestamp())";
                            if (!db::preparedStmt(query, name, zoneId, rawMessage))
                            {
                                ShowError("Failed to insert SHOUT audit_chat record for player '%s'", name);
                            }
                        });
                        // clang-format on
                    }
                    PChar->loc.zone->PushPacket(PChar, CHAR_INSHOUT, std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SHOUT, (const char*)data[0x06]));
                }
                break;
                case MESSAGE_LINKSHELL:
                {
                    if (PChar->PLinkshell1 != nullptr)
                    {
                        int8 packetData[8]{};
                        ref<uint32>(packetData, 0) = PChar->PLinkshell1->getID();
                        ref<uint32>(packetData, 4) = PChar->id;
                        message::send(MSG_CHAT_LINKSHELL, packetData, sizeof(packetData),
                                      std::make_unique<CChatMessagePacket>(PChar, MESSAGE_LINKSHELL, (const char*)data[0x06]));

                        if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_LINKSHELL"))
                        {
                            char decodedLinkshellName[DecodeStringLength];
                            DecodeStringLinkshell(PChar->PLinkshell1->getName(), decodedLinkshellName);

                            // clang-format off
                            // NOTE: We capture rawMessage as a std::string because if we cast data[0x06] into a const char*, the underlying data might
                            //     : be gone by the time we action this lambda on the worker thread.
                            Async::getInstance()->submit([name = PChar->getName(), zoneId = PChar->getZone(), rawMessage = std::string((const char*)data[0x06]), decodedLinkshellName]()
                            {
                                const auto query = "INSERT INTO audit_chat (speaker, type, lsName, zoneid, message, datetime) VALUES(?, 'LINKSHELL', ?, ?, ?, current_timestamp())";
                                if (!db::preparedStmt(query, name, decodedLinkshellName, zoneId, rawMessage))
                                {
                                    ShowError("Failed to insert LINKSHELL audit_chat record for player '%s'", name);
                                }
                            });
                            // clang-format on
                        }
                    }
                }
                break;
                case MESSAGE_LINKSHELL2:
                {
                    if (PChar->PLinkshell2 != nullptr)
                    {
                        int8 packetData[8]{};
                        ref<uint32>(packetData, 0) = PChar->PLinkshell2->getID();
                        ref<uint32>(packetData, 4) = PChar->id;
                        message::send(MSG_CHAT_LINKSHELL, packetData, sizeof(packetData),
                                      std::make_unique<CChatMessagePacket>(PChar, MESSAGE_LINKSHELL, (const char*)data[0x06]));

                        if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_LINKSHELL"))
                        {
                            char decodedLinkshellName[DecodeStringLength];
                            DecodeStringLinkshell(PChar->PLinkshell2->getName(), decodedLinkshellName);

                            // clang-format off
                            // NOTE: We capture rawMessage as a std::string because if we cast data[0x06] into a const char*, the underlying data might
                            //     : be gone by the time we action this lambda on the worker thread.
                            Async::getInstance()->submit([name = PChar->getName(), zoneId = PChar->getZone(), rawMessage = std::string((const char*)data[0x06]), decodedLinkshellName]()
                            {
                                const auto query = "INSERT INTO audit_chat (speaker, type, lsName, zoneid, message, datetime) VALUES(?, 'LINKSHELL', ?, ?, ?, current_timestamp())";
                                if (!db::preparedStmt(query, name, decodedLinkshellName, zoneId, rawMessage))
                                {
                                    ShowError("Failed to insert LINKSHELL audit_chat record for player '%s'", name);
                                }
                            });
                            // clang-format on
                        }
                    }
                }
                break;
                case MESSAGE_PARTY:
                {
                    if (PChar->PParty != nullptr)
                    {
                        int8 packetData[8]{};
                        if (PChar->PParty->m_PAlliance)
                        {
                            ref<uint32>(packetData, 0) = PChar->PParty->m_PAlliance->m_AllianceID;
                            ref<uint32>(packetData, 4) = PChar->id;
                            message::send(MSG_CHAT_ALLIANCE, packetData, sizeof(packetData), std::make_unique<CChatMessagePacket>(PChar, MESSAGE_PARTY, (const char*)data[0x06]));
                        }
                        else
                        {
                            ref<uint32>(packetData, 0) = PChar->PParty->GetPartyID();
                            ref<uint32>(packetData, 4) = PChar->id;
                            message::send(MSG_CHAT_PARTY, packetData, sizeof(packetData), std::make_unique<CChatMessagePacket>(PChar, MESSAGE_PARTY, (const char*)data[0x06]));
                        }

                        if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_PARTY"))
                        {
                            // clang-format off
                            // NOTE: We capture rawMessage as a std::string because if we cast data[0x06] into a const char*, the underlying data might
                            //     : be gone by the time we action this lambda on the worker thread.
                            Async::getInstance()->submit([name = PChar->getName(), zoneId = PChar->getZone(), rawMessage = std::string((const char*)data[0x06])]()
                            {
                                const auto query = "INSERT INTO audit_chat (speaker, type, zoneid, message, datetime) VALUES(?, 'PARTY', ?, ?, current_timestamp())";
                                if (!db::preparedStmt(query, name, zoneId, rawMessage))
                                {
                                    ShowError("Failed to insert PARTY audit_chat record for player '%s'", name);
                                }
                            });
                            // clang-format on
                        }
                    }
                }
                break;
                case MESSAGE_YELL:
                {
                    const auto yellCooldownTime = settings::get<uint16>("map.YELL_COOLDOWN");
                    const auto isYellBanned     = PChar->getCharVar("[YELL]Banned") == 1;
                    const auto isInYellCooldown = PChar->getCharVar("[YELL]Cooldown") == 1;

                    if (PChar->loc.zone->CanUseMisc(MISC_YELL))
                    {
                        if (isYellBanned)
                        {
                            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
                        }
                        else if (!isInYellCooldown)
                        {
                            // CharVar will self-expire and set to zero after the cooldown period
                            PChar->setCharVar("[YELL]Cooldown", 1, CVanaTime::getInstance()->getSysTime() + yellCooldownTime);

                            int8 packetData[4]{};
                            ref<uint32>(packetData, 0) = PChar->id;

                            message::send(MSG_CHAT_YELL, packetData, sizeof(packetData), std::make_unique<CChatMessagePacket>(PChar, MESSAGE_YELL, (const char*)data[0x06]));

                            if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_YELL"))
                            {
                                // clang-format off
                                // NOTE: We capture rawMessage as a std::string because if we cast data[0x06] into a const char*, the underlying data might
                                //     : be gone by the time we action this lambda on the worker thread.
                                Async::getInstance()->submit([name = PChar->getName(), zoneId = PChar->getZone(), rawMessage = std::string((const char*)data[0x06])]()
                                {
                                    const auto query = "INSERT INTO audit_chat (speaker, type, zoneid, message, datetime) VALUES(?, 'YELL', ?, ?, current_timestamp())";
                                    if (!db::preparedStmt(query, name, zoneId, rawMessage))
                                    {
                                        ShowError("Failed to insert YELL audit_chat record for player '%s'", name);
                                    }
                                });
                                // clang-format on
                            }
                        }
                        else // You must wait longer to perform that action.
                        {
                            PChar->pushPacket<CMessageStandardPacket>(PChar, 0, MsgStd::WaitLonger);
                        }
                    }
                    else // You cannot use that command in this area.
                    {
                        PChar->pushPacket<CMessageStandardPacket>(PChar, 0, MsgStd::CannotHere);
                    }
                }
                break;
                case MESSAGE_UNITY:
                {
                    if (PChar->PUnityChat != nullptr)
                    {
                        int8 packetData[8]{};
                        ref<uint32>(packetData, 0) = PChar->PUnityChat->getLeader();
                        ref<uint32>(packetData, 4) = PChar->id;
                        message::send(MSG_CHAT_UNITY, packetData, sizeof(packetData),
                                      std::make_unique<CChatMessagePacket>(PChar, MESSAGE_UNITY, (const char*)data[0x06]));

                        roeutils::event(ROE_EVENT::ROE_UNITY_CHAT, PChar, RoeDatagram("unityMessage", (const char*)data[0x06]));

                        if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_UNITY"))
                        {
                            // clang-format off
                            // NOTE: We capture rawMessage as a std::string because if we cast data[0x06] into a const char*, the underlying data might
                            //     : be gone by the time we action this lambda on the worker thread.
                            Async::getInstance()->submit([name = PChar->getName(), zoneId = PChar->getZone(), unityLeader = PChar->PUnityChat->getLeader(), rawMessage = std::string((const char*)data[0x06])]()
                            {
                                const auto query = "INSERT INTO audit_chat (speaker, type, zoneid, unity, message, datetime) VALUES(?, 'UNITY', ?, ?, ?, current_timestamp())";
                                if (!db::preparedStmt(query, name, zoneId, unityLeader, rawMessage))
                                {
                                    ShowError("Failed to insert UNITY audit_chat record for player '%s'", name);
                                }
                            });
                            // clang-format on
                        }
                    }
                }
                break;
            }
            PChar->m_charHistory.chatsSent++;
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Whisper / Tell                                                       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0B6(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    if (jailutils::InPrison(PChar))
    {
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
        return;
    }

    const auto recipientName = escapeString(asStringFromUntrustedSource(data[0x06], 15));

    char  message[256]    = {}; // /t messages using "<t>" with a long named NPC targeted caps out at 138 bytes, increasing to the nearest power of 2
    uint8 messagePosition = 0x15;

    std::memcpy(&message, data[messagePosition], std::min(data.getSize() - messagePosition, sizeof(message)));

    if (strcmp(recipientName.c_str(), "_CUSTOM_MENU") == 0 &&
        luautils::HasCustomMenuContext(PChar))
    {
        luautils::HandleCustomMenu(PChar, message);
        return;
    }

    int8 packetData[64]{};
    strncpy((char*)packetData + 4, recipientName.c_str(), recipientName.length() + 1);
    ref<uint32>(packetData, 0) = PChar->id;

    message::send(MSG_CHAT_TELL, packetData, recipientName.length() + 5, std::make_unique<CChatMessagePacket>(PChar, MESSAGE_TELL, message));

    if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<bool>("map.AUDIT_TELL"))
    {
        // clang-format off
        // NOTE: We capture rawMessage as a std::string because if we cast data[0x06] into a const char*, the underlying data might
        //     : be gone by the time we action this lambda on the worker thread.
        Async::getInstance()->submit([name = PChar->getName(), zoneId = PChar->getZone(), recipient = recipientName, message]()
        {
            const auto query = "INSERT INTO audit_chat (speaker, type, zoneid, recipient, message, datetime) VALUES(?, 'TELL', ?, ?, ?, current_timestamp())";
            if (!db::preparedStmt(query, name, zoneId, recipient, message))
            {
                ShowError("Failed to insert TELL audit_chat record for player '%s'", name);
            }
        });
        // clang-format on
    }
}

/************************************************************************
 *                                                                       *
 *  Merit Mode (Setting of exp or limit points mode.)                    *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0BE(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint8 operation = data.ref<uint8>(0x05);

    switch (data.ref<uint8>(0x04))
    {
        case 2: // change mode
        {
            // TODO: you can switch mode anywhere except in besieged & under level restriction
            if (_sql->Query("UPDATE char_exp SET mode = %u WHERE charid = %u", operation, PChar->id) != SQL_ERROR)
            {
                PChar->MeritMode = operation;
                PChar->pushPacket<CMenuMeritPacket>(PChar);
                PChar->pushPacket<CMonipulatorPacket1>(PChar);
                PChar->pushPacket<CMonipulatorPacket2>(PChar);
            }
        }
        break;
        case 3: // change merit
        {
            if (PChar->m_moghouseID)
            {
                MERIT_TYPE merit = (MERIT_TYPE)(data.ref<uint16>(0x06) << 1);

                if (PChar->PMeritPoints->IsMeritExist(merit))
                {
                    const Merit_t* PMerit = PChar->PMeritPoints->GetMerit(merit);

                    switch (operation)
                    {
                        case 0:
                            PChar->PMeritPoints->LowerMerit(merit);
                            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, data.ref<uint16>(0x06), PMerit->count, MSGBASIC_MERIT_DECREASE);
                            break;
                        case 1:
                            PChar->PMeritPoints->RaiseMerit(merit);
                            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, data.ref<uint16>(0x06), PMerit->count, MSGBASIC_MERIT_INCREASE);
                            break;
                    }
                    PChar->pushPacket<CMenuMeritPacket>(PChar);
                    PChar->pushPacket<CMonipulatorPacket1>(PChar);
                    PChar->pushPacket<CMonipulatorPacket2>(PChar);
                    PChar->pushPacket<CMeritPointsCategoriesPacket>(PChar, merit);

                    charutils::SaveCharExp(PChar, PChar->GetMJob());
                    PChar->PMeritPoints->SaveMeritPoints(PChar->id);

                    charutils::BuildingCharSkillsTable(PChar);
                    charutils::CalculateStats(PChar);
                    charutils::CheckValidEquipment(PChar);
                    charutils::BuildingCharAbilityTable(PChar);
                    charutils::BuildingCharTraitsTable(PChar);

                    PChar->UpdateHealth();
                    PChar->addHP(PChar->GetMaxHP());
                    PChar->addMP(PChar->GetMaxMP());
                    PChar->pushPacket<CCharUpdatePacket>(PChar);
                    PChar->pushPacket<CCharStatsPacket>(PChar);
                    PChar->pushPacket<CCharSkillsPacket>(PChar);
                    PChar->pushPacket<CCharRecastPacket>(PChar);
                    PChar->pushPacket<CCharAbilitiesPacket>(PChar);
                    PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
                    PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
                    PChar->pushPacket<CCharSyncPacket>(PChar);
                }
            }
        }
        break;
    }
}

/************************************************************************
 *                                                                        *
 *  Increase Job Point                                                    *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x0BF(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (PChar->m_moghouseID)
    {
        JOBPOINT_TYPE jpType = static_cast<JOBPOINT_TYPE>(data.ref<uint16>(0x04));

        if (PChar->PJobPoints->IsJobPointExist(jpType))
        {
            PChar->PJobPoints->RaiseJobPoint(jpType);
            PChar->pushPacket<CMenuJobPointsPacket>(PChar);
            PChar->pushPacket<CJobPointUpdatePacket>(PChar, jpType);
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Job Points Details                                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0C0(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (charutils::hasKeyItem(PChar, 2544))
    {
        // Only send Job Points Packet if the player has unlocked them
        PChar->pushPacket<CJobPointDetailsPacket>(PChar);
    }
}

/************************************************************************
 *                                                                       *
 *  Create Linkpearl                                                     *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0C3(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint8           lsNum          = data.ref<uint8>(0x05);
    CItemLinkshell* PItemLinkshell = (CItemLinkshell*)PChar->getEquip(SLOT_LINK1);
    if (lsNum == 2)
    {
        PItemLinkshell = (CItemLinkshell*)PChar->getEquip(SLOT_LINK2);
    }

    if (PItemLinkshell != nullptr && PItemLinkshell->isType(ITEM_LINKSHELL) &&
        (PItemLinkshell->GetLSType() == LSTYPE_PEARLSACK || PItemLinkshell->GetLSType() == LSTYPE_LINKSHELL))
    {
        CItemLinkshell* PItemLinkPearl = (CItemLinkshell*)itemutils::GetItem(515);
        if (PItemLinkPearl)
        {
            PItemLinkPearl->setQuantity(1);
            std::memcpy(PItemLinkPearl->m_extra, PItemLinkshell->m_extra, 24);
            PItemLinkPearl->SetLSType(LSTYPE_LINKPEARL);
            charutils::AddItem(PChar, LOC_INVENTORY, PItemLinkPearl);
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Create Linkshell (Also equips the linkshell.)                        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0C4(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint8 SlotID     = data.ref<uint8>(0x06);
    uint8 LocationID = data.ref<uint8>(0x07);
    uint8 action     = data.ref<uint8>(0x08);
    uint8 lsNum      = data.ref<uint8>(0x1B);

    CItemLinkshell* PItemLinkshell = (CItemLinkshell*)PChar->getStorage(LocationID)->GetItem(SlotID);

    if (PItemLinkshell != nullptr && PItemLinkshell->isType(ITEM_LINKSHELL))
    {
        // Create new linkshell
        if (PItemLinkshell->getID() == 512)
        {
            uint32 LinkshellID    = 0;
            uint16 LinkshellColor = data.ref<uint16>(0x04);

            char DecodedName[DecodeStringLength];
            char EncodedName[LinkshellStringLength];

            std::memset(&DecodedName, 0, sizeof(DecodedName));
            std::memset(&EncodedName, 0, sizeof(EncodedName));

            const auto incomingName = escapeString(asStringFromUntrustedSource(data[0x0C], 20));

            DecodeStringLinkshell(incomingName.data(), DecodedName);
            EncodeStringLinkshell(DecodedName, EncodedName);

            // TODO: Check if a linebreak is needed

            LinkshellID = linkshell::RegisterNewLinkshell(DecodedName, LinkshellColor);
            if (LinkshellID != 0)
            {
                destroy(PItemLinkshell);
                PItemLinkshell = (CItemLinkshell*)itemutils::GetItem(513);
                if (PItemLinkshell == nullptr)
                {
                    return;
                }

                PItemLinkshell->setQuantity(1);
                PChar->getStorage(LocationID)->InsertItem(PItemLinkshell, SlotID);
                PItemLinkshell->SetLSID(LinkshellID);
                PItemLinkshell->SetLSType(LSTYPE_LINKSHELL);
                PItemLinkshell->setSignature(EncodedName); // because apparently the format from the packet isn't right, and is missing terminators
                PItemLinkshell->SetLSColor(LinkshellColor);

                char extra[sizeof(PItemLinkshell->m_extra) * 2 + 1];
                _sql->EscapeStringLen(extra, (const char*)PItemLinkshell->m_extra, sizeof(PItemLinkshell->m_extra));

                const char* Query =
                    "UPDATE char_inventory SET signature = '%s', extra = '%s', itemId = 513 WHERE charid = %u AND location = 0 AND slot = %u LIMIT 1";

                if (_sql->Query(Query, DecodedName, extra, PChar->id, SlotID) != SQL_ERROR && _sql->AffectedRows() != 0)
                {
                    PChar->pushPacket<CInventoryItemPacket>(PItemLinkshell, LocationID, SlotID);
                }
            }
            else
            {
                PChar->pushPacket<CMessageStandardPacket>(MsgStd::LinkshellUnavailable);
                // DE
                // 20
                // 1D
                return;
            }
        }
        else
        {
            SLOTTYPE    slot         = SLOT_LINK1;
            CLinkshell* OldLinkshell = PChar->PLinkshell1;
            if (lsNum == 2)
            {
                slot         = SLOT_LINK2;
                OldLinkshell = PChar->PLinkshell2;
            }
            switch (action)
            {
                case 0: // unequip linkshell
                {
                    linkshell::DelOnlineMember(PChar, PItemLinkshell);

                    PItemLinkshell->setSubType(ITEM_UNLOCKED);

                    PChar->equip[slot]    = 0;
                    PChar->equipLoc[slot] = 0;
                    if (lsNum == 1)
                    {
                        PChar->updatemask |= UPDATE_HP;
                    }

                    PChar->pushPacket<CInventoryAssignPacket>(PItemLinkshell, INV_NORMAL);
                }
                break;
                case 1: // equip linkshell
                {
                    auto ret = _sql->Query("SELECT broken FROM linkshells WHERE linkshellid = %u LIMIT 1", PItemLinkshell->GetLSID());
                    if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS && _sql->GetUIntData(0) == 1)
                    { // if the linkshell has been broken, break the item
                        PItemLinkshell->SetLSType(LSTYPE_BROKEN);

                        char extra[sizeof(PItemLinkshell->m_extra) * 2 + 1];
                        _sql->EscapeStringLen(extra, (const char*)PItemLinkshell->m_extra, sizeof(PItemLinkshell->m_extra));

                        const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u LIMIT 1";
                        _sql->Query(Query, extra, PChar->id, PItemLinkshell->getLocationID(), PItemLinkshell->getSlotID());

                        PChar->pushPacket<CInventoryItemPacket>(PItemLinkshell, PItemLinkshell->getLocationID(), PItemLinkshell->getSlotID());
                        PChar->pushPacket<CInventoryFinishPacket>();
                        PChar->pushPacket<CMessageStandardPacket>(MsgStd::LinkshellNoLongerExists);
                        return;
                    }
                    if (PItemLinkshell->GetLSID() == 0)
                    {
                        PChar->pushPacket<CMessageStandardPacket>(MsgStd::LinkshellNoLongerExists);
                        return;
                    }
                    if (OldLinkshell != nullptr) // switching linkshell group
                    {
                        CItemLinkshell* POldItemLinkshell = (CItemLinkshell*)PChar->getEquip(slot);

                        if (POldItemLinkshell != nullptr && POldItemLinkshell->isType(ITEM_LINKSHELL))
                        {
                            linkshell::DelOnlineMember(PChar, POldItemLinkshell);

                            POldItemLinkshell->setSubType(ITEM_UNLOCKED);
                            PChar->pushPacket<CInventoryAssignPacket>(POldItemLinkshell, INV_NORMAL);
                        }
                    }
                    linkshell::AddOnlineMember(PChar, PItemLinkshell, lsNum);

                    PItemLinkshell->setSubType(ITEM_LOCKED);

                    PChar->equip[slot]    = SlotID;
                    PChar->equipLoc[slot] = LocationID;
                    if (lsNum == 1)
                    {
                        PChar->updatemask |= UPDATE_HP;
                    }

                    PChar->pushPacket<CInventoryAssignPacket>(PItemLinkshell, INV_LINKSHELL);
                }
                break;
            }
            charutils::SaveCharStats(PChar);
            charutils::SaveCharEquip(PChar);

            PChar->pushPacket<CLinkshellEquipPacket>(PChar, lsNum);
            PChar->pushPacket<CInventoryItemPacket>(PItemLinkshell, LocationID, SlotID);
        }
        PChar->pushPacket<CInventoryFinishPacket>();
        PChar->pushPacket<CCharUpdatePacket>(PChar);
    }
}

/************************************************************************
 *                                                                       *
 *  Mog House actions                                                    *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0CB(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    auto operation = data.ref<uint8>(0x04);
    if (operation == 1)
    {
        // open mog house

        // NOTE: If you zone or move floors while in the MH and you have someone visiting, they will be booted.
        // NOTE: When you zone or move floors your "open MH" flag will be reset.
    }
    else if (operation == 2)
    {
        // close mog house
    }
    else if (operation == 5)
    {
        // remodel mog house
        auto type = data.ref<uint8>(0x06); // Sandy: 103, Bastok: 104, Windy: 105, Patio: 106

        if (type == 106 && !charutils::hasKeyItem(PChar, 3051))
        {
            ShowWarning(fmt::format("Player {} is trying to remodel to MH2F to Patio without owning the KI to unlock it.", PChar->getName()));
            return;
        }

        // 0x0080: This bit and the next track which 2F decoration style is being used (0: SANDORIA, 1: BASTOK, 2: WINDURST, 3: PATIO)
        // 0x0100: ^ As above

        // Extract original model and add 103 so it's in line with what comes in with the packet.
        uint16 oldType = (uint8)(((PChar->profile.mhflag & 0x0100) + (PChar->profile.mhflag & 0x0080)) >> 7) + 103;

        // Clear bits first
        PChar->profile.mhflag &= ~(0x0080);
        PChar->profile.mhflag &= ~(0x0100);

        // Write new model bits
        PChar->profile.mhflag |= ((type - 103) << 7);
        charutils::SaveCharStats(PChar);

        // TODO: Send message on successful remodel

        // If the model changes AND you're on MH2F; force a rezone so the model change can take effect.
        if (type != oldType && PChar->profile.mhflag & 0x0040)
        {
            auto zoneid = PChar->getZone();
            auto ipp    = zoneutils::GetZoneIPP(zoneid);

            PChar->loc.destination = zoneid;
            PChar->status          = STATUS_TYPE::DISAPPEAR;

            PChar->clearPacketList();
            charutils::SendToZone(PChar, 2, ipp);
        }
    }
    else
    {
        ShowWarning("SmallPacket0x0CB : unknown byte <%.2X>", data.ref<uint8>(0x04));
    }
}

/************************************************************************
 *                                                                       *
 *  Request Party Map Positions                                          *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0D2(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    // clang-format off
    PChar->ForAlliance([PChar](CBattleEntity* PPartyMember)
    {
        if (PPartyMember->getZone() == PChar->getZone() && ((CCharEntity*)PPartyMember)->m_moghouseID == PChar->m_moghouseID)
        {
            PChar->pushPacket<CPartyMapPacket>((CCharEntity*)PPartyMember);
        }
    });
    // clang-format on
}

/************************************************************************
 *                                                                       *
 *  Help Desk Report                                                     *
 *  help desk -> i want to report -> yes -> yes -> execute               *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0D3(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->m_charHistory.gmCalls++;
}

/************************************************************************
 *                                                                       *
 *  Set Chat Filters / Preferred Language                                *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0DB(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    // https://github.com/atom0s/XiPackets/tree/main/world/client/0x00DB
    struct packet_c2s_0DB_t
    {
        uint16_t id : 9;
        uint16_t size : 7;
        uint16_t sync;
        uint8_t  unknown04;    // Set to 0.
        uint8_t  unknown05;    // Set to 0.
        uint8_t  Kind;         // The packet kind.
        uint8_t  padding00;    // Padding; unused.
        uint32_t ConfigSys[3]; // The players current PTR_pGlobalNowZone->ConfigSys values.
        uint32_t padding01[4]; // Padding; unused. (Space for future information?)
        uint32_t Param;        // Packet parameter.
    } packet = {};

    std::memcpy(&packet, data, sizeof(packet_c2s_0DB_t));

    uint32_t oldPlayerConfig = {};
    uint32_t oldChatFilter1  = {};
    uint32_t oldChatFilter2  = {};

    std::memcpy(&oldPlayerConfig, &PChar->playerConfig, sizeof(uint32_t));
    std::memcpy(&oldChatFilter1, &PChar->playerConfig.MessageFilter, sizeof(uint32_t));
    std::memcpy(&oldChatFilter2, &PChar->playerConfig.MessageFilter2, sizeof(uint32_t));

    // Player updated their search language(s).
    if (packet.Kind == 1)
    {
        uint8 oldLanguages     = PChar->search.language;
        PChar->search.language = packet.Param;
        if (oldLanguages != PChar->search.language)
        {
            charutils::SaveLanguages(PChar);
        }
    }

    // This used to cause problems with the new adventurer icon just showing up for no reason. This was because 0x00A was not sending the saved SAVE_CONF in the db.
    if (oldPlayerConfig != packet.ConfigSys[0])
    {
        std::memcpy(&PChar->playerConfig, &packet.ConfigSys[0], sizeof(uint32_t));
        charutils::SavePlayerSettings(PChar);
    }

    if (oldChatFilter1 != packet.ConfigSys[1] || oldChatFilter2 != packet.ConfigSys[2])
    {
        std::memcpy(&PChar->playerConfig.MessageFilter, &packet.ConfigSys[1], sizeof(uint32_t));
        std::memcpy(&PChar->playerConfig.MessageFilter2, &packet.ConfigSys[2], sizeof(uint32_t));
        charutils::SaveChatFilterFlags(PChar); // Do we even need to save chat filter flags? When the client logs in, they send the chat filters.
    }

    PChar->pushPacket<CMenuConfigPacket>(PChar);
}

// https://github.com/atom0s/XiPackets/blob/main/world/client/0x00DC/README.md
struct GP_CLI_CONFIG
{
    uint16_t id : 9;
    uint16_t size : 7;
    uint16_t sync;
    uint8_t  InviteFlg : 1;           // PS2: InviteFlg
    uint8_t  AwayFlg : 1;             // PS2: AwayFlg
    uint8_t  AnonymityFlg : 1;        // PS2: AnonymityFlg
    uint8_t  Language : 2;            // PS2: Language
    uint8_t  unused05 : 3;            // PS2: GmLevel
    uint8_t  unused08 : 1;            // PS2: InvisFlg
    uint8_t  unused09 : 1;            // PS2: InvulFlg
    uint8_t  unused10 : 1;            // PS2: IgnoreFlg
    uint8_t  unused11 : 2;            // PS2: SysMesFilterLevel
    uint8_t  unused13 : 1;            // PS2: GmNoPrintFlg
    uint8_t  AutoTargetOffFlg : 1;    // PS2: AutoTargetOffFlg
    uint8_t  AutoPartyFlg : 1;        // PS2: AutoPartyFlg
    uint8_t  unused16 : 8;            // PS2: JailNo
    uint8_t  unused24 : 1;            // PS2: (New; previously padding byte.)
    uint8_t  MentorFlg : 1;           // PS2: (New; previously padding byte.)
    uint8_t  NewAdventurerOffFlg : 1; // PS2: (New; previously padding byte.)
    uint8_t  DisplayHeadOffFlg : 1;   // PS2: (New; previously padding byte.)
    uint8_t  unused28 : 1;            // PS2: (New; previously padding byte.)
    uint8_t  RecruitFlg : 1;          // PS2: (New; previously padding byte.)
    uint8_t  unused30 : 2;            // PS2: (New; previously padding byte.)
    uint32_t unused00;                // PS2: (Other misc data.)
    uint32_t unused01;                // PS2: (Other misc data.)
    uint8_t  SetFlg;                  // Ps2: SetFlg
    uint8_t  padding00[3];            // PS2: (New; did not exist.)
};

void SmallPacket0x0DC(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    auto configUpdateData = data.as<GP_CLI_CONFIG>();

    bool value = configUpdateData->SetFlg == 1; // 1 == on, 2 == off. What?

    bool updated = false;

    if (configUpdateData->InviteFlg)
    {
        updated = true;

        PChar->playerConfig.InviteFlg = value;
    }

    if (configUpdateData->AwayFlg)
    {
        updated = true;

        PChar->playerConfig.AwayFlg = value;
    }

    if (configUpdateData->AnonymityFlg)
    {
        updated = true;

        PChar->playerConfig.AnonymityFlg = value;
        PChar->pushPacket<CMessageSystemPacket>(0, 0, value ? MsgStd::CharacterInfoHidden : MsgStd::CharacterInfoShown);
    }

    if (configUpdateData->AutoTargetOffFlg)
    {
        updated = true;

        PChar->playerConfig.AutoTargetOffFlg = value;
    }

    if (configUpdateData->AutoPartyFlg)
    {
        updated = true;

        PChar->playerConfig.AutoPartyFlg = value;
    }

    if (configUpdateData->MentorFlg)
    {
        updated = true;

        PChar->playerConfig.MentorFlg = value;
    }

    if (configUpdateData->NewAdventurerOffFlg)
    {
        updated = true;

        PChar->playerConfig.NewAdventurerOffFlg = value;
    }

    if (configUpdateData->DisplayHeadOffFlg)
    {
        updated = true;

        PChar->playerConfig.DisplayHeadOffFlg = value;

        // TODO: if you have no headgear you blink anyway. Check if retail does this.
        PChar->pushPacket<CCharAppearancePacket>(PChar);
        PChar->pushPacket<CMessageStandardPacket>(value ? MsgStd::HeadgearHide : MsgStd::HeadgearShow);
    }

    if (configUpdateData->RecruitFlg)
    {
        updated = true;

        PChar->playerConfig.RecruitFlg = value;
    }

    if (updated)
    {
        PChar->updatemask |= UPDATE_HP;

        charutils::SaveCharStats(PChar);
        charutils::SavePlayerSettings(PChar);
        PChar->pushPacket<CMenuConfigPacket>(PChar);
        PChar->pushPacket<CCharUpdatePacket>(PChar);
        PChar->pushPacket<CCharSyncPacket>(PChar);
    }
}

/************************************************************************
 *                                                                       *
 *  Check Target                                                         *
 *                                                                       *
 *  170 - <target> seems It seems to have high evasion and defense.      *
 *  171 - <target> seems It seems to have high evasion.                  *
 *  172 - <target> seems It seems to have high evasion but low defense.  *
 *  173 - <target> seems It seems to have high defense.                  *
 *  174 - <target> seems                                                 *
 *  175 - <target> seems It seems to have low defense.                   *
 *  176 - <target> seems It seems to have low evasion but high defense.  *
 *  177 - <target> seems It seems to have low evasion.                   *
 *  178 - <target> seems It seems to have low evasion and defense.       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0DD(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint32 id     = data.ref<uint32>(0x04);
    uint16 targid = data.ref<uint16>(0x08);
    uint8  type   = data.ref<uint8>(0x0C);

    // checkparam
    if (type == 0x02)
    {
        if (PChar->id == id)
        {
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CHECKPARAM_NAME);
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CHECKPARAM_ILVL);
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, PChar->ACC(0, 0), PChar->ATT(SLOT_MAIN), MSGBASIC_CHECKPARAM_PRIMARY);
            if (PChar->getEquip(SLOT_SUB) && PChar->getEquip(SLOT_SUB)->isType(ITEM_WEAPON))
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, PChar->ACC(1, 0), PChar->ATT(SLOT_SUB), MSGBASIC_CHECKPARAM_AUXILIARY);
            }
            else
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CHECKPARAM_AUXILIARY);
            }
            if (PChar->getEquip(SLOT_RANGED) && PChar->getEquip(SLOT_RANGED)->isType(ITEM_WEAPON))
            {
                int skill      = ((CItemWeapon*)PChar->getEquip(SLOT_RANGED))->getSkillType();
                int bonusSkill = ((CItemWeapon*)PChar->getEquip(SLOT_RANGED))->getILvlSkill();
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, PChar->RACC(skill, bonusSkill), PChar->RATT(skill, bonusSkill), MSGBASIC_CHECKPARAM_RANGE);
            }
            else if (PChar->getEquip(SLOT_AMMO) && PChar->getEquip(SLOT_AMMO)->isType(ITEM_WEAPON))
            {
                int skill      = ((CItemWeapon*)PChar->getEquip(SLOT_AMMO))->getSkillType();
                int bonusSkill = ((CItemWeapon*)PChar->getEquip(SLOT_AMMO))->getILvlSkill();
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, PChar->RACC(skill, bonusSkill), PChar->RATT(skill, bonusSkill), MSGBASIC_CHECKPARAM_RANGE);
            }
            else
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CHECKPARAM_RANGE);
            }
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, PChar->EVA(), PChar->DEF(), MSGBASIC_CHECKPARAM_DEFENSE);
        }
        else if (PChar->PPet && PChar->PPet->id == id)
        {
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar->PPet, 0, 0, MSGBASIC_CHECKPARAM_NAME);
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar->PPet, PChar->PPet->ACC(0, 0), PChar->PPet->ATT(SLOT_MAIN), MSGBASIC_CHECKPARAM_PRIMARY);
            if (PChar->getEquip(SLOT_SUB) && PChar->getEquip(SLOT_SUB)->isType(ITEM_WEAPON))
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar->PPet, PChar->PPet->ACC(1, 0), PChar->PPet->ATT(SLOT_MAIN), MSGBASIC_CHECKPARAM_AUXILIARY);
            }
            else
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar->PPet, 0, 0, MSGBASIC_CHECKPARAM_AUXILIARY);
            }
            if (PChar->getEquip(SLOT_RANGED) && PChar->getEquip(SLOT_RANGED)->isType(ITEM_WEAPON))
            {
                int skill = ((CItemWeapon*)PChar->getEquip(SLOT_RANGED))->getSkillType();
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar->PPet, PChar->PPet->RACC(skill), PChar->PPet->RATT(skill), MSGBASIC_CHECKPARAM_RANGE);
            }
            else if (PChar->getEquip(SLOT_AMMO) && PChar->getEquip(SLOT_AMMO)->isType(ITEM_WEAPON))
            {
                int skill = ((CItemWeapon*)PChar->getEquip(SLOT_AMMO))->getSkillType();
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar->PPet, PChar->PPet->RACC(skill), PChar->PPet->RATT(skill), MSGBASIC_CHECKPARAM_RANGE);
            }
            else
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar->PPet, 0, 0, MSGBASIC_CHECKPARAM_RANGE);
            }
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar->PPet, PChar->PPet->EVA(), PChar->PPet->DEF(), MSGBASIC_CHECKPARAM_DEFENSE);
        }
    }
    else
    {
        if (jailutils::InPrison(PChar))
        {
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
            return;
        }

        CBaseEntity* PEntity = PChar->GetEntity(targid, TYPE_MOB | TYPE_PC);

        if (PEntity == nullptr || PEntity->id != id)
        {
            return;
        }

        switch (PEntity->objtype)
        {
            case TYPE_MOB:
            {
                CMobEntity* PTarget = (CMobEntity*)PEntity;

                if (PTarget->m_Type & MOBTYPE_NOTORIOUS || PTarget->m_Type & MOBTYPE_BATTLEFIELD || PTarget->getMobMod(MOBMOD_CHECK_AS_NM) > 0)
                {
                    PChar->pushPacket<CMessageBasicPacket>(PChar, PTarget, 0, 0, 249);
                }
                else
                {
                    uint8          mobLvl   = PTarget->GetMLevel();
                    EMobDifficulty mobCheck = charutils::CheckMob(PChar->GetMLevel(), mobLvl);

                    // Calculate main /check message (64 is Too Weak)
                    int32 MessageValue = 64 + (uint8)mobCheck;

                    // Grab mob and player stats for extra messaging
                    uint16 charAcc = PChar->ACC(SLOT_MAIN, (uint8)0);
                    uint16 charAtt = PChar->ATT(SLOT_MAIN);
                    uint16 mobEva  = PTarget->EVA();
                    uint16 mobDef  = PTarget->DEF();

                    // Calculate +/- message
                    uint16 MessageID = 174; // Default even def/eva

                    // Offsetting the message ID by a certain amount for each stat gives us the correct message
                    // Defense is +/- 1
                    // Evasion is +/- 3
                    if (mobDef > charAtt)
                    { // High Defesne
                        MessageID -= 1;
                    }
                    else if ((mobDef * 1.25) <= charAtt)
                    { // Low Defense
                        MessageID += 1;
                    }

                    if ((mobEva - 30) > charAcc)
                    { // High Evasion
                        MessageID -= 3;
                    }
                    else if ((mobEva + 10) <= charAcc)
                    {
                        MessageID += 3;
                    }

                    PChar->pushPacket<CMessageBasicPacket>(PChar, PTarget, mobLvl, MessageValue, MessageID);
                }
            }
            break;
            case TYPE_PC:
            {
                CCharEntity* PTarget = (CCharEntity*)PEntity;

                if (PTarget->m_PMonstrosity)
                {
                    PChar->pushPacket<CMessageStandardPacket>(PTarget, 0, 0, MsgStd::MonstrosityCheckOut);
                    PTarget->pushPacket<CMessageStandardPacket>(PChar, 0, 0, MsgStd::MonstrosityCheckIn);
                    return;
                }

                if (!PChar->m_isGMHidden || (PChar->m_isGMHidden && PTarget->m_GMlevel >= PChar->m_GMlevel))
                {
                    PTarget->pushPacket<CMessageStandardPacket>(PChar, 0, 0, MsgStd::Examine);
                }

                PChar->pushPacket<CBazaarMessagePacket>(PTarget);
                PChar->pushPacket<CCheckPacket>(PChar, PTarget);
            }
            break;
            default:
            {
                break;
            }
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Set Bazaar Message                                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0DE(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->bazaar.message.clear();
    PChar->bazaar.message.insert(0, (const char*)data[4], 120); // Maximum bazaar message limit: 120 characters

    char message[256];
    _sql->EscapeString(message, PChar->bazaar.message.c_str());

    _sql->Query("UPDATE char_stats SET bazaar_message = '%s' WHERE charid = %u", message, PChar->id);

    DebugBazaarsFmt("Bazaar Interaction [Set Message] - Character: {}, Message: '{}'", PChar->name, message);
}

/************************************************************************
 *                                                                       *
 *  Set Search Message                                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0E0(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    char message[256];
    _sql->EscapeString(message, (const char*)data[0x04]);

    uint8 type = strlen(message) == 0 ? 0 : data.ref<uint8>(data.getSize() - 4);

    if (type == PChar->search.messagetype && strcmp(message, PChar->search.message.c_str()) == 0)
    {
        return;
    }

    auto ret = _sql->Query("UPDATE accounts_sessions SET seacom_type = %u, seacom_message = '%s' WHERE charid = %u", type, message, PChar->id);

    if (ret == SQL_SUCCESS)
    {
        PChar->search.message.clear();
        PChar->search.message.insert(0, message);
        PChar->search.messagetype = type;
    }
    return;
}

/************************************************************************
 *                                                                       *
 *  Request Linkshell Message (/lsmes)                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0E1(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint8 slot = data.ref<uint8>(0x07);
    if (slot == PChar->equip[SLOT_LINK1] && PChar->PLinkshell1)
    {
        PChar->PLinkshell1->PushLinkshellMessage(PChar, true);
    }
    else if (slot == PChar->equip[SLOT_LINK2] && PChar->PLinkshell2)
    {
        PChar->PLinkshell2->PushLinkshellMessage(PChar, false);
    }
}

/************************************************************************
 *                                                                       *
 *  Update Linkshell Message                                             *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0E2(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    CItemLinkshell* PItemLinkshell = (CItemLinkshell*)PChar->getEquip(SLOT_LINK1);

    if (PChar->PLinkshell1 != nullptr && (PItemLinkshell != nullptr && PItemLinkshell->isType(ITEM_LINKSHELL)))
    {
        switch (data.ref<uint8>(0x04) & 0xF0)
        {
            case 0x20: // Establish right to change the message.
            {
                if (PItemLinkshell->GetLSType() == LSTYPE_LINKSHELL)
                {
                    switch (data.ref<uint8>(0x05))
                    {
                        case 0x00:
                            PChar->PLinkshell1->setPostRights(LSTYPE_LINKSHELL);
                            break;
                        case 0x04:
                            PChar->PLinkshell1->setPostRights(LSTYPE_PEARLSACK);
                            break;
                        case 0x08:
                            PChar->PLinkshell1->setPostRights(LSTYPE_LINKPEARL);
                            break;
                    }
                    return;
                }
            }
            break;
            case 0x40: // Change Message
            {
                if (static_cast<uint8>(PItemLinkshell->GetLSType()) <= PChar->PLinkshell1->m_postRights)
                {
                    const auto lsMessage = escapeString(asStringFromUntrustedSource(data[0x10], 128));
                    PChar->PLinkshell1->setMessage(lsMessage, PChar->getName());
                    return;
                }
            }
            break;
        }
    }
    PChar->pushPacket<CMessageStandardPacket>(MsgStd::LinkshellNoAccess);
}

/************************************************************************
 *                                                                       *
 *  Exit Game Request                                                    *
 *    1 = /logout                                                        *
 *    3 = /shutdown                                                      *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0E7(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (PChar->status != STATUS_TYPE::NORMAL)
    {
        return;
    }

    if (PChar->StatusEffectContainer->HasPreventActionEffect())
    {
        return;
    }

    // FIXME: Two GM level checks? visibleGmLevel is the GM level visible to other players, and m_GMLevel is the alway-invisible GM level.
    if (PChar->m_moghouseID || PChar->visibleGmLevel >= 3 || PChar->m_GMlevel > 0)
    {
        charutils::ForceLogout(PChar);
    }
    else if (PChar->animation == ANIMATION_NONE)
    {
        uint8 ExitType = (data.ref<uint8>(0x06) == 1 ? 7 : 35);

        if (PChar->PPet == nullptr || (PChar->PPet->m_EcoSystem != ECOSYSTEM::AVATAR && PChar->PPet->m_EcoSystem != ECOSYSTEM::ELEMENTAL))
        {
            PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_HEALING, 0, 0, settings::get<uint8>("map.HEALING_TICK_DELAY"), 0));
        }
        PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_LEAVEGAME, 0, ExitType, 5, 0));
    }
    else if (PChar->animation == ANIMATION_HEALING)
    {
        if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_LEAVEGAME))
        {
            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_HEALING);
        }
        else
        {
            uint8 ExitType = (data.ref<uint8>(0x06) == 1 ? 7 : 35);

            PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_LEAVEGAME, 0, ExitType, 5, 0));
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Heal Packet (/heal)                                                  *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0E8(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (PChar->status != STATUS_TYPE::NORMAL)
    {
        return;
    }

    if (PChar->StatusEffectContainer->HasPreventActionEffect())
    {
        return;
    }

    switch (PChar->animation)
    {
        case ANIMATION_NONE:
        {
            if (data.ref<uint8>(0x04) == 0x02)
            {
                return;
            }

            if (PChar->PPet == nullptr ||
                (PChar->PPet->m_EcoSystem != ECOSYSTEM::AVATAR && PChar->PPet->m_EcoSystem != ECOSYSTEM::ELEMENTAL && !PChar->PAI->IsEngaged()))
            {
                PChar->PAI->ClearStateStack();
                if (PChar->PPet && PChar->PPet->objtype == TYPE_PET && ((CPetEntity*)PChar->PPet)->getPetType() == PET_TYPE::AUTOMATON)
                {
                    PChar->PPet->PAI->Disengage();
                }
                PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_HEALING, 0, 0, settings::get<uint8>("map.HEALING_TICK_DELAY"), 0));
                return;
            }
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, 345);
        }
        break;
        case ANIMATION_HEALING:
        {
            if (data.ref<uint8>(0x04) == 0x01)
            {
                return;
            }

            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_HEALING);
        }
        break;
    }
}

/************************************************************************
 *                                                                       *
 *  Sit Packet (/sit)                                                    *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0EA(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    // Prevent sitting while crafting.
    if (PChar->animation == ANIMATION_SYNTH || (PChar->CraftContainer && PChar->CraftContainer->getItemsCount() > 0))
    {
        return;
    }

    if (PChar->status != STATUS_TYPE::NORMAL)
    {
        return;
    }

    if (PChar->StatusEffectContainer->HasPreventActionEffect())
    {
        return;
    }

    PChar->animation = PChar->animation == ANIMATION_SIT ? ANIMATION_NONE : ANIMATION_SIT;
    PChar->updatemask |= UPDATE_HP;

    CPetEntity* PPet = dynamic_cast<CPetEntity*>(PChar->PPet);
    if (PPet)
    {
        if (PPet->getPetType() == PET_TYPE::WYVERN || PPet->getPetType() == PET_TYPE::AUTOMATON)
        {
            PPet->animation = PChar->animation;
            PPet->updatemask |= UPDATE_HP;
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Special Release Request                                              *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0EB(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (!PChar->isNpcLocked())
    {
        return;
    }

    PChar->pushPacket<CSpecialReleasePacket>(PChar);
}

/************************************************************************
 *                                                                       *
 *  Cancel Status Effect                                                 *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0F1(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint16 IconID = data.ref<uint16>(0x04);

    if (IconID)
    {
        PChar->StatusEffectContainer->DelStatusEffectsByIcon(IconID);
    }
}

/************************************************************************
 *                                                                       *
 *  Update Player Zone Boundary                                          *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0F2(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->loc.boundary = data.ref<uint16>(0x06);

    charutils::SaveCharPosition(PChar);
}

/************************************************************************
 *                                                                       *
 *  Wide Scan                                                            *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0F4(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    TracyZoneCString("Wide Scan");
    PChar->loc.zone->WideScan(PChar, charutils::getWideScanRange(PChar));
}

/************************************************************************
 *                                                                       *
 *  Wide Scan Track                                                      *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0F5(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint16 TargID = data.ref<uint16>(0x04);

    CBaseEntity* target = PChar->GetEntity(TargID, TYPE_MOB | TYPE_NPC);
    if (target == nullptr)
    {
        // Target not found
        PChar->WideScanTarget = std::nullopt;
        return;
    }

    uint16 widescanRange = charutils::getWideScanRange(PChar);
    float  dist          = distance(PChar->loc.p, target->loc.p);

    // Only allow players to track targets that are actually scannable, and within their wide scan range
    if (target->isWideScannable() && dist <= widescanRange)
    {
        PChar->WideScanTarget = EntityID_t{
            .id     = target->id,
            .targid = target->targid
        };
    }
}

/************************************************************************
 *                                                                       *
 *  Wide Scan Cancel Tracking                                            *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0F6(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->WideScanTarget = std::nullopt;
}

/************************************************************************
 *                                                                       *
 *  Mog House Place Furniture                                            *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0FA(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    uint16 itemID = data.ref<uint16>(0x04);
    if (itemID == 0)
    {
        // No item sent means the client has finished placing furniture
        PChar->UpdateMoghancement();
        return;
    }

    uint8 slotID      = data.ref<uint8>(0x06);
    uint8 containerID = data.ref<uint8>(0x07);
    uint8 on2ndFloor  = data.ref<uint8>(0x08);
    uint8 col         = data.ref<uint8>(0x09);
    uint8 level       = data.ref<uint8>(0x0A);
    uint8 row         = data.ref<uint8>(0x0B);
    uint8 rotation    = data.ref<uint8>(0x0C);

    // TODO: Should we be responding with inventory update/finish if we reject the client's request?

    if (containerID != LOC_MOGSAFE && containerID != LOC_MOGSAFE2)
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid container requested: {}", PChar->getName()));
        return;
    }

    auto* PContainer = PChar->getStorage(containerID);
    if (PContainer == nullptr)
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid storage requested: {}", PChar->getName()));
        return;
    }

    if (slotID > PContainer->GetSize()) // TODO: Is this off-by-one?
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid slot requested: {}", PChar->getName()));
        return;
    }

    if (on2ndFloor > 0x01)
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid floor requested: {}", PChar->getName()));
        return;
    }

    if (rotation > 0x03)
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid rotation requested: {}", PChar->getName()));
        return;
    }

    if (level > 0x15)
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid level requested: {}", PChar->getName()));
        return;
    }

    // NOTE: Items hanging on walls count as their own row/column entries, rather than level changes.
    //     : The multiple options on MH2F mean the col limit is higher.

    // NOTE: These are all unsigned, so <0 is handled
    bool lowerArea0 = row <= 23 && col <= 5;
    bool lowerArea1 = row >= 18 && row <= 23 && col >= 6 && col <= 13;
    bool lowerArea2 = row <= 23 && col >= 14 && col <= 19;
    bool upperArea0 = row <= 25 && col <= 91;

    if (on2ndFloor && !upperArea0)
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid row/col requested: {}", PChar->getName()));
        return;
    }
    else if (!on2ndFloor && !lowerArea0 && !lowerArea1 && !lowerArea2)
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid row/col requested: {}", PChar->getName()));
        return;
    }

    // Get item
    auto* PItem = dynamic_cast<CItemFurnishing*>(PContainer->GetItem(slotID));
    if (PItem == nullptr)
    {
        return;
    }

    // Try to catch packet abuse, leading to gardening pots being placed on 2nd floor.
    if (on2ndFloor && PItem->isGardeningPot())
    {
        RATE_LIMIT(30s, ShowErrorFmt("{} has tried to gardening pot {} ({}) on 2nd floor",
                                     PChar->getName(), PItem->getID(), PItem->getName()));
        return;
    }

    // Continue with regular usage
    if (PItem->getID() == itemID && PItem->isType(ITEM_FURNISHING))
    {
        if (PItem->getFlag() & ITEM_FLAG_WALLHANGING)
        {
            rotation = (col >= 2 ? 3 : 1);
        }

        bool wasInstalled = PItem->isInstalled();
        PItem->setInstalled(true);
        PItem->setOn2ndFloor(on2ndFloor);
        PItem->setCol(col);
        PItem->setRow(row);
        PItem->setLevel(level);
        PItem->setRotation(rotation);

        constexpr auto maxContainerSize = MAX_CONTAINER_SIZE * 2;

        // Update installed furniture placement orders
        // First we place the furniture into placed items using the order number as the index
        std::array<CItemFurnishing*, maxContainerSize> placedItems = { nullptr };
        for (auto safeContainerId : { LOC_MOGSAFE, LOC_MOGSAFE2 })
        {
            CItemContainer* PContainer = PChar->getStorage(safeContainerId);
            for (int slotIndex = 1; slotIndex <= PContainer->GetSize(); ++slotIndex)
            {
                if (slotID == slotIndex && containerID == safeContainerId)
                {
                    continue;
                }

                CItem* PContainerItem = PContainer->GetItem(slotIndex);
                if (PContainerItem != nullptr && PContainerItem->isType(ITEM_FURNISHING))
                {
                    CItemFurnishing* PFurniture = static_cast<CItemFurnishing*>(PContainerItem);
                    if (PFurniture->isInstalled())
                    {
                        placedItems[PFurniture->getOrder()] = PFurniture;
                    }
                }
            }
        }

        // Update the item's order number
        for (int32 i = 0; i < MAX_CONTAINER_SIZE * 2; ++i)
        {
            // We can stop updating the order numbers once we hit an empty order number
            if (placedItems[i] == nullptr)
            {
                break;
            }
            placedItems[i]->setOrder(placedItems[i]->getOrder() + 1);
        }

        // Set this item to being the most recently placed item
        PItem->setOrder(0);

        PItem->setSubType(ITEM_LOCKED);

        PChar->pushPacket<CFurnitureInteractPacket>(PItem, containerID, slotID);

        char extra[sizeof(PItem->m_extra) * 2 + 1];
        _sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

        const char* Query = "UPDATE char_inventory "
                            "SET "
                            "extra = '%s' "
                            "WHERE location = %u AND slot = %u AND charid = %u";

        if (_sql->Query(Query, extra, containerID, slotID, PChar->id) != SQL_ERROR && _sql->AffectedRows() != 0 && !wasInstalled)
        {
            // Storage mods only apply on the 1st floor
            if (!PItem->getOn2ndFloor())
            {
                PChar->getStorage(LOC_STORAGE)->AddBuff(PItem->getStorage());
            }

            PChar->pushPacket<CInventorySizePacket>(PChar);

            luautils::OnFurniturePlaced(PChar, PItem);

            PChar->loc.zone->SpawnConditionalNPCs(PChar);
        }
        PChar->pushPacket<CInventoryItemPacket>(PItem, containerID, slotID);
        PChar->pushPacket<CInventoryFinishPacket>();
    }
}

/************************************************************************
 *                                                                       *
 *  Mog House Remove Furniture                                           *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0FB(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint16 ItemID = data.ref<uint16>(0x04);

    if (ItemID == 0)
    {
        return;
    }

    uint8 slotID      = data.ref<uint8>(0x06);
    uint8 containerID = data.ref<uint8>(0x07);

    if (containerID != LOC_MOGSAFE && containerID != LOC_MOGSAFE2)
    {
        return;
    }

    CItemContainer*  PItemContainer = PChar->getStorage(containerID);
    CItemFurnishing* PItem          = (CItemFurnishing*)PItemContainer->GetItem(slotID);

    if (PItem != nullptr && PItem->getID() == ItemID && PItem->isType(ITEM_FURNISHING))
    {
        PItemContainer = PChar->getStorage(LOC_STORAGE);

        uint8 RemovedSize = PItemContainer->GetSize() - std::min<uint8>(PItemContainer->GetSize(), PItemContainer->GetBuff() - PItem->getStorage());

        if (PItemContainer->GetFreeSlotsCount() >= RemovedSize)
        {
            PItem->setInstalled(false);
            PItem->setCol(0);
            PItem->setRow(0);
            PItem->setLevel(0);
            PItem->setRotation(0);

            PItem->setSubType(ITEM_UNLOCKED);

            // If this furniture is a mannequin, clear its appearance and unlock all items that were on it!
            if (PItem->isMannequin())
            {
                PChar->pushPacket<CInventoryCountPacket>(containerID, slotID, 0, 0, 0, 0, 0, 0, 0, 0);
                for (uint8 i = 0; i < 8; ++i)
                {
                    if (PItem->m_extra[10 + i] > 0)
                    {
                        auto* PEquippedItem = PChar->getStorage(LOC_STORAGE)->GetItem(i);
                        if (PEquippedItem == nullptr)
                        {
                            continue;
                        }
                        PChar->pushPacket<CInventoryAssignPacket>(PEquippedItem, INV_NORMAL);
                        PItem->m_extra[10 + i] = 0;
                    }
                }
            }

            char extra[sizeof(PItem->m_extra) * 2 + 1];
            _sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

            const char* Query = "UPDATE char_inventory "
                                "SET "
                                "extra = '%s' "
                                "WHERE location = %u AND slot = %u AND charid = %u";

            if (_sql->Query(Query, extra, containerID, slotID, PChar->id) != SQL_ERROR && _sql->AffectedRows() != 0)
            {
                uint8 NewSize = PItemContainer->GetSize() - RemovedSize;
                for (uint8 SlotID = PItemContainer->GetSize(); SlotID > NewSize; --SlotID)
                {
                    if (PItemContainer->GetItem(SlotID) != nullptr)
                    {
                        charutils::MoveItem(PChar, LOC_STORAGE, SlotID, ERROR_SLOTID);
                    }
                }

                // Storage mods only apply on the 1st floor
                if (!PItem->getOn2ndFloor())
                {
                    PChar->getStorage(LOC_STORAGE)->AddBuff(-(int8)PItem->getStorage());
                }

                PChar->pushPacket<CInventorySizePacket>(PChar);

                luautils::OnFurnitureRemoved(PChar, PItem);

                PChar->loc.zone->SpawnConditionalNPCs(PChar);
            }
            PChar->pushPacket<CInventoryItemPacket>(PItem, containerID, PItem->getSlotID());
            PChar->pushPacket<CInventoryFinishPacket>();
        }
        else
        {
            ShowError("SmallPacket0x0FB: furnishing can't be removed");
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Mog House Plant Flowerpot
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0FC(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint16 potItemID = data.ref<uint16>(0x04);
    uint16 itemID    = data.ref<uint16>(0x06);

    if (potItemID == 0 || itemID == 0)
    {
        return;
    }

    uint8 potSlotID      = data.ref<uint8>(0x08);
    uint8 slotID         = data.ref<uint8>(0x09);
    uint8 potContainerID = data.ref<uint8>(0x0A);
    uint8 containerID    = data.ref<uint8>(0x0B);

    if ((potContainerID != LOC_MOGSAFE && potContainerID != LOC_MOGSAFE2) || (containerID != LOC_MOGSAFE && containerID != LOC_MOGSAFE2))
    {
        return;
    }

    CItemContainer* PPotItemContainer = PChar->getStorage(potContainerID);
    CItemFlowerpot* PPotItem          = (CItemFlowerpot*)PPotItemContainer->GetItem(potSlotID);
    if (PPotItem == nullptr)
    {
        return;
    }

    if (!PPotItem->isGardeningPot())
    {
        ShowWarning(fmt::format("{} has tried to invalid gardening pot {} ({})",
                                PChar->getName(), PPotItem->getID(), PPotItem->getName()));
        return;
    }

    CItemContainer* PItemContainer = PChar->getStorage(containerID);
    CItem*          PItem          = PItemContainer->GetItem(slotID);
    if (PItem == nullptr || PItem->getQuantity() < 1)
    {
        return;
    }

    bool updatedPot = false;

    if (CItemFlowerpot::getPlantFromSeed(itemID) != FLOWERPOT_PLANT_NONE)
    {
        // Planting a seed in the flowerpot
        PChar->pushPacket<CMessageStandardPacket>(itemID, 132); // "Your moogle plants the <seed> in the flowerpot."
        PPotItem->cleanPot();
        PPotItem->setPlant(CItemFlowerpot::getPlantFromSeed(itemID));
        PPotItem->setPlantTimestamp(CVanaTime::getInstance()->getVanaTime());
        PPotItem->setStrength(xirand::GetRandomNumber(33));
        gardenutils::GrowToNextStage(PPotItem);
        updatedPot = true;
    }
    else if (itemID >= 4096 && itemID <= 4111)
    {
        // Feeding the plant a crystal
        PChar->pushPacket<CMessageStandardPacket>(itemID, 136); // "Your moogle uses the <item> on the plant."
        if (PPotItem->getStage() == FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL)
        {
            PPotItem->setFirstCrystalFeed(CItemFlowerpot::getElementFromItem(itemID));
            updatedPot = true;
        }
        else if (PPotItem->getStage() == FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL)
        {
            PPotItem->setSecondCrystalFeed(CItemFlowerpot::getElementFromItem(itemID));
            updatedPot = true;
        }
        if (updatedPot)
        {
            gardenutils::GrowToNextStage(PPotItem, true);
            PPotItem->markExamined();
        }
    }

    if (updatedPot)
    {
        char extra[sizeof(PPotItem->m_extra) * 2 + 1];
        _sql->EscapeStringLen(extra, (const char*)PPotItem->m_extra, sizeof(PPotItem->m_extra));
        const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u";
        _sql->Query(Query, extra, PChar->id, PPotItem->getLocationID(), PPotItem->getSlotID());

        PChar->pushPacket<CFurnitureInteractPacket>(PPotItem, potContainerID, potSlotID);

        PChar->pushPacket<CInventoryItemPacket>(PPotItem, potContainerID, potSlotID);

        charutils::UpdateItem(PChar, containerID, slotID, -1);
        PChar->pushPacket<CInventoryFinishPacket>();
    }
}

/************************************************************************
 *                                                                       *
 *  Mog House Examine Flowerpot
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0FD(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint16 itemID = data.ref<uint16>(0x04);
    if (itemID == 0)
    {
        return;
    }

    uint8 slotID      = data.ref<uint8>(0x06);
    uint8 containerID = data.ref<uint8>(0x07);
    if (containerID != LOC_MOGSAFE && containerID != LOC_MOGSAFE2)
    {
        return;
    }

    CItemContainer* PItemContainer = PChar->getStorage(containerID);
    CItemFlowerpot* PItem          = (CItemFlowerpot*)PItemContainer->GetItem(slotID);
    if (PItem == nullptr)
    {
        return;
    }

    if (PItem->isPlanted())
    {
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, CItemFlowerpot::getSeedID(PItem->getPlant()), 0, MSGBASIC_GARDENING_SEED_SOWN);
        if (PItem->isTree())
        {
            if (PItem->getStage() > FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL)
            {
                if (PItem->getExtraCrystalFeed() != FLOWERPOT_ELEMENT_NONE)
                {
                    PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, CItemFlowerpot::getItemFromElement(PItem->getExtraCrystalFeed()), 0,
                                                           MSGBASIC_GARDENING_CRYSTAL_USED);
                }
                else
                {
                    PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_GARDENING_CRYSTAL_NONE);
                }
            }
        }
        if (PItem->getStage() > FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL)
        {
            if (PItem->getCommonCrystalFeed() != FLOWERPOT_ELEMENT_NONE)
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, CItemFlowerpot::getItemFromElement(PItem->getCommonCrystalFeed()), 0,
                                                       MSGBASIC_GARDENING_CRYSTAL_USED);
            }
            else
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_GARDENING_CRYSTAL_NONE);
            }
        }

        if (!PItem->wasExamined())
        {
            PItem->markExamined();
            char extra[sizeof(PItem->m_extra) * 2 + 1];
            _sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));
            const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u";
            _sql->Query(Query, extra, PChar->id, PItem->getLocationID(), PItem->getSlotID());
        }
    }

    PChar->pushPacket<CFurnitureInteractPacket>(PItem, containerID, slotID);
}

/************************************************************************
 *                                                                       *
 *  Mog House Uproot Flowerpot
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0FE(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint16 ItemID = data.ref<uint16>(0x04);
    if (ItemID == 0)
    {
        return;
    }

    uint8 slotID      = data.ref<uint8>(0x06);
    uint8 containerID = data.ref<uint8>(0x07);
    if (containerID != LOC_MOGSAFE && containerID != LOC_MOGSAFE2)
    {
        return;
    }

    CItemContainer* PItemContainer = PChar->getStorage(containerID);
    CItemFlowerpot* PItem          = (CItemFlowerpot*)PItemContainer->GetItem(slotID);
    if (PItem == nullptr)
    {
        return;
    }

    // Try to catch packet abuse, leading to gardening pots being placed on 2nd floor.
    if (PItem->getOn2ndFloor() && PItem->isGardeningPot())
    {
        ShowWarning(fmt::format("{} has tried to uproot gardening pot {} ({}) on 2nd floor",
                                PChar->getName(), PItem->getID(), PItem->getName()));
        return;
    }

    uint8 isEmptyingPot = data.ref<uint8>(0x08);

    if (PItem->isPlanted())
    {
        if (isEmptyingPot == 0 && PItem->getStage() == FLOWERPOT_STAGE_MATURE_PLANT)
        {
            // Harvesting plant
            uint16 resultID                   = 0;
            uint8  totalQuantity              = 0;
            std::tie(resultID, totalQuantity) = gardenutils::CalculateResults(PChar, PItem);
            uint8 stackSize                   = itemutils::GetItemPointer(resultID)->getStackSize();
            uint8 requiredSlots               = (uint8)ceil(float(totalQuantity) / stackSize);
            uint8 totalFreeSlots              = PChar->getStorage(LOC_MOGSAFE)->GetFreeSlotsCount() + PChar->getStorage(LOC_MOGSAFE2)->GetFreeSlotsCount();
            if (requiredSlots > totalFreeSlots || totalQuantity == 0)
            {
                PChar->pushPacket<CMessageStandardPacket>(MsgStd::MoghouseCantPickUp); // Kupo. I can't pick anything right now, kupo.
                return;
            }
            uint8 remainingQuantity = totalQuantity;
            for (uint8 slot = 0; slot < requiredSlots; ++slot)
            {
                uint8 quantity = std::min(remainingQuantity, stackSize);
                if (charutils::AddItem(PChar, LOC_MOGSAFE, resultID, quantity) == ERROR_SLOTID)
                {
                    charutils::AddItem(PChar, LOC_MOGSAFE2, resultID, quantity);
                }
                remainingQuantity -= quantity;
            }
            PChar->pushPacket<CMessageStandardPacket>(resultID, totalQuantity, 134); // Your moogle <quantity> <item> from the plant!
        }

        PChar->pushPacket<CFurnitureInteractPacket>(PItem, containerID, slotID);
        PItem->cleanPot();

        char extra[sizeof(PItem->m_extra) * 2 + 1];
        _sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));
        const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u";
        _sql->Query(Query, extra, PChar->id, PItem->getLocationID(), PItem->getSlotID());

        PChar->pushPacket<CInventoryItemPacket>(PItem, containerID, slotID);
        PChar->pushPacket<CInventoryFinishPacket>();
    }
}

/************************************************************************
 *                                                                       *
 *  Mog House Dry Flowerpot
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0FF(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint16 itemID = data.ref<uint16>(0x04);
    if (itemID == 0)
    {
        return;
    }

    uint8 slotID      = data.ref<uint8>(0x06);
    uint8 containerID = data.ref<uint8>(0x07);
    if (containerID != LOC_MOGSAFE && containerID != LOC_MOGSAFE2)
    {
        return;
    }

    CItemContainer* PItemContainer = PChar->getStorage(containerID);
    CItemFlowerpot* PItem          = (CItemFlowerpot*)PItemContainer->GetItem(slotID);

    if (PItem != nullptr && PItem->isPlanted() && PItem->getStage() > FLOWERPOT_STAGE_INITIAL && PItem->getStage() < FLOWERPOT_STAGE_WILTED && !PItem->isDried())
    {
        PChar->pushPacket<CMessageStandardPacket>(itemID, 133); // Your moogle dries the plant in the <item>.
        PChar->pushPacket<CFurnitureInteractPacket>(PItem, containerID, slotID);
        PItem->setDried(true);

        char extra[sizeof(PItem->m_extra) * 2 + 1];
        _sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));
        const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u";
        _sql->Query(Query, extra, PChar->id, PItem->getLocationID(), PItem->getSlotID());

        PChar->pushPacket<CInventoryItemPacket>(PItem, containerID, slotID);
        PChar->pushPacket<CInventoryFinishPacket>();
    }
}

/************************************************************************
 *                                                                       *
 *  Job Change                                                           *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x100(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (PChar->loc.zone->CanUseMisc(MISC_MOGMENU) || PChar->m_moghouseID)
    {
        uint8 mjob = data.ref<uint8>(0x04);
        uint8 sjob = data.ref<uint8>(0x05);

        if ((mjob > 0x00) && (mjob < MAX_JOBTYPE) && (PChar->jobs.unlocked & (1 << mjob)))
        {
            JOBTYPE prevjob = PChar->GetMJob();
            PChar->resetPetZoningInfo();

            charutils::SaveJobChangeGear(PChar);
            charutils::RemoveAllEquipment(PChar);
            PChar->SetMJob(mjob);
            PChar->SetMLevel(PChar->jobs.job[PChar->GetMJob()]);
            PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);

            // If removing RemoveAllEquipment, please add a charutils::CheckUnarmedItem(PChar) if main hand is empty.
            puppetutils::LoadAutomaton(PChar);
            if (mjob == JOB_BLU)
            {
                blueutils::LoadSetSpells(PChar);
            }
            else if (prevjob == JOB_BLU)
            {
                blueutils::UnequipAllBlueSpells(PChar);
            }

            bool canUseMeritMode = PChar->jobs.job[PChar->GetMJob()] >= 75 && charutils::hasKeyItem(PChar, 606);
            if (!canUseMeritMode && PChar->MeritMode)
            {
                if (_sql->Query("UPDATE char_exp SET mode = %u WHERE charid = %u", 0, PChar->id) != SQL_ERROR)
                {
                    PChar->MeritMode = false;
                }
            }
        }

        if ((sjob > 0x00) && (sjob < MAX_JOBTYPE) && (PChar->jobs.unlocked & (1 << sjob)))
        {
            JOBTYPE prevsjob = PChar->GetSJob();
            PChar->resetPetZoningInfo();

            PChar->SetSJob(sjob);
            PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);

            charutils::CheckEquipLogic(PChar, SCRIPT_CHANGESJOB, prevsjob);
            puppetutils::LoadAutomaton(PChar);
            if (sjob == JOB_BLU)
            {
                blueutils::LoadSetSpells(PChar);
            }
            else if (prevsjob == JOB_BLU)
            {
                blueutils::UnequipAllBlueSpells(PChar);
            }

            DAMAGE_TYPE subType = DAMAGE_TYPE::NONE;
            if (auto* weapon = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_SUB]))
            {
                subType = weapon->getDmgType();
            }

            if (subType > DAMAGE_TYPE::NONE && subType < DAMAGE_TYPE::HTH)
            {
                charutils::UnequipItem(PChar, SLOT_SUB);
            }
        }

        charutils::SetStyleLock(PChar, false);
        luautils::CheckForGearSet(PChar); // check for gear set on gear change

        jobpointutils::RefreshGiftMods(PChar);
        charutils::BuildingCharSkillsTable(PChar);
        charutils::CalculateStats(PChar);
        charutils::BuildingCharTraitsTable(PChar);
        PChar->PRecastContainer->ChangeJob();
        charutils::BuildingCharAbilityTable(PChar);
        charutils::BuildingCharWeaponSkills(PChar);
        charutils::LoadJobChangeGear(PChar);
        PChar->RequestPersist(CHAR_PERSIST::EQUIP);

        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DISPELABLE | EFFECTFLAG_ROLL | EFFECTFLAG_ON_JOBCHANGE);

        // clang-format off
        PChar->ForParty([](CBattleEntity* PMember)
        {
            ((CCharEntity*)PMember)->PLatentEffectContainer->CheckLatentsPartyJobs();
        });
        // clang-format on

        PChar->UpdateHealth();

        PChar->health.hp = PChar->GetMaxHP();
        PChar->health.mp = PChar->GetMaxMP();
        PChar->updatemask |= UPDATE_HP;

        charutils::SaveCharStats(PChar);

        PChar->pushPacket<CCharJobsPacket>(PChar);
        PChar->pushPacket<CCharUpdatePacket>(PChar);
        PChar->pushPacket<CCharStatsPacket>(PChar);
        PChar->pushPacket<CCharSkillsPacket>(PChar);
        PChar->pushPacket<CCharRecastPacket>(PChar);
        PChar->pushPacket<CCharAbilitiesPacket>(PChar);
        PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
        PChar->pushPacket<CCharJobExtraPacket>(PChar, false);
        PChar->pushPacket<CMenuMeritPacket>(PChar);
        PChar->pushPacket<CMonipulatorPacket1>(PChar);
        PChar->pushPacket<CMonipulatorPacket2>(PChar);
        PChar->pushPacket<CCharSyncPacket>(PChar);
    }
}

/************************************************************************
 *                                                                       *
 *  Set Blue Magic Spells / PUP Attachments / MON equip                  *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x102(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint8 job = data.ref<uint8>(0x08);
    if ((PChar->GetMJob() == JOB_BLU || PChar->GetSJob() == JOB_BLU) && job == JOB_BLU)
    {
        // This may be a request to add or remove set spells, so lets check.

        uint8 spellToAdd      = data.ref<uint8>(0x04); // this is non-zero if client wants to add.
        uint8 spellInQuestion = 0;
        int8  spellIndex      = -1;

        if (spellToAdd == 0x00)
        {
            for (uint8 i = 0x0C; i <= 0x1F; i++)
            {
                if (data.ref<uint8>(i) > 0)
                {
                    spellInQuestion   = data.ref<uint8>(i);
                    spellIndex        = i - 0x0C;
                    CBlueSpell* spell = (CBlueSpell*)spell::GetSpell(
                        static_cast<SpellID>(spellInQuestion + 0x200)); // the spells in this packet are offsetted by 0x200 from their spell IDs.

                    if (spell != nullptr)
                    {
                        if (PChar->m_SetBlueSpells[spellIndex] == 0x00)
                        {
                            ShowWarning("SmallPacket0x102: Player %s trying to unset BLU spell they don't have set!", PChar->getName());
                            return;
                        }
                        else
                        {
                            blueutils::SetBlueSpell(PChar, spell, spellIndex, false);
                        }
                    }
                    else
                    {
                        ShowDebug("SmallPacket0x102: Cannot resolve spell id %u ", spellInQuestion);
                        return;
                    }
                }
            }
            charutils::BuildingCharTraitsTable(PChar);
            PChar->pushPacket<CCharAbilitiesPacket>(PChar);
            PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
            PChar->pushPacket<CCharJobExtraPacket>(PChar, false);
            PChar->pushPacket<CCharStatsPacket>(PChar);
            PChar->UpdateHealth();
        }
        else
        {
            // loop all 20 slots and find which index they are playing with
            for (uint8 i = 0x0C; i <= 0x1F; i++)
            {
                if (data.ref<uint8>(i) > 0)
                {
                    spellInQuestion = data.ref<uint8>(i);
                    spellIndex      = i - 0x0C;
                    break;
                }
            }

            if (spellIndex != -1 && spellInQuestion != 0)
            {
                CBlueSpell* spell = (CBlueSpell*)spell::GetSpell(
                    static_cast<SpellID>(spellInQuestion + 0x200)); // the spells in this packet are offsetted by 0x200 from their spell IDs.

                if (spell != nullptr)
                {
                    uint8 mLevel = PChar->m_LevelRestriction != 0 && PChar->m_LevelRestriction < PChar->GetMLevel() ? PChar->m_LevelRestriction : PChar->GetMLevel();
                    uint8 sLevel = floor(mLevel / 2);

                    if (mLevel < spell->getJob(PChar->GetMJob()) && sLevel < spell->getJob(PChar->GetSJob()))
                    {
                        ShowWarning("SmallPacket0x102: Player %s trying to set BLU spell at invalid level!", PChar->getName());
                        return;
                    }

                    blueutils::SetBlueSpell(PChar, spell, spellIndex, true);
                    charutils::BuildingCharTraitsTable(PChar);
                    PChar->pushPacket<CCharAbilitiesPacket>(PChar);
                    PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
                    PChar->pushPacket<CCharJobExtraPacket>(PChar, false);
                    PChar->pushPacket<CCharStatsPacket>(PChar);
                    PChar->UpdateHealth();
                }
                else
                {
                    ShowDebug("SmallPacket0x102: Cannot resolve spell id %u ", spellInQuestion);
                }
            }
            else
            {
                ShowDebug("No match found. ");
            }
        }

        // Regardless what the set spell action is, force recast on all currently-set blu spells
        for (uint8 i = 0; i < 20; i++)
        {
            if (PChar->m_SetBlueSpells[i] != 0)
            {
                auto  spellId = static_cast<SpellID>(PChar->m_SetBlueSpells[i] + 0x200);
                auto* PSpell  = spell::GetSpell(spellId);
                if (CBlueSpell* PBlueSpell = dynamic_cast<CBlueSpell*>(PSpell))
                {
                    PChar->PRecastContainer->Add(RECAST_MAGIC, static_cast<uint16>(PBlueSpell->getID()), 60);
                }
            }
        }
    }
    else if ((PChar->GetMJob() == JOB_PUP || PChar->GetSJob() == JOB_PUP) && job == JOB_PUP && PChar->PAutomaton != nullptr && PChar->PPet == nullptr)
    {
        uint8 attachment = data.ref<uint8>(0x04);

        if (attachment == 0x00)
        {
            // remove all attachments specified
            for (uint8 i = 0x0E; i < 0x1A; i++)
            {
                if (data.ref<uint8>(i) != 0)
                {
                    puppetutils::setAttachment(PChar, i - 0x0E, 0x00);
                }
            }
        }
        else
        {
            if (data.ref<uint8>(0x0C) != 0)
            {
                puppetutils::setHead(PChar, data.ref<uint8>(0x0C));
                puppetutils::LoadAutomatonStats(PChar);
            }
            else if (data.ref<uint8>(0x0D) != 0)
            {
                puppetutils::setFrame(PChar, data.ref<uint8>(0x0D));
                puppetutils::LoadAutomatonStats(PChar);
            }
            else
            {
                for (uint8 i = 0x0E; i < 0x1A; i++)
                {
                    if (data.ref<uint8>(i) != 0)
                    {
                        puppetutils::setAttachment(PChar, i - 0x0E, data.ref<uint8>(i));
                    }
                }
            }
        }
        PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
        PChar->pushPacket<CCharJobExtraPacket>(PChar, false);
        puppetutils::SaveAutomaton(PChar);
    }
    else if (PChar->loc.zone->GetID() == ZONE_FERETORY && PChar->m_PMonstrosity != nullptr)
    {
        monstrosity::HandleEquipChangePacket(PChar, data);
    }
}

/************************************************************************
 *                                                                        *
 *  Closing the "View wares", sending a message to the bazaar            *
 *  that you have left the shop                                            *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x104(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    CCharEntity* PTarget = (CCharEntity*)PChar->GetEntity(PChar->BazaarID.targid, TYPE_PC);

    if (PTarget != nullptr && PTarget->id == PChar->BazaarID.id)
    {
        for (std::size_t i = 0; i < PTarget->BazaarCustomers.size(); ++i)
        {
            if (PTarget->BazaarCustomers[i].id == PChar->id)
            {
                PTarget->BazaarCustomers.erase(PTarget->BazaarCustomers.begin() + i--);
            }
        }
        if (!PChar->m_isGMHidden || (PChar->m_isGMHidden && PTarget->m_GMlevel >= PChar->m_GMlevel))
        {
            PTarget->pushPacket<CBazaarCheckPacket>(PChar, BAZAAR_LEAVE);
        }

        DebugBazaarsFmt("Bazaar Interaction [Leave Bazaar] - Buyer: {}, Seller: {}", PChar->name, PTarget->name);
    }
    PChar->BazaarID.clean();
}

/************************************************************************
 *                                                                       *
 *  Clicking "View wares", opening the bazaar for browsing               *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x105(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (PChar->BazaarID.id != 0)
    {
        ShowWarning("BazaarID.id is not equal to zero.");
        return;
    }

    if (PChar->BazaarID.targid != 0)
    {
        ShowWarning("BazaarID.targid is not equal to zero.");
        return;
    }

    uint32 charid = data.ref<uint32>(0x04);

    CCharEntity* PTarget = charid != 0 ? PChar->loc.zone->GetCharByID(charid) : (CCharEntity*)PChar->GetEntity(PChar->m_TargID, TYPE_PC);

    if (PTarget != nullptr && PTarget->id == charid && PTarget->hasBazaar())
    {
        PChar->BazaarID.id     = PTarget->id;
        PChar->BazaarID.targid = PTarget->targid;

        EntityID_t EntityID = { PChar->id, PChar->targid };

        if (!PChar->m_isGMHidden || (PChar->m_isGMHidden && PTarget->m_GMlevel >= PChar->m_GMlevel))
        {
            PTarget->pushPacket<CBazaarCheckPacket>(PChar, BAZAAR_ENTER);
        }
        PTarget->BazaarCustomers.emplace_back(EntityID);

        CItemContainer* PBazaar = PTarget->getStorage(LOC_INVENTORY);

        for (uint8 SlotID = 1; SlotID <= PBazaar->GetSize(); ++SlotID)
        {
            CItem* PItem = PBazaar->GetItem(SlotID);

            if ((PItem != nullptr) && (PItem->getCharPrice() != 0))
            {
                PChar->pushPacket<CBazaarItemPacket>(PItem, SlotID, PChar->loc.zone->GetTax());
            }
        }

        DebugBazaarsFmt("Bazaar Interaction [View Wares] - Buyer: {}, Seller: {}", PChar->name, PTarget->name);
    }
}

/************************************************************************
 *                                                                       *
 *  Purchasing an item from a bazaar                                     *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x106(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint8 Quantity = data.ref<uint8>(0x08);
    uint8 SlotID   = data.ref<uint8>(0x04);

    CCharEntity* PTarget = (CCharEntity*)PChar->GetEntity(PChar->BazaarID.targid, TYPE_PC);

    if (PTarget == nullptr || PTarget->id != PChar->BazaarID.id)
    {
        return;
    }

    CItemContainer* PBazaar         = PTarget->getStorage(LOC_INVENTORY);
    CItemContainer* PBuyerInventory = PChar->getStorage(LOC_INVENTORY);
    if (PBazaar == nullptr || PBuyerInventory == nullptr)
    {
        return;
    }

    CItem* PBazaarItem = PBazaar->GetItem(SlotID);
    if (PBazaarItem == nullptr || PBazaarItem->getReserve() > 0)
    {
        return;
    }

    // Validate purchase quantity
    if (Quantity < 1)
    {
        // Exploit attempt
        ShowWarningFmt("Bazaar Interaction [Invalid Quantity] - Buyer: {}, Seller: {}, Item: {}, Qty: {}", PChar->name, PTarget->name, PBazaarItem->getName(), Quantity);
        return;
    }

    if (PChar->id == PTarget->id || PBuyerInventory->GetFreeSlotsCount() == 0)
    {
        PChar->pushPacket<CBazaarPurchasePacket>(PTarget, false);

        if (settings::get<bool>("logging.DEBUG_BAZAARS") && PChar->id == PTarget->id)
        {
            if (PChar->id == PTarget->id)
            {
                DebugBazaarsFmt("Bazaar Interaction [Purchase Failed / Self Bazaar] - Character: {}, Item: {}", PChar->name, PBazaarItem->getName());
            }
            if (PBuyerInventory->GetFreeSlotsCount() == 0)
            {
                DebugBazaarsFmt("Bazaar Interaction [Purchase Failed / Inventory Full] - Buyer: {}, Seller: {}, Item: {}", PChar->name, PTarget->name, PBazaarItem->getName());
            }
        }

        return;
    }

    // Obtain the players gil
    CItem* PCharGil = PBuyerInventory->GetItem(0);
    if (PCharGil == nullptr || !PCharGil->isType(ITEM_CURRENCY) || PCharGil->getReserve() > 0)
    {
        // Player has no gil
        PChar->pushPacket<CBazaarPurchasePacket>(PTarget, false);
        return;
    }

    if ((PBazaarItem->getCharPrice() != 0) && (PBazaarItem->getQuantity() >= Quantity))
    {
        uint32 Price        = (PBazaarItem->getCharPrice() * Quantity);
        uint32 PriceWithTax = (PChar->loc.zone->GetTax() * Price) / 10000 + Price;

        // Validate this player can afford said item
        if (PCharGil->getQuantity() < PriceWithTax)
        {
            PChar->pushPacket<CBazaarPurchasePacket>(PTarget, false);

            // Exploit attempt
            ShowWarningFmt("Bazaar Interaction [Insufficient Gil] - Buyer: {}, Seller: {}, Buyer Gil: {}, Price: {}", PChar->name, PTarget->name, PCharGil->getQuantity(), PriceWithTax);

            return;
        }

        CItem* PItem = itemutils::GetItem(PBazaarItem);

        PItem->setCharPrice(0);
        PItem->setQuantity(Quantity);
        PItem->setSubType(ITEM_UNLOCKED);

        if (charutils::AddItem(PChar, LOC_INVENTORY, PItem) == ERROR_SLOTID)
        {
            return;
        }

        charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -(int32)PriceWithTax);
        charutils::UpdateItem(PTarget, LOC_INVENTORY, 0, Price);

        PChar->pushPacket<CBazaarPurchasePacket>(PTarget, true);

        PTarget->pushPacket<CBazaarConfirmationPacket>(PChar, PItem);

        charutils::UpdateItem(PTarget, LOC_INVENTORY, SlotID, -Quantity);

        PTarget->pushPacket<CInventoryItemPacket>(PBazaar->GetItem(SlotID), LOC_INVENTORY, SlotID);
        PTarget->pushPacket<CInventoryFinishPacket>();

        DebugBazaarsFmt("Bazaar Interaction [Purchase Successful] - Buyer: {}, Seller: {}, Item: {}, Qty: {}, Cost: {}", PChar->name, PTarget->name, PItem->getName(), Quantity, PriceWithTax);

        bool BazaarIsEmpty = true;

        for (uint8 BazaarSlotID = 1; BazaarSlotID <= PBazaar->GetSize(); ++BazaarSlotID)
        {
            PItem = PBazaar->GetItem(BazaarSlotID);

            if ((PItem != nullptr) && (PItem->getCharPrice() != 0))
            {
                BazaarIsEmpty = false;
                break;
            }
        }
        for (std::size_t i = 0; i < PTarget->BazaarCustomers.size(); ++i)
        {
            CCharEntity* PCustomer = (CCharEntity*)PTarget->GetEntity(PTarget->BazaarCustomers[i].targid, TYPE_PC);

            if (PCustomer != nullptr && PCustomer->id == PTarget->BazaarCustomers[i].id)
            {
                if (PCustomer->id != PChar->id)
                {
                    PCustomer->pushPacket<CBazaarConfirmationPacket>(PChar, SlotID, Quantity);
                }
                PCustomer->pushPacket<CBazaarItemPacket>(PBazaar->GetItem(SlotID), SlotID, PChar->loc.zone->GetTax());

                if (BazaarIsEmpty)
                {
                    PCustomer->pushPacket<CBazaarClosePacket>(PTarget);

                    DebugBazaarsFmt("Bazaar Interaction [Bazaar Emptied] - Buyer: {}, Seller: {}", PChar->name, PTarget->name);
                }
            }
        }
        if (BazaarIsEmpty)
        {
            PTarget->updatemask |= UPDATE_HP;
        }
        return;
    }
    PChar->pushPacket<CBazaarPurchasePacket>(PTarget, false);
}

/************************************************************************
 *                                                                       *
 *  Bazaar (Exit Price Setting)                                          *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x109(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    if (PChar->isSettingBazaarPrices)
    {
        PChar->isSettingBazaarPrices = false;
        PChar->updatemask |= UPDATE_HP;
    }
}

/************************************************************************
 *                                                                       *
 *  Bazaar (Set Price)                                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x10A(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint8  slotID = data.ref<uint8>(0x04);
    uint32 price  = data.ref<uint32>(0x08);

    auto* PStorage = PChar->getStorage(LOC_INVENTORY);
    if (PStorage == nullptr)
    {
        return;
    }

    CItem* PItem = PStorage->GetItem(slotID);
    if (PItem == nullptr)
    {
        return;
    }

    if (PItem->getReserve() > 0)
    {
        ShowError("SmallPacket0x10A: Player %s trying to bazaar a RESERVED item! [Item: %i | Slot ID: %i] ", PChar->getName(), PItem->getID(),
                  slotID);
        return;
    }

    if ((PItem != nullptr) && !(PItem->getFlag() & ITEM_FLAG_EX) && (!PItem->isSubType(ITEM_LOCKED) || PItem->getCharPrice() != 0))
    {
        _sql->Query("UPDATE char_inventory SET bazaar = %u WHERE charid = %u AND location = 0 AND slot = %u", price, PChar->id, slotID);

        PItem->setCharPrice(price);
        PItem->setSubType((price == 0 ? ITEM_UNLOCKED : ITEM_LOCKED));

        PChar->pushPacket<CInventoryItemPacket>(PItem, LOC_INVENTORY, slotID);
        PChar->pushPacket<CInventoryFinishPacket>();

        DebugBazaarsFmt("Bazaar Interaction [Price Set] - Character: {}, Item: {}, Price: {}", PChar->name, PItem->getName(), price);
    }
}

/************************************************************************
 *                                                                        *
 *  Opening "Set Prices" in bazaar-menu, closing the bazaar                 *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x10B(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    for (std::size_t i = 0; i < PChar->BazaarCustomers.size(); ++i)
    {
        CCharEntity* PCustomer = (CCharEntity*)PChar->GetEntity(PChar->BazaarCustomers[i].targid, TYPE_PC);

        if (PCustomer != nullptr && PCustomer->id == PChar->BazaarCustomers[i].id)
        {
            PCustomer->pushPacket<CBazaarClosePacket>(PChar);

            DebugBazaarsFmt("Bazaar Interaction [Leave Bazaar] - Buyer: {}, Seller: {}", PCustomer->name, PChar->name);
        }
    }
    PChar->BazaarCustomers.clear();

    PChar->isSettingBazaarPrices = true;
    PChar->updatemask |= UPDATE_HP;

    DebugBazaarsFmt("Bazaar Interaction [Setting Prices] - Character: {}", PChar->name);
}

/************************************************************************
 *                                                                        *
 *  Eminence Record Start                                                  *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x10C(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (settings::get<bool>("main.ENABLE_ROE"))
    {
        uint16 recordID = data.ref<uint32>(0x04);
        roeutils::AddEminenceRecord(PChar, recordID);
        PChar->pushPacket<CRoeSparkUpdatePacket>(PChar);
        roeutils::onRecordTake(PChar, recordID);
    }
}

/************************************************************************
 *                                                                        *
 *  Eminence Record Drop                                                  *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x10D(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (settings::get<bool>("main.ENABLE_ROE"))
    {
        roeutils::DelEminenceRecord(PChar, data.ref<uint32>(0x04));
        PChar->pushPacket<CRoeSparkUpdatePacket>(PChar);
    }
}

/************************************************************************
 *                                                                        *
 *  Claim completed eminence record                                       *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x10E(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (settings::get<bool>("main.ENABLE_ROE"))
    {
        uint16 recordID = data.ref<uint16>(0x04);
        roeutils::onRecordClaim(PChar, recordID);
    }
}

/************************************************************************
 *                                                                        *
 *  Request Currency1 tab                                                 *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x10F(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->pushPacket<CCurrencyPacket1>(PChar);
}

/************************************************************************
 *                                                                       *
 *  Fishing (New)                                                        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x110(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (settings::get<bool>("map.FISHING_ENABLE") && PChar->GetMLevel() >= settings::get<uint8>("map.FISHING_MIN_LEVEL"))
    {
        fishingutils::HandleFishingAction(PChar, data);
    }
}

/************************************************************************
 *                                                                        *
 *  Lock Style Request                                                    *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x111(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    charutils::SetStyleLock(PChar, data.ref<uint8>(0x04));
    PChar->pushPacket<CCharAppearancePacket>(PChar);
}

/************************************************************************
 *                                                                        *
 *  Roe Quest Log Request                                                 *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x112(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    // Send spark updates
    PChar->pushPacket<CRoeSparkUpdatePacket>(PChar);

    if (settings::get<bool>("main.ENABLE_ROE"))
    {
        // Current RoE quests
        PChar->pushPacket<CRoeUpdatePacket>(PChar);

        // Players logging in to a new timed record get one-time message
        if (PChar->m_eminenceCache.notifyTimedRecord)
        {
            PChar->m_eminenceCache.notifyTimedRecord = false;
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, roeutils::GetActiveTimedRecord(), 0, MSGBASIC_ROE_TIMED);
        }

        // 4-part Eminence Completion bitmap
        for (int i = 0; i < 4; i++)
        {
            PChar->pushPacket<CRoeQuestLogPacket>(PChar, i);
        }
    }
}

/************************************************************************
 *                                                                       *
 *  /sitchair                                                            *
 *                                                                       *
 ************************************************************************/
void SmallPacket0x113(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    if (PChar->status != STATUS_TYPE::NORMAL)
    {
        return;
    }

    if (PChar->StatusEffectContainer->HasPreventActionEffect())
    {
        return;
    }

    uint8 type = data.ref<uint8>(0x04);
    if (type == 2)
    {
        PChar->animation = ANIMATION_NONE;
        PChar->updatemask |= UPDATE_HP;
        return;
    }

    uint8 chairId = data.ref<uint8>(0x08) + ANIMATION_SITCHAIR_0;
    if (chairId < 63 || chairId > 83)
    {
        return;
    }

    // Validate key item ownership for 64 through 83
    if (chairId != 63 && !charutils::hasKeyItem(PChar, chairId + 0xACA))
    {
        chairId = ANIMATION_SITCHAIR_0;
    }

    PChar->animation = PChar->animation == chairId ? (uint8)ANIMATION_NONE : chairId;
    PChar->updatemask |= UPDATE_HP;
}

/************************************************************************
 *                                                                       *
 *  Map Marker Request Packet                                            *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x114(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->pushPacket<CMapMarkerPacket>(PChar);
}

/************************************************************************
 *                                                                        *
 *  Request Currency2 tab                                                  *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x115(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->pushPacket<CCurrencyPacket2>(PChar);
}

/************************************************************************
 *                                                                        *
 *  Unity Menu Packet (Possibly incomplete)                               *
 *  This stub only handles the needed RoE updates.                        *
 *                                                                        *
 ************************************************************************/
void SmallPacket0x116(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->pushPacket<CRoeSparkUpdatePacket>(PChar);
    PChar->pushPacket<CMenuUnityPacket>(PChar);
}

/************************************************************************
 *                                                                        *
 *  Unity Rankings Menu Packet (Possibly incomplete)                      *
 *  This stub only handles the needed RoE updates.                        *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x117(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->pushPacket<CRoeSparkUpdatePacket>(PChar);
    PChar->pushPacket<CMenuUnityPacket>(PChar);
}

/************************************************************************
 *                                                                        *
 *  Unity Chat Toggle                                                     *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x118(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    bool active = data.ref<uint8>(0x04);
    if (PChar->PUnityChat)
    {
        unitychat::DelOnlineMember(PChar, PChar->PUnityChat->getLeader());
    }
    if (active)
    {
        unitychat::AddOnlineMember(PChar, PChar->profile.unity_leader);
    }
}

/************************************************************************
 *                                                                        *
 *  Request Emote List                                                    *
 *                                                                        *
 ************************************************************************/
void SmallPacket0x119(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    PChar->pushPacket<CCharEmoteListPacket>(PChar);
}

/************************************************************************
 *                                                                        *
 *  Set Job Master Display                                                *
 *                                                                        *
 ************************************************************************/
void SmallPacket0x11B(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    PChar->m_jobMasterDisplay = data.ref<uint8>(0x04) > 0;

    charutils::SaveJobMasterDisplay(PChar);
    PChar->pushPacket<CCharUpdatePacket>(PChar);
}

/************************************************************************
 *                                                                       *
 *  Jump (/jump)                                                         *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x11D(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (jailutils::InPrison(PChar))
    {
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
        return;
    }

    auto const& targetIndex = data.ref<uint16>(0x08);
    auto const& extra       = data.ref<uint16>(0x0A);

    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CCharEmotionJumpPacket>(PChar, targetIndex, extra));
}

/************************************************************************
 *                                                                       *
 *  Packet Array Initialization                                          *
 *                                                                       *
 ************************************************************************/

void PacketParserInitialize()
{
    TracyZoneScoped;
    for (uint16 i = 0; i < 512; ++i)
    {
        PacketSize[i]   = 0;
        PacketParser[i] = &SmallPacket0x000;
    }
    // clang-format off
    PacketSize[0x00A] = 0x2E; PacketParser[0x00A] = &SmallPacket0x00A;
    PacketSize[0x00C] = 0x00; PacketParser[0x00C] = &SmallPacket0x00C;
    PacketSize[0x00D] = 0x04; PacketParser[0x00D] = &SmallPacket0x00D;
    PacketSize[0x00F] = 0x00; PacketParser[0x00F] = &SmallPacket0x00F;
    PacketSize[0x011] = 0x00; PacketParser[0x011] = &SmallPacket0x011;
    PacketSize[0x015] = 0x10; PacketParser[0x015] = &SmallPacket0x015;
    PacketSize[0x016] = 0x04; PacketParser[0x016] = &SmallPacket0x016;
    PacketSize[0x017] = 0x00; PacketParser[0x017] = &SmallPacket0x017;
    PacketSize[0x01A] = 0x0E; PacketParser[0x01A] = &SmallPacket0x01A;
    PacketSize[0x01B] = 0x00; PacketParser[0x01B] = &SmallPacket0x01B;
    PacketSize[0x01C] = 0x00; PacketParser[0x01C] = &SmallPacket0x01C;
    PacketSize[0x01E] = 0x00; PacketParser[0x01E] = &SmallPacket0x01E;
    PacketSize[0x028] = 0x06; PacketParser[0x028] = &SmallPacket0x028;
    PacketSize[0x029] = 0x06; PacketParser[0x029] = &SmallPacket0x029;
    PacketSize[0x032] = 0x06; PacketParser[0x032] = &SmallPacket0x032;
    PacketSize[0x033] = 0x06; PacketParser[0x033] = &SmallPacket0x033;
    PacketSize[0x034] = 0x06; PacketParser[0x034] = &SmallPacket0x034;
    PacketSize[0x036] = 0x20; PacketParser[0x036] = &SmallPacket0x036;
    PacketSize[0x037] = 0x0A; PacketParser[0x037] = &SmallPacket0x037;
    PacketSize[0x03A] = 0x04; PacketParser[0x03A] = &SmallPacket0x03A;
    PacketSize[0x03B] = 0x10; PacketParser[0x03B] = &SmallPacket0x03B;
    PacketSize[0x03C] = 0x00; PacketParser[0x03C] = &SmallPacket0x03C;
    PacketSize[0x03D] = 0x00; PacketParser[0x03D] = &SmallPacket0x03D;
    PacketSize[0x041] = 0x00; PacketParser[0x041] = &SmallPacket0x041;
    PacketSize[0x042] = 0x00; PacketParser[0x042] = &SmallPacket0x042;
    PacketSize[0x04B] = 0x00; PacketParser[0x04B] = &SmallPacket0x04B;
    PacketSize[0x04D] = 0x00; PacketParser[0x04D] = &SmallPacket0x04D;
    PacketSize[0x04E] = 0x1E; PacketParser[0x04E] = &SmallPacket0x04E;
    PacketSize[0x050] = 0x04; PacketParser[0x050] = &SmallPacket0x050;
    PacketSize[0x051] = 0x24; PacketParser[0x051] = &SmallPacket0x051;
    PacketSize[0x052] = 0x26; PacketParser[0x052] = &SmallPacket0x052;
    PacketSize[0x053] = 0x44; PacketParser[0x053] = &SmallPacket0x053;
    PacketSize[0x058] = 0x0A; PacketParser[0x058] = &SmallPacket0x058;
    PacketSize[0x059] = 0x00; PacketParser[0x059] = &SmallPacket0x059;
    PacketSize[0x05A] = 0x02; PacketParser[0x05A] = &SmallPacket0x05A;
    PacketSize[0x05B] = 0x0A; PacketParser[0x05B] = &SmallPacket0x05B;
    PacketSize[0x05C] = 0x00; PacketParser[0x05C] = &SmallPacket0x05C;
    PacketSize[0x05D] = 0x08; PacketParser[0x05D] = &SmallPacket0x05D;
    PacketSize[0x05E] = 0x0C; PacketParser[0x05E] = &SmallPacket0x05E;
    PacketSize[0x060] = 0x00; PacketParser[0x060] = &SmallPacket0x060;
    PacketSize[0x061] = 0x04; PacketParser[0x061] = &SmallPacket0x061;
    PacketSize[0x063] = 0x00; PacketParser[0x063] = &SmallPacket0x063;
    PacketSize[0x064] = 0x26; PacketParser[0x064] = &SmallPacket0x064;
    PacketSize[0x066] = 0x0A; PacketParser[0x066] = &SmallPacket0x066;
    PacketSize[0x06E] = 0x06; PacketParser[0x06E] = &SmallPacket0x06E;
    PacketSize[0x06F] = 0x00; PacketParser[0x06F] = &SmallPacket0x06F;
    PacketSize[0x070] = 0x00; PacketParser[0x070] = &SmallPacket0x070;
    PacketSize[0x071] = 0x00; PacketParser[0x071] = &SmallPacket0x071;
    PacketSize[0x074] = 0x00; PacketParser[0x074] = &SmallPacket0x074;
    PacketSize[0x076] = 0x00; PacketParser[0x076] = &SmallPacket0x076;
    PacketSize[0x077] = 0x00; PacketParser[0x077] = &SmallPacket0x077;
    PacketSize[0x078] = 0x00; PacketParser[0x078] = &SmallPacket0x078;
    PacketSize[0x083] = 0x08; PacketParser[0x083] = &SmallPacket0x083;
    PacketSize[0x084] = 0x06; PacketParser[0x084] = &SmallPacket0x084;
    PacketSize[0x085] = 0x04; PacketParser[0x085] = &SmallPacket0x085;
    PacketSize[0x096] = 0x12; PacketParser[0x096] = &SmallPacket0x096;
    PacketSize[0x09B] = 0x00; PacketParser[0x09B] = &SmallPacket0x09B;
    PacketSize[0x0A0] = 0x00; PacketParser[0x0A0] = &SmallPacket0xFFF_NOT_IMPLEMENTED;
    PacketSize[0x0A1] = 0x00; PacketParser[0x0A1] = &SmallPacket0xFFF_NOT_IMPLEMENTED;
    PacketSize[0x0A2] = 0x00; PacketParser[0x0A2] = &SmallPacket0x0A2;
    PacketSize[0x0AA] = 0x00; PacketParser[0x0AA] = &SmallPacket0x0AA;
    PacketSize[0x0AB] = 0x00; PacketParser[0x0AB] = &SmallPacket0x0AB;
    PacketSize[0x0AC] = 0x00; PacketParser[0x0AC] = &SmallPacket0x0AC;
    PacketSize[0x0AD] = 0x00; PacketParser[0x0AD] = &SmallPacket0x0AD;
    PacketSize[0x0B5] = 0x00; PacketParser[0x0B5] = &SmallPacket0x0B5;
    PacketSize[0x0B6] = 0x00; PacketParser[0x0B6] = &SmallPacket0x0B6;
    PacketSize[0x0BE] = 0x00; PacketParser[0x0BE] = &SmallPacket0x0BE;
    PacketSize[0x0BF] = 0x00; PacketParser[0x0BF] = &SmallPacket0x0BF;
    PacketSize[0x0C0] = 0x00; PacketParser[0x0C0] = &SmallPacket0x0C0;
    PacketSize[0x0C3] = 0x00; PacketParser[0x0C3] = &SmallPacket0x0C3;
    PacketSize[0x0C4] = 0x0E; PacketParser[0x0C4] = &SmallPacket0x0C4;
    PacketSize[0x0CB] = 0x04; PacketParser[0x0CB] = &SmallPacket0x0CB;
    PacketSize[0x0D2] = 0x00; PacketParser[0x0D2] = &SmallPacket0x0D2;
    PacketSize[0x0D3] = 0x00; PacketParser[0x0D3] = &SmallPacket0x0D3;
    PacketSize[0x0D4] = 0x00; PacketParser[0x0D4] = &SmallPacket0xFFF_NOT_IMPLEMENTED;
    PacketSize[0x0DB] = 0x00; PacketParser[0x0DB] = &SmallPacket0x0DB;
    PacketSize[0x0DC] = 0x0A; PacketParser[0x0DC] = &SmallPacket0x0DC;
    PacketSize[0x0DD] = 0x08; PacketParser[0x0DD] = &SmallPacket0x0DD;
    PacketSize[0x0DE] = 0x40; PacketParser[0x0DE] = &SmallPacket0x0DE;
    PacketSize[0x0E0] = 0x4C; PacketParser[0x0E0] = &SmallPacket0x0E0;
    PacketSize[0x0E1] = 0x00; PacketParser[0x0E1] = &SmallPacket0x0E1;
    PacketSize[0x0E2] = 0x00; PacketParser[0x0E2] = &SmallPacket0x0E2;
    PacketSize[0x0E7] = 0x04; PacketParser[0x0E7] = &SmallPacket0x0E7;
    PacketSize[0x0E8] = 0x04; PacketParser[0x0E8] = &SmallPacket0x0E8;
    PacketSize[0x0EA] = 0x00; PacketParser[0x0EA] = &SmallPacket0x0EA;
    PacketSize[0x0EB] = 0x00; PacketParser[0x0EB] = &SmallPacket0x0EB;
    PacketSize[0x0F1] = 0x00; PacketParser[0x0F1] = &SmallPacket0x0F1;
    PacketSize[0x0F2] = 0x00; PacketParser[0x0F2] = &SmallPacket0x0F2;
    PacketSize[0x0F4] = 0x04; PacketParser[0x0F4] = &SmallPacket0x0F4;
    PacketSize[0x0F5] = 0x00; PacketParser[0x0F5] = &SmallPacket0x0F5;
    PacketSize[0x0F6] = 0x00; PacketParser[0x0F6] = &SmallPacket0x0F6;
    PacketSize[0x0FA] = 0x00; PacketParser[0x0FA] = &SmallPacket0x0FA;
    PacketSize[0x0FB] = 0x00; PacketParser[0x0FB] = &SmallPacket0x0FB;
    PacketSize[0x0FC] = 0x00; PacketParser[0x0FC] = &SmallPacket0x0FC;
    PacketSize[0x0FD] = 0x00; PacketParser[0x0FD] = &SmallPacket0x0FD;
    PacketSize[0x0FE] = 0x00; PacketParser[0x0FE] = &SmallPacket0x0FE;
    PacketSize[0x0FF] = 0x00; PacketParser[0x0FF] = &SmallPacket0x0FF;
    PacketSize[0x100] = 0x04; PacketParser[0x100] = &SmallPacket0x100;
    PacketSize[0x102] = 0x52; PacketParser[0x102] = &SmallPacket0x102;
    PacketSize[0x104] = 0x02; PacketParser[0x104] = &SmallPacket0x104;
    PacketSize[0x105] = 0x06; PacketParser[0x105] = &SmallPacket0x105;
    PacketSize[0x106] = 0x06; PacketParser[0x106] = &SmallPacket0x106;
    PacketSize[0x109] = 0x00; PacketParser[0x109] = &SmallPacket0x109;
    PacketSize[0x10A] = 0x06; PacketParser[0x10A] = &SmallPacket0x10A;
    PacketSize[0x10B] = 0x00; PacketParser[0x10B] = &SmallPacket0x10B;
    PacketSize[0x10C] = 0x04; PacketParser[0x10C] = &SmallPacket0x10C;
    PacketSize[0x10D] = 0x04; PacketParser[0x10D] = &SmallPacket0x10D;
    PacketSize[0x10E] = 0x04; PacketParser[0x10E] = &SmallPacket0x10E;
    PacketSize[0x10F] = 0x02; PacketParser[0x10F] = &SmallPacket0x10F;
    PacketSize[0x110] = 0x0A; PacketParser[0x110] = &SmallPacket0x110;
    PacketSize[0x111] = 0x00; PacketParser[0x111] = &SmallPacket0x111;
    PacketSize[0x112] = 0x00; PacketParser[0x112] = &SmallPacket0x112;
    PacketSize[0x113] = 0x06; PacketParser[0x113] = &SmallPacket0x113;
    PacketSize[0x114] = 0x00; PacketParser[0x114] = &SmallPacket0x114;
    PacketSize[0x115] = 0x02; PacketParser[0x115] = &SmallPacket0x115;
    PacketSize[0x116] = 0x00; PacketParser[0x116] = &SmallPacket0x116;
    PacketSize[0x117] = 0x00; PacketParser[0x117] = &SmallPacket0x117;
    PacketSize[0x118] = 0x00; PacketParser[0x118] = &SmallPacket0x118;
    PacketSize[0x119] = 0x00; PacketParser[0x119] = &SmallPacket0x119;
    PacketSize[0x11B] = 0x00; PacketParser[0x11B] = &SmallPacket0x11B;
    PacketSize[0x11D] = 0x00; PacketParser[0x11D] = &SmallPacket0x11D;
    // clang-format on
}
