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

#include "ai/ai_container.h"
#include "ai/states/death_state.h"
#include "alliance.h"
#include "campaign_system.h"
#include "conquest_system.h"
#include "enmity_container.h"
#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "entities/npcentity.h"
#include "entities/trustentity.h"
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
#include "utils/battleutils.h"
#include "utils/blacklistutils.h"
#include "utils/blueutils.h"
#include "utils/charutils.h"
#include "utils/fishingutils.h"
#include "utils/gardenutils.h"
#include "utils/itemutils.h"
#include "utils/jailutils.h"
#include "utils/petutils.h"
#include "utils/puppetutils.h"
#include "utils/synthutils.h"
#include "utils/zoneutils.h"
#include "zone.h"

#include "items/item_flowerpot.h"
#include "items/item_shop.h"

#include "lua/luautils.h"

#include "packets/auction_house.h"
#include "packets/basic.h"
#include "packets/bazaar_check.h"
#include "packets/bazaar_close.h"
#include "packets/bazaar_confirmation.h"
#include "packets/bazaar_item.h"
#include "packets/bazaar_message.h"
#include "packets/bazaar_purchase.h"
#include "packets/blacklist.h"
#include "packets/campaign_map.h"
#include "packets/change_music.h"
#include "packets/char.h"
#include "packets/char_abilities.h"
#include "packets/char_appearance.h"
#include "packets/char_check.h"
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
#include "packets/delivery_box.h"
#include "packets/downloading_data.h"
#include "packets/entity_update.h"
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
#include "packets/server_ip.h"
#include "packets/server_message.h"
#include "packets/shop_appraise.h"
#include "packets/shop_buy.h"
#include "packets/status_effects.h"
#include "packets/stop_downloading.h"
#include "packets/synth_suggestion.h"
#include "packets/trade_action.h"
#include "packets/trade_item.h"
#include "packets/trade_request.h"
#include "packets/trade_update.h"
#include "packets/wide_scan_track.h"
#include "packets/world_pass.h"
#include "packets/zone_in.h"
#include "packets/zone_visited.h"

uint8 PacketSize[512];

std::function<void(map_session_data_t* const, CCharEntity* const, CBasicPacket&)> PacketParser[512];

/************************************************************************
 *                                                                       *
 *  Display the contents of the incoming packet to the console.          *
 *                                                                       *
 ************************************************************************/

void PrintPacket(CBasicPacket data)
{
    std::string message;
    char        buffer[5];

    for (size_t y = 0; y < data.getSize(); y++)
    {
        std::memset(buffer, 0, sizeof(buffer));                               // TODO: Replace these three lines with std::format when/if we move to C++ 20.
        snprintf(buffer, sizeof(buffer), "%02hhx ", *((uint8*)data[(int)y])); //
        message.append(buffer);                                               //

        if (((y + 1) % 16) == 0)
        {
            message += "\n";
            ShowDebug(message.c_str());
            message.clear();
        }
    }

    if (message.length() > 0)
    {
        message += "\n";
        ShowDebug(message.c_str());
    }
}

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

void SmallPacket0xFFF(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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

    if (PSession->blowfish.status == BLOWFISH_WAITING) // Generate new blowfish session, call zone in, etc, only once.
    {
        PChar->clearPacketList();

        if (PChar->loc.zone != nullptr)
        {
            // Remove the char from previous zone, and unset shuttingDown (already in next zone)
            auto basicPacket = CBasicPacket();
            PacketParser[0x00D](PSession, PChar, basicPacket);
        }

        PSession->shuttingDown = 0;
        PSession->blowfish.key[4] += 2;
        PSession->blowfish.status = BLOWFISH_SENT;

        md5((uint8*)(PSession->blowfish.key), PSession->blowfish.hash, 20);

        for (uint32 i = 0; i < 16; ++i)
        {
            if (PSession->blowfish.hash[i] == 0)
            {
                memset(PSession->blowfish.hash + i, 0, 16 - i);
                break;
            }
        }
        blowfish_init((int8*)PSession->blowfish.hash, 16, PSession->blowfish.P, PSession->blowfish.S[0]);

        char session_key[20 * 2 + 1];
        bin2hex(session_key, (uint8*)PSession->blowfish.key, 20);

        uint16 destination = PChar->loc.destination;
        CZone* destZone    = zoneutils::GetZone(destination);

        if (destination >= MAX_ZONEID || destZone == nullptr)
        {
            // TODO: work out how to drop player in moghouse that exits them to the zone they were in before this happened, like we used to.
            ShowWarning("packet_system::SmallPacket0x00A player tried to enter zone out of range: %d", destination);
            ShowWarning("packet_system::SmallPacket0x00A dumping player `%s` to homepoint!", PChar->getName());
            charutils::HomePoint(PChar);
        }

        destZone->IncreaseZoneCounter(PChar);

        PChar->m_ZonesList[PChar->getZone() >> 3] |= (1 << (PChar->getZone() % 8));

        const char* fmtQuery = "UPDATE accounts_sessions SET targid = %u, session_key = x'%s', server_addr = %u, client_port = %u WHERE charid = %u";

        // Current zone could either be current zone or destination
        CZone* currentZone = zoneutils::GetZone(PChar->getZone());

        if (currentZone == nullptr)
        {
            ShowWarning("currentZone was null for Zone ID %d.", PChar->getZone());
            return;
        }

        sql->Query(fmtQuery, PChar->targid, session_key, currentZone->GetIP(), PSession->client_port, PChar->id);

        fmtQuery  = "SELECT death FROM char_stats WHERE charid = %u;";
        int32 ret = sql->Query(fmtQuery, PChar->id);
        if (sql->NextRow() == SQL_SUCCESS)
        {
            // Update the character's death timestamp based off of how long they were previously dead
            uint32 secondsSinceDeath = sql->GetUIntData(0);
            if (PChar->health.hp == 0)
            {
                PChar->SetDeathTimestamp((uint32)time(nullptr) - secondsSinceDeath);
                PChar->Die(CCharEntity::death_duration - std::chrono::seconds(secondsSinceDeath));
            }
        }

        fmtQuery = "SELECT pos_prevzone FROM chars WHERE charid = %u";
        ret      = sql->Query(fmtQuery, PChar->id);
        if (ret != SQL_ERROR && sql->NextRow() == SQL_SUCCESS)
        {
            if (PChar->getZone() == sql->GetUIntData(0))
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
                            PChar->pushPacket(new CInventoryCountPacket(safeContainerId, slotIndex, headId, bodyId, handsId, legId, feetId, mainId, subId, rangeId));
                        }
                    }
                }
            }
        }

        PChar->pushPacket(new CDownloadingDataPacket());
        PChar->pushPacket(new CZoneInPacket(PChar, PChar->currentEvent));
        PChar->pushPacket(new CZoneVisitedPacket(PChar));
    }
}

/************************************************************************
 *                                                                       *
 *  Character Information Request                                        *
 *  Occurs while player is zoning or entering the game.                  *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x00C(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->pushPacket(new CInventorySizePacket(PChar));
    PChar->pushPacket(new CMenuConfigPacket(PChar));
    PChar->pushPacket(new CCharJobsPacket(PChar));

    if (charutils::hasKeyItem(PChar, 2544))
    {
        // Only send Job Points Packet if the player has unlocked them
        PChar->pushPacket(new CJobPointDetailsPacket(PChar));
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
 *                                                                       *
 ************************************************************************/

void SmallPacket0x00D(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    std::ignore = data;

    if (PChar->status == STATUS_TYPE::DISAPPEAR && (PSession->blowfish.status == BLOWFISH_WAITING || PSession->blowfish.status == BLOWFISH_SENT)) // Character has already requested to zone, do nothing.
    {
        return;
    }

    PSession->blowfish.status = BLOWFISH_WAITING;

    PChar->TradePending.clean();
    PChar->InvitePending.clean();
    PChar->PWideScanTarget = nullptr;

    if (PChar->animation == ANIMATION_ATTACK)
    {
        PChar->animation = ANIMATION_NONE;
        PChar->updatemask |= UPDATE_HP;
    }

    if (!PChar->PTrusts.empty())
    {
        PChar->ClearTrusts();
    }

    if (PChar->status == STATUS_TYPE::SHUTDOWN)
    {
        if (PChar->PParty != nullptr)
        {
            if (PChar->PParty->m_PAlliance != nullptr)
            {
                if (PChar->PParty->GetLeader() == PChar)
                {
                    if (PChar->PParty->HasOnlyOneMember())
                    {
                        if (PChar->PParty->m_PAlliance->hasOnlyOneParty())
                        {
                            PChar->PParty->m_PAlliance->dissolveAlliance();
                        }
                        else
                        {
                            PChar->PParty->m_PAlliance->removeParty(PChar->PParty);
                        }
                    }
                    else
                    { // party leader logged off - will pass party lead
                        PChar->PParty->RemoveMember(PChar);
                    }
                }
                else
                { // not party leader - just drop from party
                    PChar->PParty->RemoveMember(PChar);
                }
            }
            else
            {
                // normal party - just drop group
                PChar->PParty->RemoveMember(PChar);
            }
        }

        if (PChar->shouldPetPersistThroughZoning())
        {
            PChar->setPetZoningInfo();
        }
        else
        {
            PChar->resetPetZoningInfo();
        }

        PSession->shuttingDown = 1;
        sql->Query("UPDATE char_stats SET zoning = 0 WHERE charid = %u", PChar->id);
    }
    else
    {
        PSession->shuttingDown = 2;
        sql->Query("UPDATE char_stats SET zoning = 1 WHERE charid = %u", PChar->id);
        charutils::CheckEquipLogic(PChar, SCRIPT_CHANGEZONE, PChar->getZone());

        if (PChar->CraftContainer->getItemsCount() > 0 && PChar->animation == ANIMATION_SYNTH)
        {
            // NOTE:
            // Supposed non-losable items are reportely lost if this condition is met:
            // https://ffxiclopedia.fandom.com/wiki/Lu_Shang%27s_Fishing_Rod
            // The broken rod can never be lost in a normal failed synth. It will only be lost if the synth is
            // interrupted in some way, such as by being attacked or moving to another area (e.g. ship docking).

            ShowWarning("SmallPacket0x00D: %s attempting to zone in the middle of a synth, failing their synth!", PChar->getName());
            synthutils::doSynthFail(PChar);
        }
    }

    if (PChar->loc.zone != nullptr)
    {
        PChar->loc.zone->DecreaseZoneCounter(PChar);
    }

    PChar->PersistData();
    charutils::SaveCharStats(PChar);
    charutils::SaveCharExp(PChar, PChar->GetMJob());
    charutils::SaveEminenceData(PChar);

    PChar->status = STATUS_TYPE::DISAPPEAR;
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

    PChar->pushPacket(new CCharSpellsPacket(PChar));
    PChar->pushPacket(new CCharMountsPacket(PChar));
    PChar->pushPacket(new CCharAbilitiesPacket(PChar));
    PChar->pushPacket(new CCharSyncPacket(PChar));
    PChar->pushPacket(new CBazaarMessagePacket(PChar));
    PChar->pushPacket(new CMeritPointsCategoriesPacket(PChar));

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
            PChar->pushPacket(new CEquipPacket(PChar->equip[i], i, PChar->equipLoc[i]));
        }
    }

    PChar->PAI->QueueAction(queueAction_t(4000ms, false, zoneutils::AfterZoneIn));

    // todo: kill player til theyre dead and bsod
    const char* fmtQuery = "SELECT version_mismatch FROM accounts_sessions WHERE charid = %u";
    int32       ret      = sql->Query(fmtQuery, PChar->id);
    if (ret != SQL_ERROR && sql->NextRow() == SQL_SUCCESS)
    {
        // On zone change, only sending a version message if mismatch
        // if ((bool)sql->GetUIntData(0))
        // PChar->pushPacket(new CChatMessagePacket(PChar, CHAT_MESSAGE_TYPE::MESSAGE_SYSTEM_1, "Server does not support this client version."));
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

        if (PChar->PWideScanTarget != nullptr)
        {
            PChar->pushPacket(new CWideScanTrackPacket(PChar->PWideScanTarget));

            if (PChar->PWideScanTarget->status == STATUS_TYPE::DISAPPEAR)
            {
                PChar->PWideScanTarget = nullptr;
            }
        }
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
        PChar->pushPacket(new CCharUpdatePacket(PChar));
    }
    else
    {
        CBaseEntity* PEntity = PChar->GetEntity(targid, TYPE_NPC | TYPE_PC);

        if (PEntity && PEntity->objtype == TYPE_PC)
        {
            PChar->updateCharPacket((CCharEntity*)PEntity, ENTITY_SPAWN, UPDATE_ALL_CHAR);
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
                // Using the same logic as in ZoneEntities::SpawnMoogle:
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

            if (PChar->m_Costume != 0 || PChar->animation == ANIMATION_SYNTH)
            {
                PChar->pushPacket(new CReleasePacket(PChar, RELEASE_TYPE::STANDARD));
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
                PChar->pushPacket(new CReleasePacket(PChar, RELEASE_TYPE::STANDARD));
                return;
            }

            // NOTE: Moogles inside of mog houses are the exception for not requiring Spawned or Status checks.
            if (PNpc != nullptr && distance(PNpc->loc.p, PChar->loc.p) <= 10 && ((PNpc->PAI->IsSpawned() && PNpc->status == STATUS_TYPE::NORMAL) || PChar->m_moghouseID != 0))
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
                PChar->pushPacket(new CReleasePacket(PChar, RELEASE_TYPE::STANDARD));
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
                    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CMessageBasicPacket(PChar, PChar, 0, 0, 19));
                    return;
                }
            }

            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 22));
        }
        break;
        case 0x07: // weaponskill
        {
            if (!PChar->PAI->IsEngaged() && settings::get<bool>("map.PREVENT_UNENGAGED_WS")) // Prevent Weaponskill usage if player isn't engaged.
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_WS));
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
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA2));
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
            charutils::HomePoint(PChar);
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
            if (!PChar->isMounted())
            {
                return;
            }

            // bunch of gysahl greens
            uint8 slotID = PChar->getStorage(LOC_INVENTORY)->SearchItem(4545);

            if (slotID != ERROR_SLOTID)
            {
                // attempt to dig
                if (luautils::OnChocoboDig(PChar, true))
                {
                    charutils::UpdateItem(PChar, LOC_INVENTORY, slotID, -1);

                    PChar->pushPacket(new CInventoryFinishPacket());
                    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CChocoboDiggingPacket(PChar));

                    // dig is possible
                    luautils::OnChocoboDig(PChar, false);
                }
                else
                {
                    // unable to dig yet
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_WAIT_LONGER));
                }
            }
            else
            {
                // You don't have any gysahl greens
                PChar->pushPacket(new CMessageSystemPacket(4545, 0, 39));
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
            PChar->loc.zone->PushPacket(PChar, CHAR_INZONE, new CCharPacket(PChar, ENTITY_UPDATE, UPDATE_HP));
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
            if (PChar->m_moghouseID != 0)
            {
                PChar->loc.zone->SpawnMoogle(PChar);
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
                    PChar->pushPacket(new CMessageSystemPacket(0, 0, 222));
                    PChar->setBlockingAid(false);
                }
                else if (type == 0x01 && !PChar->getBlockingAid()) // /blockaid on
                {
                    // Blockaid activated
                    PChar->pushPacket(new CMessageSystemPacket(0, 0, 221));
                    PChar->setBlockingAid(true);
                }
                else if (type == 0x02) // /blockaid
                {
                    // Blockaid is currently active/inactive
                    PChar->pushPacket(new CMessageSystemPacket(0, 0, PChar->getBlockingAid() ? 223 : 224));
                }
            }
            else
            {
                PChar->pushPacket(new CMessageSystemPacket(0, 0, 142));
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
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 71));
            }
            else if (!PChar->loc.zone->CanUseMisc(MISC_MOUNT))
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
            }
            else if (PChar->GetMLevel() < 20)
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 20, 0, 773));
            }
            else if (charutils::hasKeyItem(PChar, 3072 + MountID))
            {
                if (PChar->PRecastContainer->HasRecast(RECAST_ABILITY, 256, 60))
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 94));

                    // add recast timer
                    // PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 202));
                    return;
                }

                if (PChar->PNotorietyContainer->hasEnmity())
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 339));
                    return;
                }

                PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(
                                                                  EFFECT_MOUNTED,
                                                                  EFFECT_MOUNTED,
                                                                  MountID ? ++MountID : 0,
                                                                  0,
                                                                  1800,
                                                                  0,
                                                                  FLAG_CHOCOBO),
                                                              true);

                PChar->PRecastContainer->Add(RECAST_ABILITY, 256, 60);
                PChar->pushPacket(new CCharRecastPacket(PChar));

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

    PChar->pushPacket(new CWorldPassPacket(data.ref<uint8>(0x04) & 1 ? (uint32)xirand::GetRandomNumber(9999999999) : 0));
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
    PrintPacket(std::move(data));
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
            PChar->pushPacket(new CMessageStandardPacket(MsgStd::CannotBeProcessed));
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
                PChar->pushPacket(new CInventoryItemPacket(PSlotItem, FromLocationID, slotID));
            }
        }
        PChar->pushPacket(new CInventoryFinishPacket());

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
            return;
        }

        uint8 NewSlotID = PChar->getStorage(ToLocationID)->InsertItem(PItem);

        if (NewSlotID != ERROR_SLOTID)
        {
            const char* Query = "UPDATE char_inventory SET location = %u, slot = %u WHERE charid = %u AND location = %u AND slot = %u;";

            if (sql->Query(Query, ToLocationID, NewSlotID, PChar->id, FromLocationID, FromSlotID) != SQL_ERROR && sql->AffectedRows() != 0)
            {
                PChar->getStorage(FromLocationID)->InsertItem(nullptr, FromSlotID);

                PChar->pushPacket(new CInventoryItemPacket(nullptr, FromLocationID, FromSlotID));
                PChar->pushPacket(new CInventoryItemPacket(PItem, ToLocationID, NewSlotID));
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
                    PChar->pushPacket(new CInventoryItemPacket(PSlotItem, ToLocationID, slotID));
                }
            }
            PChar->pushPacket(new CInventoryFinishPacket());

            ShowError("SmallPacket0x29: Location %u Slot %u is full", ToLocationID, ToSlotID);
            return;
        }
    }
    PChar->pushPacket(new CInventoryFinishPacket());
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
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 155));
            return;
        }

        // If either player is in prison don't allow the trade.
        if (jailutils::InPrison(PChar) || jailutils::InPrison(PTarget))
        {
            PChar->pushPacket(new CTradeActionPacket(PTarget, 0x07));
            return;
        }

        // If either player is crafting, don't allow the trade request
        if (PChar->animation == ANIMATION_SYNTH || PTarget->animation == ANIMATION_SYNTH)
        {
            ShowDebug("%s trade request with %s was blocked.", PChar->getName(), PTarget->getName());
            PChar->pushPacket(new CTradeActionPacket(PTarget, 0x07));
            return;
        }

        // check /blockaid
        if (charutils::IsAidBlocked(PChar, PTarget))
        {
            ShowDebug("%s is blocking trades", PTarget->getName());
            // Target is blocking assistance
            PChar->pushPacket(new CMessageSystemPacket(0, 0, 225));
            // Interaction was blocked
            PTarget->pushPacket(new CMessageSystemPacket(0, 0, 226));
            PChar->pushPacket(new CTradeActionPacket(PTarget, 0x07));
            return;
        }

        if (PTarget->TradePending.id == PChar->id)
        {
            ShowDebug("%s has already sent a trade request to %s", PChar->getName(), PTarget->getName());
            return;
        }

        if (!PTarget->UContainer->IsContainerEmpty())
        {
            PChar->pushPacket(new CTradeActionPacket(PTarget, 0x07));
            ShowDebug("%s's UContainer is not empty. %s cannot trade with them at this time", PTarget->getName(), PChar->getName());
            return;
        }

        auto lastTargetTradeTimeSeconds = std::chrono::duration_cast<std::chrono::seconds>(server_clock::now() - PTarget->lastTradeInvite).count();
        if ((PTarget->TradePending.targid != 0 && lastTargetTradeTimeSeconds < 60) || PTarget->UContainer->GetType() == UCONTAINER_TRADE)
        {
            // Can't trade with someone who's already got a pending trade before timeout
            PChar->pushPacket(new CTradeActionPacket(PTarget, 0x07));
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

                POldTradeTarget->pushPacket(new CTradeActionPacket(PChar, 0x07));
                PChar->pushPacket(new CTradeActionPacket(POldTradeTarget, 0x07));
                return;
            }
        }

        PChar->lastTradeInvite     = server_clock::now();
        PChar->TradePending.id     = charid;
        PChar->TradePending.targid = targid;

        PTarget->lastTradeInvite     = server_clock::now();
        PTarget->TradePending.id     = PChar->id;
        PTarget->TradePending.targid = PChar->targid;
        PTarget->pushPacket(new CTradeRequestPacket(PChar));
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
                            PChar->pushPacket(new CTradeActionPacket(PTarget, action));

                            PTarget->UContainer->SetType(UCONTAINER_TRADE);
                            PTarget->pushPacket(new CTradeActionPacket(PChar, action));
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
                PTarget->pushPacket(new CTradeActionPacket(PChar, action));

                PChar->TradePending.clean();
            }
            break;
            case 0x02: // trade accepted
            {
                ShowDebug("%s accepted trade with %s", PTarget->getName(), PChar->getName());
                if (PChar->TradePending.id == PTarget->id && PTarget->TradePending.id == PChar->id)
                {
                    PChar->UContainer->SetLock();
                    PTarget->pushPacket(new CTradeActionPacket(PChar, action));

                    if (PTarget->UContainer->IsLocked())
                    {
                        if (charutils::CanTrade(PChar, PTarget) && charutils::CanTrade(PTarget, PChar))
                        {
                            charutils::DoTrade(PChar, PTarget);
                            PTarget->pushPacket(new CTradeActionPacket(PTarget, 9));

                            charutils::DoTrade(PTarget, PChar);
                            PChar->pushPacket(new CTradeActionPacket(PChar, 9));
                        }
                        else
                        {
                            // Failed to trade
                            // Either players containers are full or illegal item trade attempted
                            ShowDebug("%s->%s trade failed (full inventory or illegal items)", PChar->getName(), PTarget->getName());
                            PChar->pushPacket(new CTradeActionPacket(PTarget, 1));
                            PTarget->pushPacket(new CTradeActionPacket(PChar, 1));
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
                        PChar->pushPacket(new CMessageStandardPacket(MsgStd::LinkshellEquipBeforeUsing));
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
            PChar->pushPacket(new CTradeItemPacket(PItem, tradeSlotID));
            ShowDebug("%s->%s trade pushing packet to %s", PChar->getName(), PTarget->getName(), PTarget->getName());
            PTarget->pushPacket(new CTradeUpdatePacket(PItem, tradeSlotID));

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
        PChar->pushPacket(new CMessageSystemPacket(0, 0, 172));
        return;
    }

    // MONs can't trade
    if (PChar->m_PMonstrosity != nullptr)
    {
        return;
    }

    uint32 npcid  = data.ref<uint32>(0x04);
    uint16 targid = data.ref<uint16>(0x3A);

    CBaseEntity* PNpc = PChar->GetEntity(targid, TYPE_NPC);

    if ((PNpc != nullptr) && (PNpc->id == npcid) && distance(PNpc->loc.p, PChar->loc.p) <= 10)
    {
        uint8 numItems = data.ref<uint8>(0x3C);

        PChar->TradeContainer->Clean();

        for (int32 slotID = 0; slotID < numItems; ++slotID)
        {
            uint8  invSlotID = data.ref<uint8>(0x30 + slotID);
            uint32 Quantity  = data.ref<uint32>(0x08 + slotID * 4);

            CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotID);

            if (PItem == nullptr || PItem->getQuantity() < Quantity)
            {
                ShowError("SmallPacket0x036: Player %s trying to trade invalid item [to NPC]! ", PChar->getName());
                return;
            }

            if (PItem->getReserve() > 0)
            {
                ShowError("SmallPacket0x036: Player %s trying to trade a RESERVED item [to NPC]! ", PChar->getName());
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
        ShowWarning("SmallPacket0x037: Invalid storage ID passed to packet %u by %s", StorageID, PChar->getName());
        return;
    }

    if (PChar->UContainer->GetType() != UCONTAINER_USEITEM)
    {
        PChar->PAI->UseItem(TargetID, StorageID, SlotID);
    }
    else
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 56));
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
    PChar->pushPacket(new CInventoryFinishPacket());
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

        PChar->pushPacket(new CInventoryAssignPacket(PItem, status));
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
    sql->EscapeStringLen(extra, (const char*)PMannequin->m_extra, sizeof(PMannequin->m_extra));

    const char* Query = "UPDATE char_inventory "
                        "SET "
                        "extra = '%s' "
                        "WHERE location = %u AND slot = %u AND charid = %u";

    auto ret  = sql->Query(Query, extra, mannequinStorageLoc, mannequinStorageLocSlot, PChar->id);
    auto rows = sql->AffectedRows();
    if (ret != SQL_ERROR && rows != 0)
    {
        PChar->pushPacket(new CInventoryItemPacket(PMannequin, mannequinStorageLoc, mannequinStorageLocSlot));
        PChar->pushPacket(new CInventoryCountPacket(mannequinStorageLoc, mannequinStorageLocSlot, headId, bodyId, handsId, legId, feetId, mainId, subId, rangeId));
        PChar->pushPacket(new CInventoryFinishPacket());
    }
    else
    {
        ShowError("SmallPacket0x03B: Problem writing Mannequin to database!");
    }
}

/************************************************************************
 *                                                                       *
 *  Unknown Packet                                                       *
 *  Assumed packet empty response for npcs/monsters/players.             *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x03C(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    ShowWarning("SmallPacket0x03C");
}

/************************************************************************
 *                                                                       *
 *  Incoming Blacklist Command                                           *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x03D(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    char blacklistedName[PacketNameLength] = {};
    memcpy(&blacklistedName, data[0x08], PacketNameLength - 1);

    std::string name = blacklistedName;
    uint8       cmd  = data.ref<uint8>(0x18);

    // Attempt to locate the character by their name
    const char* query = "SELECT charid, accid FROM chars WHERE charname = '%s' LIMIT 1";
    int32       ret   = sql->Query(query, name);
    if (ret == SQL_ERROR || sql->NumRows() != 1 || sql->NextRow() != SQL_SUCCESS)
    {
        // Send failed
        PChar->pushPacket(new CBlacklistPacket(0, "", 0x02));
        return;
    }

    // Retrieve the data from Sql
    uint32 charid = sql->GetUIntData(0);
    uint32 accid  = sql->GetUIntData(1);

    // User is trying to add someone to their blacklist
    if (cmd == 0x00)
    {
        if (blacklistutils::IsBlacklisted(PChar->id, charid))
        {
            // We cannot readd this person, fail to add
            PChar->pushPacket(new CBlacklistPacket(0, "", 0x02));
            return;
        }

        // Attempt to add this person
        if (blacklistutils::AddBlacklisted(PChar->id, charid))
        {
            PChar->pushPacket(new CBlacklistPacket(accid, name, cmd));
        }
        else
        {
            PChar->pushPacket(new CBlacklistPacket(0, "", 0x02));
        }
    }

    // User is trying to remove someone from their blacklist
    else if (cmd == 0x01)
    {
        if (!blacklistutils::IsBlacklisted(PChar->id, charid))
        {
            // We cannot remove this person, fail to remove
            PChar->pushPacket(new CBlacklistPacket(0, "", 0x02));
            return;
        }

        // Attempt to remove this person
        if (blacklistutils::DeleteBlacklisted(PChar->id, charid))
        {
            PChar->pushPacket(new CBlacklistPacket(accid, name, cmd));
        }
        else
        {
            PChar->pushPacket(new CBlacklistPacket(0, "", 0x02));
        }
    }
    else
    {
        // Send failed
        PChar->pushPacket(new CBlacklistPacket(0, "", 0x02));
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
    PrintPacket(data);

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
    PrintPacket(data);

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
    // uint8   msg_chunk = data.ref<uint8>(0x04); // The current chunk of the message to send (1 = start, 2 = rest of message)
    // uint8   msg_unknown1 = data.ref<uint8>(0x05); // Unknown always 0
    // uint8   msg_unknown2 = data.ref<uint8>(0x06); // Unknown always 1
    uint8  msg_language  = data.ref<uint8>(0x07);  // Language request id (2 = English, 4 = French)
    uint32 msg_timestamp = data.ref<uint32>(0x08); // The message timestamp being requested
    // uint32  msg_size_total = data.ref<uint32>(0x0C); // The total length of the requested server message
    uint32 msg_offset = data.ref<uint32>(0x10); // The offset to start obtaining the server message
    // uint32  msg_request_len = data.ref<uint32>(0x14); // The total requested size of send to the client

    std::string login_message = luautils::GetServerMessage(msg_language);

    PChar->pushPacket(new CServerMessagePacket(login_message, msg_language, msg_timestamp, msg_offset));
    PChar->pushPacket(new CCharSyncPacket(PChar));

    // todo: kill player til theyre dead and bsod
    const char* fmtQuery = "SELECT version_mismatch FROM accounts_sessions WHERE charid = %u";
    int32       ret      = sql->Query(fmtQuery, PChar->id);
    if (ret != SQL_ERROR && sql->NextRow() == SQL_SUCCESS)
    {
        if ((bool)sql->GetUIntData(0))
        {
            PChar->pushPacket(new CChatMessagePacket(PChar, CHAT_MESSAGE_TYPE::MESSAGE_SYSTEM_1, "Server does not support this client version."));
        }
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
    uint8 action  = data.ref<uint8>(0x04);
    uint8 boxtype = data.ref<uint8>(0x05);
    uint8 slotID  = data.ref<uint8>(0x06);

    constexpr auto actionToStr = [](uint8 actionIn)
    {
        switch (actionIn)
        {
            case 0x01:
                return "Send old items";
            case 0x02:
                return "Add item";
            case 0x03:
                return "Send confirmation";
            case 0x04:
                return "Cancel item";
            case 0x05:
                return "Send item count";
            case 0x06:
                return "Send new items";
            case 0x07:
                return "Remove delivered item";
            case 0x08:
                return "Update delivery slot";
            case 0x09:
                return "Return to sender";
            case 0x0A:
                return "Take item";
            case 0x0B:
                return "Remove item";
            case 0x0C:
                return "Confirm name";
            case 0x0D:
                return "Open send box";
            case 0x0E:
                return "Open recv box";
            case 0x0F:
                return "Close box";
            default:
                return "Unknown";
        }
    };

    if (settings::get<bool>("logging.DEBUG_DELIVERY_BOX"))
    {
        ShowDebug(fmt::format("DeliveryBox Action 0x{:02X} ({}) by {}", action, actionToStr(action), PChar->name));
    }

    if (jailutils::InPrison(PChar)) // If jailed, no mailbox menu for you.
    {
        return;
    }

    if (!zoneutils::IsResidentialArea(PChar) && PChar->m_GMlevel == 0 && !PChar->loc.zone->CanUseMisc(MISC_AH) && !PChar->loc.zone->CanUseMisc(MISC_MOGMENU))
    {
        ShowWarning("%s is trying to use the delivery box in a disallowed zone [%s]", PChar->getName(), PChar->loc.zone->getName());
        return;
    }

    if (PChar->animation == ANIMATION_SYNTH)
    {
        ShowWarning("SmallPacket0x04D: %s attempting to access delivery box in the middle of a synth!", PChar->getName());
        return;
    }

    if ((PChar->animation >= ANIMATION_FISHING_FISH && PChar->animation <= ANIMATION_FISHING_STOP) ||
        PChar->animation == ANIMATION_FISHING_START_OLD || PChar->animation == ANIMATION_FISHING_START)
    {
        ShowWarning("SmallPacket0x04D: %s attempting to access delivery box while fishing!", PChar->getName());
        return;
    }

    switch (action)
    {
        // 0x01 - Send old items
        case 0x01:
        {
            if (boxtype < 1 || boxtype > 2 || !charutils::isAnyDeliveryBoxOpen(PChar))
            {
                ShowWarning("Delivery Box packet handler received action %u while UContainer is in an invalid state (%s)", action, PChar->getName());
                return;
            }

            const char* fmtQuery = "SELECT itemid, itemsubid, slot, quantity, sent, extra, sender, charname FROM delivery_box WHERE charid = %u AND box = %d "
                                   "AND slot < 8 ORDER BY slot;";

            int32 ret = sql->Query(fmtQuery, PChar->id, boxtype);

            if (ret != SQL_ERROR)
            {
                int items = 0;
                if (sql->NumRows() != 0)
                {
                    while (sql->NextRow() == SQL_SUCCESS)
                    {
                        CItem* PItem = itemutils::GetItem(sql->GetIntData(0));

                        if (PItem != nullptr) // Prevent an access violation in the event that an item doesn't exist for an ID
                        {
                            PItem->setSubID(sql->GetIntData(1));
                            PItem->setSlotID(sql->GetIntData(2));
                            PItem->setQuantity(sql->GetUIntData(3));

                            if (sql->GetUIntData(4) > 0)
                            {
                                PItem->setSent(true);
                            }

                            size_t length = 0;
                            char*  extra  = nullptr;
                            sql->GetData(5, &extra, &length);
                            memcpy(PItem->m_extra, extra, (length > sizeof(PItem->m_extra) ? sizeof(PItem->m_extra) : length));

                            if (boxtype == 2)
                            {
                                PItem->setSender(sql->GetStringData(7));
                                PItem->setReceiver(sql->GetStringData(6));
                            }
                            else
                            {
                                PItem->setSender(sql->GetStringData(6));
                                PItem->setReceiver(sql->GetStringData(7));
                            }

                            PChar->UContainer->SetItem(PItem->getSlotID(), PItem);
                            ++items;
                        }
                    }
                }
                for (uint8 i = 0; i < 8; ++i)
                {
                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PChar->UContainer->GetItem(i), i, items, 1));
                }
            }
            return;
        }
        // 0x02 - Add items to be sent
        case 0x02:
        {
            if (!charutils::isSendBoxOpen(PChar))
            {
                ShowWarning("Delivery Box packet handler received action %u while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX (%s)", action, PChar->getName());
                return;
            }

            uint8  invslot  = data.ref<uint8>(0x07);
            uint32 quantity = data.ref<uint32>(0x08);

            CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invslot);

            if (quantity > 0 && PItem && PItem->getQuantity() >= quantity && PChar->UContainer->IsSlotEmpty(slotID))
            {
                int32 ret = sql->Query("SELECT charid, accid FROM chars WHERE charname = '%s' LIMIT 1;", str(data[0x10]));
                if (ret != SQL_ERROR && sql->NumRows() > 0 && sql->NextRow() == SQL_SUCCESS)
                {
                    uint32 charid = sql->GetUIntData(0);

                    if (PItem->getFlag() & ITEM_FLAG_NODELIVERY)
                    {
                        if (!(PItem->getFlag() & ITEM_FLAG_MAIL2ACCOUNT))
                        {
                            return;
                        }

                        uint32 accid = sql->GetUIntData(1);

                        ret = sql->Query("SELECT COUNT(*) FROM chars WHERE charid = '%u' AND accid = '%u' LIMIT 1;", PChar->id, accid);
                        if (ret == SQL_ERROR || sql->NextRow() != SQL_SUCCESS || sql->GetUIntData(0) == 0)
                        {
                            return;
                        }
                    }

                    CItem* PUBoxItem = itemutils::GetItem(PItem->getID());

                    if (PUBoxItem == nullptr)
                    {
                        ShowError("PUBoxItem was null.");
                        return;
                    }

                    char receiver[PacketNameLength] = {};
                    memcpy(&receiver, data[0x10], PacketNameLength - 1);
                    PUBoxItem->setReceiver(receiver);
                    PUBoxItem->setSender(PChar->getName());
                    PUBoxItem->setQuantity(quantity);
                    PUBoxItem->setSlotID(PItem->getSlotID());
                    memcpy(PUBoxItem->m_extra, PItem->m_extra, sizeof(PUBoxItem->m_extra));

                    char extra[sizeof(PItem->m_extra) * 2 + 1];
                    sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

                    ret = sql->Query(
                        "INSERT INTO delivery_box(charid, charname, box, slot, itemid, itemsubid, quantity, extra, senderid, sender) VALUES(%u, "
                        "'%s', 2, %u, %u, %u, %u, '%s', %u, '%s'); ",
                        PChar->id, PChar->getName(), slotID, PItem->getID(), PItem->getSubID(), quantity, extra, charid, str(data[0x10]));

                    if (ret != SQL_ERROR && sql->AffectedRows() == 1 && charutils::UpdateItem(PChar, LOC_INVENTORY, invslot, -(int32)quantity))
                    {
                        PChar->UContainer->SetItem(slotID, PUBoxItem);
                        PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PUBoxItem, slotID, PChar->UContainer->GetItemsCount(), 1));
                        PChar->pushPacket(new CInventoryFinishPacket());
                    }
                    else
                    {
                        destroy(PUBoxItem);
                    }
                }
            }
            return;
        }
        // 0x03 - Send confirmation
        case 0x03:
        {
            if (!charutils::isSendBoxOpen(PChar))
            {
                ShowWarning("Delivery Box packet handler received action %u while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX (%s)", action, PChar->getName());
                return;
            }

            uint8 send_items = 0;
            for (int i = 0; i < 8; i++)
            {
                if (!PChar->UContainer->IsSlotEmpty(i) && !PChar->UContainer->GetItem(i)->isSent())
                {
                    send_items++;
                }
            }

            if (!PChar->UContainer->IsSlotEmpty(slotID))
            {
                CItem* PItem = PChar->UContainer->GetItem(slotID);

                if (PItem && !PItem->isSent())
                {
                    bool isAutoCommitOn = sql->GetAutoCommit();
                    bool commit         = false;

                    if (sql->SetAutoCommit(false) && sql->TransactionStart())
                    {
                        int32 ret = sql->Query("SELECT charid FROM chars WHERE charname = '%s' LIMIT 1", PItem->getReceiver());

                        if (ret != SQL_ERROR && sql->NumRows() > 0 && sql->NextRow() == SQL_SUCCESS)
                        {
                            uint32 charid = sql->GetUIntData(0);

                            ret = sql->Query("UPDATE delivery_box SET sent = 1 WHERE charid = %u AND senderid = %u AND slot = %u AND box = 2;",
                                             PChar->id, charid, slotID);

                            if (ret != SQL_ERROR && sql->AffectedRows() == 1)
                            {
                                char extra[sizeof(PItem->m_extra) * 2 + 1];
                                sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

                                ret = sql->Query(
                                    "INSERT INTO delivery_box(charid, charname, box, itemid, itemsubid, quantity, extra, senderid, sender) "
                                    "VALUES(%u, '%s', 1, %u, %u, %u, '%s', %u, '%s'); ",
                                    charid, PItem->getReceiver(), PItem->getID(), PItem->getSubID(), PItem->getQuantity(), extra, PChar->id,
                                    PChar->getName());

                                if (ret != SQL_ERROR && sql->AffectedRows() == 1)
                                {
                                    PItem->setSent(true);
                                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, send_items, 0x02));
                                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, send_items, 0x01));
                                    commit = true;
                                }
                            }
                        }

                        if (!commit || !sql->TransactionCommit())
                        {
                            sql->TransactionRollback();
                            ShowError("Could not finalize send transaction. PlayerID: %d Target: %s slotID: %d", PChar->id, PItem->getReceiver(), slotID);
                        }

                        sql->SetAutoCommit(isAutoCommitOn);
                    }
                }
            }
            return;
        }
        // 0x04 - Cancel sending item
        case 0x04:
        {
            if (!charutils::isSendBoxOpen(PChar))
            {
                ShowWarning("Delivery Box packet handler received action %u while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX (%s)", action, PChar->getName());
                return;
            }

            if (!PChar->UContainer->IsSlotEmpty(slotID))
            {
                bool   isAutoCommitOn = sql->GetAutoCommit();
                bool   commit         = false;
                bool   orphan         = false;
                CItem* PItem          = PChar->UContainer->GetItem(slotID);

                if (sql->SetAutoCommit(false) && sql->TransactionStart())
                {
                    int32 ret =
                        sql->Query("SELECT charid FROM chars WHERE charname = '%s' LIMIT 1", PChar->UContainer->GetItem(slotID)->getReceiver());

                    if (ret != SQL_ERROR && sql->NumRows() > 0 && sql->NextRow() == SQL_SUCCESS)
                    {
                        uint32 charid = sql->GetUIntData(0);
                        ret           = sql->Query(
                                      "UPDATE delivery_box SET sent = 0 WHERE charid = %u AND box = 2 AND slot = %u AND sent = 1 AND received = 0 LIMIT 1;",
                                      PChar->id, slotID);

                        if (ret != SQL_ERROR && sql->AffectedRows() == 1)
                        {
                            ret = sql->Query(
                                "DELETE FROM delivery_box WHERE senderid = %u AND box = 1 AND charid = %u AND itemid = %u AND quantity = %u "
                                "AND slot >= 8 LIMIT 1;",
                                PChar->id, charid, PItem->getID(), PItem->getQuantity());

                            if (ret != SQL_ERROR && sql->AffectedRows() == 1)
                            {
                                PChar->UContainer->GetItem(slotID)->setSent(false);
                                commit = true;
                                PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PChar->UContainer->GetItem(slotID), slotID,
                                                                         PChar->UContainer->GetItemsCount(), 0x02));
                                PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PChar->UContainer->GetItem(slotID), slotID,
                                                                         PChar->UContainer->GetItemsCount(), 0x01));
                            }
                            else if (ret != SQL_ERROR && sql->AffectedRows() == 0)
                            {
                                orphan = true;
                            }
                        }
                    }
                    else if (ret != SQL_ERROR && sql->NumRows() == 0)
                    {
                        orphan = true;
                    }

                    if (!commit || !sql->TransactionCommit())
                    {
                        sql->TransactionRollback();
                        ShowError("Could not finalize cancel send transaction. PlayerID: %d slotID: %d", PChar->id, slotID);
                        if (orphan)
                        {
                            sql->SetAutoCommit(true);
                            ret = sql->Query(
                                "DELETE FROM delivery_box WHERE box = 2 AND charid = %u AND itemid = %u AND quantity = %u AND slot = %u LIMIT 1;",
                                PChar->id, PItem->getID(), PItem->getQuantity(), slotID);
                            if (ret != SQL_ERROR && sql->AffectedRows() == 1)
                            {
                                ShowError("Deleting orphaned outbox record. PlayerID: %d slotID: %d itemID: %d", PChar->id, slotID, PItem->getID());
                                PChar->pushPacket(new CDeliveryBoxPacket(0x0F, boxtype, 0, 1));
                            }
                        }
                        // error message: "Delivery orders are currently backlogged."
                        PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0, -1));
                    }

                    sql->SetAutoCommit(isAutoCommitOn);
                }
            }
            return;
        }
        // 0x05 - Send client new item count
        case 0x05:
        {
            // Send the player the new items count not seen
            if (boxtype < 1 || boxtype > 2 || !charutils::isAnyDeliveryBoxOpen(PChar))
            {
                ShowWarning("Delivery Box packet handler received action %u while UContainer is in an invalid state (%s)", action, PChar->getName());
                return;
            }

            uint8 received_items = 0;
            int32 ret            = SQL_ERROR;

            if (boxtype == 0x01)
            {
                int limit = 0;
                for (int i = 0; i < 8; ++i)
                {
                    if (PChar->UContainer->IsSlotEmpty(i))
                    {
                        limit++;
                    }
                }
                std::string Query = "SELECT charid FROM delivery_box WHERE charid = %u AND box = 1 AND slot >= 8 ORDER BY slot ASC LIMIT %u;";
                ret               = sql->Query(Query.c_str(), PChar->id, limit);
            }
            else if (boxtype == 0x02)
            {
                std::string Query = "SELECT charid FROM delivery_box WHERE charid = %u AND received = 1 AND box = 2;";
                ret               = sql->Query(Query.c_str(), PChar->id);
            }

            if (ret != SQL_ERROR)
            {
                received_items = (uint8)sql->NumRows();
            }

            PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0xFF, 0x02));
            PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, received_items, 0x01));

            return;
        }
        // 0x06 - Send new items
        case 0x06:
        {
            if (!charutils::isRecvBoxOpen(PChar))
            {
                ShowWarning("Delivery Box packet handler received action %u while UContainer is in a state other than UCONTAINER_RECV_DELIVERYBOX (%s)", action, PChar->getName());
                return;
            }

            if (boxtype == 1)
            {
                bool isAutoCommitOn = sql->GetAutoCommit();
                bool commit         = false;

                if (sql->SetAutoCommit(false) && sql->TransactionStart())
                {
                    std::string Query = "SELECT itemid, itemsubid, quantity, extra, sender, senderid FROM delivery_box WHERE charid = %u AND box = 1 AND slot "
                                        ">= 8 ORDER BY slot ASC LIMIT 1;";

                    int32 ret = sql->Query(Query.c_str(), PChar->id);

                    CItem* PItem = nullptr;

                    if (ret != SQL_ERROR && sql->NumRows() > 0 && sql->NextRow() == SQL_SUCCESS)
                    {
                        PItem = itemutils::GetItem(sql->GetUIntData(0));

                        if (PItem)
                        {
                            PItem->setSubID(sql->GetIntData(1));
                            PItem->setQuantity(sql->GetUIntData(2));

                            size_t length = 0;
                            char*  extra  = nullptr;
                            sql->GetData(3, &extra, &length);
                            memcpy(PItem->m_extra, extra, (length > sizeof(PItem->m_extra) ? sizeof(PItem->m_extra) : length));

                            PItem->setSender(sql->GetStringData(4));
                            if (PChar->UContainer->IsSlotEmpty(slotID))
                            {
                                int senderID = sql->GetUIntData(5);
                                PItem->setSlotID(slotID);

                                // the result of this query doesn't really matter, it can be sent from the auction house which has no sender record
                                sql->Query("UPDATE delivery_box SET received = 1 WHERE senderid = %u AND charid = %u AND box = 2 AND received = 0 AND quantity "
                                           "= %u AND sent = 1 AND itemid = %u LIMIT 1;",
                                           PChar->id, senderID, PItem->getQuantity(), PItem->getID());

                                sql->Query("SELECT slot FROM delivery_box WHERE charid = %u AND box = 1 AND slot > 7 ORDER BY slot ASC;", PChar->id);
                                if (ret != SQL_ERROR && sql->NumRows() > 0 && sql->NextRow() == SQL_SUCCESS)
                                {
                                    uint8 queue = sql->GetUIntData(0);
                                    Query       = "UPDATE delivery_box SET slot = %u WHERE charid = %u AND box = 1 AND slot = %u;";
                                    ret         = sql->Query(Query.c_str(), slotID, PChar->id, queue);
                                    if (ret != SQL_ERROR)
                                    {
                                        Query = "UPDATE delivery_box SET slot = slot - 1 WHERE charid = %u AND box = 1 AND slot > %u;";
                                        ret   = sql->Query(Query.c_str(), PChar->id, queue);
                                        if (ret != SQL_ERROR)
                                        {
                                            PChar->UContainer->SetItem(slotID, PItem);
                                            // TODO: increment "count" for every new item, if needed
                                            PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, nullptr, slotID, 1, 2));
                                            PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, 1, 1));
                                            commit = true;
                                        }
                                    }
                                }
                            }
                        }
                    }

                    if (!commit || !sql->TransactionCommit())
                    {
                        destroy(PItem);

                        sql->TransactionRollback();
                        ShowError("Could not find new item to add to delivery box. PlayerID: %d Box :%d Slot: %d", PChar->id, boxtype, slotID);
                        PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0, 0xEB));
                    }
                }
                sql->SetAutoCommit(isAutoCommitOn);
            }
            return;
        }
        // 0x07 - Removes a delivered item from sending box
        case 0x07:
        {
            if (!charutils::isSendBoxOpen(PChar))
            {
                ShowWarning("Delivery Box packet handler received action %u while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX (%s)", action, PChar->getName());
                return;
            }

            uint8 received_items = 0;
            uint8 deliverySlotID = 0;

            int32 ret = sql->Query("SELECT slot FROM delivery_box WHERE charid = %u AND received = 1 AND box = 2 ORDER BY slot ASC;", PChar->id);

            if (ret != SQL_ERROR)
            {
                received_items = (uint8)sql->NumRows();
                if (received_items && sql->NextRow() == SQL_SUCCESS)
                {
                    deliverySlotID = sql->GetUIntData(0);
                    if (!PChar->UContainer->IsSlotEmpty(deliverySlotID))
                    {
                        CItem* PItem = PChar->UContainer->GetItem(deliverySlotID);
                        if (PItem && PItem->isSent())
                        {
                            ret = sql->Query("DELETE FROM delivery_box WHERE charid = %u AND box = 2 AND slot = %u LIMIT 1;", PChar->id, deliverySlotID);
                            if (ret != SQL_ERROR && sql->AffectedRows() == 1)
                            {
                                PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0, 0x02));
                                PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, deliverySlotID, received_items, 0x01));
                                PChar->UContainer->SetItem(deliverySlotID, nullptr);
                                destroy(PItem);
                            }
                        }
                    }
                }
            }
            return;
        }
        // 0x08 - Update delivery cell before removing
        case 0x08:
        {
            if (!charutils::isAnyDeliveryBoxOpen(PChar))
            {
                ShowWarning("Delivery Box packet handler received action %u while UContainer is in an invalid state (%s)", action, PChar->getName());
                return;
            }

            if (!PChar->UContainer->IsSlotEmpty(slotID))
            {
                PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PChar->UContainer->GetItem(slotID), slotID, 1, 1));
            }

            return;
        }
        // 0x09 - Return to sender
        case 0x09:
        {
            if (!charutils::isRecvBoxOpen(PChar))
            {
                ShowWarning("Delivery Box packet handler received action %u while UContainer is in a state other than UCONTAINER_RECV_DELIVERYBOX (%s)", action, PChar->getName());
                return;
            }

            if (!PChar->UContainer->IsSlotEmpty(slotID))
            {
                bool isAutoCommitOn = sql->GetAutoCommit();
                bool commit         = false; // When in doubt back it out.

                CItem*      PItem    = PChar->UContainer->GetItem(slotID);
                auto        item_id  = PItem->getID();
                auto        quantity = PItem->getQuantity();
                uint32      senderID = 0;
                std::string senderName;

                if (sql->SetAutoCommit(false) && sql->TransactionStart())
                {
                    // Get sender of delivery record
                    int32 ret = sql->Query("SELECT senderid, sender FROM delivery_box WHERE charid = %u AND slot = %u AND box = 1 LIMIT 1;",
                                           PChar->id, slotID);

                    if (ret != SQL_ERROR && sql->NumRows() > 0 && sql->NextRow() == SQL_SUCCESS)
                    {
                        senderID = sql->GetUIntData(0);
                        senderName.insert(0, (const char*)sql->GetData(1));

                        if (senderID != 0)
                        {
                            char extra[sizeof(PItem->m_extra) * 2 + 1];
                            sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

                            // Insert a return record into delivery_box
                            ret = sql->Query("INSERT INTO delivery_box(charid, charname, box, itemid, itemsubid, quantity, extra, senderid, sender) VALUES(%u, "
                                             "'%s', 1, %u, %u, %u, '%s', %u, '%s'); ",
                                             senderID, senderName.c_str(), PItem->getID(), PItem->getSubID(), PItem->getQuantity(), extra, PChar->id,
                                             PChar->getName());

                            if (ret != SQL_ERROR && sql->AffectedRows() > 0)
                            {
                                // Remove original delivery record
                                ret = sql->Query("DELETE FROM delivery_box WHERE charid = %u AND slot = %u AND box = 1 LIMIT 1;", PChar->id, slotID);

                                if (ret != SQL_ERROR && sql->AffectedRows() > 0)
                                {
                                    PChar->UContainer->SetItem(slotID, nullptr);
                                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 1));
                                    destroy(PItem);
                                    commit = true;
                                }
                            }
                        }
                    }

                    if (!commit || !sql->TransactionCommit())
                    {
                        sql->TransactionRollback();
                        ShowError("Could not finalize delivery return transaction. PlayerID: %d SenderID :%d ItemID: %d Quantity: %d", PChar->id, senderID,
                                  item_id, quantity);
                        PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 0xEB));
                    }

                    sql->SetAutoCommit(isAutoCommitOn);
                }
            }
            return;
        }
        // 0x0a - Take item from cell
        case 0x0A:
        {
            if (boxtype < 1 || boxtype > 2 || !charutils::isAnyDeliveryBoxOpen(PChar))
            {
                ShowWarning("Delivery Box packet handler received action %u while UContainer is in an invalid state (%s)", action, PChar->getName());
                return;
            }

            if (!PChar->UContainer->IsSlotEmpty(slotID))
            {
                bool isAutoCommitOn = sql->GetAutoCommit();
                bool commit         = false;
                bool invErr         = false;

                CItem* PItem = PChar->UContainer->GetItem(slotID);

                if (!PItem->isType(ITEM_CURRENCY) && PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() == 0)
                {
                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 0xB9));
                    return;
                }

                if (sql->SetAutoCommit(false) && sql->TransactionStart())
                {
                    int32 ret = SQL_ERROR;
                    if (boxtype == 0x01)
                    {
                        ret = sql->Query("DELETE FROM delivery_box WHERE charid = %u AND slot = %u AND box = %u LIMIT 1", PChar->id, slotID, boxtype);
                    }
                    else if (boxtype == 0x02)
                    {
                        ret = sql->Query("DELETE FROM delivery_box WHERE charid = %u AND sent = 0 AND slot = %u AND box = %u LIMIT 1", PChar->id,
                                         slotID, boxtype);
                    }

                    if (ret != SQL_ERROR && sql->AffectedRows() != 0)
                    {
                        if (charutils::AddItem(PChar, LOC_INVENTORY, itemutils::GetItem(PItem), true) != ERROR_SLOTID)
                        {
                            commit = true;
                        }
                        else
                        {
                            invErr = true;
                        }
                    }

                    if (!commit || !sql->TransactionCommit())
                    {
                        sql->TransactionRollback();
                        PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 0xBA));
                        if (!invErr)
                        { // only display error in log if there's a database problem, not if inv is full or rare item conflict
                            ShowError("Could not finalize receive transaction. PlayerID: %d Action: 0x0A", PChar->id);
                        }
                    }
                    else
                    {
                        PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 1));
                        PChar->pushPacket(new CInventoryFinishPacket());
                        PChar->UContainer->SetItem(slotID, nullptr);
                        destroy(PItem);
                    }
                }

                sql->SetAutoCommit(isAutoCommitOn);
            }
            return;
        }
        // 0x0b - Remove item from cell
        case 0x0B:
        {
            if (!charutils::isRecvBoxOpen(PChar))
            {
                ShowWarning("Delivery Box packet handler received action %u while UContainer is in a state other than UCONTAINER_RECV_DELIVERYBOX (%s)", action, PChar->getName());
                return;
            }

            if (!PChar->UContainer->IsSlotEmpty(slotID))
            {
                int32 ret = sql->Query("DELETE FROM delivery_box WHERE charid = %u AND slot = %u AND box = 1 LIMIT 1", PChar->id, slotID);

                if (ret != SQL_ERROR && sql->AffectedRows() != 0)
                {
                    CItem* PItem = PChar->UContainer->GetItem(slotID);
                    PChar->UContainer->SetItem(slotID, nullptr);

                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 1));
                    destroy(PItem);
                }
            }
            return;
        }
        // 0x0c - Confirm name before sending
        case 0x0C:
        {
            if (!charutils::isSendBoxOpen(PChar))
            {
                ShowWarning("Delivery Box packet handler received action %u while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX (%s)", action, PChar->getName());
                return;
            }

            int32 ret = sql->Query("SELECT accid FROM chars WHERE charname = '%s' LIMIT 1", str(data[0x10]));

            if (ret != SQL_ERROR && sql->NumRows() > 0 && sql->NextRow() == SQL_SUCCESS)
            {
                uint32 accid = sql->GetUIntData(0);
                ret          = sql->Query("SELECT COUNT(*) FROM chars WHERE charid = '%u' AND accid = '%u' LIMIT 1;", PChar->id, accid);
                if (ret != SQL_ERROR && sql->NextRow() == SQL_SUCCESS && sql->GetUIntData(0))
                {
                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0xFF, 0x02));
                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0x01, 0x01));
                }
                else
                {
                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0xFF, 0x02));
                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0x00, 0x01));
                }
            }
            else
            {
                PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0xFF, 0x02));
                PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0x00, 0xFB));
            }
            return;
        }
        // 0x0d - Opening to send mail
        case 0x0D:
        {
            charutils::OpenSendBox(PChar, action, boxtype);
            return;
        }
        // 0x0e - Opening to receive mail
        case 0x0E:
        {
            charutils::OpenRecvBox(PChar, action, boxtype);
            return;
        }
        // 0x0f - Closing mail window
        case 0x0F:
        {
            if (charutils::isAnyDeliveryBoxOpen(PChar))
            {
                PChar->UContainer->Clean();
            }
        }
        break;
    }

    // Open mail, close mail
    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0, 1));
}

/************************************************************************
 *                                                                       *
 *  Auction House                                                        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x04E(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint8  action   = data.ref<uint8>(0x04);
    uint8  slotid   = data.ref<uint8>(0x05);
    uint32 price    = data.ref<uint32>(0x08);
    uint8  slot     = data.ref<uint8>(0x0C);
    uint16 itemid   = data.ref<uint16>(0x0E);
    uint8  quantity = data.ref<uint8>(0x10);

    ShowDebug("AH Action (%02hx)", data.ref<uint8>(0x04));

    if (jailutils::InPrison(PChar)) // If jailed, no AH menu for you.
    {
        return;
    }

    if (PChar->m_GMlevel == 0 && !PChar->loc.zone->CanUseMisc(MISC_AH))
    {
        ShowWarning("%s is trying to use the auction house in a disallowed zone [%s]", PChar->getName(), PChar->loc.zone->getName());
        return;
    }

    // 0x04 - Selling Items
    // 0x05 - Open List Of Sales / Wait
    // 0x0A - Retrieve List of Items Sold By Player
    // 0x0B - Proof Of Purchase
    // 0x0E - Purchasing Items
    // 0x0C - Cancel Sale
    // 0x0D - Update Sale List By Player

    switch (action)
    {
        case 0x04:
        {
            CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(slot);

            if ((PItem != nullptr) && (PItem->getID() == itemid) && !(PItem->isSubType(ITEM_LOCKED)) && !(PItem->getFlag() & ITEM_FLAG_NOAUCTION))
            {
                if (PItem->isSubType(ITEM_CHARGED) && ((CItemUsable*)PItem)->getCurrentCharges() < ((CItemUsable*)PItem)->getMaxCharges())
                {
                    PChar->pushPacket(new CAuctionHousePacket(action, 197, 0, 0, 0, 0));
                    return;
                }
                PChar->pushPacket(new CAuctionHousePacket(action, PItem, quantity, price));
            }
        }
        break;
        case 0x05:
        {
            uint32 curTick = gettick();

            if (curTick - PChar->m_AHHistoryTimestamp > 5000)
            {
                PChar->m_ah_history.clear();
                PChar->m_AHHistoryTimestamp = curTick;
                PChar->pushPacket(new CAuctionHousePacket(action));

                // A single SQL query for the player's AH history which is stored in a Char Entity struct + vector.
                const char* Query = "SELECT itemid, price, stack FROM auction_house WHERE seller = %u and sale=0 ORDER BY id ASC LIMIT 7;";

                int32 ret = sql->Query(Query, PChar->id);

                if (ret != SQL_ERROR && sql->NumRows() != 0)
                {
                    while (sql->NextRow() == SQL_SUCCESS)
                    {
                        AuctionHistory_t ah{};
                        ah.itemid = (uint16)sql->GetIntData(0);
                        ah.price  = sql->GetUIntData(1);
                        ah.stack  = (uint8)sql->GetIntData(2);
                        ah.status = 0;
                        PChar->m_ah_history.emplace_back(ah);
                    }
                }
                ShowDebug("%s has %i items up on the AH. ", PChar->getName(), PChar->m_ah_history.size());
            }
            else
            {
                PChar->pushPacket(new CAuctionHousePacket(action, 246, 0, 0, 0, 0)); // try again in a little while msg
                break;
            }
        }
            [[fallthrough]];
        case 0x0A:
        {
            auto totalItemsOnAh = PChar->m_ah_history.size();

            for (size_t auctionSlot = 0; auctionSlot < totalItemsOnAh; auctionSlot++)
            {
                PChar->pushPacket(new CAuctionHousePacket(0x0C, (uint8)auctionSlot, PChar));
            }
        }
        break;
        case 0x0B:
        {
            CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(slot);

            if ((PItem != nullptr) && !(PItem->isSubType(ITEM_LOCKED)) && !(PItem->getFlag() & ITEM_FLAG_NOAUCTION) && PItem->getQuantity() >= quantity)
            {
                if (PItem->isSubType(ITEM_CHARGED) && ((CItemUsable*)PItem)->getCurrentCharges() < ((CItemUsable*)PItem)->getMaxCharges())
                {
                    PChar->pushPacket(new CAuctionHousePacket(action, 197, 0, 0, 0, 0));
                    return;
                }

                uint32 auctionFee = 0;
                if (quantity == 0)
                {
                    if (PItem->getStackSize() == 1 || PItem->getStackSize() != PItem->getQuantity())
                    {
                        ShowError("SmallPacket0x04E::AuctionHouse: Incorrect quantity of item %s", PItem->getName());
                        PChar->pushPacket(new CAuctionHousePacket(action, 197, 0, 0, 0, 0)); // Failed to place up
                        return;
                    }
                    auctionFee = (uint32)(settings::get<uint32>("map.AH_BASE_FEE_STACKS") + (price * settings::get<float>("map.AH_TAX_RATE_STACKS") / 100));
                }
                else
                {
                    auctionFee = (uint32)(settings::get<uint32>("map.AH_BASE_FEE_SINGLE") + (price * settings::get<float>("map.AH_TAX_RATE_SINGLE") / 100));
                }

                auctionFee = std::clamp<uint32>(auctionFee, 0, settings::get<uint32>("map.AH_MAX_FEE"));

                if (PChar->getStorage(LOC_INVENTORY)->GetItem(0)->getQuantity() < auctionFee)
                {
                    PChar->pushPacket(new CAuctionHousePacket(action, 197, 0, 0, 0, 0)); // Not enough gil to pay fee
                    return;
                }

                // Get the current number of items the player has for sale
                const char* Query = "SELECT COUNT(*) FROM auction_house WHERE seller = %u AND sale=0;";

                int32  ret         = sql->Query(Query, PChar->id);
                uint32 ah_listings = 0;

                if (ret != SQL_ERROR && sql->NumRows() != 0)
                {
                    sql->NextRow();
                    ah_listings = (uint32)sql->GetIntData(0);
                }

                if (settings::get<uint8>("map.AH_LIST_LIMIT") && ah_listings >= settings::get<uint8>("map.AH_LIST_LIMIT"))
                {
                    PChar->pushPacket(new CAuctionHousePacket(action, 197, 0, 0, 0, 0)); // Failed to place up
                    return;
                }

                const char* fmtQuery = "INSERT INTO auction_house(itemid, stack, seller, seller_name, date, price) VALUES(%u,%u,%u,'%s',%u,%u)";

                if (sql->Query(fmtQuery, PItem->getID(), quantity == 0, PChar->id, PChar->getName(), (uint32)time(nullptr), price) == SQL_ERROR)
                {
                    ShowError("SmallPacket0x04E::AuctionHouse: Cannot insert item %s to database", PItem->getName());
                    PChar->pushPacket(new CAuctionHousePacket(action, 197, 0, 0, 0, 0)); // failed to place up
                    return;
                }
                charutils::UpdateItem(PChar, LOC_INVENTORY, slot, -(int32)(quantity != 0 ? 1 : PItem->getStackSize()));
                charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -(int32)auctionFee); // Deduct AH fee

                PChar->pushPacket(new CAuctionHousePacket(action, 1, 0, 0, 0, 0));           // Merchandise put up on auction msg
                PChar->pushPacket(new CAuctionHousePacket(0x0C, (uint8)ah_listings, PChar)); // Inform history of slot
            }
        }
        break;
        case 0x0E:
        {
            itemid = data.ref<uint16>(0x0C);

            if (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() == 0)
            {
                PChar->pushPacket(new CAuctionHousePacket(action, 0xE5, 0, 0, 0, 0));
            }
            else
            {
                CItem* PItem = itemutils::GetItemPointer(itemid);

                if (PItem != nullptr)
                {
                    if (PItem->getFlag() & ITEM_FLAG_RARE)
                    {
                        for (uint8 LocID = 0; LocID < CONTAINER_ID::MAX_CONTAINER_ID; ++LocID)
                        {
                            if (PChar->getStorage(LocID)->SearchItem(itemid) != ERROR_SLOTID)
                            {
                                PChar->pushPacket(new CAuctionHousePacket(action, 0xE5, 0, 0, 0, 0));
                                return;
                            }
                        }
                    }
                    CItem* gil = PChar->getStorage(LOC_INVENTORY)->GetItem(0);

                    if (gil != nullptr && gil->isType(ITEM_CURRENCY) && gil->getQuantity() >= price)
                    {
                        const char* fmtQuery = "UPDATE auction_house SET buyer_name = '%s', sale = %u, sell_date = %u WHERE itemid = %u AND buyer_name IS NULL "
                                               "AND stack = %u AND price <= %u ORDER BY price LIMIT 1";

                        if (sql->Query(fmtQuery, PChar->getName(), price, (uint32)time(nullptr), itemid, quantity == 0, price) != SQL_ERROR &&
                            sql->AffectedRows() != 0)
                        {
                            uint8 SlotID = charutils::AddItem(PChar, LOC_INVENTORY, itemid, (quantity == 0 ? PItem->getStackSize() : 1));

                            if (SlotID != ERROR_SLOTID)
                            {
                                charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -(int32)(price));

                                PChar->pushPacket(new CAuctionHousePacket(action, 0x01, itemid, price, quantity, PItem->getStackSize()));
                                PChar->pushPacket(new CInventoryFinishPacket());
                            }
                            return;
                        }
                    }
                }
                // You were unable to buy the {qty} {item}
                if (PItem)
                {
                    PChar->pushPacket(new CAuctionHousePacket(action, 0xC5, itemid, price, quantity, PItem->getStackSize()));
                }
                else
                {
                    PChar->pushPacket(new CAuctionHousePacket(action, 0xC5, itemid, price, quantity, 0));
                }
            }
        }
        break;
        case 0x0C: // Removing item from AH
        {
            if (slotid < PChar->m_ah_history.size())
            {
                bool             isAutoCommitOn = sql->GetAutoCommit();
                AuctionHistory_t canceledItem   = PChar->m_ah_history[slotid];

                if (sql->SetAutoCommit(false) && sql->TransactionStart())
                {
                    const char* fmtQuery = "DELETE FROM auction_house WHERE seller = %u AND itemid = %u AND stack = %u AND price = %u AND sale = 0 LIMIT 1;";
                    int32       ret      = sql->Query(fmtQuery, PChar->id, canceledItem.itemid, canceledItem.stack, canceledItem.price);
                    if (ret != SQL_ERROR && sql->AffectedRows())
                    {
                        CItem* PDelItem = itemutils::GetItemPointer(canceledItem.itemid);
                        if (PDelItem)
                        {
                            uint8 SlotID =
                                charutils::AddItem(PChar, LOC_INVENTORY, canceledItem.itemid, (canceledItem.stack != 0 ? PDelItem->getStackSize() : 1), true);

                            if (SlotID != ERROR_SLOTID)
                            {
                                sql->TransactionCommit();
                                PChar->pushPacket(new CAuctionHousePacket(action, 0, PChar, slotid, false));
                                PChar->pushPacket(new CInventoryFinishPacket());
                                sql->SetAutoCommit(isAutoCommitOn);
                                return;
                            }
                        }
                    }
                    else
                    {
                        ShowError("Failed to return item id %u stack %u to char. ", canceledItem.itemid, canceledItem.stack);
                    }

                    sql->TransactionRollback();
                    sql->SetAutoCommit(isAutoCommitOn);
                }
            }
            // Let client know something went wrong
            PChar->pushPacket(new CAuctionHousePacket(action, 0xE5, PChar, slotid, true)); // Inventory full, unable to remove msg
        }
        break;
        case 0x0D:
        {
            PChar->pushPacket(new CAuctionHousePacket(action, slotid, PChar));
        }
        break;
    }
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
    PChar->pushPacket(new CAddtoEquipSet(PChar, data));
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
        PChar->pushPacket(new CMessageStandardPacket(PChar->getStyleLocked() ? MsgStd::StyleLockIsOn : MsgStd::StyleLockIsOff));
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
        charutils::UpdateRemovedSlots(PChar);
        PChar->RequestPersist(CHAR_PERSIST::EQUIP);
    }
    else if (type == 4)
    {
        charutils::SetStyleLock(PChar, true);
        charutils::UpdateRemovedSlots(PChar);
        PChar->RequestPersist(CHAR_PERSIST::EQUIP);
    }

    if (type != 1 && type != 2)
    {
        PChar->pushPacket(new CCharAppearancePacket(PChar));
        PChar->pushPacket(new CCharSyncPacket(PChar));
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

        PChar->pushPacket(new CSynthSuggestionListPacket(skillID, skillLevel, skillRank, resultMin));
    }
    else
    {
        uint16 selectedRecipeOffset = data.ref<uint16>(0x10);
        PChar->pushPacket(new CSynthSuggestionRecipePacket(skillID, skillLevel, skillRank, selectedRecipeOffset));
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
    PChar->pushPacket(new CConquestPacket(PChar));

    // TODO: This is unstable across multiple processes. Fix me.
    // CampaignState state = campaign::GetCampaignState();
    // PChar->pushPacket(new CCampaignPacket(PChar, state, 0));
    // PChar->pushPacket(new CCampaignPacket(PChar, state, 1));
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

    PChar->pushPacket(new CReleasePacket(PChar, RELEASE_TYPE::EVENT));
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
            updatePosition = luautils::OnEventUpdate(PChar, EventID, Result) == 1;
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

        PChar->pushPacket(new CCSPositionPacket(PChar));
        PChar->pushPacket(new CPositionPacket(PChar));
    }
    PChar->pushPacket(new CReleasePacket(PChar, RELEASE_TYPE::EVENT));
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
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
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

    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CCharEmotionPacket(PChar, TargetID, TargetIndex, EmoteID, emoteMode, extra));

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

                PChar->pushPacket(new CMessageSystemPacket(0, 0, 2)); // You could not enter the next area.
                PChar->pushPacket(new CCSPositionPacket(PChar));

                PChar->status = STATUS_TYPE::NORMAL;
                return;
            }
            else if (PChar->m_PMonstrosity != nullptr) // Not allowed to use zonelines while MON
            {
                PChar->loc.p.rotation += 128;

                PChar->pushPacket(new CMessageSystemPacket(0, 0, 2)); // You could not enter the next area.
                PChar->pushPacket(new CCSPositionPacket(PChar));

                PChar->status = STATUS_TYPE::NORMAL;
                return;
            }
            else
            {
                // Ensure the destination exists
                CZone* PDestination = zoneutils::GetZone(PZoneLine->m_toZone);
                if (PDestination && PDestination->GetIP() == 0)
                {
                    ShowDebug("SmallPacket0x5E: Zone %u closed to chars", PZoneLine->m_toZone);

                    PChar->loc.p.rotation += 128;

                    PChar->pushPacket(new CMessageSystemPacket(0, 0, 2)); // You could not enter the next area.
                    PChar->pushPacket(new CCSPositionPacket(PChar));

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

        PChar->pushPacket(new CMessageSystemPacket(0, 0, 2)); // You could not enter the next area.
        PChar->pushPacket(new CCSPositionPacket(PChar));

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

    std::string updateString = std::string((char*)data[12]);
    luautils::OnEventUpdate(PChar, updateString);

    PChar->pushPacket(new CReleasePacket(PChar, RELEASE_TYPE::EVENT));
    PChar->pushPacket(new CReleasePacket(PChar, RELEASE_TYPE::PLAYERINPUT));
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x061(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->pushPacket(new CCharUpdatePacket(PChar));
    PChar->pushPacket(new CCharHealthPacket(PChar));
    PChar->pushPacket(new CCharStatsPacket(PChar));
    PChar->pushPacket(new CCharSkillsPacket(PChar));
    PChar->pushPacket(new CCharRecastPacket(PChar));
    PChar->pushPacket(new CMenuMeritPacket(PChar));
    PChar->pushPacket(new CMonipulatorPacket1(PChar));
    PChar->pushPacket(new CMonipulatorPacket2(PChar));

    if (charutils::hasKeyItem(PChar, 2544))
    {
        // Only send Job Points Packet if the player has unlocked them
        PChar->pushPacket(new CMenuJobPointsPacket(PChar));
        PChar->pushPacket(new CJobPointDetailsPacket(PChar));
    }

    PChar->pushPacket(new CCharJobExtraPacket(PChar, true));
    PChar->pushPacket(new CCharJobExtraPacket(PChar, false));
    PChar->pushPacket(new CStatusEffectPacket(PChar));
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
    if (settings::get<bool>("map.FISHING_ENABLE"))
    {
        fishingutils::HandleFishingAction(PChar, data);
    }
    else
    {
        return;
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
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
        return;
    }

    switch (data.ref<uint8>(0x0A))
    {
        case 0: // party - must by party leader or solo
            if (PChar->PParty == nullptr || PChar->PParty->GetLeader() == PChar)
            {
                if (PChar->PParty && PChar->PParty->IsFull())
                {
                    PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::CannotInvite));
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
                        PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::CannotInvite));
                        break;
                    }
                    // check /blockaid
                    if (PInvitee->getBlockingAid())
                    {
                        ShowDebug("%s is blocking party invites", PInvitee->getName());
                        // Target is blocking assistance
                        PChar->pushPacket(new CMessageSystemPacket(0, 0, 225));
                        // Interaction was blocked
                        PInvitee->pushPacket(new CMessageSystemPacket(0, 0, 226));
                        // You cannot invite that person at this time.
                        PChar->pushPacket(new CMessageSystemPacket(0, 0, 23));
                        break;
                    }
                    if (PInvitee->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
                    {
                        ShowDebug("%s has level sync, unable to send invite", PInvitee->getName());
                        PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::CannotInviteLevelSync));
                        break;
                    }

                    PInvitee->InvitePending.id     = PChar->id;
                    PInvitee->InvitePending.targid = PChar->targid;
                    PInvitee->pushPacket(new CPartyInvitePacket(charid, targid, PChar, INVITE_PARTY));
                    ShowDebug("Sent party invite packet to %s", PInvitee->getName());
                    if (PChar->PParty && PChar->PParty->GetSyncTarget())
                    {
                        PInvitee->pushPacket(new CMessageStandardPacket(PInvitee, 0, 0, MsgStd::LevelSyncWarning));
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
                    message::send(MSG_PT_INVITE, packetData, sizeof packetData, new CPartyInvitePacket(charid, targid, PChar, INVITE_PARTY));

                    ShowDebug("Sent invite packet to lobby server from %s to (%d)", PChar->getName(), charid);
                }
            }
            else // in party but not leader, cannot invite
            {
                ShowDebug("%s is not party leader, cannot send invite", PChar->getName());
                PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::NotPartyLeader));
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
                        PChar->pushPacket(new CMessageSystemPacket(0, 0, 225));
                        // Interaction was blocked
                        PInvitee->pushPacket(new CMessageSystemPacket(0, 0, 226));
                        // You cannot invite that person at this time.
                        PChar->pushPacket(new CMessageSystemPacket(0, 0, 23));
                        break;
                    }
                    // make sure intvitee isn't dead or in jail, they are an unallied party leader and don't already have an invite pending
                    if (PInvitee->isDead() || jailutils::InPrison(PInvitee) || PInvitee->InvitePending.id != 0 || PInvitee->PParty == nullptr ||
                        PInvitee->PParty->GetLeader() != PInvitee || PInvitee->PParty->m_PAlliance)
                    {
                        ShowDebug("%s is dead, in jail, has a pending invite, or is already in a party/alliance", PInvitee->getName());
                        PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::CannotInvite));
                        break;
                    }
                    if (PInvitee->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
                    {
                        ShowDebug("%s has level sync, unable to send invite", PInvitee->getName());
                        PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::CannotInviteLevelSync));
                        break;
                    }

                    PInvitee->InvitePending.id     = PChar->id;
                    PInvitee->InvitePending.targid = PChar->targid;
                    PInvitee->pushPacket(new CPartyInvitePacket(charid, targid, PChar, INVITE_ALLIANCE));
                    ShowDebug("Sent party invite packet to %s", PInvitee->getName());
                }
                else
                {
                    ShowDebug("(Alliance)Building invite packet to send to lobby server from %s to (%d)", PChar->getName(), charid);
                    // on another server (hopefully)
                    uint8 packetData[12]{};
                    ref<uint32>(packetData, 0)  = charid;
                    ref<uint16>(packetData, 4)  = targid;
                    ref<uint32>(packetData, 6)  = PChar->id;
                    ref<uint16>(packetData, 10) = PChar->targid;
                    message::send(MSG_PT_INVITE, packetData, sizeof packetData, new CPartyInvitePacket(charid, targid, PChar, INVITE_ALLIANCE));

                    ShowDebug("(Alliance)Sent invite packet to lobby server from %s to (%d)", PChar->getName(), charid);
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
            if (PChar->PParty && PChar->PParty->GetLeader() == PChar)
            {
                char charName[PacketNameLength] = {};
                memcpy(&charName, data[0x0C], PacketNameLength - 1);

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
                    char victimName[31]{};
                    sql->EscapeStringLen(victimName, (const char*)data[0x0C], std::min<size_t>(strlen((const char*)data[0x0C]), 15));
                    int32 ret = sql->Query("SELECT charid FROM chars WHERE charname = '%s';", victimName);
                    if (ret != SQL_ERROR && sql->NumRows() == 1 && sql->NextRow() == SQL_SUCCESS)
                    {
                        uint32 id = sql->GetUIntData(0);
                        if (sql->Query("DELETE FROM accounts_parties WHERE partyid = %u AND charid = %u;", PChar->id, id) == SQL_SUCCESS &&
                            sql->AffectedRows())
                        {
                            ShowDebug("%s has removed %s from party", PChar->getName(), str(data[0x0C]));

                            uint8 reloadData[4]{};
                            if (PChar->PParty && PChar->PParty->m_PAlliance)
                            {
                                ref<uint32>(reloadData, 0) = PChar->PParty->m_PAlliance->m_AllianceID;
                                message::send(MSG_ALLIANCE_RELOAD, reloadData, sizeof reloadData, nullptr);
                            }
                            else // No alliance, notify party.
                            {
                                ref<uint32>(reloadData, 0) = PChar->PParty->GetPartyID();
                                message::send(MSG_PT_RELOAD, reloadData, sizeof reloadData, nullptr);
                            }

                            // Notify the player they were just kicked -- they are no longer in the DB and party/alliance reloads won't notify them.
                            ref<uint32>(reloadData, 0) = id;
                            message::send(MSG_PLAYER_KICK, reloadData, sizeof reloadData, nullptr);
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
                int8 packetData[29]{};
                ref<uint32>(packetData, 0) = PChar->id;
                memcpy(packetData + 0x04, data[0x0C], 20);
                ref<uint32>(packetData, 24) = PChar->PLinkshell1->getID();
                ref<uint8>(packetData, 28)  = PItemLinkshell->GetLSType();
                message::send(MSG_LINKSHELL_REMOVE, packetData, sizeof packetData, nullptr);
            }
        }
        break;
        case 2: // linkshell2
        {
            // Ensure the player has a linkshell equipped
            CItemLinkshell* PItemLinkshell = (CItemLinkshell*)PChar->getEquip(SLOT_LINK2);
            if (PChar->PLinkshell2 && PItemLinkshell)
            {
                int8 packetData[29]{};
                ref<uint32>(packetData, 0) = PChar->id;
                memcpy(packetData + 0x04, data[0x0C], 20);
                ref<uint32>(packetData, 24) = PChar->PLinkshell2->getID();
                ref<uint8>(packetData, 28)  = PItemLinkshell->GetLSType();
                message::send(MSG_LINKSHELL_REMOVE, packetData, sizeof packetData, nullptr);
            }
        }
        break;

        case 5: // alliance - alliance leader may kick a party by using that party's leader as kick parameter
            if (PChar->PParty && PChar->PParty->GetLeader() == PChar && PChar->PParty->m_PAlliance)
            {
                CCharEntity* PVictim = nullptr;
                for (std::size_t i = 0; i < PChar->PParty->m_PAlliance->partyList.size(); ++i)
                {
                    char charName[PacketNameLength] = {};
                    memcpy(&charName, data[0x0C], PacketNameLength - 1);

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
                    char   victimName[31]{};
                    uint32 allianceID = PChar->PParty->m_PAlliance->m_AllianceID;

                    sql->EscapeStringLen(victimName, (const char*)data[0x0C], std::min<size_t>(strlen((const char*)data[0x0C]), 15));
                    int32 ret = sql->Query("SELECT charid FROM chars WHERE charname = '%s';", victimName);
                    if (ret != SQL_ERROR && sql->NumRows() == 1 && sql->NextRow() == SQL_SUCCESS)
                    {
                        uint32 charid = sql->GetUIntData(0);
                        ret           = sql->Query(
                                      "SELECT partyid FROM accounts_parties WHERE charid = %u AND allianceid = %u AND partyflag & %d",
                                      charid, PChar->PParty->m_PAlliance->m_AllianceID, PARTY_LEADER | PARTY_SECOND | PARTY_THIRD);
                        if (ret != SQL_ERROR && sql->NumRows() == 1 && sql->NextRow() == SQL_SUCCESS)
                        {
                            uint32 partyid = sql->GetUIntData(0);
                            if (sql->Query("UPDATE accounts_parties SET allianceid = 0, partyflag = partyflag & ~%d WHERE partyid = %u;",
                                           PARTY_SECOND | PARTY_THIRD, partyid) == SQL_SUCCESS &&
                                sql->AffectedRows())
                            {
                                ShowDebug("%s has removed %s party from alliance", PChar->getName(), str(data[0x0C]));
                                // notify party they were removed
                                uint8 removeData[4]{};
                                ref<uint32>(removeData, 0) = partyid;
                                message::send(MSG_PT_RELOAD, removeData, sizeof removeData, nullptr);

                                // notify alliance a party was removed
                                ref<uint32>(removeData, 0) = allianceID;
                                message::send(MSG_ALLIANCE_RELOAD, removeData, sizeof removeData, nullptr);
                            }
                        }
                    }
                }
            }
            break;

        default:
            ShowError("SmallPacket0x071 : unknown byte <%.2X>", data.ref<uint8>(0x0A));
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
            PInviter->pushPacket(new CMessageStandardPacket(PInviter, 0, 0, MsgStd::InvitationDeclined));
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
                        PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::CannotBeProcessed));
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
                    PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::TrustCannotJoinAlliance));
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
                        // PInviter->pushPacket(new CMessageStandardPacket(PInviter, 0, 0, 14)); Don't think retail sends error packet to inviter on full pt
                        ShowDebug("Someone else accepted party invite, %s cannot be added to party", PChar->getName());
                        PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::CannotBeProcessed));
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
                PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::CannotJoinLevelSync));
            }
        }
    }
    else
    {
        ShowDebug("(Party)Building invite packet to send to lobby server for %s", PChar->getName());
        uint8 packetData[13]{};
        ref<uint32>(packetData, 0)  = PChar->InvitePending.id;
        ref<uint16>(packetData, 4)  = PChar->InvitePending.targid;
        ref<uint32>(packetData, 6)  = PChar->id;
        ref<uint16>(packetData, 10) = PChar->targid;
        ref<uint8>(packetData, 12)  = InviteAnswer;
        PChar->InvitePending.clean();
        message::send(MSG_PT_INV_RES, packetData, sizeof packetData, nullptr);
        ShowDebug("(Party)Sent invite packet to send to lobby server for %s", PChar->getName());
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
        PChar->pushPacket(new CPartyDefinePacket(nullptr, false));
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
                char memberName[PacketNameLength] = {};
                memcpy(&memberName, data[0x04], PacketNameLength - 1);

                ShowDebug(fmt::format("(Party)Altering permissions of {} to {}", str(memberName), str(data[0x15])));
                PChar->PParty->AssignPartyRole(memberName, data.ref<uint8>(0x15));
            }
        }
        break;
        case 1: // linkshell
        {
            if (PChar->PLinkshell1 != nullptr)
            {
                int8 packetData[29]{};
                ref<uint32>(packetData, 0) = PChar->id;
                memcpy(packetData + 0x04, data[0x04], 20);
                ref<uint32>(packetData, 24) = PChar->PLinkshell1->getID();
                ref<uint8>(packetData, 28)  = data.ref<uint8>(0x15);
                message::send(MSG_LINKSHELL_RANK_CHANGE, packetData, sizeof packetData, nullptr);
            }
        }
        break;
        case 2: // linkshell2
        {
            if (PChar->PLinkshell2 != nullptr)
            {
                int8 packetData[29]{};
                ref<uint32>(packetData, 0) = PChar->id;
                memcpy(packetData + 0x04, data[0x04], 20);
                ref<uint32>(packetData, 24) = PChar->PLinkshell2->getID();
                ref<uint8>(packetData, 28)  = data.ref<uint8>(0x15);
                message::send(MSG_LINKSHELL_RANK_CHANGE, packetData, sizeof packetData, nullptr);
            }
        }
        break;
        case 5: // alliance
        {
            if (PChar->PParty && PChar->PParty->m_PAlliance && PChar->PParty->GetLeader() == PChar &&
                PChar->PParty->m_PAlliance->getMainParty() == PChar->PParty)
            {
                char memberName[PacketNameLength] = {};
                memcpy(&memberName, data[0x04], PacketNameLength - 1);

                ShowDebug(fmt::format("(Alliance)Changing leader to {}", str(memberName)));
                PChar->PParty->m_PAlliance->assignAllianceLeader(str(data[0x04]).c_str());

                uint8 allianceData[4]{};
                ref<uint32>(allianceData, 0) = PChar->PParty->m_PAlliance->m_AllianceID;
                message::send(MSG_ALLIANCE_RELOAD, allianceData, sizeof allianceData, nullptr);
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
    PChar->pushPacket(new CPartySearchPacket(PChar));
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
        if (gil->getQuantity() >= (price * quantity))
        {
            uint8 SlotID = charutils::AddItem(PChar, LOC_INVENTORY, itemID, quantity);

            if (SlotID != ERROR_SLOTID)
            {
                charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -(int32)(price * quantity));
                ShowInfo("User '%s' purchased %u of item of ID %u [from VENDOR] ", PChar->getName(), quantity, itemID);
                PChar->pushPacket(new CShopBuyPacket(shopSlotID, quantity));
                PChar->pushPacket(new CInventoryFinishPacket());
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
    if (PChar->animation != ANIMATION_SYNTH)
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
            PChar->pushPacket(new CShopAppraisePacket(slotID, PItem->getBasePrice()));
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

    if ((PItem != nullptr) && ((gil != nullptr) && gil->isType(ITEM_CURRENCY)))
    {
        if (quantity < 1 || quantity > PItem->getStackSize()) // Possible exploit
        {
            ShowWarning("SmallPacket0x085: Player %s trying to sell invalid quantity %u of itemID %u [to VENDOR] ",
                        PChar->getName(), quantity, PItem->getID());
            return;
        }

        if (PItem->isSubType(ITEM_LOCKED)) // Possible exploit
        {
            ShowWarning("SmallPacket0x085: Player %s trying to sell %u of a LOCKED item! ID %i [to VENDOR] ",
                        PChar->getName(), quantity, PItem->getID());
            return;
        }

        if (PItem->getReserve() > 0) // Usually caused by bug during synth, trade, etc. reserving the item. We don't want such items sold in this state.
        {
            ShowError("SmallPacket0x085: Player %s trying to sell %u of a RESERVED(%u) item! ID %i [to VENDOR] ",
                      PChar->getName(), quantity, PItem->getReserve(), PItem->getID());
            return;
        }

        charutils::UpdateItem(PChar, LOC_INVENTORY, 0, quantity * PItem->getBasePrice());
        charutils::UpdateItem(PChar, LOC_INVENTORY, slotID, -(int32)quantity);
        ShowInfo("SmallPacket0x085: Player '%s' sold %u of itemID %u [to VENDOR] ", PChar->getName(), quantity, itemID);
        PChar->pushPacket(new CMessageStandardPacket(nullptr, itemID, quantity, MsgStd::Sell));
        PChar->pushPacket(new CInventoryFinishPacket());
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
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
        return;
    }

    // If the player is already crafting, don't allow them to craft.
    // This prevents packet injection based multi-craft, or time-based exploits.
    if (PChar->animation == ANIMATION_SYNTH)
    {
        return;
    }

    // Force full synth duration wait no matter the synth animation length
    // Thus players can synth on whatever fps they want
    if (PChar->m_LastSynthTime + 15s > server_clock::now())
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 94));
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
            PTarget->pushPacket(new CTradeActionPacket(PChar, 0x01));
            PChar->pushPacket(new CTradeActionPacket(PTarget, 0x01));
        }
        PChar->pushPacket(new CMessageStandardPacket(MsgStd::CannotBeProcessed));
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
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
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

    if (((gil != nullptr) && gil->isType(ITEM_CURRENCY)) && item != nullptr && item->getQuantity() >= quantity)
    {
        if (gil->getQuantity() > (item->getBasePrice() * quantity))
        {
            uint8 SlotID = charutils::AddItem(PChar, LOC_INVENTORY, itemID, quantity);

            if (SlotID != ERROR_SLOTID)
            {
                charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -(int32)(item->getBasePrice() * quantity));
                ShowInfo("SmallPacket0x0AA: Player '%s' purchased %u of itemID %u [from GUILD] ", PChar->getName(), quantity, itemID);
                PChar->PGuildShop->GetItem(shopSlotID)->setQuantity(PChar->PGuildShop->GetItem(shopSlotID)->getQuantity() - quantity);
                PChar->pushPacket(
                    new CGuildMenuBuyUpdatePacket(PChar, PChar->PGuildShop->GetItem(PChar->PGuildShop->SearchItem(itemID))->getQuantity(), itemID, quantity));
                PChar->pushPacket(new CInventoryFinishPacket());
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

    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CMessageStandardPacket(PChar, diceroll, MsgStd::DiceRoll));
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
        PChar->pushPacket(new CGuildMenuBuyPacket(PChar, PChar->PGuildShop));
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
    if (PChar->animation != ANIMATION_SYNTH)
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
                    PChar->pushPacket(new CGuildMenuSellUpdatePacket(PChar, PChar->PGuildShop->GetItem(PChar->PGuildShop->SearchItem(itemID))->getQuantity(),
                                                                     itemID, quantity));
                    PChar->pushPacket(new CInventoryFinishPacket());
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
        PChar->pushPacket(new CGuildMenuSellPacket(PChar, PChar->PGuildShop));
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

    memcpy(&message, data[messagePosition], std::min(data.getSize() - messagePosition, sizeof(message)));

    if (data.ref<uint8>(0x06) == '!' && !jailutils::InPrison(PChar) && CCommandHandler::call(lua, PChar, message) == 0)
    {
        // this makes sure a command isn't sent to chat
    }
    else if (data.ref<uint8>(0x06) == '#' && PChar->m_GMlevel > 0)
    {
        message::send(MSG_CHAT_SERVMES, nullptr, 0, new CChatMessagePacket(PChar, MESSAGE_SYSTEM_1, (const char*)data[7]));
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
                    // NOTE: We capture rawMessage as a std::string because if we cast data[6] into a const char*, the underlying data might
                    //     : be gone by the time we action this lambda on the worker thread.
                    Async::getInstance()->query([name = PChar->getName(), rawMessage = std::string((const char*)data[6])](SqlConnection* _sql)
                    {
                        auto message = _sql->EscapeString(rawMessage);
                        std::ignore  = _sql->Query("INSERT INTO audit_chat (speaker,type,message,datetime) VALUES('%s','SAY','%s',current_timestamp())",
                            name.c_str(), message.c_str());
                    });
                    // clang-format on
                }
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CChatMessagePacket(PChar, MESSAGE_SAY, (const char*)data[6]));
            }
            else
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANT_BE_USED_IN_AREA));
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
                        // NOTE: We capture rawMessage as a std::string because if we cast data[6] into a const char*, the underlying data might
                        //     : be gone by the time we action this lambda on the worker thread.
                        Async::getInstance()->query([name = PChar->getName(), rawMessage = std::string((const char*)data[6])](SqlConnection* _sql)
                        {
                            auto message = _sql->EscapeString(rawMessage);
                            std::ignore  = _sql->Query("INSERT INTO audit_chat (speaker,type,message,datetime) VALUES('%s','SAY','%s',current_timestamp())",
                                name.c_str(), message.c_str());
                        });
                        // clang-format on
                    }
                    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CChatMessagePacket(PChar, MESSAGE_SAY, (const char*)data[6]));
                }
                break;
                case MESSAGE_EMOTION:
                {
                    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CChatMessagePacket(PChar, MESSAGE_EMOTION, (const char*)data[6]));
                }
                break;
                case MESSAGE_SHOUT:
                {
                    if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_SHOUT"))
                    {
                        // clang-format off
                        // NOTE: We capture rawMessage as a std::string because if we cast data[6] into a const char*, the underlying data might
                        //     : be gone by the time we action this lambda on the worker thread.
                        Async::getInstance()->query([name = PChar->getName(), rawMessage = std::string((const char*)data[6])](SqlConnection* _sql)
                        {
                            auto message = _sql->EscapeString(rawMessage);
                            std::ignore  = _sql->Query("INSERT INTO audit_chat (speaker,type,message,datetime) VALUES('%s','SHOUT','%s',current_timestamp())",
                                name.c_str(), message.c_str());
                        });
                        // clang-format on
                    }
                    PChar->loc.zone->PushPacket(PChar, CHAR_INSHOUT, new CChatMessagePacket(PChar, MESSAGE_SHOUT, (const char*)data[6]));
                }
                break;
                case MESSAGE_LINKSHELL:
                {
                    if (PChar->PLinkshell1 != nullptr)
                    {
                        int8 packetData[8]{};
                        ref<uint32>(packetData, 0) = PChar->PLinkshell1->getID();
                        ref<uint32>(packetData, 4) = PChar->id;
                        message::send(MSG_CHAT_LINKSHELL, packetData, sizeof packetData,
                                      new CChatMessagePacket(PChar, MESSAGE_LINKSHELL, (const char*)data[6]));

                        if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_LINKSHELL"))
                        {
                            char decodedLinkshellName[DecodeStringLength];
                            DecodeStringLinkshell(PChar->PLinkshell1->getName(), decodedLinkshellName);
                            // clang-format off
                            // NOTE: We capture rawMessage as a std::string because if we cast data[6] into a const char*, the underlying data might
                            //     : be gone by the time we action this lambda on the worker thread.
                            Async::getInstance()->query([name = PChar->getName(), rawMessage = std::string((const char*)data[6]), decodedLinkshellName](SqlConnection* _sql)
                            {
                                auto message = _sql->EscapeString(rawMessage);
                                std::ignore  = _sql->Query("INSERT INTO audit_chat (speaker,type,lsName,message,datetime) VALUES('%s','LINKSHELL','%s','%s',current_timestamp())",
                                    name.c_str(), decodedLinkshellName, message.c_str());
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
                        message::send(MSG_CHAT_LINKSHELL, packetData, sizeof packetData,
                                      new CChatMessagePacket(PChar, MESSAGE_LINKSHELL, (const char*)data[6]));

                        if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_LINKSHELL"))
                        {
                            char decodedLinkshellName[DecodeStringLength];
                            DecodeStringLinkshell(PChar->PLinkshell2->getName(), decodedLinkshellName);
                            // clang-format off
                            // NOTE: We capture rawMessage as a std::string because if we cast data[6] into a const char*, the underlying data might
                            //     : be gone by the time we action this lambda on the worker thread.
                            Async::getInstance()->query([name = PChar->getName(), rawMessage = std::string((const char*)data[6]), decodedLinkshellName](SqlConnection* _sql)
                            {
                                auto message = _sql->EscapeString(rawMessage);
                                std::ignore  = _sql->Query("INSERT INTO audit_chat (speaker,type,lsName,message,datetime) VALUES('%s','LINKSHELL','%s','%s',current_timestamp())",
                                    name.c_str(), decodedLinkshellName, message.c_str());
                            });
                        }
                    }
                }
                break;
                case MESSAGE_PARTY:
                {
                    if (PChar->PParty != nullptr)
                    {
                        int8 packetData[8]{};
                        if(PChar->PParty->m_PAlliance)
                        {
                            ref<uint32>(packetData, 0) = PChar->PParty->m_PAlliance->m_AllianceID;
                            ref<uint32>(packetData, 4) = PChar->id;
                            message::send(MSG_CHAT_ALLIANCE, packetData, sizeof packetData, new CChatMessagePacket(PChar, MESSAGE_PARTY, (const char*)data[6]));
                        }
                        else
                        {
                            ref<uint32>(packetData, 0) = PChar->PParty->GetPartyID();
                            ref<uint32>(packetData, 4) = PChar->id;
                            message::send(MSG_CHAT_PARTY, packetData, sizeof packetData, new CChatMessagePacket(PChar, MESSAGE_PARTY, (const char*)data[6]));
                        }

                        if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_PARTY"))
                        {
                            // clang-format off
                            // NOTE: We capture rawMessage as a std::string because if we cast data[6] into a const char*, the underlying data might
                            //     : be gone by the time we action this lambda on the worker thread.
                            Async::getInstance()->query([name = PChar->getName(), rawMessage = std::string((const char*)data[6])](SqlConnection* _sql)
                            {
                                auto message = _sql->EscapeString(rawMessage);
                                std::ignore  = _sql->Query("INSERT INTO audit_chat (speaker,type,message,datetime) VALUES('%s','PARTY','%s',current_timestamp())",
                                    name.c_str(), message.c_str());
                            });
                            // clang-format on
                        }
                    }
                }
                break;
                case MESSAGE_YELL:
                {
                    if (PChar->loc.zone->CanUseMisc(MISC_YELL))
                    {
                        if (gettick() >= PChar->m_LastYell)
                        {
                            PChar->m_LastYell = gettick() + settings::get<uint16>("map.YELL_COOLDOWN") * 1000;
                            int8 packetData[4]{};
                            ref<uint32>(packetData, 0) = PChar->id;

                            message::send(MSG_CHAT_YELL, packetData, sizeof packetData, new CChatMessagePacket(PChar, MESSAGE_YELL, (const char*)data[6]));
                        }
                        else // You must wait longer to perform that action.
                        {
                            PChar->pushPacket(new CMessageStandardPacket(PChar, 0, MsgStd::WaitLonger));
                        }

                        if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_YELL"))
                        {
                            // clang-format off
                            // NOTE: We capture rawMessage as a std::string because if we cast data[6] into a const char*, the underlying data might
                            //     : be gone by the time we action this lambda on the worker thread.
                            Async::getInstance()->query([name = PChar->getName(), rawMessage = std::string((const char*)data[6])](SqlConnection* _sql)
                            {
                                auto message = _sql->EscapeString(rawMessage);
                                std::ignore  = _sql->Query("INSERT INTO audit_chat (speaker,type,message,datetime) VALUES('%s','YELL','%s',current_timestamp())",
                                    name.c_str(), message.c_str());
                            });
                            // clang-format on
                        }
                    }
                    else // You cannot use that command in this area.
                    {
                        PChar->pushPacket(new CMessageStandardPacket(PChar, 0, MsgStd::CannotHere));
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
                        message::send(MSG_CHAT_UNITY, packetData, sizeof packetData,
                                      new CChatMessagePacket(PChar, MESSAGE_UNITY, (const char*)data[6]));

                        roeutils::event(ROE_EVENT::ROE_UNITY_CHAT, PChar, RoeDatagram("unityMessage", (const char*)data[6]));

                        if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<uint8>("map.AUDIT_UNITY"))
                        {
                            // clang-format off
                            // NOTE: We capture rawMessage as a std::string because if we cast data[6] into a const char*, the underlying data might
                            //     : be gone by the time we action this lambda on the worker thread.
                            Async::getInstance()->query([name = PChar->getName(), rawMessage = std::string((const char*)data[6])](SqlConnection* _sql)
                            {
                                auto message = _sql->EscapeString(rawMessage);
                                std::ignore  = _sql->Query("INSERT INTO audit_chat (speaker,type,message,datetime) VALUES('%s','UNITY','%s',current_timestamp())",
                                    name.c_str(), message.c_str());
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
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
        return;
    }

    std::string RecipientName = std::string((const char*)data[6], 15);

    char  message[256]    = {}; // /t messages using "<t>" with a long named NPC targeted caps out at 138 bytes, increasing to the nearest power of 2
    uint8 messagePosition = 0x15;

    memcpy(&message, data[messagePosition], std::min(data.getSize() - messagePosition, sizeof(message)));

    if (strcmp(RecipientName.c_str(), "_CUSTOM_MENU") == 0 &&
        luautils::HasCustomMenuContext(PChar))
    {
        luautils::HandleCustomMenu(PChar, message);
        return;
    }

    int8 packetData[64]{};
    strncpy((char*)packetData + 4, RecipientName.c_str(), RecipientName.length() + 1);
    ref<uint32>(packetData, 0) = PChar->id;

    message::send(MSG_CHAT_TELL, packetData, RecipientName.length() + 5, new CChatMessagePacket(PChar, MESSAGE_TELL, message));

    if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<bool>("map.AUDIT_TELL"))
    {
        char escaped_speaker[16 * 2 + 1];
        sql->EscapeString(escaped_speaker, PChar->getName().c_str());

        char escaped_recipient[16 * 2 + 1];
        sql->EscapeString(escaped_recipient, &RecipientName[0]);

        std::string escaped_full_string;
        escaped_full_string.reserve(strlen((const char*)data[21]) * 2 + 1);
        sql->EscapeString(escaped_full_string.data(), (const char*)data[21]);

        const char* fmtQuery = "INSERT into audit_chat (speaker,type,recipient,message,datetime) VALUES('%s','TELL','%s','%s',current_timestamp())";
        if (sql->Query(fmtQuery, escaped_speaker, escaped_recipient, escaped_full_string.data()) == SQL_ERROR)
        {
            ShowError("packet_system::call: Failed to log MESSAGE_TELL.");
        }
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
            if (sql->Query("UPDATE char_exp SET mode = %u WHERE charid = %u", operation, PChar->id) != SQL_ERROR)
            {
                PChar->MeritMode = operation;
                PChar->pushPacket(new CMenuMeritPacket(PChar));
                PChar->pushPacket(new CMonipulatorPacket1(PChar));
                PChar->pushPacket(new CMonipulatorPacket2(PChar));
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
                            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, data.ref<uint16>(0x06), PMerit->count, MSGBASIC_MERIT_DECREASE));
                            break;
                        case 1:
                            PChar->PMeritPoints->RaiseMerit(merit);
                            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, data.ref<uint16>(0x06), PMerit->count, MSGBASIC_MERIT_INCREASE));
                            break;
                    }
                    PChar->pushPacket(new CMenuMeritPacket(PChar));
                    PChar->pushPacket(new CMonipulatorPacket1(PChar));
                    PChar->pushPacket(new CMonipulatorPacket2(PChar));
                    PChar->pushPacket(new CMeritPointsCategoriesPacket(PChar, merit));

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
                    PChar->pushPacket(new CCharUpdatePacket(PChar));
                    PChar->pushPacket(new CCharStatsPacket(PChar));
                    PChar->pushPacket(new CCharSkillsPacket(PChar));
                    PChar->pushPacket(new CCharRecastPacket(PChar));
                    PChar->pushPacket(new CCharAbilitiesPacket(PChar));
                    PChar->pushPacket(new CCharJobExtraPacket(PChar, true));
                    PChar->pushPacket(new CCharJobExtraPacket(PChar, true));
                    PChar->pushPacket(new CCharSyncPacket(PChar));
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
            PChar->pushPacket(new CMenuJobPointsPacket(PChar));
            PChar->pushPacket(new CJobPointUpdatePacket(PChar, jpType));
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
        PChar->pushPacket(new CJobPointDetailsPacket(PChar));
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
            memcpy(PItemLinkPearl->m_extra, PItemLinkshell->m_extra, 24);
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

            memset(&DecodedName, 0, sizeof(DecodedName));
            memset(&EncodedName, 0, sizeof(EncodedName));

            char* decodePtr = reinterpret_cast<char*>(data[12]);
            DecodeStringLinkshell(decodePtr, DecodedName);
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
                sql->EscapeStringLen(extra, (const char*)PItemLinkshell->m_extra, sizeof(PItemLinkshell->m_extra));

                const char* Query =
                    "UPDATE char_inventory SET signature = '%s', extra = '%s', itemId = 513 WHERE charid = %u AND location = 0 AND slot = %u LIMIT 1";

                if (sql->Query(Query, DecodedName, extra, PChar->id, SlotID) != SQL_ERROR && sql->AffectedRows() != 0)
                {
                    PChar->pushPacket(new CInventoryItemPacket(PItemLinkshell, LocationID, SlotID));
                }
            }
            else
            {
                PChar->pushPacket(new CMessageStandardPacket(MsgStd::LinkshellUnavailable));
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
                        PChar->nameflags.flags &= ~FLAG_LINKSHELL;
                        PChar->updatemask |= UPDATE_HP;
                    }

                    PChar->pushPacket(new CInventoryAssignPacket(PItemLinkshell, INV_NORMAL));
                }
                break;
                case 1: // equip linkshell
                {
                    auto ret = sql->Query("SELECT broken FROM linkshells WHERE linkshellid = %u LIMIT 1", PItemLinkshell->GetLSID());
                    if (ret != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS && sql->GetUIntData(0) == 1)
                    { // if the linkshell has been broken, break the item
                        PItemLinkshell->SetLSType(LSTYPE_BROKEN);
                        char extra[sizeof(PItemLinkshell->m_extra) * 2 + 1];
                        sql->EscapeStringLen(extra, (const char*)PItemLinkshell->m_extra, sizeof(PItemLinkshell->m_extra));
                        const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u LIMIT 1";
                        sql->Query(Query, extra, PChar->id, PItemLinkshell->getLocationID(), PItemLinkshell->getSlotID());
                        PChar->pushPacket(new CInventoryItemPacket(PItemLinkshell, PItemLinkshell->getLocationID(), PItemLinkshell->getSlotID()));
                        PChar->pushPacket(new CInventoryFinishPacket());
                        PChar->pushPacket(new CMessageStandardPacket(MsgStd::LinkshellNoLongerExists));
                        return;
                    }
                    if (PItemLinkshell->GetLSID() == 0)
                    {
                        PChar->pushPacket(new CMessageStandardPacket(MsgStd::LinkshellNoLongerExists));
                        return;
                    }
                    if (OldLinkshell != nullptr) // switching linkshell group
                    {
                        CItemLinkshell* POldItemLinkshell = (CItemLinkshell*)PChar->getEquip(slot);

                        if (POldItemLinkshell != nullptr && POldItemLinkshell->isType(ITEM_LINKSHELL))
                        {
                            linkshell::DelOnlineMember(PChar, POldItemLinkshell);

                            POldItemLinkshell->setSubType(ITEM_UNLOCKED);
                            PChar->pushPacket(new CInventoryAssignPacket(POldItemLinkshell, INV_NORMAL));
                        }
                    }
                    linkshell::AddOnlineMember(PChar, PItemLinkshell, lsNum);

                    PItemLinkshell->setSubType(ITEM_LOCKED);

                    PChar->equip[slot]    = SlotID;
                    PChar->equipLoc[slot] = LocationID;
                    if (lsNum == 1)
                    {
                        PChar->nameflags.flags |= FLAG_LINKSHELL;
                        PChar->updatemask |= UPDATE_HP;
                    }

                    PChar->pushPacket(new CInventoryAssignPacket(PItemLinkshell, INV_LINKSHELL));
                }
                break;
            }
            charutils::SaveCharStats(PChar);
            charutils::SaveCharEquip(PChar);

            PChar->pushPacket(new CLinkshellEquipPacket(PChar, lsNum));
            PChar->pushPacket(new CInventoryItemPacket(PItemLinkshell, LocationID, SlotID));
        }
        PChar->pushPacket(new CInventoryFinishPacket());
        PChar->pushPacket(new CCharUpdatePacket(PChar));
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
            PChar->pushPacket(new CPartyMapPacket((CCharEntity*)PPartyMember));
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

    auto oldMenuConfigFlags = PChar->menuConfigFlags.flags;
    auto oldChatFilterFlags = PChar->chatFilterFlags;
    auto oldLanguages       = PChar->search.language;

    // Extract the system filter bits and update MenuConfig
    const uint8 systemFilterMask = (NFLAG_SYSTEM_FILTER_H | NFLAG_SYSTEM_FILTER_L) >> 8;
    PChar->menuConfigFlags.byte2 &= ~systemFilterMask;
    PChar->menuConfigFlags.byte2 |= data.ref<uint8>(0x09) & systemFilterMask;

    PChar->chatFilterFlags = data.ref<uint64>(0x0C);

    PChar->search.language = data.ref<uint8>(0x24);

    if (oldMenuConfigFlags != PChar->menuConfigFlags.flags)
    {
        charutils::SaveMenuConfigFlags(PChar);
    }

    if (oldChatFilterFlags != PChar->chatFilterFlags)
    {
        charutils::SaveChatFilterFlags(PChar);
    }

    if (oldLanguages != PChar->search.language)
    {
        charutils::SaveLanguages(PChar);
    }

    PChar->pushPacket(new CMenuConfigPacket(PChar));
}

/************************************************************************
 *                                                                       *
 *  Set Name Flags (Party, Away, Autogroup, etc.)                        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0DC(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    switch (data.ref<uint32>(0x04))
    {
        case NFLAG_INVITE:
            // /invite [on|off]
            if (PChar->PParty)
            {
                // Can't put flag up while in a party
                PChar->nameflags.flags &= ~FLAG_INVITE;
            }
            else
            {
                PChar->nameflags.flags ^= FLAG_INVITE;
            }
            break;
        case NFLAG_AWAY:
            // /away | /online
            if (data.ref<uint8>(0x10) == 1)
            {
                PChar->nameflags.flags |= FLAG_AWAY;
            }
            if (data.ref<uint8>(0x10) == 2)
            {
                PChar->nameflags.flags &= ~FLAG_AWAY;
            }
            break;
        case NFLAG_ANON:
        {
            // /anon [on|off]
            auto flags = PChar->nameflags.flags;
            auto param = data.ref<uint8>(0x10);
            if (param == 1)
            {
                PChar->nameflags.flags |= FLAG_ANON;
                PChar->menuConfigFlags.flags |= NFLAG_ANON;
            }
            else if (param == 2)
            {
                PChar->nameflags.flags &= ~FLAG_ANON;
                PChar->menuConfigFlags.flags &= ~NFLAG_ANON;
            }
            if (flags != PChar->nameflags.flags)
            {
                PChar->pushPacket(new CMessageSystemPacket(0, 0, param == 1 ? 175 : 176));
            }
            break;
        }
        case NFLAG_AUTOTARGET:
            // /autotarget [on|off]
            if (data.ref<uint8>(0x10) == 1)
            {
                PChar->m_hasAutoTarget = false;
            }
            if (data.ref<uint8>(0x10) == 2)
            {
                PChar->m_hasAutoTarget = true;
            }
            break;
        case NFLAG_AUTOGROUP:
            // /autogroup [on|off]
            if (data.ref<uint8>(0x10) == 1)
            {
                PChar->menuConfigFlags.flags |= NFLAG_AUTOGROUP;
            }
            if (data.ref<uint8>(0x10) == 2)
            {
                PChar->menuConfigFlags.flags &= ~NFLAG_AUTOGROUP;
            }
            break;
        case NFLAG_MENTOR:
            // /mentor [on|off]
            if (data.ref<uint8>(0x10) == 1)
            {
                PChar->menuConfigFlags.flags |= NFLAG_MENTOR;
            }
            else if (data.ref<uint8>(0x10) == 2)
            {
                PChar->menuConfigFlags.flags &= ~NFLAG_MENTOR;
            }
            break;
        case NFLAG_NEWPLAYER:
            // Cancel new adventurer status.
            if (data.ref<uint8>(0x10) == 1)
            {
                PChar->menuConfigFlags.flags |= NFLAG_NEWPLAYER;
            }
            break;
        case NFLAG_DISPLAY_HEAD:
        {
            // /displayhead [on|off]
            auto flags = PChar->menuConfigFlags.byte4;
            auto param = data.ref<uint8>(0x10);
            if (param == 1)
            {
                PChar->menuConfigFlags.flags |= NFLAG_DISPLAY_HEAD;
            }
            else if (param == 2)
            {
                PChar->menuConfigFlags.flags &= ~NFLAG_DISPLAY_HEAD;
            }

            // This should only check that the display head bit has changed, since
            // a user gaining mentorship or losing new adventurer status at the
            // same time this code is called. Since it is unlikely that situation
            // would occur and the negative impact would be displaying the headgear
            // message twice, it isn't worth checking. If additional bits are found
            // in this flag, that assumption may need to be re-evaluated.
            if (flags != PChar->menuConfigFlags.byte4)
            {
                PChar->pushPacket(new CCharAppearancePacket(PChar));
                PChar->pushPacket(new CMessageStandardPacket(param == 1 ? MsgStd::HeadgearHide : MsgStd::HeadgearShow));
            }
            break;
        }
        case NFLAG_RECRUIT:
            // /recruit [on|off]
            if (data.ref<uint8>(0x10) == 1)
            {
                PChar->menuConfigFlags.flags |= NFLAG_RECRUIT;
            }
            if (data.ref<uint8>(0x10) == 2)
            {
                PChar->menuConfigFlags.flags &= ~NFLAG_RECRUIT;
            }
            break;
    }

    charutils::SaveCharStats(PChar);
    charutils::SaveMenuConfigFlags(PChar);
    PChar->pushPacket(new CMenuConfigPacket(PChar));
    PChar->pushPacket(new CCharUpdatePacket(PChar));
    PChar->pushPacket(new CCharSyncPacket(PChar));
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
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CHECKPARAM_NAME));
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CHECKPARAM_ILVL));
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, PChar->ACC(0, 0), PChar->ATT(), MSGBASIC_CHECKPARAM_PRIMARY));
            if (PChar->getEquip(SLOT_SUB) && PChar->getEquip(SLOT_SUB)->isType(ITEM_WEAPON))
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, PChar->ACC(1, 0), PChar->ATT(), MSGBASIC_CHECKPARAM_AUXILIARY));
            }
            else
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CHECKPARAM_AUXILIARY));
            }
            if (PChar->getEquip(SLOT_RANGED) && PChar->getEquip(SLOT_RANGED)->isType(ITEM_WEAPON))
            {
                int skill      = ((CItemWeapon*)PChar->getEquip(SLOT_RANGED))->getSkillType();
                int bonusSkill = ((CItemWeapon*)PChar->getEquip(SLOT_RANGED))->getILvlSkill();
                PChar->pushPacket(
                    new CMessageBasicPacket(PChar, PChar, PChar->RACC(skill, bonusSkill), PChar->RATT(skill, bonusSkill), MSGBASIC_CHECKPARAM_RANGE));
            }
            else if (PChar->getEquip(SLOT_AMMO) && PChar->getEquip(SLOT_AMMO)->isType(ITEM_WEAPON))
            {
                int skill      = ((CItemWeapon*)PChar->getEquip(SLOT_AMMO))->getSkillType();
                int bonusSkill = ((CItemWeapon*)PChar->getEquip(SLOT_AMMO))->getILvlSkill();
                PChar->pushPacket(
                    new CMessageBasicPacket(PChar, PChar, PChar->RACC(skill, bonusSkill), PChar->RATT(skill, bonusSkill), MSGBASIC_CHECKPARAM_RANGE));
            }
            else
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CHECKPARAM_RANGE));
            }
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, PChar->EVA(), PChar->DEF(), MSGBASIC_CHECKPARAM_DEFENSE));
        }
        else if (PChar->PPet && PChar->PPet->id == id)
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar->PPet, 0, 0, MSGBASIC_CHECKPARAM_NAME));
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar->PPet, PChar->PPet->ACC(0, 0), PChar->PPet->ATT(), MSGBASIC_CHECKPARAM_PRIMARY));
            if (PChar->getEquip(SLOT_SUB) && PChar->getEquip(SLOT_SUB)->isType(ITEM_WEAPON))
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar->PPet, PChar->PPet->ACC(1, 0), PChar->PPet->ATT(), MSGBASIC_CHECKPARAM_AUXILIARY));
            }
            else
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar->PPet, 0, 0, MSGBASIC_CHECKPARAM_AUXILIARY));
            }
            if (PChar->getEquip(SLOT_RANGED) && PChar->getEquip(SLOT_RANGED)->isType(ITEM_WEAPON))
            {
                int skill = ((CItemWeapon*)PChar->getEquip(SLOT_RANGED))->getSkillType();
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar->PPet, PChar->PPet->RACC(skill), PChar->PPet->RATT(skill), MSGBASIC_CHECKPARAM_RANGE));
            }
            else if (PChar->getEquip(SLOT_AMMO) && PChar->getEquip(SLOT_AMMO)->isType(ITEM_WEAPON))
            {
                int skill = ((CItemWeapon*)PChar->getEquip(SLOT_AMMO))->getSkillType();
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar->PPet, PChar->PPet->RACC(skill), PChar->PPet->RATT(skill), MSGBASIC_CHECKPARAM_RANGE));
            }
            else
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar->PPet, 0, 0, MSGBASIC_CHECKPARAM_RANGE));
            }
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar->PPet, PChar->PPet->EVA(), PChar->PPet->DEF(), MSGBASIC_CHECKPARAM_DEFENSE));
        }
    }
    else
    {
        if (jailutils::InPrison(PChar))
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
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
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PTarget, 0, 0, 249));
                }
                else
                {
                    uint8          mobLvl   = PTarget->GetMLevel();
                    EMobDifficulty mobCheck = charutils::CheckMob(PChar->GetMLevel(), mobLvl);

                    // Calculate main /check message (64 is Too Weak)
                    int32 MessageValue = 64 + (uint8)mobCheck;

                    // Grab mob and player stats for extra messaging
                    uint16 charAcc = PChar->ACC(SLOT_MAIN, (uint8)0);
                    uint16 charAtt = PChar->ATT();
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

                    PChar->pushPacket(new CMessageBasicPacket(PChar, PTarget, mobLvl, MessageValue, MessageID));
                }
            }
            break;
            case TYPE_PC:
            {
                CCharEntity* PTarget = (CCharEntity*)PEntity;

                if (PTarget->m_PMonstrosity)
                {
                    PChar->pushPacket(new CMessageStandardPacket(PTarget, 0, 0, MsgStd::MonstrosityCheckOut));
                    PTarget->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::MonstrosityCheckIn));
                    return;
                }

                if (!PChar->m_isGMHidden || (PChar->m_isGMHidden && PTarget->m_GMlevel >= PChar->m_GMlevel))
                {
                    PTarget->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::Examine));
                }

                PChar->pushPacket(new CBazaarMessagePacket(PTarget));
                PChar->pushPacket(new CCheckPacket(PChar, PTarget));
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
    sql->EscapeString(message, PChar->bazaar.message.c_str());

    sql->Query("UPDATE char_stats SET bazaar_message = '%s' WHERE charid = %u;", message, PChar->id);
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
    sql->EscapeString(message, (const char*)data[4]);

    uint8 type = strlen(message) == 0 ? 0 : data.ref<uint8>(data.getSize() - 4);

    if (type == PChar->search.messagetype && strcmp(message, PChar->search.message.c_str()) == 0)
    {
        return;
    }

    auto ret = sql->Query("UPDATE accounts_sessions SET seacom_type = %u, seacom_message = '%s' WHERE charid = %u;", type, message, PChar->id);

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
                    char lsMessage[128] = {};
                    memcpy(&lsMessage, data[16], sizeof(lsMessage));
                    PChar->PLinkshell1->setMessage(lsMessage, PChar->getName());
                    return;
                }
            }
            break;
        }
    }
    PChar->pushPacket(new CMessageStandardPacket(MsgStd::LinkshellNoAccess));
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

    if (PChar->m_moghouseID || PChar->nameflags.flags & FLAG_GM || PChar->m_GMlevel > 0)
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
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 345));
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
    if (PChar->CraftContainer->getItemsCount() > 0 && PChar->animation == ANIMATION_SYNTH)
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

    PChar->pushPacket(new CSpecialReleasePacket(PChar));
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
        PChar->PWideScanTarget = nullptr;
        return;
    }

    uint16 widescanRange = charutils::getWideScanRange(PChar);
    float  dist          = distance(PChar->loc.p, target->loc.p);

    // Only allow players to track targets that are actually scannable, and within their wide scan range
    if (target->isWideScannable() && dist <= widescanRange)
    {
        PChar->PWideScanTarget = target;
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
    PChar->PWideScanTarget = nullptr;
}

/************************************************************************
 *                                                                       *
 *  Mog House Place Furniture                                            *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0FA(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint16 ItemID = data.ref<uint16>(0x04);

    if (ItemID == 0)
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

    if (containerID != LOC_MOGSAFE && containerID != LOC_MOGSAFE2)
    {
        return;
    }

    CItemFurnishing* PItem = (CItemFurnishing*)PChar->getStorage(containerID)->GetItem(slotID);

    // Try to catch packet abuse, leading to gardening pots being placed on 2nd floor.
    if (PItem->getOn2ndFloor() && PItem->isGardeningPot())
    {
        ShowWarning(fmt::format("{} has tried to gardening pot {} ({}) on 2nd floor",
                                PChar->getName(), PItem->getID(), PItem->getName()));
        return;
    }

    if (PItem != nullptr && PItem->getID() == ItemID && PItem->isType(ITEM_FURNISHING))
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

        // Update installed furniture placement orders
        // First we place the furniture into placed items using the order number as the index
        std::array<CItemFurnishing*, MAX_CONTAINER_SIZE* 2> placedItems = { nullptr };
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

        PChar->pushPacket(new CFurnitureInteractPacket(PItem, containerID, slotID));

        char extra[sizeof(PItem->m_extra) * 2 + 1];
        sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

        const char* Query = "UPDATE char_inventory "
                            "SET "
                            "extra = '%s' "
                            "WHERE location = %u AND slot = %u AND charid = %u";

        if (sql->Query(Query, extra, containerID, slotID, PChar->id) != SQL_ERROR && sql->AffectedRows() != 0 && !wasInstalled)
        {
            // Storage mods only apply on the 1st floor
            if (!PItem->getOn2ndFloor())
            {
                PChar->getStorage(LOC_STORAGE)->AddBuff(PItem->getStorage());
            }

            PChar->pushPacket(new CInventorySizePacket(PChar));

            luautils::OnFurniturePlaced(PChar, PItem);
        }
        PChar->pushPacket(new CInventoryItemPacket(PItem, containerID, slotID));
        PChar->pushPacket(new CInventoryFinishPacket());
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
                PChar->pushPacket(new CInventoryCountPacket(containerID, slotID, 0, 0, 0, 0, 0, 0, 0, 0));
                for (uint8 i = 0; i < 8; ++i)
                {
                    if (PItem->m_extra[10 + i] > 0)
                    {
                        auto* PEquippedItem = PChar->getStorage(LOC_STORAGE)->GetItem(i);
                        if (PEquippedItem == nullptr)
                        {
                            continue;
                        }
                        PChar->pushPacket(new CInventoryAssignPacket(PEquippedItem, INV_NORMAL));
                        PItem->m_extra[10 + i] = 0;
                    }
                }
            }

            char extra[sizeof(PItem->m_extra) * 2 + 1];
            sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

            const char* Query = "UPDATE char_inventory "
                                "SET "
                                "extra = '%s' "
                                "WHERE location = %u AND slot = %u AND charid = %u";

            if (sql->Query(Query, extra, containerID, slotID, PChar->id) != SQL_ERROR && sql->AffectedRows() != 0)
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

                PChar->pushPacket(new CInventorySizePacket(PChar));

                luautils::OnFurnitureRemoved(PChar, PItem);
            }
            PChar->pushPacket(new CInventoryItemPacket(PItem, containerID, PItem->getSlotID()));
            PChar->pushPacket(new CInventoryFinishPacket());
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

    if (CItemFlowerpot::getPlantFromSeed(itemID) != FLOWERPOT_PLANT_NONE)
    {
        // Planting a seed in the flowerpot
        PChar->pushPacket(new CMessageStandardPacket(itemID, 132)); // "Your moogle plants the <seed> in the flowerpot."
        PPotItem->cleanPot();
        PPotItem->setPlant(CItemFlowerpot::getPlantFromSeed(itemID));
        PPotItem->setPlantTimestamp(CVanaTime::getInstance()->getVanaTime());
        PPotItem->setStrength(xirand::GetRandomNumber(33));
        gardenutils::GrowToNextStage(PPotItem);
    }
    else if (itemID >= 4096 && itemID <= 4111)
    {
        // Feeding the plant a crystal
        PChar->pushPacket(new CMessageStandardPacket(itemID, 136)); // "Your moogle uses the <item> on the plant."
        if (PPotItem->getStage() == FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL)
        {
            PPotItem->setFirstCrystalFeed(CItemFlowerpot::getElementFromItem(itemID));
        }
        else if (PPotItem->getStage() == FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL)
        {
            PPotItem->setSecondCrystalFeed(CItemFlowerpot::getElementFromItem(itemID));
        }
        gardenutils::GrowToNextStage(PPotItem, true);
        PPotItem->markExamined();
    }

    char extra[sizeof(PPotItem->m_extra) * 2 + 1];
    sql->EscapeStringLen(extra, (const char*)PPotItem->m_extra, sizeof(PPotItem->m_extra));
    const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u";
    sql->Query(Query, extra, PChar->id, PPotItem->getLocationID(), PPotItem->getSlotID());

    PChar->pushPacket(new CFurnitureInteractPacket(PPotItem, potContainerID, potSlotID));

    PChar->pushPacket(new CInventoryItemPacket(PPotItem, potContainerID, potSlotID));

    charutils::UpdateItem(PChar, containerID, slotID, -1);
    PChar->pushPacket(new CInventoryFinishPacket());
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
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, CItemFlowerpot::getSeedID(PItem->getPlant()), 0, MSGBASIC_GARDENING_SEED_SOWN));
        if (PItem->isTree())
        {
            if (PItem->getStage() > FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL)
            {
                if (PItem->getExtraCrystalFeed() != FLOWERPOT_ELEMENT_NONE)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, CItemFlowerpot::getItemFromElement(PItem->getExtraCrystalFeed()), 0,
                                                              MSGBASIC_GARDENING_CRYSTAL_USED));
                }
                else
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_GARDENING_CRYSTAL_NONE));
                }
            }
        }
        if (PItem->getStage() > FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL)
        {
            if (PItem->getCommonCrystalFeed() != FLOWERPOT_ELEMENT_NONE)
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, CItemFlowerpot::getItemFromElement(PItem->getCommonCrystalFeed()), 0,
                                                          MSGBASIC_GARDENING_CRYSTAL_USED));
            }
            else
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_GARDENING_CRYSTAL_NONE));
            }
        }

        if (!PItem->wasExamined())
        {
            PItem->markExamined();
            char extra[sizeof(PItem->m_extra) * 2 + 1];
            sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));
            const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u";
            sql->Query(Query, extra, PChar->id, PItem->getLocationID(), PItem->getSlotID());
        }
    }

    PChar->pushPacket(new CFurnitureInteractPacket(PItem, containerID, slotID));
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
                PChar->pushPacket(new CMessageStandardPacket(MsgStd::MoghouseCantPickUp)); // Kupo. I can't pick anything right now, kupo.
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
            PChar->pushPacket(new CMessageStandardPacket(resultID, totalQuantity, 134)); // Your moogle <quantity> <item> from the plant!
        }

        PChar->pushPacket(new CFurnitureInteractPacket(PItem, containerID, slotID));
        PItem->cleanPot();

        char extra[sizeof(PItem->m_extra) * 2 + 1];
        sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));
        const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u";
        sql->Query(Query, extra, PChar->id, PItem->getLocationID(), PItem->getSlotID());

        PChar->pushPacket(new CInventoryItemPacket(PItem, containerID, slotID));
        PChar->pushPacket(new CInventoryFinishPacket());
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
        PChar->pushPacket(new CMessageStandardPacket(itemID, 133)); // Your moogle dries the plant in the <item>.
        PChar->pushPacket(new CFurnitureInteractPacket(PItem, containerID, slotID));
        PItem->setDried(true);

        char extra[sizeof(PItem->m_extra) * 2 + 1];
        sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));
        const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u";
        sql->Query(Query, extra, PChar->id, PItem->getLocationID(), PItem->getSlotID());

        PChar->pushPacket(new CInventoryItemPacket(PItem, containerID, slotID));
        PChar->pushPacket(new CInventoryFinishPacket());
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
                if (sql->Query("UPDATE char_exp SET mode = %u WHERE charid = %u", 0, PChar->id) != SQL_ERROR)
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

        PChar->pushPacket(new CCharJobsPacket(PChar));
        PChar->pushPacket(new CCharUpdatePacket(PChar));
        PChar->pushPacket(new CCharStatsPacket(PChar));
        PChar->pushPacket(new CCharSkillsPacket(PChar));
        PChar->pushPacket(new CCharRecastPacket(PChar));
        PChar->pushPacket(new CCharAbilitiesPacket(PChar));
        PChar->pushPacket(new CCharJobExtraPacket(PChar, true));
        PChar->pushPacket(new CCharJobExtraPacket(PChar, false));
        PChar->pushPacket(new CMenuMeritPacket(PChar));
        PChar->pushPacket(new CMonipulatorPacket1(PChar));
        PChar->pushPacket(new CMonipulatorPacket2(PChar));
        PChar->pushPacket(new CCharSyncPacket(PChar));
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
            PChar->pushPacket(new CCharAbilitiesPacket(PChar));
            PChar->pushPacket(new CCharJobExtraPacket(PChar, true));
            PChar->pushPacket(new CCharJobExtraPacket(PChar, false));
            PChar->pushPacket(new CCharStatsPacket(PChar));
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
                    PChar->pushPacket(new CCharAbilitiesPacket(PChar));
                    PChar->pushPacket(new CCharJobExtraPacket(PChar, true));
                    PChar->pushPacket(new CCharJobExtraPacket(PChar, false));
                    PChar->pushPacket(new CCharStatsPacket(PChar));
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
        PChar->pushPacket(new CCharJobExtraPacket(PChar, true));
        PChar->pushPacket(new CCharJobExtraPacket(PChar, false));
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
        PTarget->pushPacket(new CBazaarCheckPacket(PChar, BAZAAR_LEAVE));
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

    if (PTarget != nullptr && PTarget->id == charid && (PTarget->nameflags.flags & FLAG_BAZAAR))
    {
        PChar->BazaarID.id     = PTarget->id;
        PChar->BazaarID.targid = PTarget->targid;

        EntityID_t EntityID = { PChar->id, PChar->targid };

        PTarget->pushPacket(new CBazaarCheckPacket(PChar, BAZAAR_ENTER));
        PTarget->BazaarCustomers.emplace_back(EntityID);

        CItemContainer* PBazaar = PTarget->getStorage(LOC_INVENTORY);

        for (uint8 SlotID = 1; SlotID <= PBazaar->GetSize(); ++SlotID)
        {
            CItem* PItem = PBazaar->GetItem(SlotID);

            if ((PItem != nullptr) && (PItem->getCharPrice() != 0))
            {
                PChar->pushPacket(new CBazaarItemPacket(PItem, SlotID, PChar->loc.zone->GetTax()));
            }
        }
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

    // Validate purchase quantity
    if (Quantity < 1)
    {
        // Exploit attempt
        ShowWarning("Player %s purchasing invalid quantity %u from Player %s bazaar! ", PChar->getName(), Quantity, PTarget->getName());
        return;
    }

    CItemContainer* PBazaar         = PTarget->getStorage(LOC_INVENTORY);
    CItemContainer* PBuyerInventory = PChar->getStorage(LOC_INVENTORY);
    if (PBazaar == nullptr || PBuyerInventory == nullptr)
    {
        return;
    }

    if (PChar->id == PTarget->id || PBuyerInventory->GetFreeSlotsCount() == 0)
    {
        PChar->pushPacket(new CBazaarPurchasePacket(PTarget, false));
        return;
    }

    CItem* PBazaarItem = PBazaar->GetItem(SlotID);
    if (PBazaarItem == nullptr)
    {
        return;
    }

    // Obtain the players gil
    CItem* PCharGil = PBuyerInventory->GetItem(0);
    if (PCharGil == nullptr || !PCharGil->isType(ITEM_CURRENCY))
    {
        // Player has no gil
        PChar->pushPacket(new CBazaarPurchasePacket(PTarget, false));
        return;
    }

    if ((PBazaarItem->getCharPrice() != 0) && (PBazaarItem->getQuantity() >= Quantity))
    {
        uint32 Price        = (PBazaarItem->getCharPrice() * Quantity);
        uint32 PriceWithTax = (PChar->loc.zone->GetTax() * Price) / 10000 + Price;

        // Validate this player can afford said item
        if (PCharGil->getQuantity() < PriceWithTax)
        {
            // Exploit attempt
            ShowWarning("Bazaar purchase exploit attempt by: %s", PChar->getName());
            PChar->pushPacket(new CBazaarPurchasePacket(PTarget, false));
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

        PChar->pushPacket(new CBazaarPurchasePacket(PTarget, true));

        PTarget->pushPacket(new CBazaarConfirmationPacket(PChar, PItem));

        charutils::UpdateItem(PTarget, LOC_INVENTORY, SlotID, -Quantity);

        PTarget->pushPacket(new CInventoryItemPacket(PBazaar->GetItem(SlotID), LOC_INVENTORY, SlotID));
        PTarget->pushPacket(new CInventoryFinishPacket());

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
                    PCustomer->pushPacket(new CBazaarConfirmationPacket(PChar, SlotID, Quantity));
                }
                PCustomer->pushPacket(new CBazaarItemPacket(PBazaar->GetItem(SlotID), SlotID, PChar->loc.zone->GetTax()));

                if (BazaarIsEmpty)
                {
                    PCustomer->pushPacket(new CBazaarClosePacket(PTarget));
                }
            }
        }
        if (BazaarIsEmpty)
        {
            PTarget->updatemask |= UPDATE_HP;
            PTarget->nameflags.flags &= ~FLAG_BAZAAR;
        }
        return;
    }
    PChar->pushPacket(new CBazaarPurchasePacket(PTarget, false));
}

/************************************************************************
 *                                                                       *
 *  Bazaar (Exit Price Setting)                                          *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x109(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    CItemContainer* PStorage = PChar->getStorage(LOC_INVENTORY);
    if (PStorage == nullptr)
    {
        return;
    }

    for (uint8 slotID = 1; slotID <= PStorage->GetSize(); ++slotID)
    {
        CItem* PItem = PStorage->GetItem(slotID);

        if ((PItem != nullptr) && (PItem->getCharPrice() != 0))
        {
            PChar->nameflags.flags |= FLAG_BAZAAR;
            PChar->updatemask |= UPDATE_HP;
            return;
        }
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
        sql->Query("UPDATE char_inventory SET bazaar = %u WHERE charid = %u AND location = 0 AND slot = %u;", price, PChar->id, slotID);

        PItem->setCharPrice(price);
        PItem->setSubType((price == 0 ? ITEM_UNLOCKED : ITEM_LOCKED));

        PChar->pushPacket(new CInventoryItemPacket(PItem, LOC_INVENTORY, slotID));
        PChar->pushPacket(new CInventoryFinishPacket());
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
            PCustomer->pushPacket(new CBazaarClosePacket(PChar));
        }
    }
    PChar->BazaarCustomers.clear();

    PChar->nameflags.flags &= ~FLAG_BAZAAR;
    PChar->updatemask |= UPDATE_HP;
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
        PChar->pushPacket(new CRoeSparkUpdatePacket(PChar));
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
        PChar->pushPacket(new CRoeSparkUpdatePacket(PChar));
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
    PChar->pushPacket(new CCurrencyPacket1(PChar));
}

/************************************************************************
 *                                                                       *
 *  Fishing (New)                                                        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x110(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    if (settings::get<bool>("map.FISHING_ENABLE"))
    {
        fishingutils::HandleFishingAction(PChar, data);
    }
    else
    {
        return;
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
    PChar->pushPacket(new CCharAppearancePacket(PChar));
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
    PChar->pushPacket(new CRoeSparkUpdatePacket(PChar));

    if (settings::get<bool>("main.ENABLE_ROE"))
    {
        // Current RoE quests
        PChar->pushPacket(new CRoeUpdatePacket(PChar));

        // Players logging in to a new timed record get one-time message
        if (PChar->m_eminenceCache.notifyTimedRecord)
        {
            PChar->m_eminenceCache.notifyTimedRecord = false;
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, roeutils::GetActiveTimedRecord(), 0, MSGBASIC_ROE_TIMED));
        }

        // 4-part Eminence Completion bitmap
        for (int i = 0; i < 4; i++)
        {
            PChar->pushPacket(new CRoeQuestLogPacket(PChar, i));
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
    PrintPacket(data);

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
    PChar->pushPacket(new CMapMarkerPacket(PChar));
}

/************************************************************************
 *                                                                        *
 *  Request Currency2 tab                                                  *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x115(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    PChar->pushPacket(new CCurrencyPacket2(PChar));
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
    PChar->pushPacket(new CRoeSparkUpdatePacket(PChar));
    PChar->pushPacket(new CMenuUnityPacket(PChar));
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
    PChar->pushPacket(new CRoeSparkUpdatePacket(PChar));
    PChar->pushPacket(new CMenuUnityPacket(PChar));
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
 *  Set Job Master Display                                                *
 *                                                                        *
 ************************************************************************/
void SmallPacket0x11B(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    PChar->m_jobMasterDisplay = data.ref<uint8>(0x04) > 0;

    charutils::SaveJobMasterDisplay(PChar);
    PChar->pushPacket(new CCharUpdatePacket(PChar));
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
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
        return;
    }

    auto const& targetIndex = data.ref<uint16>(0x08);
    auto const& extra       = data.ref<uint16>(0x0A);

    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CCharEmotionJumpPacket(PChar, targetIndex, extra));
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
    PacketSize[0x03D] = 0x00; PacketParser[0x03D] = &SmallPacket0x03D; // Blacklist Command
    PacketSize[0x041] = 0x00; PacketParser[0x041] = &SmallPacket0x041;
    PacketSize[0x042] = 0x00; PacketParser[0x042] = &SmallPacket0x042;
    PacketSize[0x04B] = 0x0C; PacketParser[0x04B] = &SmallPacket0x04B;
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
    PacketSize[0x0A0] = 0x00; PacketParser[0x0A0] = &SmallPacket0xFFF;    // not implemented
    PacketSize[0x0A1] = 0x00; PacketParser[0x0A1] = &SmallPacket0xFFF;    // not implemented
    PacketSize[0x0A2] = 0x00; PacketParser[0x0A2] = &SmallPacket0x0A2;
    PacketSize[0x0AA] = 0x00; PacketParser[0x0AA] = &SmallPacket0x0AA;
    PacketSize[0x0AB] = 0x00; PacketParser[0x0AB] = &SmallPacket0x0AB;
    PacketSize[0x0AC] = 0x00; PacketParser[0x0AC] = &SmallPacket0x0AC;
    PacketSize[0x0AD] = 0x00; PacketParser[0x0AD] = &SmallPacket0x0AD;
    PacketSize[0x0B5] = 0x00; PacketParser[0x0B5] = &SmallPacket0x0B5;
    PacketSize[0x0B6] = 0x00; PacketParser[0x0B6] = &SmallPacket0x0B6;
    PacketSize[0x0BE] = 0x00; PacketParser[0x0BE] = &SmallPacket0x0BE;    // merit packet
    PacketSize[0x0BF] = 0x00; PacketParser[0x0BF] = &SmallPacket0x0BF;
    PacketSize[0x0C0] = 0x00; PacketParser[0x0C0] = &SmallPacket0x0C0;
    PacketSize[0x0C3] = 0x00; PacketParser[0x0C3] = &SmallPacket0x0C3;
    PacketSize[0x0C4] = 0x0E; PacketParser[0x0C4] = &SmallPacket0x0C4;
    PacketSize[0x0CB] = 0x04; PacketParser[0x0CB] = &SmallPacket0x0CB;
    PacketSize[0x0D2] = 0x00; PacketParser[0x0D2] = &SmallPacket0x0D2;
    PacketSize[0x0D3] = 0x00; PacketParser[0x0D3] = &SmallPacket0x0D3;
    PacketSize[0x0D4] = 0x00; PacketParser[0x0D4] = &SmallPacket0xFFF;    // not implemented
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
    PacketSize[0x111] = 0x00; PacketParser[0x111] = &SmallPacket0x111; // Lock Style Request
    PacketSize[0x112] = 0x00; PacketParser[0x112] = &SmallPacket0x112;
    PacketSize[0x113] = 0x06; PacketParser[0x113] = &SmallPacket0x113;
    PacketSize[0x114] = 0x00; PacketParser[0x114] = &SmallPacket0x114;
    PacketSize[0x115] = 0x02; PacketParser[0x115] = &SmallPacket0x115;
    PacketSize[0x116] = 0x00; PacketParser[0x116] = &SmallPacket0x116;
    PacketSize[0x117] = 0x00; PacketParser[0x117] = &SmallPacket0x117;
    PacketSize[0x118] = 0x00; PacketParser[0x118] = &SmallPacket0x118;
    PacketSize[0x11B] = 0x00; PacketParser[0x11B] = &SmallPacket0x11B;
    PacketSize[0x11D] = 0x00; PacketParser[0x11D] = &SmallPacket0x11D;
    // clang-format on
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/
