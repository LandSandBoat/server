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

#include "../common/blowfish.h"
#include "../common/md52.h"
#include "../common/mmo.h"
#include "../common/showmsg.h"
#include "../common/socket.h"
#include "../common/taskmgr.h"
#include "../common/timer.h"
#include "../common/utils.h"
#include "../common/version.h"

#include <cstring>
#include <utility>

#include "ai/ai_container.h"
#include "ai/states/death_state.h"
#include "alliance.h"
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
#include "notoriety_container.h"
#include "packet_system.h"
#include "party.h"
#include "recast_container.h"
#include "roe.h"
#include "spell.h"
#include "status_effect_container.h"
#include "trade_container.h"
#include "treasure_pool.h"
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
#include "unitychat.h"
#include "zone.h"

#include "items/item_flowerpot.h"
#include "items/item_shop.h"

#include "lua/luautils.h"

#include "packets/auction_house.h"
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
void (*PacketParser[512])(map_session_data_t* const, CCharEntity* const, CBasicPacket);

/************************************************************************
 *                                                                       *
 *  Display the contents of the incoming packet to the console.          *
 *                                                                       *
 ************************************************************************/

void PrintPacket(CBasicPacket data)
{
    char message[50];
    memset(&message, 0, 50);

    for (size_t y = 0; y < data.length(); y++)
    {
        // TODO: -Wno-restrict - undefined behavior to print and write src into dest
        // TODO: -Wno-format-overflow - writing between 4 and 53 bytes into destination of 50
        snprintf(message, sizeof(message), "%s %02hhx", message, *((uint8*)data[(const int)y]));
        if (((y + 1) % 16) == 0)
        {
            message[48] = '\n';
            ShowDebug(message);
            memset(&message, 0, 50);
        }
    }
    if (strlen(message) > 0)
    {
        message[strlen(message)] = '\n';
        ShowDebug(message);
    }
}

/************************************************************************
 *                                                                       *
 *  Unknown Packet                                                       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x000(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    ShowWarning(CL_YELLOW "parse: Unhandled game packet %03hX from user: %s\n" CL_RESET, (data.ref<uint16>(0) & 0x1FF), PChar->GetName());
}

/************************************************************************
 *                                                                       *
 *  Non-Implemented Packet                                               *
 *                                                                       *
 ************************************************************************/

void SmallPacket0xFFF(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    ShowDebug(CL_CYAN "parse: SmallPacket is not implemented Type<%03hX>\n" CL_RESET, (data.ref<uint16>(0) & 0x1FF));
}

/************************************************************************
 *                                                                       *
 *  Log Into Zone                                                        *
 *                                                                       *
 *  Update session key and client port between zone transitions.         *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x00A(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    data.ref<uint32>(0x5C) = 0;

    PChar->clearPacketList();

    if (PChar->status == STATUS_TYPE::DISAPPEAR)
    {
        if (PChar->loc.zone != nullptr)
        {
            // Remove the char from previous zone, and unset shuttingDown (already in next zone)
            PacketParser[0x00D](PSession, PChar, nullptr);
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

        if (destination >= MAX_ZONEID)
        {
            ShowWarning("packet_system::SmallPacket0x00A player tried to enter zone out of range: %d\n", destination);
            PChar->loc.destination = destination = ZONE_RESIDENTIAL_AREA;
        }

        zoneutils::GetZone(destination)->IncreaseZoneCounter(PChar);

        PChar->m_ZonesList[PChar->getZone() >> 3] |= (1 << (PChar->getZone() % 8));

        const char* fmtQuery = "UPDATE accounts_sessions SET targid = %u, session_key = x'%s', server_addr = %u, client_port = %u WHERE charid = %u";

        // Current zone could either be current zone or destination
        CZone* currentZone = zoneutils::GetZone(PChar->getZone());

        Sql_Query(SqlHandle, fmtQuery, PChar->targid, session_key, currentZone->GetIP(), PSession->client_port, PChar->id);

        fmtQuery  = "SELECT death FROM char_stats WHERE charid = %u;";
        int32 ret = Sql_Query(SqlHandle, fmtQuery, PChar->id);
        if (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            // Update the character's death timestamp based off of how long they were previously dead
            uint32 secondsSinceDeath = (uint32)Sql_GetUIntData(SqlHandle, 0);
            if (PChar->health.hp == 0)
            {
                PChar->SetDeathTimestamp((uint32)time(nullptr) - secondsSinceDeath);
                PChar->Die(CCharEntity::death_duration - std::chrono::seconds(secondsSinceDeath));
            }
        }

        fmtQuery = "SELECT pos_prevzone FROM chars WHERE charid = %u";
        ret      = Sql_Query(SqlHandle, fmtQuery, PChar->id);
        if (ret != SQL_ERROR && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            if (PChar->getZone() == Sql_GetUIntData(SqlHandle, 0))
            {
                PChar->loc.zoning = true;
            }
        }
        PChar->status = STATUS_TYPE::NORMAL;
    }
    else
    {
        if (PChar->loc.zone != nullptr)
        {
            ShowWarning(CL_YELLOW "Client cannot receive packet or key is invalid: %s\n" CL_RESET, PChar->GetName());
        }
    }

    charutils::SaveCharPosition(PChar);
    charutils::SaveZonesVisited(PChar);
    charutils::SavePlayTime(PChar);

    if (PChar->m_moghouseID != 0)
    {
        gardenutils::UpdateGardening(PChar, false);
    }

    PChar->pushPacket(new CDownloadingDataPacket());
    PChar->pushPacket(new CZoneInPacket(PChar, PChar->m_event.EventID));
    PChar->pushPacket(new CZoneVisitedPacket(PChar));

    PChar->PAI->QueueAction(queueAction_t(400ms, false, luautils::AfterZoneIn));
}

/************************************************************************
 *                                                                       *
 *  Character Information Request                                        *
 *  Occurs while player is zoning or entering the game.                  *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x00C(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
    if (PChar->petZoningInfo.respawnPet)
    {
        // only repawn pet in valid zones
        if (PChar->loc.zone->CanUseMisc(MISC_PET) && !PChar->m_moghouseID)
        {
            switch (PChar->petZoningInfo.petType)
            {
                case PET_TYPE::AUTOMATON:
                case PET_TYPE::JUG_PET:
                case PET_TYPE::WYVERN:
                    petutils::SpawnPet(PChar, PChar->petZoningInfo.petID, true);
                    break;

                default:
                    break;
            }
        }
    }
    // Reset the petZoning info
    PChar->resetPetZoningInfo();
}

/************************************************************************
 *                                                                       *
 *  Player Leaving Zone (Dezone)                                         *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x00D(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
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
                    if (PChar->PParty->members.size() == 1)
                    {
                        if (PChar->PParty->m_PAlliance->partyList.size() == 1)
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

        if (PChar->PPet != nullptr)
        {
            PChar->setPetZoningInfo();
        }

        PSession->shuttingDown = 1;
        Sql_Query(SqlHandle, "UPDATE char_stats SET zoning = 0 WHERE charid = %u", PChar->id);
    }
    else
    {
        PSession->shuttingDown = 2;
        Sql_Query(SqlHandle, "UPDATE char_stats SET zoning = 1 WHERE charid = %u", PChar->id);
        charutils::CheckEquipLogic(PChar, SCRIPT_CHANGEZONE, PChar->getZone());

        if (PChar->CraftContainer->getItemsCount() > 0 && PChar->animation == ANIMATION_SYNTH)
        {
            // NOTE:
            // Supposed non-losable items are reportely lost if this condition is met:
            // https://ffxiclopedia.fandom.com/wiki/Lu_Shang%27s_Fishing_Rod
            // The broken rod can never be lost in a normal failed synth. It will only be lost if the synth is
            // interrupted in some way, such as by being attacked or moving to another area (e.g. ship docking).

            ShowExploit(CL_YELLOW "SmallPacket0x00D: %s attempting to zone in the middle of a synth, failing their synth!\n" CL_RESET, PChar->GetName());
            synthutils::doSynthFail(PChar);
        }
    }

    if (PChar->loc.zone != nullptr)
    {
        PChar->loc.zone->DecreaseZoneCounter(PChar);
    }

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

void SmallPacket0x00F(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x011(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    PSession->blowfish.status = BLOWFISH_ACCEPTED;

    PChar->health.tp = 0;

    for (uint8 i = 0; i < 16; ++i)
    {
        if (PChar->equip[i] != 0)
        {
            PChar->pushPacket(new CEquipPacket(PChar->equip[i], i, PChar->equipLoc[i]));
        }
    }

    // todo: kill player til theyre dead and bsod
    const char* fmtQuery = "SELECT version_mismatch FROM accounts_sessions WHERE charid = %u";
    int32       ret      = Sql_Query(SqlHandle, fmtQuery, PChar->id);
    if (ret != SQL_ERROR && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        // On zone change, only sending a version message if mismatch
        // if ((bool)Sql_GetUIntData(SqlHandle, 0))
        // PChar->pushPacket(new CChatMessagePacket(PChar, CHAT_MESSAGE_TYPE::MESSAGE_SYSTEM_1, "Server does not support this client version."));
    }
}

/************************************************************************
 *                                                                       *
 *  Player Sync                                                          *
 *  Updates the players position and other important information.        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x015(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    TracyZoneCString("Player Sync");

    if (PChar->status != STATUS_TYPE::SHUTDOWN && PChar->status != STATUS_TYPE::DISAPPEAR)
    {
        bool moved = ((PChar->loc.p.x != data.ref<float>(0x04)) || (PChar->loc.p.z != data.ref<float>(0x0C)) || (PChar->m_TargID != data.ref<uint16>(0x16)));

        bool isUpdate = moved || PChar->updatemask & UPDATE_POS;

        if (!PChar->isCharmed)
        {
            PChar->loc.p.x = data.ref<float>(0x04);
            PChar->loc.p.y = data.ref<float>(0x08);
            PChar->loc.p.z = data.ref<float>(0x0C);

            PChar->loc.p.moving   = data.ref<uint16>(0x12);
            PChar->loc.p.rotation = data.ref<uint8>(0x14);

            PChar->m_TargID = data.ref<uint16>(0x16);
        }

        if (moved)
        {
            PChar->updatemask |= UPDATE_POS;
        }

        if (isUpdate)
        {
            PChar->loc.zone->SpawnPCs(PChar);
            PChar->loc.zone->SpawnNPCs(PChar);
        }

        PChar->loc.zone->SpawnMOBs(PChar);
        PChar->loc.zone->SpawnPETs(PChar);
        PChar->loc.zone->SpawnTRUSTs(PChar);

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

void SmallPacket0x016(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint16 targid = data.ref<uint16>(0x04);

    if (targid == PChar->targid)
    {
        PChar->pushPacket(new CCharPacket(PChar, ENTITY_SPAWN, UPDATE_ALL_CHAR));
        PChar->pushPacket(new CCharUpdatePacket(PChar));
    }
    else
    {
        CBaseEntity* PEntity = PChar->GetEntity(targid, TYPE_NPC | TYPE_PC);

        if (PEntity && PEntity->objtype == TYPE_PC)
        {
            PChar->pushPacket(new CCharPacket((CCharEntity*)PEntity, ENTITY_SPAWN, UPDATE_ALL_CHAR));
        }
        else
        {
            if (!PEntity)
            {
                PEntity = zoneutils::GetTrigger(targid, PChar->getZone());
            }
            PChar->pushPacket(new CEntityUpdatePacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB));
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Invalid NPC Information Response                                     *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x017(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint16 targid = data.ref<uint16>(0x04);
    uint32 npcid  = data.ref<uint32>(0x08);
    uint8  type   = data.ref<uint8>(0x12);

    ShowWarning(CL_YELLOW "SmallPacket0x17: Incorrect NPC(%u,%u) type(%u)\n" CL_RESET, targid, npcid, type);
}

/************************************************************************
 *                                                                       *
 *  Player Action                                                        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x01A(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    TracyZoneCString("Player Action");

    // uint32 ID = data.ref<uint32>(0x04);
    uint16 TargID = data.ref<uint16>(0x08);
    uint8  action = data.ref<uint8>(0x0A);

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
            PNpc              = PChar->GetEntity(TargID, TYPE_NPC);

            if (PNpc != nullptr && distance(PNpc->loc.p, PChar->loc.p) <= 10 && (PNpc->PAI->IsSpawned() || PChar->m_moghouseID != 0))
            {
                PNpc->PAI->Trigger(PChar);
            }

            // Releasing a trust
            // TODO: 0x0c is set to 0x1, not sure if that is relevant or not.
            if (auto* PTrust = dynamic_cast<CTrustEntity*>(PChar->GetEntity(TargID, TYPE_TRUST)))
            {
                PChar->RemoveTrust(PTrust);
            }

            if (!PChar->isNpcLocked())
            {
                PChar->m_event.reset();
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
        }
        break;
        case 0x04: // disengage
        {
            PChar->PAI->Disengage();
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
                if (!PMob->CalledForHelp() && PMob->PEnmityContainer->HasID(PChar->id))
                {
                    PMob->CallForHelp(true);
                    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CMessageBasicPacket(PChar, PChar, 0, 0, 19));
                    return;
                }
            }

            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 22));
        }
        break;
        case 0x07: // weaponskill
        {
            uint16 WSkillID = data.ref<uint16>(0x0C);
            PChar->PAI->WeaponSkill(TargID, WSkillID);
        }
        break;
        case 0x09: // jobability
        {
            uint16 JobAbilityID = data.ref<uint16>(0x0C);
            uint8 currentAnimation = PChar->animation;
            if (currentAnimation != ANIMATION_NONE && currentAnimation != ANIMATION_ATTACK)
            {
                ShowExploit(CL_YELLOW "SmallPacket0x009: Player %s trying to use a Job Ability from invalid state\n" CL_RESET, PChar->GetName());
                return;
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
                ShowExploit(CL_YELLOW "SmallPacket0x01A: Player %s trying to Ranged Attack from invalid state\n" CL_RESET, PChar->GetName());
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
                    PChar->pushPacket(new CChocoboDiggingPacket(PChar));

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
                PChar->loc.zone->SpawnPCs(PChar);
                PChar->loc.zone->SpawnNPCs(PChar);
                PChar->loc.zone->SpawnMOBs(PChar);
                PChar->loc.zone->SpawnTRUSTs(PChar);
            }
        }
        break;
        case 0x15: // ballista - quarry
        case 0x16: // ballista - sprint
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

                PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_MOUNTED, EFFECT_MOUNTED, (MountID ? ++MountID : 0), 0, 1800), true);
                PChar->PRecastContainer->Add(RECAST_ABILITY, 256, 60);
                PChar->pushPacket(new CCharRecastPacket(PChar));
            }
        }
        break;
        default:
        {
            ShowWarning(CL_YELLOW "CLIENT PERFORMING UNHANDLED ACTION %02hX\n" CL_RESET, action);
            return;
        }
        break;
    }
    ShowAction(CL_CYAN "CLIENT %s PERFORMING ACTION %02hX\n" CL_RESET, PChar->GetName(), action);
}

/************************************************************************
 *                                                                       *
 *  World Pass                                                           *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x01B(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x01C(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    PrintPacket(std::move(data));
}

/************************************************************************
 *                                                                       *
 *  Item Movement (Disposal)                                             *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x028(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    int32 quantity  = data.ref<uint8>(0x04);
    uint8 container = data.ref<uint8>(0x08);
    uint8 slotID    = data.ref<uint8>(0x09);

    if (container >= MAX_CONTAINER_ID)
    {
        ShowExploit(CL_YELLOW "SmallPacket0x028: Invalid container ID passed to packet %u by %s\n" CL_RESET, container, PChar->GetName());
        return;
    }

    CItem* PItem = PChar->getStorage(container)->GetItem(slotID);

    if (PItem != nullptr && !PItem->isSubType(ITEM_LOCKED))
    {
        uint16 ItemID = PItem->getID();
        // Break linkshell if the main shell was disposed of.
        CItemLinkshell* ItemLinkshell = dynamic_cast<CItemLinkshell*>(PItem);
        if (ItemLinkshell && ItemLinkshell->GetLSType() == LSTYPE_LINKSHELL)
        {
            uint32      lsid       = ItemLinkshell->GetLSID();
            CLinkshell* PLinkshell = linkshell::GetLinkshell(lsid);
            if (!PLinkshell)
            {
                PLinkshell = linkshell::LoadLinkshell(lsid);
            }
            PLinkshell->BreakLinkshell((int8*)PLinkshell->getName(), false);
            linkshell::UnloadLinkshell(lsid);
        }

        if (charutils::UpdateItem(PChar, container, slotID, -quantity) != 0)
        {
            // ShowNotice(CL_CYAN"Player %s DROPPING itemID %u (quantity: %u)\n" CL_RESET, PChar->GetName(), ItemID, quantity);
            PChar->pushPacket(new CMessageStandardPacket(nullptr, ItemID, quantity, MsgStd::ThrowAway));
            PChar->pushPacket(new CInventoryFinishPacket());
        }
        return;
    }
    ShowExploit(CL_YELLOW "SmallPacket0x028: Attempt of removal nullptr or LOCKED item from slot %u\n" CL_RESET, slotID);
}

/************************************************************************
 *                                                                       *
 *  Item Movement (Between Containers)                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x029(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint32 quantity       = data.ref<uint8>(0x04);
    uint8  FromLocationID = data.ref<uint8>(0x08);
    uint8  ToLocationID   = data.ref<uint8>(0x09);
    uint8  FromSlotID     = data.ref<uint8>(0x0A);
    uint8  ToSlotID       = data.ref<uint8>(0x0B);

    if (ToLocationID >= MAX_CONTAINER_ID || FromLocationID >= MAX_CONTAINER_ID)
    {
        return;
    }

    CItem* PItem = PChar->getStorage(FromLocationID)->GetItem(FromSlotID);

    if (PItem == nullptr || PItem->isSubType(ITEM_LOCKED))
    {
        if (PItem == nullptr)
        {
            ShowWarning(CL_YELLOW "SmallPacket0x29: Trying to move nullptr item from location %u slot %u to location %u slot %u of quan %u \n" CL_RESET,
                        FromLocationID, FromSlotID, ToLocationID, ToSlotID, quantity);
        }
        else
        {
            ShowWarning(CL_YELLOW "SmallPacket0x29: Trying to move LOCKED item %i from location %u slot %u to location %u slot %u of quan %u \n" CL_RESET,
                        PItem->getID(), FromLocationID, FromSlotID, ToLocationID, ToSlotID, quantity);
        }

        uint8 size = PChar->getStorage(FromLocationID)->GetSize();
        for (uint8 slotID = 0; slotID <= size; ++slotID)
        {
            CItem* PItem = PChar->getStorage(FromLocationID)->GetItem(slotID);
            if (PItem != nullptr)
            {
                PChar->pushPacket(new CInventoryItemPacket(PItem, FromLocationID, slotID));
            }
        }
        PChar->pushPacket(new CInventoryFinishPacket());

        return;
    }

    if (PItem->getQuantity() - PItem->getReserve() < quantity)
    {
        ShowWarning(CL_YELLOW "SmallPacket0x29: Trying to move too much quantity from location %u slot %u\n" CL_RESET, FromLocationID, FromSlotID);
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
            ShowDebug("SmallPacket0x29: Trying to unite items\n", FromLocationID, FromSlotID);
            return;
        }

        uint8 NewSlotID = PChar->getStorage(ToLocationID)->InsertItem(PItem);

        if (NewSlotID != ERROR_SLOTID)
        {
            const char* Query = "UPDATE char_inventory SET location = %u, slot = %u WHERE charid = %u AND location = %u AND slot = %u;";

            if (Sql_Query(SqlHandle, Query, ToLocationID, NewSlotID, PChar->id, FromLocationID, FromSlotID) != SQL_ERROR && Sql_AffectedRows(SqlHandle) != 0)
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
            // Client assumed the location was not full when it is..
            // Resend the packets to inform the client of the storage sizes..
            uint8 size = PChar->getStorage(ToLocationID)->GetSize();
            for (uint8 slotID = 0; slotID <= size; ++slotID)
            {
                CItem* PItem = PChar->getStorage(ToLocationID)->GetItem(slotID);
                if (PItem != nullptr)
                {
                    PChar->pushPacket(new CInventoryItemPacket(PItem, ToLocationID, slotID));
                }
            }
            PChar->pushPacket(new CInventoryFinishPacket());

            ShowError(CL_RED "SmallPacket0x29: Location %u Slot %u is full\n" CL_RESET, ToLocationID, ToSlotID);
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

void SmallPacket0x032(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint32 charid = data.ref<uint32>(0x04);
    uint16 targid = data.ref<uint16>(0x08);

    CCharEntity* PTarget = (CCharEntity*)PChar->GetEntity(targid, TYPE_PC);

    if ((PTarget != nullptr) && (PTarget->id == charid))
    {
        ShowDebug(CL_CYAN "%s initiated trade request with %s\n" CL_RESET, PChar->GetName(), PTarget->GetName());

        // If PChar is invisible don't allow the trade, but you are able to initiate a trade TO an invisible player
        if (PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE))
        {
            // 155 = "You cannot perform that action on the specified target."
            // TODO: Correct message is "You cannot use that command while invisible."
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 155));
            return;
        }

        // If either player is in prison don't allow the trade.
        if (jailutils::InPrison(PChar) || jailutils::InPrison(PTarget))
        {
            // 316 = "That action cannot be used in this area."
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
            return;
        }

        // check /blockaid
        if (charutils::IsAidBlocked(PChar, PTarget))
        {
            ShowDebug(CL_CYAN "%s is blocking trades\n" CL_RESET, PTarget->GetName());
            // Target is blocking assistance
            PChar->pushPacket(new CMessageSystemPacket(0, 0, 225));
            // Interaction was blocked
            PTarget->pushPacket(new CMessageSystemPacket(0, 0, 226));
            PChar->pushPacket(new CTradeActionPacket(PTarget, 0x01));
            return;
        }

        if (PTarget->TradePending.id == PChar->id)
        {
            ShowDebug(CL_CYAN "%s already sent a trade request to %s\n" CL_RESET, PChar->GetName(), PTarget->GetName());
            return;
        }
        if (!PTarget->UContainer->IsContainerEmpty())
        {
            ShowDebug(CL_CYAN "%s UContainer is not empty. %s cannot trade with them at this time\n" CL_RESET, PTarget->GetName(), PChar->GetName());
            return;
        }
        PChar->TradePending.id     = charid;
        PChar->TradePending.targid = targid;

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

void SmallPacket0x033(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    CCharEntity* PTarget = (CCharEntity*)PChar->GetEntity(PChar->TradePending.targid, TYPE_PC);

    if (PTarget != nullptr && PChar->TradePending.id == PTarget->id)
    {
        uint16 action = data.ref<uint8>(0x04);

        switch (action)
        {
            case 0x00: // request accepted
            {
                ShowDebug(CL_CYAN "%s accepted trade request from %s\n" CL_RESET, PTarget->GetName(), PChar->GetName());
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

                    ShowDebug(CL_CYAN "Trade: UContainer is not empty\n" CL_RESET);
                }
            }
            break;
            case 0x01: // trade cancelled
            {
                ShowDebug(CL_CYAN "%s cancelled trade with %s\n" CL_RESET, PTarget->GetName(), PChar->GetName());
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
                ShowDebug(CL_CYAN "%s accepted trade with %s\n" CL_RESET, PTarget->GetName(), PChar->GetName());
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
                            // Failed to trade..
                            // Either players containers are full or illegal item trade attempted..
                            ShowDebug(CL_CYAN "%s->%s trade failed (full inventory or illegal items)\n" CL_RESET, PChar->GetName(), PTarget->GetName());
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

void SmallPacket0x034(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
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
                ShowError(CL_RED "SmallPacket0x034: Player %s trying to update trade quantity of a RESERVED item! [Item: %i | Trade Slot: %i] \n" CL_RESET,
                          PChar->GetName(), PCurrentSlotItem->getID(), tradeSlotID);
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

            // If item count is zero.. remove from container..
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
                        ShowNotice(CL_CYAN "%s->%s trade updating trade slot id %d with item %s, quantity %d\n" CL_RESET, PChar->GetName(), PTarget->GetName(),
                                   tradeSlotID, PItem->getName(), quantity);
                        PItem->setReserve(quantity + PItem->getReserve());
                        PChar->UContainer->SetItem(tradeSlotID, PItem);
                    }
                }
                else
                {
                    ShowNotice(CL_CYAN "%s->%s trade updating trade slot id %d with item %s, quantity %d\n" CL_RESET, PChar->GetName(), PTarget->GetName(),
                               tradeSlotID, PItem->getName(), quantity);
                    PItem->setReserve(quantity + PItem->getReserve());
                    PChar->UContainer->SetItem(tradeSlotID, PItem);
                }
            }
            else
            {
                ShowNotice(CL_CYAN "%s->%s trade updating trade slot id %d with item %s, quantity 0\n" CL_RESET, PChar->GetName(), PTarget->GetName(),
                           tradeSlotID, PItem->getName());
                PItem->setReserve(0);
                PChar->UContainer->SetItem(tradeSlotID, nullptr);
            }
            ShowDebug(CL_CYAN "%s->%s trade pushing packet to %s\n" CL_RESET, PChar->GetName(), PTarget->GetName(), PChar->GetName());
            PChar->pushPacket(new CTradeItemPacket(PItem, tradeSlotID));
            ShowDebug(CL_CYAN "%s->%s trade pushing packet to %s\n" CL_RESET, PChar->GetName(), PTarget->GetName(), PTarget->GetName());
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

void SmallPacket0x036(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;

     // If PChar is invisible don't allow the trade, but you are able to initiate a trade TO an invisible player
    if (PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE))
    {
        // 155 = "You cannot perform that action on the specified target."
        // TODO: Correct message is "You cannot use that command while invisible."
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 155));
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
                ShowError(CL_RED "SmallPacket0x036: Player %s trying to trade invalid item [to NPC]! \n" CL_RESET, PChar->GetName());
                return;
            }

            if (PItem->getReserve() > 0)
            {
                ShowError(CL_RED "SmallPacket0x036: Player %s trying to trade a RESERVED item [to NPC]! \n" CL_RESET, PChar->GetName());
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

void SmallPacket0x037(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    // uint32 EntityID = data.ref<uint32>(0x04);
    uint16 TargetID  = data.ref<uint16>(0x0C);
    uint8  SlotID    = data.ref<uint8>(0x0E);
    uint8  StorageID = data.ref<uint8>(0x10);

    if (StorageID >= MAX_CONTAINER_ID)
    {
        ShowExploit(CL_YELLOW "SmallPacket0x037: Invalid storage ID passed to packet %u by %s\n" CL_RESET, StorageID, PChar->GetName());
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

void SmallPacket0x03A(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    TracyZoneCString("Sort Inventory");

    uint8 container = data.ref<uint8>(0x04);

    if (container >= MAX_CONTAINER_ID)
    {
        ShowExploit(CL_YELLOW "SmallPacket0x03A: Invalid container ID passed to packet %u by %s\n" CL_RESET, container, PChar->GetName());
        return;
    }

    CItemContainer* PItemContainer = PChar->getStorage(container);

    uint8 size = PItemContainer->GetSize();

    if (gettick() - PItemContainer->LastSortingTime < 1000)
    {
        if (map_config.lightluggage_block == (int32)(++PItemContainer->SortingPacket))
        {
            ShowWarning(CL_YELLOW "lightluggage detected: <%s> will be removed from server\n" CL_RESET, PChar->GetName());

            PChar->status = STATUS_TYPE::SHUTDOWN;
            charutils::SendToZone(PChar, 1, 0);
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

        if ((PItem != nullptr) && (PItem->getQuantity() < PItem->getStackSize()) && !PItem->isSubType(ITEM_LOCKED))
        {
            for (uint8 slotID2 = slotID + 1; slotID2 <= size; ++slotID2)
            {
                CItem* PItem2 = PItemContainer->GetItem(slotID2);

                if ((PItem2 != nullptr) && (PItem2->getID() == PItem->getID()) && (PItem2->getQuantity() < PItem2->getStackSize()) &&
                    !PItem2->isSubType(ITEM_LOCKED))
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
 *  Unknown Packet                                                       *
 *  Assumed packet empty response for npcs/monsters/players.             *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x03C(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    ShowWarning(CL_YELLOW "SmallPacket0x03C\n" CL_RESET);
}

/************************************************************************
 *                                                                       *
 *  Incoming Blacklist Command                                           *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x03D(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    const int8* name = (const int8*)(data[0x08]);
    uint8       cmd  = data.ref<uint8>(0x18);

    // Attempt to locate the character by their name..
    const char* sql = "SELECT charid, accid FROM chars WHERE charname = '%s' LIMIT 1";
    int32       ret = Sql_Query(SqlHandle, sql, name);
    if (ret == SQL_ERROR || Sql_NumRows(SqlHandle) != 1 || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
    {
        // Send failed..
        PChar->pushPacket(new CBlacklistPacket(0, (const int8*)"", 0x02));
        return;
    }

    // Retrieve the data from Sql..
    uint32 charid = Sql_GetUIntData(SqlHandle, 0);
    uint32 accid  = Sql_GetUIntData(SqlHandle, 1);

    // User is trying to add someone to their blacklist..
    if (cmd == 0x00)
    {
        if (blacklistutils::IsBlacklisted(PChar->id, charid))
        {
            // We cannot readd this person, fail to add..
            PChar->pushPacket(new CBlacklistPacket(0, (const int8*)"", 0x02));
            return;
        }

        // Attempt to add this person..
        if (blacklistutils::AddBlacklisted(PChar->id, charid))
        {
            PChar->pushPacket(new CBlacklistPacket(accid, name, cmd));
        }
        else
        {
            PChar->pushPacket(new CBlacklistPacket(0, (const int8*)"", 0x02));
        }
    }

    // User is trying to remove someone from their blacklist..
    else if (cmd == 0x01)
    {
        if (!blacklistutils::IsBlacklisted(PChar->id, charid))
        {
            // We cannot remove this person, fail to remove..
            PChar->pushPacket(new CBlacklistPacket(0, (const int8*)"", 0x02));
            return;
        }

        // Attempt to remove this person..
        if (blacklistutils::DeleteBlacklisted(PChar->id, charid))
        {
            PChar->pushPacket(new CBlacklistPacket(accid, name, cmd));
        }
        else
        {
            PChar->pushPacket(new CBlacklistPacket(0, (const int8*)"", 0x02));
        }
    }
    else
    {
        // Send failed..
        PChar->pushPacket(new CBlacklistPacket(0, (const int8*)"", 0x02));
    }
}

/************************************************************************
 *                                                                       *
 *  Treasure Pool (Lot On Item)                                          *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x041(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    PrintPacket(data);

    uint8 SlotID = data.ref<uint8>(0x04);

    if (SlotID >= TREASUREPOOL_SIZE)
    {
        ShowExploit(CL_YELLOW "SmallPacket0x041: Invalid slot ID passed to packet %u by %s\n" CL_RESET, SlotID, PChar->GetName());
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

void SmallPacket0x042(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    PrintPacket(data);

    uint8 SlotID = data.ref<uint8>(0x04);

    if (SlotID >= TREASUREPOOL_SIZE)
    {
        ShowExploit(CL_YELLOW "SmallPacket0x042: Invalid slot ID passed to packet %u by %s\n" CL_RESET, SlotID, PChar->GetName());
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

void SmallPacket0x04B(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    // uint8   msg_chunk = data.ref<uint8>(0x04); // The current chunk of the message to send.. (1 = start, 2 = rest of message)
    // uint8   msg_unknown1 = data.ref<uint8>(0x05); // Unknown.. always 0
    // uint8   msg_unknown2 = data.ref<uint8>(0x06); // Unknown.. always 1
    uint8  msg_language  = data.ref<uint8>(0x07);  // Language request id (2 = English, 4 = French)
    uint32 msg_timestamp = data.ref<uint32>(0x08); // The message timestamp being requested..
    // uint32  msg_size_total = data.ref<uint32>(0x0C); // The total length of the requested server message..
    uint32 msg_offset = data.ref<uint32>(0x10); // The offset to start obtaining the server message..
    // uint32  msg_request_len = data.ref<uint32>(0x14); // The total requested size of send to the client..

    if (msg_language == 0x02)
    {
        PChar->pushPacket(new CServerMessagePacket(map_config.server_message, msg_language, msg_timestamp, msg_offset));
    }

    PChar->pushPacket(new CCharSyncPacket(PChar));

    // todo: kill player til theyre dead and bsod
    const char* fmtQuery = "SELECT version_mismatch FROM accounts_sessions WHERE charid = %u";
    int32       ret      = Sql_Query(SqlHandle, fmtQuery, PChar->id);
    if (ret != SQL_ERROR && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        if ((bool)Sql_GetUIntData(SqlHandle, 0))
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

void SmallPacket0x04D(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint8 action  = data.ref<uint8>(0x04);
    uint8 boxtype = data.ref<uint8>(0x05);
    uint8 slotID  = data.ref<uint8>(0x06);

    ShowAction(CL_CYAN "DeliveryBox Action (%02hx)\n" CL_RESET, data.ref<uint8>(0x04));
    PrintPacket(data);

    if (jailutils::InPrison(PChar)) // If jailed, no mailbox menu for you.
    {
        return;
    }

    if (!zoneutils::IsResidentialArea(PChar) && PChar->m_GMlevel == 0 && !PChar->loc.zone->CanUseMisc(MISC_AH) && !PChar->loc.zone->CanUseMisc(MISC_MOGMENU))
    {
        ShowDebug(CL_CYAN "%s is trying to use the delivery box in a disallowed zone [%s]\n" CL_RESET, PChar->GetName(), PChar->loc.zone->GetName());
        return;
    }

    // 0x01 - Send old items..
    // 0x02 - Add items to be sent..
    // 0x03 - Send confirmation..
    // 0x04 - Cancel sending item..
    // 0x05 - Send client new item count..
    // 0x06 - Send new items..
    // 0x07 - Removes a delivered item from sending box
    // 0x08 - Update delivery cell before removing..
    // 0x09 - Return to sender..
    // 0x0a - Take item from cell..
    // 0x0b - Remove item from cell..
    // 0x0c - Confirm name before sending..
    // 0x0d - Opening to send mail..
    // 0x0e - Opening to receive mail..
    // 0x0f - Closing mail window..

    switch (action)
    {
        case 0x01:
        {
            const char* fmtQuery = "SELECT itemid, itemsubid, slot, quantity, sent, extra, sender, charname FROM delivery_box WHERE charid = %u AND box = %d "
                                   "AND slot < 8 ORDER BY slot;";

            int32 ret = Sql_Query(SqlHandle, fmtQuery, PChar->id, boxtype);

            if (ret != SQL_ERROR)
            {
                int items = 0;
                if (Sql_NumRows(SqlHandle) != 0)
                {
                    while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                    {
                        CItem* PItem = itemutils::GetItem(Sql_GetIntData(SqlHandle, 0));

                        if (PItem != nullptr) // Prevent an access violation in the event that an item doesn't exist for an ID
                        {
                            PItem->setSubID(Sql_GetIntData(SqlHandle, 1));
                            PItem->setSlotID(Sql_GetIntData(SqlHandle, 2));
                            PItem->setQuantity(Sql_GetUIntData(SqlHandle, 3));

                            if (Sql_GetUIntData(SqlHandle, 4) > 0)
                            {
                                PItem->setSent(true);
                            }

                            size_t length = 0;
                            char*  extra  = nullptr;
                            Sql_GetData(SqlHandle, 5, &extra, &length);
                            memcpy(PItem->m_extra, extra, (length > sizeof(PItem->m_extra) ? sizeof(PItem->m_extra) : length));

                            if (boxtype == 2)
                            {
                                PItem->setSender(Sql_GetData(SqlHandle, 7));
                                PItem->setReceiver(Sql_GetData(SqlHandle, 6));
                            }
                            else
                            {
                                PItem->setSender(Sql_GetData(SqlHandle, 6));
                                PItem->setReceiver(Sql_GetData(SqlHandle, 7));
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
        case 0x02: // add items to send box
        {
            uint8  invslot  = data.ref<uint8>(0x07);
            uint32 quantity = data.ref<uint32>(0x08);
            CItem* PItem    = PChar->getStorage(LOC_INVENTORY)->GetItem(invslot);

            if (quantity > 0 && PItem && PItem->getQuantity() >= quantity && PChar->UContainer->IsSlotEmpty(slotID))
            {
                int32 ret = Sql_Query(SqlHandle, "SELECT charid, accid FROM chars WHERE charname = '%s' LIMIT 1;", data[0x10]);
                if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) > 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                {
                    uint32 charid = Sql_GetUIntData(SqlHandle, 0);

                    if (PItem->getFlag() & ITEM_FLAG_NODELIVERY)
                    {
                        if (!(PItem->getFlag() & ITEM_FLAG_MAIL2ACCOUNT))
                        {
                            return;
                        }

                        uint32 accid = Sql_GetUIntData(SqlHandle, 1);
                        int32  ret   = Sql_Query(SqlHandle, "SELECT COUNT(*) FROM chars WHERE charid = '%u' AND accid = '%u' LIMIT 1;", PChar->id, accid);
                        if (ret == SQL_ERROR || Sql_NextRow(SqlHandle) != SQL_SUCCESS || Sql_GetUIntData(SqlHandle, 0) == 0)
                        {
                            return;
                        }
                    }

                    CItem* PUBoxItem = itemutils::GetItem(PItem->getID());
                    PUBoxItem->setReceiver(data[0x10]);
                    PUBoxItem->setSender((int8*)PChar->GetName());
                    PUBoxItem->setQuantity(quantity);
                    PUBoxItem->setSlotID(PItem->getSlotID());
                    memcpy(PUBoxItem->m_extra, PItem->m_extra, sizeof(PUBoxItem->m_extra));

                    char extra[sizeof(PItem->m_extra) * 2 + 1];
                    Sql_EscapeStringLen(SqlHandle, extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

                    ret = Sql_Query(SqlHandle,
                                    "INSERT INTO delivery_box(charid, charname, box, slot, itemid, itemsubid, quantity, extra, senderid, sender) VALUES(%u, "
                                    "'%s', 2, %u, %u, %u, %u, '%s', %u, '%s'); ",
                                    PChar->id, PChar->GetName(), slotID, PItem->getID(), PItem->getSubID(), quantity, extra, charid, data[0x10]);

                    if (ret != SQL_ERROR && Sql_AffectedRows(SqlHandle) == 1 && charutils::UpdateItem(PChar, LOC_INVENTORY, invslot, -(int32)quantity))
                    {
                        PChar->UContainer->SetItem(slotID, PUBoxItem);
                        PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PUBoxItem, slotID, PChar->UContainer->GetItemsCount(), 1));
                        PChar->pushPacket(new CInventoryFinishPacket());
                    }
                    else
                    {
                        delete PUBoxItem;
                    }
                }
            }
            return;
        }
        case 0x03: // send items
        {
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
                    bool isAutoCommitOn = Sql_GetAutoCommit(SqlHandle);
                    bool commit         = false;

                    if (Sql_SetAutoCommit(SqlHandle, false) && Sql_TransactionStart(SqlHandle))
                    {
                        int32 ret = Sql_Query(SqlHandle, "SELECT charid FROM chars WHERE charname = '%s' LIMIT 1", PItem->getReceiver());

                        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) > 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                        {
                            uint32 charid = Sql_GetUIntData(SqlHandle, 0);

                            ret = Sql_Query(SqlHandle, "UPDATE delivery_box SET sent = 1 WHERE charid = %u AND senderid = %u AND slot = %u AND box = 2;",
                                            PChar->id, charid, slotID);

                            if (ret != SQL_ERROR && Sql_AffectedRows(SqlHandle) == 1)
                            {
                                char extra[sizeof(PItem->m_extra) * 2 + 1];
                                Sql_EscapeStringLen(SqlHandle, extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

                                ret = Sql_Query(SqlHandle,
                                                "INSERT INTO delivery_box(charid, charname, box, itemid, itemsubid, quantity, extra, senderid, sender) "
                                                "VALUES(%u, '%s', 1, %u, %u, %u, '%s', %u, '%s'); ",
                                                charid, PItem->getReceiver(), PItem->getID(), PItem->getSubID(), PItem->getQuantity(), extra, PChar->id,
                                                PChar->GetName());
                                if (ret != SQL_ERROR && Sql_AffectedRows(SqlHandle) == 1)
                                {
                                    PItem->setSent(true);
                                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, send_items, 0x02));
                                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, send_items, 0x01));
                                    commit = true;
                                }
                            }
                        }
                        if (!commit || !Sql_TransactionCommit(SqlHandle))
                        {
                            Sql_TransactionRollback(SqlHandle);
                            ShowError("Could not finalize send transaction. PlayerID: %d Target: %s slotID: %d", PChar->id, PItem->getReceiver(), slotID);
                        }

                        Sql_SetAutoCommit(SqlHandle, isAutoCommitOn);
                    }
                }
            }
            return;
        }
        case 0x04: // cancel send
        {
            if (PChar->UContainer->GetType() != UCONTAINER_DELIVERYBOX)
            {
                return;
            }

            if (!PChar->UContainer->IsSlotEmpty(slotID))
            {
                bool   isAutoCommitOn = Sql_GetAutoCommit(SqlHandle);
                bool   commit         = false;
                bool   orphan         = false;
                CItem* PItem          = PChar->UContainer->GetItem(slotID);

                if (Sql_SetAutoCommit(SqlHandle, false) && Sql_TransactionStart(SqlHandle))
                {
                    int32 ret =
                        Sql_Query(SqlHandle, "SELECT charid FROM chars WHERE charname = '%s' LIMIT 1", PChar->UContainer->GetItem(slotID)->getReceiver());

                    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) > 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                    {
                        uint32 charid = Sql_GetUIntData(SqlHandle, 0);
                        ret           = Sql_Query(SqlHandle,
                                        "UPDATE delivery_box SET sent = 0 WHERE charid = %u AND box = 2 AND slot = %u AND sent = 1 AND received = 0 LIMIT 1;",
                                        PChar->id, slotID);

                        if (ret != SQL_ERROR && Sql_AffectedRows(SqlHandle) == 1)
                        {
                            int32 ret = Sql_Query(SqlHandle,
                                                  "DELETE FROM delivery_box WHERE senderid = %u AND box = 1 AND charid = %u AND itemid = %u AND quantity = %u "
                                                  "AND slot >= 8 LIMIT 1;",
                                                  PChar->id, charid, PItem->getID(), PItem->getQuantity());

                            if (ret != SQL_ERROR && Sql_AffectedRows(SqlHandle) == 1)
                            {
                                PChar->UContainer->GetItem(slotID)->setSent(false);
                                commit = true;
                                PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PChar->UContainer->GetItem(slotID), slotID,
                                                                         PChar->UContainer->GetItemsCount(), 0x02));
                                PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PChar->UContainer->GetItem(slotID), slotID,
                                                                         PChar->UContainer->GetItemsCount(), 0x01));
                            }
                            else if (ret != SQL_ERROR && Sql_AffectedRows(SqlHandle) == 0)
                            {
                                orphan = true;
                            }
                        }
                    }
                    else if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) == 0)
                    {
                        orphan = true;
                    }

                    if (!commit || !Sql_TransactionCommit(SqlHandle))
                    {
                        Sql_TransactionRollback(SqlHandle);
                        ShowError("Could not finalize cancel send transaction. PlayerID: %d slotID: %d\n", PChar->id, slotID);
                        if (orphan)
                        {
                            Sql_SetAutoCommit(SqlHandle, true);
                            int32 ret = Sql_Query(
                                SqlHandle, "DELETE FROM delivery_box WHERE box = 2 AND charid = %u AND itemid = %u AND quantity = %u AND slot = %u LIMIT 1;",
                                PChar->id, PItem->getID(), PItem->getQuantity(), slotID);
                            if (ret != SQL_ERROR && Sql_AffectedRows(SqlHandle) == 1)
                            {
                                ShowError("Deleting orphaned outbox record. PlayerID: %d slotID: %d itemID: %d\n", PChar->id, slotID, PItem->getID());
                                PChar->pushPacket(new CDeliveryBoxPacket(0x0F, boxtype, 0, 1));
                            }
                        }
                        // error message: "Delivery orders are currently backlogged."
                        PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0, -1));
                    }

                    Sql_SetAutoCommit(SqlHandle, isAutoCommitOn);
                }
            }
            return;
        }
        case 0x05:
        {
            // Send the player the new items count not seen..
            if (PChar->UContainer->GetType() != UCONTAINER_DELIVERYBOX)
            {
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
                ret               = Sql_Query(SqlHandle, Query.c_str(), PChar->id, limit);
            }
            else if (boxtype == 0x02)
            {
                std::string Query = "SELECT charid FROM delivery_box WHERE charid = %u AND received = 1 AND box = 2;";
                ret               = Sql_Query(SqlHandle, Query.c_str(), PChar->id);
            }

            if (ret != SQL_ERROR)
            {
                received_items = (uint8)Sql_NumRows(SqlHandle);
            }
            PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0xFF, 0x02));
            PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, received_items, 0x01));

            return;
        }
        case 0x06: // Move item to received
        {
            if (boxtype == 1)
            {
                bool isAutoCommitOn = Sql_GetAutoCommit(SqlHandle);
                bool commit         = false;

                if (Sql_SetAutoCommit(SqlHandle, false) && Sql_TransactionStart(SqlHandle))
                {
                    std::string Query = "SELECT itemid, itemsubid, quantity, extra, sender, senderid FROM delivery_box WHERE charid = %u AND box = 1 AND slot "
                                        ">= 8 ORDER BY slot ASC LIMIT 1;";

                    int32 ret = Sql_Query(SqlHandle, Query.c_str(), PChar->id);

                    CItem* PItem = nullptr;

                    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) > 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                    {
                        PItem = itemutils::GetItem(Sql_GetUIntData(SqlHandle, 0));

                        if (PItem)
                        {
                            PItem->setSubID(Sql_GetIntData(SqlHandle, 1));
                            PItem->setQuantity(Sql_GetUIntData(SqlHandle, 2));

                            size_t length = 0;
                            char*  extra  = nullptr;
                            Sql_GetData(SqlHandle, 3, &extra, &length);
                            memcpy(PItem->m_extra, extra, (length > sizeof(PItem->m_extra) ? sizeof(PItem->m_extra) : length));

                            PItem->setSender(Sql_GetData(SqlHandle, 4));
                            if (PChar->UContainer->IsSlotEmpty(slotID))
                            {
                                int senderID = Sql_GetUIntData(SqlHandle, 5);
                                PItem->setSlotID(slotID);

                                // the result of this query doesn't really matter, it can be sent from the auction house which has no sender record
                                Sql_Query(SqlHandle,
                                          "UPDATE delivery_box SET received = 1 WHERE senderid = %u AND charid = %u AND box = 2 AND received = 0 AND quantity "
                                          "= %u AND sent = 1 AND itemid = %u LIMIT 1;",
                                          PChar->id, senderID, PItem->getQuantity(), PItem->getID());

                                Sql_Query(SqlHandle, "SELECT slot FROM delivery_box WHERE charid = %u AND box = 1 AND slot > 7 ORDER BY slot ASC;", PChar->id);
                                if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) > 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                                {
                                    uint8 queue = Sql_GetUIntData(SqlHandle, 0);
                                    Query       = "UPDATE delivery_box SET slot = %u WHERE charid = %u AND box = 1 AND slot = %u;";
                                    ret         = Sql_Query(SqlHandle, Query.c_str(), slotID, PChar->id, queue);
                                    if (ret != SQL_ERROR)
                                    {
                                        Query = "UPDATE delivery_box SET slot = slot - 1 WHERE charid = %u AND box = 1 AND slot > %u;";
                                        ret   = Sql_Query(SqlHandle, Query.c_str(), PChar->id, queue);
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
                    if (!commit || !Sql_TransactionCommit(SqlHandle))
                    {
                        delete PItem;

                        Sql_TransactionRollback(SqlHandle);
                        ShowError("Could not find new item to add to delivery box. PlayerID: %d Box :%d Slot: %d\n", PChar->id, boxtype, slotID);
                        PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0, 0xEB));
                    }
                }
                Sql_SetAutoCommit(SqlHandle, isAutoCommitOn);
            }
            return;
        }
        case 0x07: // remove received items from send box
        {
            uint8 received_items = 0;
            uint8 slotID         = 0;

            int32 ret = Sql_Query(SqlHandle, "SELECT slot FROM delivery_box WHERE charid = %u AND received = 1 AND box = 2 ORDER BY slot ASC;", PChar->id);

            if (ret != SQL_ERROR)
            {
                received_items = (uint8)Sql_NumRows(SqlHandle);
                if (received_items && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                {
                    slotID = Sql_GetUIntData(SqlHandle, 0);
                    if (!PChar->UContainer->IsSlotEmpty(slotID))
                    {
                        CItem* PItem = PChar->UContainer->GetItem(slotID);
                        if (PItem->isSent())
                        {
                            ret = Sql_Query(SqlHandle, "DELETE FROM delivery_box WHERE charid = %u AND box = 2 AND slot = %u LIMIT 1;", PChar->id, slotID);
                            if (ret != SQL_ERROR && Sql_AffectedRows(SqlHandle) == 1)
                            {
                                PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0, 0x02));
                                PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, received_items, 0x01));
                                PChar->UContainer->SetItem(slotID, nullptr);
                                delete PItem;
                            }
                        }
                    }
                }
            }
            return;
        }
        case 0x08:
        {
            if (PChar->UContainer->GetType() == UCONTAINER_DELIVERYBOX && !PChar->UContainer->IsSlotEmpty(slotID))
            {
                PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PChar->UContainer->GetItem(slotID), slotID, 1, 1));
            }
            return;
        }
        case 0x09: // Option: Return
        {
            if (PChar->UContainer->GetType() == UCONTAINER_DELIVERYBOX && !PChar->UContainer->IsSlotEmpty(slotID))
            {
                bool isAutoCommitOn = Sql_GetAutoCommit(SqlHandle);
                bool commit         = false; // When in doubt back it out.

                CItem*   PItem    = PChar->UContainer->GetItem(slotID);
                auto     item_id  = PItem->getID();
                auto     quantity = PItem->getQuantity();
                uint32   senderID = 0;
                string_t senderName;

                if (Sql_SetAutoCommit(SqlHandle, false) && Sql_TransactionStart(SqlHandle))
                {
                    // Get sender of delivery record
                    int32 ret = Sql_Query(SqlHandle, "SELECT senderid, sender FROM delivery_box WHERE charid = %u AND slot = %u AND box = 1 LIMIT 1;",
                                          PChar->id, slotID);

                    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) > 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                    {
                        senderID = Sql_GetUIntData(SqlHandle, 0);
                        senderName.insert(0, (const char*)Sql_GetData(SqlHandle, 1));

                        if (senderID != 0)
                        {
                            char extra[sizeof(PItem->m_extra) * 2 + 1];
                            Sql_EscapeStringLen(SqlHandle, extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

                            // Insert a return record into delivery_box
                            ret = Sql_Query(SqlHandle,
                                            "INSERT INTO delivery_box(charid, charname, box, itemid, itemsubid, quantity, extra, senderid, sender) VALUES(%u, "
                                            "'%s', 1, %u, %u, %u, '%s', %u, '%s'); ",
                                            senderID, senderName.c_str(), PItem->getID(), PItem->getSubID(), PItem->getQuantity(), extra, PChar->id,
                                            PChar->GetName());

                            if (ret != SQL_ERROR && Sql_AffectedRows(SqlHandle) > 0)
                            {
                                // Remove original delivery record
                                ret = Sql_Query(SqlHandle, "DELETE FROM delivery_box WHERE charid = %u AND slot = %u AND box = 1 LIMIT 1;", PChar->id, slotID);

                                if (ret != SQL_ERROR && Sql_AffectedRows(SqlHandle) > 0)
                                {
                                    PChar->UContainer->SetItem(slotID, nullptr);
                                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 1));
                                    delete PItem;
                                    commit = true;
                                }
                            }
                        }
                    }

                    if (!commit || !Sql_TransactionCommit(SqlHandle))
                    {
                        Sql_TransactionRollback(SqlHandle);
                        ShowError("Could not finalize delivery return transaction. PlayerID: %d SenderID :%d ItemID: %d Quantity: %d", PChar->id, senderID,
                                  item_id, quantity);
                        PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 0xEB));
                    }

                    Sql_SetAutoCommit(SqlHandle, isAutoCommitOn);
                }
            }
            return;
        }
        case 0x0A: // Option: Take
        {
            if (PChar->UContainer->GetType() == UCONTAINER_DELIVERYBOX && !PChar->UContainer->IsSlotEmpty(slotID))
            {
                bool isAutoCommitOn = Sql_GetAutoCommit(SqlHandle);
                bool commit         = false;
                bool invErr         = false;

                CItem* PItem = PChar->UContainer->GetItem(slotID);

                // ShowMessage("FreeSlots %u\n", PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount());
                // ShowMessage("ItemId %u", PItem->getID());

                if (!PItem->isType(ITEM_CURRENCY) && PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() == 0)
                {
                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 0xB9));
                    return;
                }

                if (Sql_SetAutoCommit(SqlHandle, false) && Sql_TransactionStart(SqlHandle))
                {
                    int32 ret = SQL_ERROR;
                    if (boxtype == 0x01)
                    {
                        ret = Sql_Query(SqlHandle, "DELETE FROM delivery_box WHERE charid = %u AND slot = %u AND box = %u LIMIT 1", PChar->id, slotID, boxtype);
                    }
                    else if (boxtype == 0x02)
                    {
                        ret = Sql_Query(SqlHandle, "DELETE FROM delivery_box WHERE charid = %u AND sent = 0 AND slot = %u AND box = %u LIMIT 1", PChar->id,
                                        slotID, boxtype);
                    }

                    if (ret != SQL_ERROR && Sql_AffectedRows(SqlHandle) != 0)
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

                    if (!commit || !Sql_TransactionCommit(SqlHandle))
                    {
                        Sql_TransactionRollback(SqlHandle);
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
                        delete PItem;
                    }
                }

                Sql_SetAutoCommit(SqlHandle, isAutoCommitOn);
            }
            return;
        }
        case 0x0B: // Option: Drop
        {
            if (PChar->UContainer->GetType() == UCONTAINER_DELIVERYBOX && !PChar->UContainer->IsSlotEmpty(slotID))
            {
                int32 ret = Sql_Query(SqlHandle, "DELETE FROM delivery_box WHERE charid = %u AND slot = %u AND box = 1 LIMIT 1", PChar->id, slotID);

                if (ret != SQL_ERROR && Sql_AffectedRows(SqlHandle) != 0)
                {
                    CItem* PItem = PChar->UContainer->GetItem(slotID);
                    PChar->UContainer->SetItem(slotID, nullptr);

                    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 1));
                    delete PItem;
                }
            }
            return;
        }
        case 0x0C: // Confirm name (send box)
        {
            int32 ret = Sql_Query(SqlHandle, "SELECT accid FROM chars WHERE charname = '%s' LIMIT 1", data[0x10]);

            if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) > 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                uint32 accid = Sql_GetUIntData(SqlHandle, 0);
                ret          = Sql_Query(SqlHandle, "SELECT COUNT(*) FROM chars WHERE charid = '%u' AND accid = '%u' LIMIT 1;", PChar->id, accid);
                if (ret != SQL_ERROR && Sql_NextRow(SqlHandle) == SQL_SUCCESS && Sql_GetUIntData(SqlHandle, 0))
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
        case 0x0D: // open send box
        case 0x0E: // open delivery box
        {
            PChar->UContainer->Clean();
            PChar->UContainer->SetType(UCONTAINER_DELIVERYBOX);
            PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0, 1));
            return;
        }
        case 0x0F:
        {
            if (PChar->UContainer->GetType() == UCONTAINER_DELIVERYBOX)
            {
                PChar->UContainer->Clean();
            }
        }
        break;
    }

    // Open mail, close mail..

    PChar->pushPacket(new CDeliveryBoxPacket(action, boxtype, 0, 1));
}

/************************************************************************
 *                                                                       *
 *  Auction House                                                        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x04E(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint8  action   = data.ref<uint8>(0x04);
    uint8  slotid   = data.ref<uint8>(0x05);
    uint32 price    = data.ref<uint32>(0x08);
    uint8  slot     = data.ref<uint8>(0x0C);
    uint16 itemid   = data.ref<uint16>(0x0E);
    uint8  quantity = data.ref<uint8>(0x10);

    ShowDebug(CL_CYAN "AH Action (%02hx)\n" CL_RESET, data.ref<uint8>(0x04));

    if (jailutils::InPrison(PChar)) // If jailed, no AH menu for you.
    {
        return;
    }

    if (PChar->m_GMlevel == 0 && !PChar->loc.zone->CanUseMisc(MISC_AH))
    {
        ShowDebug(CL_CYAN "%s is trying to use the auction house in a disallowed zone [%s]\n" CL_RESET, PChar->GetName(), PChar->loc.zone->GetName());
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
                    PChar->pushPacket(new CAuctionHousePacket(action, 197, 0, 0));
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

                int32 ret = Sql_Query(SqlHandle, Query, PChar->id);

                if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
                {
                    while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                    {
                        AuctionHistory_t ah;
                        ah.itemid = (uint16)Sql_GetIntData(SqlHandle, 0);
                        ah.price  = (uint32)Sql_GetUIntData(SqlHandle, 1);
                        ah.stack  = (uint8)Sql_GetIntData(SqlHandle, 2);
                        ah.status = 0;
                        PChar->m_ah_history.push_back(ah);
                    }
                }
                ShowDebug("%s has %i items up on the AH. \n", PChar->GetName(), PChar->m_ah_history.size());
            }
            else
            {
                PChar->pushPacket(new CAuctionHousePacket(action, 246, 0, 0)); // try again in a little while msg
                break;
            }
        }
        case 0x0A:
        {
            auto totalItemsOnAh = PChar->m_ah_history.size();

            for (size_t slot = 0; slot < totalItemsOnAh; slot++)
            {
                PChar->pushPacket(new CAuctionHousePacket(0x0C, (uint8)slot, PChar));
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
                    PChar->pushPacket(new CAuctionHousePacket(action, 197, 0, 0));
                    return;
                }
                uint32 auctionFee = 0;
                if (quantity == 0)
                {
                    if (PItem->getStackSize() == 1 || PItem->getStackSize() != PItem->getQuantity())
                    {
                        ShowError(CL_RED "SmallPacket0x04E::AuctionHouse: Incorrect quantity of item %s\n" CL_RESET, PItem->getName());
                        PChar->pushPacket(new CAuctionHousePacket(action, 197, 0, 0)); // Failed to place up
                        return;
                    }
                    auctionFee = (uint32)(map_config.ah_base_fee_stacks + (price * map_config.ah_tax_rate_stacks / 100));
                }
                else
                {
                    auctionFee = (uint32)(map_config.ah_base_fee_single + (price * map_config.ah_tax_rate_single / 100));
                }

                auctionFee = std::clamp<uint32>(auctionFee, 0, map_config.ah_max_fee);

                if (PChar->getStorage(LOC_INVENTORY)->GetItem(0)->getQuantity() < auctionFee)
                {
                    // ShowDebug(CL_CYAN"%s Can't afford the AH fee\n" CL_RESET,PChar->GetName());
                    PChar->pushPacket(new CAuctionHousePacket(action, 197, 0, 0)); // Not enough gil to pay fee
                    return;
                }

                // Get the current number of items the player has for sale
                const char* Query = "SELECT COUNT(*) FROM auction_house WHERE seller = %u AND sale=0;";

                int32  ret         = Sql_Query(SqlHandle, Query, PChar->id);
                uint32 ah_listings = 0;

                if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
                {
                    Sql_NextRow(SqlHandle);
                    ah_listings = (uint32)Sql_GetIntData(SqlHandle, 0);
                    // ShowDebug(CL_CYAN"%s has %d outstanding listings before placing this one." CL_RESET, PChar->GetName(), ah_listings);
                }

                if (map_config.ah_list_limit && ah_listings >= map_config.ah_list_limit)
                {
                    // ShowDebug(CL_CYAN"%s already has %d items on the AH\n" CL_RESET,PChar->GetName(), ah_listings);
                    PChar->pushPacket(new CAuctionHousePacket(action, 197, 0, 0)); // Failed to place up
                    return;
                }

                const char* fmtQuery = "INSERT INTO auction_house(itemid, stack, seller, seller_name, date, price) VALUES(%u,%u,%u,'%s',%u,%u)";

                if (Sql_Query(SqlHandle, fmtQuery, PItem->getID(), quantity == 0, PChar->id, PChar->GetName(), (uint32)time(nullptr), price) == SQL_ERROR)
                {
                    ShowError(CL_RED "SmallPacket0x04E::AuctionHouse: Cannot insert item %s to database\n" CL_RESET, PItem->getName());
                    PChar->pushPacket(new CAuctionHousePacket(action, 197, 0, 0)); // failed to place up
                    return;
                }
                charutils::UpdateItem(PChar, LOC_INVENTORY, slot, -(int32)(quantity != 0 ? 1 : PItem->getStackSize()));
                charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -(int32)auctionFee); // Deduct AH fee

                PChar->pushPacket(new CAuctionHousePacket(action, 1, 0, 0));                 // Merchandise put up on auction msg
                PChar->pushPacket(new CAuctionHousePacket(0x0C, (uint8)ah_listings, PChar)); // Inform history of slot
            }
        }
        break;
        case 0x0E:
        {
            itemid = data.ref<uint16>(0x0C);

            if (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() == 0)
            {
                PChar->pushPacket(new CAuctionHousePacket(action, 0xE5, 0, 0));
            }
            else
            {
                CItem* PItem = itemutils::GetItemPointer(itemid);

                if (PItem != nullptr)
                {
                    if (PItem->getFlag() & ITEM_FLAG_RARE)
                    {
                        for (uint8 LocID = 0; LocID < MAX_CONTAINER_ID; ++LocID)
                        {
                            if (PChar->getStorage(LocID)->SearchItem(itemid) != ERROR_SLOTID)
                            {
                                PChar->pushPacket(new CAuctionHousePacket(action, 0xE5, 0, 0));
                                return;
                            }
                        }
                    }
                    CItem* gil = PChar->getStorage(LOC_INVENTORY)->GetItem(0);

                    if (gil != nullptr && gil->isType(ITEM_CURRENCY) && gil->getQuantity() >= price)
                    {
                        const char* fmtQuery = "UPDATE auction_house SET buyer_name = '%s', sale = %u, sell_date = %u WHERE itemid = %u AND buyer_name IS NULL "
                                               "AND stack = %u AND price <= %u ORDER BY price LIMIT 1";

                        if (Sql_Query(SqlHandle, fmtQuery, PChar->GetName(), price, (uint32)time(nullptr), itemid, quantity == 0, price) != SQL_ERROR &&
                            Sql_AffectedRows(SqlHandle) != 0)
                        {
                            uint8 SlotID = charutils::AddItem(PChar, LOC_INVENTORY, itemid, (quantity == 0 ? PItem->getStackSize() : 1));

                            if (SlotID != ERROR_SLOTID)
                            {
                                charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -(int32)(price));

                                PChar->pushPacket(new CAuctionHousePacket(action, 0x01, itemid, price));
                                PChar->pushPacket(new CInventoryFinishPacket());
                            }
                            return;
                        }
                    }
                }
                PChar->pushPacket(new CAuctionHousePacket(action, 0xC5, itemid, price));
            }
        }
        break;
        case 0x0C: // Removing item from AH
        {
            if (slotid < PChar->m_ah_history.size())
            {
                bool             isAutoCommitOn = Sql_GetAutoCommit(SqlHandle);
                AuctionHistory_t canceledItem   = PChar->m_ah_history[slotid];

                if (Sql_SetAutoCommit(SqlHandle, false) && Sql_TransactionStart(SqlHandle))
                {
                    const char* fmtQuery = "DELETE FROM auction_house WHERE seller = %u AND itemid = %u AND stack = %u AND price = %u AND sale = 0 LIMIT 1;";
                    int32       ret      = Sql_Query(SqlHandle, fmtQuery, PChar->id, canceledItem.itemid, canceledItem.stack, canceledItem.price);
                    if (ret != SQL_ERROR && Sql_AffectedRows(SqlHandle))
                    {
                        CItem* PDelItem = itemutils::GetItemPointer(canceledItem.itemid);
                        if (PDelItem)
                        {
                            uint8 SlotID =
                                charutils::AddItem(PChar, LOC_INVENTORY, canceledItem.itemid, (canceledItem.stack != 0 ? PDelItem->getStackSize() : 1), true);

                            if (SlotID != ERROR_SLOTID)
                            {
                                Sql_TransactionCommit(SqlHandle);
                                PChar->pushPacket(new CAuctionHousePacket(action, 0, PChar, slotid, false));
                                PChar->pushPacket(new CInventoryFinishPacket());
                                Sql_SetAutoCommit(SqlHandle, isAutoCommitOn);
                                return;
                            }
                        }
                    }
                    else
                    {
                        ShowError("Failed to return item id %u stack %u to char... \n", canceledItem.itemid, canceledItem.stack);
                    }

                    Sql_TransactionRollback(SqlHandle);
                    Sql_SetAutoCommit(SqlHandle, isAutoCommitOn);
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

void SmallPacket0x050(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    if (PChar->status != STATUS_TYPE::NORMAL)
    {
        return;
    }

    uint8 slotID      = data.ref<uint8>(0x04); // inventory slot
    uint8 equipSlotID = data.ref<uint8>(0x05); // charequip slot
    uint8 containerID = data.ref<uint8>(0x06); // container id

    if (containerID != LOC_INVENTORY && containerID != LOC_WARDROBE && containerID != LOC_WARDROBE2 && containerID != LOC_WARDROBE3 &&
        containerID != LOC_WARDROBE4)
    {
        if (equipSlotID != 16 && equipSlotID != 17)
        {
            return;
        }
        else if (containerID != LOC_MOGSATCHEL && containerID != LOC_MOGSACK && containerID != LOC_MOGCASE)
        {
            return;
        }
    }

    charutils::EquipItem(PChar, slotID, equipSlotID, containerID); // current
    charutils::SaveCharEquip(PChar);
    charutils::SaveCharLook(PChar);
    luautils::CheckForGearSet(PChar); // check for gear set on gear change
    PChar->UpdateHealth();
}
/************************************************************************
 *                                                                       *
 *  Equip Macro Set                                                      *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x051(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
            containerID == LOC_WARDROBE4)
        {
            charutils::EquipItem(PChar, slotID, equipSlotID, containerID);
        }
    }
    charutils::SaveCharEquip(PChar);
    charutils::SaveCharLook(PChar);
    luautils::CheckForGearSet(PChar); // check for gear set on gear change
    PChar->UpdateHealth();
}
/************************************************************************
 *                                                                        *
 *  Add Equipment to set                                                 *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x052(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
    PChar->pushPacket(new CAddtoEquipSet(data));
}

/************************************************************************
 *                                                                        *
 *  LockStyleSet                                                          *
 *                                                                        *
 ************************************************************************/
void SmallPacket0x053(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint8 count = data.ref<uint8>(0x04);
    uint8 type  = data.ref<uint8>(0x05);

    if (type == 0 && PChar->getStyleLocked())
    {
        charutils::SetStyleLock(PChar, false);
        charutils::SaveCharLook(PChar);
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

        for (int i = 0x08; i < 0x08 + (0x08 * count); i += 0x08)
        {
            // uint8 slotId = data.ref<uint8>(i);
            uint8 equipSlotId = data.ref<uint8>(i + 0x01);
            // uint8 locationId = data.ref<uint8>(i + 0x02);
            uint16 itemId = data.ref<uint16>(i + 0x04);

            if (equipSlotId > SLOT_BACK)
            {
                continue;
            }

            auto* PItem = itemutils::GetItem(itemId);
            if (PItem == nullptr || !(PItem->isType(ITEM_WEAPON) || PItem->isType(ITEM_EQUIPMENT)))
            {
                itemId = 0;
            }
            else if (!(((CItemEquipment*)PItem)->getEquipSlotId() & (1 << equipSlotId)))
            {
                itemId = 0;
            }

            PChar->styleItems[equipSlotId] = itemId;

            switch (equipSlotId)
            {
                case SLOT_MAIN:
                case SLOT_SUB:
                case SLOT_RANGED:
                case SLOT_AMMO:
                    charutils::UpdateWeaponStyle(PChar, equipSlotId, (CItemWeapon*)PChar->getEquip((SLOTTYPE)equipSlotId));
                case SLOT_HEAD:
                case SLOT_BODY:
                case SLOT_HANDS:
                case SLOT_LEGS:
                case SLOT_FEET:
                    charutils::UpdateArmorStyle(PChar, equipSlotId);
                    break;
            }
        }
        charutils::SaveCharLook(PChar);
    }
    else if (type == 4)
    {
        charutils::SetStyleLock(PChar, true);
        charutils::SaveCharLook(PChar);
    }

    if (type != 1 && type != 2)
    {
        PChar->pushPacket(new CCharAppearancePacket(PChar));
        PChar->pushPacket(new CCharSyncPacket(PChar));
    }
}

/************************************************************************
 *                                                                        *
 *  Request synthesis suggestion                                            *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x058(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint16 skillID    = data.ref<uint16>(0x04);
    uint16 skillLevel = data.ref<uint16>(0x06);

    PChar->pushPacket(new CSynthSuggestionPacket(skillID, skillLevel));
}

/************************************************************************
 *                                                                       *
 *  Synthesis Complete                                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x059(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x05A(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    PChar->pushPacket(new CConquestPacket(PChar));
    PChar->pushPacket(new CCampaignPacket(PChar, 0));
    PChar->pushPacket(new CCampaignPacket(PChar, 1));
}

/************************************************************************
 *                                                                       *
 *  Event Update (Completion or Update)                                  *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x05B(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    // auto CharID = data.ref<uint32>(0x04);
    auto Result = data.ref<uint32>(0x08);
    // auto ZoneID = data.ref<uint16>(0x10);
    auto EventID = data.ref<uint16>(0x12);

    PrintPacket(data);
    if (PChar->m_event.EventID == EventID)
    {
        if (PChar->m_event.Option != 0)
        {
            Result = PChar->m_event.Option;
        }

        if (data.ref<uint8>(0x0E) != 0)
        {
            luautils::OnEventUpdate(PChar, EventID, Result);
        }
        else
        {
            luautils::OnEventFinish(PChar, EventID, Result);
            // reset if this event did not initiate another event
            if (PChar->m_event.EventID == EventID)
            {
                PChar->m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
                PChar->m_event.reset();
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

void SmallPacket0x05C(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    // auto CharID = data.ref<uint32>(0x10);
    auto Result = data.ref<uint32>(0x14);
    // auto ZoneID = data.ref<uint16>(0x18);

    auto EventID = data.ref<uint16>(0x1A);

    PrintPacket(data);
    if (PChar->m_event.EventID == EventID)
    {
        bool updatePosition = false;

        if (data.ref<uint8>(0x1E) != 0)
        {
            updatePosition = luautils::OnEventUpdate(PChar, EventID, Result) == 1;
        }
        else
        {
            updatePosition = luautils::OnEventFinish(PChar, EventID, Result) == 1;
            if (PChar->m_event.EventID == EventID)
            {
                PChar->m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
                PChar->m_event.reset();
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

void SmallPacket0x05D(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    if (jailutils::InPrison(PChar))
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
        return;
    }

    const auto TargetID    = data.ref<uint32>(0x04);
    const auto TargetIndex = data.ref<uint16>(0x08);
    const auto EmoteID     = data.ref<Emote>(0x0A);
    const auto emoteMode   = data.ref<EmoteMode>(0x0B);

    // Rate limit emotes
    auto lastEmoteTime  = PChar->GetLocalVar("LastEmoteTime");
    auto timeNowSeconds = std::chrono::time_point_cast<std::chrono::seconds>(server_clock::now());
    if (lastEmoteTime == 0 || (timeNowSeconds.time_since_epoch().count() - lastEmoteTime) > 2)
    {
        PChar->SetLocalVar("LastEmoteTime", (uint32)timeNowSeconds.time_since_epoch().count());
    }
    else
    {
        ShowWarning(CL_YELLOW "SmallPacket0x05D: Rate limiting emote packet for %s\n" CL_RESET, PChar->GetName());
        return;
    }

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

    // Attempting to use locked job emote.
    if (EmoteID == Emote::JOB && extra && !(PChar->jobs.unlocked & (1 << (extra - 0x1E))))
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

void SmallPacket0x05E(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;

    // handle pets on zone
    if (PChar->PPet != nullptr)
    {
        PChar->setPetZoningInfo();
        petutils::DespawnPet(PChar);
    }

    uint32 zoneLineID    = data.ref<uint32>(0x04);
    uint8  town          = data.ref<uint8>(0x16);
    uint8  requestedZone = data.ref<uint8>(0x17);

    uint16 startingZone = PChar->getZone();

    PChar->ClearTrusts();

    if (PChar->status == STATUS_TYPE::NORMAL)
    {
        PChar->status       = STATUS_TYPE::DISAPPEAR;
        PChar->loc.boundary = 0;

        // Exiting Mog House..
        if (zoneLineID == 1903324538)
        {
            uint16 destinationZone = PChar->getZone();
            // Note: zone zero actually exists but is unused in retail, we should stop using zero someday.
            // If zero, return to previous zone.. otherwise, determine the zone..
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

                // Handle case for mog garden.. (Above addition does not work for this zone.)
                if (requestedZone == 127)
                {
                    destinationZone = ZONE_MOG_GARDEN;
                }
                else if (requestedZone == 125) // Go to second floor
                {
                    destinationZone = PChar->getZone();
                }
            }

            bool moghouseExitRegular = requestedZone == 0 && PChar->m_moghouseID > 0;

            auto startingRegion            = zoneutils::GetCurrentRegion(startingZone);
            auto destinationRegion         = zoneutils::GetCurrentRegion(destinationZone);
            auto moghouseExitRegions = { REGION_TYPE::SANDORIA, REGION_TYPE::BASTOK, REGION_TYPE::WINDURST, REGION_TYPE::JEUNO, REGION_TYPE::WEST_AHT_URHGAN };
            auto moghouseQuestComplete     = PChar->profile.mhflag & (town ? 0x01 << (town - 1) : 0);
            bool moghouseExitQuestZoneline = moghouseQuestComplete && startingRegion == destinationRegion && PChar->m_moghouseID > 0 &&
                                             std::any_of(moghouseExitRegions.begin(), moghouseExitRegions.end(),
                                                         [&destinationRegion](REGION_TYPE acceptedReg) { return destinationRegion == acceptedReg; });

            bool moghouseExitMogGardenZoneline = destinationZone == ZONE_MOG_GARDEN && PChar->m_moghouseID > 0;

            // Validate travel
            if (moghouseExitRegular || moghouseExitQuestZoneline || moghouseExitMogGardenZoneline)
            {
                PChar->m_moghouseID    = 0;
                PChar->loc.destination = destinationZone;
                memset(&PChar->loc.p, 0, sizeof(PChar->loc.p));
            }
            else
            {
                PChar->status = STATUS_TYPE::NORMAL;
                ShowWarning(CL_YELLOW "SmallPacket0x05E: Moghouse zoneline abuse by %s\n" CL_RESET, PChar->GetName());
                return;
            }
        }
        else
        {
            zoneLine_t* PZoneLine = PChar->loc.zone->GetZoneLine(zoneLineID);

            // Ensure the zone line exists..
            if (PZoneLine == nullptr)
            {
                ShowError(CL_RED "SmallPacket0x5E: Zone line %u not found\n" CL_RESET, zoneLineID);

                PChar->loc.p.rotation += 128;

                PChar->pushPacket(new CMessageSystemPacket(0, 0, 2));
                PChar->pushPacket(new CCSPositionPacket(PChar));

                PChar->status = STATUS_TYPE::NORMAL;
                return;
            }
            else
            {
                // Ensure the destination exists..
                CZone* PDestination = zoneutils::GetZone(PZoneLine->m_toZone);
                if (PDestination && PDestination->GetIP() == 0)
                {
                    ShowDebug(CL_CYAN "SmallPacket0x5E: Zone %u closed to chars\n" CL_RESET, PZoneLine->m_toZone);

                    PChar->loc.p.rotation += 128;

                    PChar->pushPacket(new CMessageSystemPacket(0, 0, 2));
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
        ShowInfo(CL_WHITE "Zoning from zone %u to zone %u: %s\n" CL_RESET, PChar->getZone(), PChar->loc.destination, PChar->GetName());
    }
    PChar->clearPacketList();

    if (PChar->loc.destination >= MAX_ZONEID)
    {
        ShowWarning(CL_YELLOW "SmallPacket0x05E: Invalid destination passed to packet %u by %s\n" CL_RESET, PChar->loc.destination, PChar->GetName());
        PChar->loc.destination = startingZone;
        return;
    }

    uint64 ipp = zoneutils::GetZoneIPP(PChar->loc.destination == 0 ? PChar->getZone() : PChar->loc.destination);

    charutils::SendToZone(PChar, 2, ipp);
}

/************************************************************************
 *                                                                       *
 *  Event Update (String Update)                                         *
 *  Player sends string for event update.                                *
 *                                                                       *
 ************************************************************************/

// zone 245 cs 0x00C7 Password

void SmallPacket0x060(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    // uint32 charid = data.ref<uint32>(0x04);
    std::string updateString = std::string((char*)data[12]);
    luautils::OnEventUpdate(PChar, updateString);

    PChar->pushPacket(new CReleasePacket(PChar, RELEASE_TYPE::EVENT));
    PChar->pushPacket(new CReleasePacket(PChar, RELEASE_TYPE::UNKNOWN));
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x061(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    PChar->pushPacket(new CCharUpdatePacket(PChar));
    PChar->pushPacket(new CCharHealthPacket(PChar));
    PChar->pushPacket(new CCharStatsPacket(PChar));
    PChar->pushPacket(new CCharSkillsPacket(PChar));
    PChar->pushPacket(new CCharRecastPacket(PChar));
    PChar->pushPacket(new CMenuMeritPacket(PChar));

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

void SmallPacket0x063(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
}

/************************************************************************
 *                                                                       *
 *  Key Items (Mark As Seen)                                             *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x064(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint8 KeyTable = data.ref<uint8>(0x4A);

    if (KeyTable >= PChar->keys.tables.size())
    {
        return;
    }

    memcpy(&PChar->keys.tables[KeyTable].seenList, data[0x08], 0x40);

    charutils::SaveKeyItems(PChar);
}

/************************************************************************
 *                                                                       *
 *  Fishing (Action) [Old fishing method packet! Still used.]            *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x066(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    // PrintPacket(data);

    // uint32 charid = data.ref<uint32>(0x04);
    uint16 stamina = data.ref<uint16>(0x08);
    // uint16 ukn1 = data.ref<uint16>(0x0A); // Seems to always be zero with basic fishing, skill not high enough to test legendary fish.
    // uint16 targetid = data.ref<uint16>(0x0C);
    uint8 action = data.ref<uint8>(0x0E);
    // uint8 ukn2 = data.ref<uint8>(0x0F);
    uint32 special = data.ref<uint32>(0x10);

    if (static_cast<FISH_ACTION>(action) != FISH_ACTION::FINISH || PChar->animation == ANIMATION_FISHING_FISH)
    {
        fishingutils::FishingAction(PChar, static_cast<FISH_ACTION>(action), stamina, special);
    }
}

/************************************************************************
 *                                                                       *
 *  Party Invite                                                         *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x06E(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
                if (PChar->PParty && PChar->PParty->members.size() > 5)
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
                    ShowDebug(CL_CYAN "%s sent party invite to %s\n" CL_RESET, PChar->GetName(), PInvitee->GetName());
                    // make sure invitee isn't dead or in jail, they aren't a party member and don't already have an invite pending, and your party is not full
                    if (PInvitee->isDead() || jailutils::InPrison(PInvitee) || PInvitee->InvitePending.id != 0 || PInvitee->PParty != nullptr)
                    {
                        ShowDebug(CL_CYAN "%s is dead, in jail, has a pending invite, or is already in a party\n" CL_RESET, PInvitee->GetName());
                        PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::CannotInvite));
                        break;
                    }
                    // check /blockaid
                    if (PInvitee->getBlockingAid())
                    {
                        ShowDebug(CL_CYAN "%s is blocking party invites\n" CL_RESET, PInvitee->GetName());
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
                        ShowDebug(CL_CYAN "%s has level sync, unable to send invite\n" CL_RESET, PInvitee->GetName());
                        PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::CannotInviteLevelSync));
                        break;
                    }

                    PInvitee->InvitePending.id     = PChar->id;
                    PInvitee->InvitePending.targid = PChar->targid;
                    PInvitee->pushPacket(new CPartyInvitePacket(charid, targid, PChar, INVITE_PARTY));
                    ShowDebug(CL_CYAN "Sent party invite packet to %s\n" CL_RESET, PInvitee->GetName());
                    if (PChar->PParty && PChar->PParty->GetSyncTarget())
                    {
                        PInvitee->pushPacket(new CMessageStandardPacket(PInvitee, 0, 0, MsgStd::LevelSyncWarning));
                    }
                }
                else
                {
                    ShowDebug(CL_CYAN "Building invite packet to send to lobby server from %s to (%d)\n" CL_RESET, PChar->GetName(), charid);
                    // on another server (hopefully)
                    uint8 packetData[12]{};
                    ref<uint32>(packetData, 0)  = charid;
                    ref<uint16>(packetData, 4)  = targid;
                    ref<uint32>(packetData, 6)  = PChar->id;
                    ref<uint16>(packetData, 10) = PChar->targid;
                    message::send(MSG_PT_INVITE, packetData, sizeof packetData, new CPartyInvitePacket(charid, targid, PChar, INVITE_PARTY));

                    ShowDebug(CL_CYAN "Sent invite packet to lobby server from %s to (%d)\n" CL_RESET, PChar->GetName(), charid);
                }
            }
            else // in party but not leader, cannot invite
            {
                ShowDebug(CL_CYAN "%s is not party leader, cannot send invite\n" CL_RESET, PChar->GetName());
                PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::NotPartyLeader));
            }
            break;

        case 5: // alliance - must be unallied party leader or alliance leader of a non-full alliance
            if (PChar->PParty && PChar->PParty->GetLeader() == PChar &&
                (PChar->PParty->m_PAlliance == nullptr ||
                 (PChar->PParty->m_PAlliance->getMainParty() == PChar->PParty && PChar->PParty->m_PAlliance->partyCount() < 3)))
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
                    ShowDebug(CL_CYAN "%s sent alliance invite to %s\n" CL_RESET, PChar->GetName(), PInvitee->GetName());
                    // check /blockaid
                    if (PInvitee->getBlockingAid())
                    {
                        ShowDebug(CL_CYAN "%s is blocking alliance invites\n" CL_RESET, PInvitee->GetName());
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
                        ShowDebug(CL_CYAN "%s is dead, in jail, has a pending invite, or is already in a party/alliance\n" CL_RESET, PInvitee->GetName());
                        PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::CannotInvite));
                        break;
                    }
                    if (PInvitee->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
                    {
                        ShowDebug(CL_CYAN "%s has level sync, unable to send invite\n" CL_RESET, PInvitee->GetName());
                        PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::CannotInviteLevelSync));
                        break;
                    }

                    PInvitee->InvitePending.id     = PChar->id;
                    PInvitee->InvitePending.targid = PChar->targid;
                    PInvitee->pushPacket(new CPartyInvitePacket(charid, targid, PChar, INVITE_ALLIANCE));
                    ShowDebug(CL_CYAN "Sent party invite packet to %s\n" CL_RESET, PInvitee->GetName());
                }
                else
                {
                    ShowDebug(CL_CYAN "(Alliance)Building invite packet to send to lobby server from %s to (%d)\n" CL_RESET, PChar->GetName(), charid);
                    // on another server (hopefully)
                    uint8 packetData[12]{};
                    ref<uint32>(packetData, 0)  = charid;
                    ref<uint16>(packetData, 4)  = targid;
                    ref<uint32>(packetData, 6)  = PChar->id;
                    ref<uint16>(packetData, 10) = PChar->targid;
                    message::send(MSG_PT_INVITE, packetData, sizeof packetData, new CPartyInvitePacket(charid, targid, PChar, INVITE_ALLIANCE));

                    ShowDebug(CL_CYAN "(Alliance)Sent invite packet to lobby server from %s to (%d)\n" CL_RESET, PChar->GetName(), charid);
                }
            }
            break;

        default:
            ShowError(CL_RED "SmallPacket0x06E : unknown byte <%.2X>\n" CL_RESET, data.ref<uint8>(0x0A));
            break;
    }
}

/************************************************************************
 *                                                                       *
 *  Party / Alliance Command 'Leave'                                     *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x06F(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    if (PChar->PParty)
    {
        switch (data.ref<uint8>(0x04))
        {
            case 0: // party - anyone may remove themself from party regardless of leadership or alliance
                if (PChar->PParty->m_PAlliance &&
                    PChar->PParty->members.size() == 1) // single member alliance parties must be removed from alliance before disband
                {
                    ShowDebug(CL_CYAN "%s party size is one\n" CL_RESET, PChar->GetName());
                    if (PChar->PParty->m_PAlliance->partyCount() == 1) // if there is only 1 party then dissolve alliance
                    {
                        ShowDebug(CL_CYAN "%s alliance size is one party\n" CL_RESET, PChar->GetName());
                        PChar->PParty->m_PAlliance->dissolveAlliance();
                        ShowDebug(CL_CYAN "%s alliance is dissolved\n" CL_RESET, PChar->GetName());
                    }
                    else
                    {
                        ShowDebug(CL_CYAN "Removing %s party from alliance\n" CL_RESET, PChar->GetName());
                        PChar->PParty->m_PAlliance->removeParty(PChar->PParty);
                        ShowDebug(CL_CYAN "%s party is removed from alliance\n" CL_RESET, PChar->GetName());
                    }
                }
                ShowDebug(CL_CYAN "Removing %s from party\n" CL_RESET, PChar->GetName());
                PChar->PParty->RemoveMember(PChar);
                ShowDebug(CL_CYAN "%s is removed from party\n" CL_RESET, PChar->GetName());
                break;

            case 5: // alliance - any party leader in alliance may remove their party
                if (PChar->PParty->m_PAlliance && PChar->PParty->GetLeader() == PChar)
                {
                    ShowDebug(CL_CYAN "%s is leader of a party in an alliance\n" CL_RESET, PChar->GetName());
                    if (PChar->PParty->m_PAlliance->partyCount() == 1) // if there is only 1 party then dissolve alliance
                    {
                        ShowDebug(CL_CYAN "One party in alliance, %s wants to dissolve the alliance\n" CL_RESET, PChar->GetName());
                        PChar->PParty->m_PAlliance->dissolveAlliance();
                        ShowDebug(CL_CYAN "%s has dissolved the alliance\n" CL_RESET, PChar->GetName());
                    }
                    else
                    {
                        ShowDebug(CL_CYAN "%s wants to remove their party from the alliance\n" CL_RESET, PChar->GetName());
                        PChar->PParty->m_PAlliance->removeParty(PChar->PParty);
                        ShowDebug(CL_CYAN "%s party is removed from the alliance\n" CL_RESET, PChar->GetName());
                    }
                }
                break;

            default:
                ShowError(CL_RED "SmallPacket0x06F : unknown byte <%.2X>\n" CL_RESET, data.ref<uint8>(0x04));
                break;
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Party / Alliance Command 'Breakup'                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x070(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    if (PChar->PParty && PChar->PParty->GetLeader() == PChar)
    {
        switch (data.ref<uint8>(0x04))
        {
            case 0: // party - party leader may disband party if not an alliance member
                if (PChar->PParty->m_PAlliance == nullptr)
                {
                    ShowDebug(CL_CYAN "%s is disbanding the party (pcmd breakup)\n" CL_RESET, PChar->GetName());
                    PChar->PParty->DisbandParty();
                    ShowDebug(CL_CYAN "%s party has been disbanded (pcmd breakup)\n" CL_RESET, PChar->GetName());
                }
                break;

            case 5: // alliance - only alliance leader may dissolve the entire alliance
                if (PChar->PParty->m_PAlliance && PChar->PParty->m_PAlliance->getMainParty() == PChar->PParty)
                {
                    ShowDebug(CL_CYAN "%s is disbanding the alliance (acmd breakup)\n" CL_RESET, PChar->GetName());
                    PChar->PParty->m_PAlliance->dissolveAlliance();
                    ShowDebug(CL_CYAN "%s alliance has been disbanded (acmd breakup)\n" CL_RESET, PChar->GetName());
                }
                break;

            default:
                ShowError(CL_RED "SmallPacket0x070 : unknown byte <%.2X>\n" CL_RESET, data.ref<uint8>(0x04));
                break;
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Party / Linkshell / Alliance Command 'Kick'                          *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x071(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    switch (data.ref<uint8>(0x0A))
    {
        case 0: // party - party leader may remove member of his own party
            if (PChar->PParty && PChar->PParty->GetLeader() == PChar)
            {
                CCharEntity* PVictim = (CCharEntity*)(PChar->PParty->GetMemberByName(data[0x0C]));
                if (PVictim)
                {
                    ShowDebug(CL_CYAN "%s is trying to kick %s from party\n" CL_RESET, PChar->GetName(), PVictim->GetName());
                    if (PVictim == PChar) // using kick on yourself, let's borrow the logic from /pcmd leave to prevent alliance crash
                    {
                        if (PChar->PParty->m_PAlliance &&
                            PChar->PParty->members.size() == 1) // single member alliance parties must be removed from alliance before disband
                        {
                            if (PChar->PParty->m_PAlliance->partyCount() == 1) // if there is only 1 party then dissolve alliance
                            {
                                ShowDebug(CL_CYAN "One party in alliance, %s wants to dissolve the alliance\n" CL_RESET, PChar->GetName());
                                PChar->PParty->m_PAlliance->dissolveAlliance();
                                ShowDebug(CL_CYAN "%s has dissolved the alliance\n" CL_RESET, PChar->GetName());
                            }
                            else
                            {
                                ShowDebug(CL_CYAN "%s wants to remove their party from the alliance\n" CL_RESET, PChar->GetName());
                                PChar->PParty->m_PAlliance->removeParty(PChar->PParty);
                                ShowDebug(CL_CYAN "%s party is removed from the alliance\n" CL_RESET, PChar->GetName());
                            }
                        }
                    }

                    PChar->PParty->RemoveMember(PVictim);
                    ShowDebug(CL_CYAN "%s has removed %s from party\n" CL_RESET, PChar->GetName(), PVictim->GetName());
                }
                else
                {
                    char victimName[31]{};
                    Sql_EscapeStringLen(SqlHandle, victimName, (const char*)data[0x0C], std::min<size_t>(strlen((const char*)data[0x0C]), 15));
                    int32 ret = Sql_Query(SqlHandle, "SELECT charid FROM chars WHERE charname = '%s';", victimName);
                    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) == 1 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                    {
                        uint32 id = Sql_GetUIntData(SqlHandle, 0);
                        if (Sql_Query(SqlHandle, "DELETE FROM accounts_parties WHERE partyid = %u AND charid = %u;", PChar->id, id) == SQL_SUCCESS &&
                            Sql_AffectedRows(SqlHandle))
                        {
                            ShowDebug(CL_CYAN "%s has removed %s from party\n" CL_RESET, PChar->GetName(), data[0x0C]);
                            uint8 data[8]{};
                            ref<uint32>(data, 0) = PChar->PParty->GetPartyID();
                            ref<uint32>(data, 4) = id;
                            message::send(MSG_PT_RELOAD, data, sizeof data, nullptr);
                        }
                    }
                }
            }
            break;
        case 1: // linkshell
        {
            // Ensure the player has a linkshell equipped..
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
            // Ensure the player has a linkshell equipped..
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
                for (uint8 i = 0; i < PChar->PParty->m_PAlliance->partyList.size(); ++i)
                {
                    PVictim = (CCharEntity*)(PChar->PParty->m_PAlliance->partyList[i]->GetMemberByName(data[0x0C]));
                    if (PVictim && PVictim->PParty && PVictim->PParty->m_PAlliance) // victim is in this party
                    {
                        ShowDebug(CL_CYAN "%s is trying to kick %s party from alliance\n" CL_RESET, PChar->GetName(), PVictim->GetName());
                        // if using kick on yourself, or alliance leader using kick on another party leader - remove the party
                        if (PVictim == PChar || (PChar->PParty->m_PAlliance->getMainParty() == PChar->PParty && PVictim->PParty->GetLeader() == PVictim))
                        {
                            if (PVictim->PParty->m_PAlliance->partyCount() == 1) // if there is only 1 party then dissolve alliance
                            {
                                ShowDebug(CL_CYAN "One party in alliance, %s wants to dissolve the alliance\n" CL_RESET, PChar->GetName());
                                PVictim->PParty->m_PAlliance->dissolveAlliance();
                                ShowDebug(CL_CYAN "%s has dissolved the alliance\n" CL_RESET, PChar->GetName());
                            }
                            else
                            {
                                PVictim->PParty->m_PAlliance->removeParty(PVictim->PParty);
                                ShowDebug(CL_CYAN "%s has removed %s party from alliance\n" CL_RESET, PChar->GetName(), PVictim->GetName());
                            }
                        }
                        break; // we're done, break the for
                    }
                }
                if (!PVictim && PChar->PParty->m_PAlliance->getMainParty() == PChar->PParty)
                {
                    char victimName[31]{};
                    Sql_EscapeStringLen(SqlHandle, victimName, (const char*)data[0x0C], std::min<size_t>(strlen((const char*)data[0x0C]), 15));
                    int32 ret = Sql_Query(SqlHandle, "SELECT charid FROM chars WHERE charname = '%s';", victimName);
                    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) == 1 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                    {
                        uint32 id = Sql_GetUIntData(SqlHandle, 0);
                        ret       = Sql_Query(SqlHandle,
                                        "SELECT partyid FROM accounts_parties WHERE charid = %u AND allianceid = %u AND partyflag & %d AND partyflag & %d", id,
                                        PChar->PParty->m_PAlliance->m_AllianceID, PARTY_LEADER, PARTY_SECOND | PARTY_THIRD);
                        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) == 1 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                        {
                            if (Sql_Query(SqlHandle, "UPDATE accounts_parties SET allianceid = 0, partyflag = partyflag & ~%d WHERE partyid = %u;",
                                          PARTY_SECOND | PARTY_THIRD, id) == SQL_SUCCESS &&
                                Sql_AffectedRows(SqlHandle))
                            {
                                ShowDebug(CL_CYAN "%s has removed %s party from alliance\n" CL_RESET, PChar->GetName(), data[0x0C]);
                                uint8 data[8]{};
                                ref<uint32>(data, 0) = PChar->PParty->GetPartyID();
                                ref<uint32>(data, 4) = id;
                                message::send(MSG_PT_RELOAD, data, sizeof data, nullptr);
                            }
                        }
                    }
                }
            }
            break;

        default:
            ShowError(CL_RED "SmallPacket0x071 : unknown byte <%.2X>\n" CL_RESET, data.ref<uint8>(0x0A));
            break;
    }
}

/************************************************************************
 *                                                                       *
 *  Party Invite Response (Accept, Decline, Leave)                       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x074(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    CCharEntity* PInviter = zoneutils::GetCharFromWorld(PChar->InvitePending.id, PChar->InvitePending.targid);

    uint8 InviteAnswer = data.ref<uint8>(0x04);

    if (PInviter != nullptr)
    {
        if (InviteAnswer == 0)
        {
            ShowDebug(CL_CYAN "%s declined party invite from %s\n" CL_RESET, PChar->GetName(), PInviter->GetName());
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
                ShowDebug(CL_CYAN "%s invited %s to an alliance\n" CL_RESET, PInviter->GetName(), PChar->GetName());
                // the inviter already has an alliance and wants to add another party - only add if they have room for another party
                if (PInviter->PParty->m_PAlliance)
                {
                    // break if alliance is full or the inviter is not the leader
                    if (PInviter->PParty->m_PAlliance->partyCount() == 3 || PInviter->PParty->m_PAlliance->getMainParty() != PInviter->PParty)
                    {
                        ShowDebug(CL_CYAN "Alliance is full, invite to %s cancelled\n" CL_RESET, PChar->GetName());
                        PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::CannotBeProcessed));
                        PChar->InvitePending.clean();
                        return;
                    }

                    // alliance is not full, add the new party
                    PInviter->PParty->m_PAlliance->addParty(PChar->PParty);
                    PChar->InvitePending.clean();
                    ShowDebug(CL_CYAN "%s party added to %s alliance\n" CL_RESET, PChar->GetName(), PInviter->GetName());
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
                    ShowDebug(CL_CYAN "Creating new alliance\n" CL_RESET);
                    PInviter->PParty->m_PAlliance = new CAlliance(PInviter);
                    PInviter->PParty->m_PAlliance->addParty(PChar->PParty);
                    PChar->InvitePending.clean();
                    ShowDebug(CL_CYAN "%s party added to %s alliance\n" CL_RESET, PChar->GetName(), PInviter->GetName());
                    return;
                }
            }
        }

        // the rest is for a standard party invitation
        if (PChar->PParty == nullptr)
        {
            if (!(PChar->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC) && PChar->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_RESTRICTION)))
            {
                ShowDebug(CL_CYAN "%s is not under lvl sync or restriction\n" CL_RESET, PChar->GetName());
                if (PInviter->PParty == nullptr)
                {
                    ShowDebug(CL_CYAN "Creating new party\n" CL_RESET);
                    PInviter->PParty = new CParty(PInviter);
                }
                if (PInviter->PParty->GetLeader() == PInviter)
                {
                    if (PInviter->PParty->members.size() > 5)
                    { // someone else accepted invitation
                        // PInviter->pushPacket(new CMessageStandardPacket(PInviter, 0, 0, 14)); Don't think retail sends error packet to inviter on full pt
                        ShowDebug(CL_CYAN "Someone else accepted party invite, %s cannot be added to party\n" CL_RESET, PChar->GetName());
                        PChar->pushPacket(new CMessageStandardPacket(PChar, 0, 0, MsgStd::CannotBeProcessed));
                    }
                    else
                    {
                        ShowDebug(CL_CYAN "Added %s to %s's party\n" CL_RESET, PChar->GetName(), PInviter->GetName());
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
        ShowDebug(CL_CYAN "(Party)Building invite packet to send to lobby server for %s\n" CL_RESET, PChar->GetName());
        uint8 packetData[13]{};
        ref<uint32>(packetData, 0)  = PChar->InvitePending.id;
        ref<uint16>(packetData, 4)  = PChar->InvitePending.targid;
        ref<uint32>(packetData, 6)  = PChar->id;
        ref<uint16>(packetData, 10) = PChar->targid;
        ref<uint8>(packetData, 12)  = InviteAnswer;
        PChar->InvitePending.clean();
        message::send(MSG_PT_INV_RES, packetData, sizeof packetData, nullptr);
        ShowDebug(CL_CYAN "(Party)Sent invite packet to send to lobby server for %s\n" CL_RESET, PChar->GetName());
    }
    PChar->InvitePending.clean();
}

/************************************************************************
 *                                                                       *
 *  Party List Request                                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x076(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x077(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    switch (data.ref<uint8>(0x14))
    {
        case 0: // party
        {
            if (PChar->PParty != nullptr && PChar->PParty->GetLeader() == PChar)
            {
                ShowDebug(CL_CYAN "(Party)Changing leader to %s\n" CL_RESET, data[0x04]);
                PChar->PParty->AssignPartyRole(data[0x04], data.ref<uint8>(0x15));
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
                ShowDebug(CL_CYAN "(Alliance)Changing leader to %s\n" CL_RESET, data[0x04]);
                PChar->PParty->m_PAlliance->assignAllianceLeader((const char*)data[0x04]);
                uint8 data[4]{};
                ref<uint32>(data, 0) = PChar->PParty->m_PAlliance->m_AllianceID;
                message::send(MSG_PT_RELOAD, data, sizeof data, nullptr);
            }
        }
        break;
        default:
        {
            ShowError(CL_RED "SmallPacket0x077 : changing role packet with unknown byte <%.2X>\n" CL_RESET, data.ref<uint8>(0x14));
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Party Search                                                         *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x078(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    PChar->pushPacket(new CPartySearchPacket(PChar));
}

/************************************************************************
 *                                                                       *
 *  Vender Item Purchase                                                 *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x083(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint8 quantity   = data.ref<uint8>(0x04);
    uint8 shopSlotID = data.ref<uint8>(0x0A);

    // Prevent users from buying from invalid container slots
    if (shopSlotID > PChar->Container->getExSize() - 1)
    {
        ShowError(CL_RED "User '%s' attempting to buy vendor item from an invalid slot!\n" CL_RESET, PChar->GetName());
        return;
    }

    uint16 itemID = PChar->Container->getItemID(shopSlotID);
    uint32 price  = PChar->Container->getQuantity(shopSlotID); // We used the "quantity" to store the item's sale price

    CItem* PItem = itemutils::GetItemPointer(itemID);
    if (PItem == nullptr)
    {
        ShowWarning(CL_YELLOW "User '%s' attempting to buy an invalid item from vendor!\n" CL_RESET, PChar->GetName());
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
        if (gil->getQuantity() > (price * quantity))
        {
            uint8 SlotID = charutils::AddItem(PChar, LOC_INVENTORY, itemID, quantity);

            if (SlotID != ERROR_SLOTID)
            {
                charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -(int32)(price * quantity));
                ShowNotice(CL_CYAN "User '%s' purchased %u of item of ID %u [from VENDOR] \n" CL_RESET, PChar->GetName(), quantity, itemID);
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

void SmallPacket0x084(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x085(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
            ShowExploit(CL_RED "SmallPacket0x085: Player %s trying to sell invalid quantity %u of itemID %u [to VENDOR] \n" CL_RESET, PChar->GetName(),
                        quantity);
            return;
        }

        if (PItem->isSubType(ITEM_LOCKED)) // Possible exploit
        {
            ShowExploit(CL_RED "SmallPacket0x085: Player %s trying to sell %u of a LOCKED item! ID %i [to VENDOR] \n" CL_RESET, PChar->GetName(), quantity,
                        PItem->getID());
            return;
        }

        if (PItem->getReserve() > 0) // Usually caused by bug during synth, trade, etc. reserving the item. We don't want such items sold in this state.
        {
            ShowError(CL_RED "SmallPacket0x085: Player %s trying to sell %u of a RESERVED(%u) item! ID %i [to VENDOR] \n" CL_RESET, PChar->GetName(), quantity,
                      PItem->getReserve(), PItem->getID());
            return;
        }

        charutils::UpdateItem(PChar, LOC_INVENTORY, 0, quantity * PItem->getBasePrice());
        charutils::UpdateItem(PChar, LOC_INVENTORY, slotID, -(int32)quantity);
        ShowNotice(CL_CYAN "SmallPacket0x085: Player '%s' sold %u of itemID %u [to VENDOR] \n" CL_RESET, PChar->GetName(), quantity, itemID);
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

void SmallPacket0x096(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    if (jailutils::InPrison(PChar))
    {
        // Prevent crafting in prison
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
        return;
    }

    if (PChar->m_LastSynthTime + 10s > server_clock::now())
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 94));
        return;
    }

    PChar->CraftContainer->Clean();

    uint16 ItemID    = data.ref<uint32>(0x06);
    uint8  invSlotID = data.ref<uint8>(0x08);

    uint8 numItems = data.ref<uint8>(0x09);

    std::vector<uint8> slotQty(MAX_CONTAINER_SIZE);

    if (numItems > 8)
    {
        // Prevent crafting exploit to crash on container size > 8
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
        return;
    }

    PChar->CraftContainer->setItem(0, ItemID, invSlotID, 0);

    for (int32 SlotID = 0; SlotID < numItems; ++SlotID)
    {
        ItemID    = data.ref<uint16>(0x0A + SlotID * 2);
        invSlotID = data.ref<uint8>(0x1A + SlotID);

        slotQty[invSlotID]++;

        auto* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotID);

        if (PItem && PItem->getID() == ItemID && slotQty[invSlotID] <= (PItem->getQuantity() - PItem->getReserve()))
        {
            PChar->CraftContainer->setItem(SlotID + 1, ItemID, invSlotID, 1);
        }
    }

    synthutils::startSynth(PChar);
}

/************************************************************************
 *                                                                        *
 *  Guild Purchase                                                        *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x0AA(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint16     itemID     = data.ref<uint16>(0x04);
    uint8      quantity   = data.ref<uint8>(0x07);
    uint8      shopSlotID = PChar->PGuildShop->SearchItem(itemID);
    CItemShop* item       = (CItemShop*)PChar->PGuildShop->GetItem(shopSlotID);
    CItem*     gil        = PChar->getStorage(LOC_INVENTORY)->GetItem(0);

    CItem* PItem = itemutils::GetItemPointer(itemID);
    if (PItem == nullptr)
    {
        ShowWarning(CL_YELLOW "User '%s' attempting to buy an invalid item from guild vendor!\n" CL_RESET, PChar->GetName());
        return;
    }

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
                ShowNotice(CL_CYAN "SmallPacket0x0AA: Player '%s' purchased %u of itemID %u [from GUILD] \n" CL_RESET, PChar->GetName(), quantity, itemID);
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

void SmallPacket0x0A2(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x0AB(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x0AC(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
                    ShowNotice(CL_CYAN "SmallPacket0x0AC: Player '%s' sold %u of itemID %u [to GUILD] \n" CL_RESET, PChar->GetName(), quantity, itemID);
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

void SmallPacket0x0AD(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x0B5(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    if (data.ref<uint8>(0x06) == '!' && !jailutils::InPrison(PChar) && CCommandHandler::call(luautils::lua, PChar, (const int8*)data[7]) == 0)
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
                if (map_config.audit_chat == 1 && map_config.audit_say == 1)
                {
                    char escaped_speaker[16 * 2 + 1];
                    Sql_EscapeString(SqlHandle, escaped_speaker, (const char*)PChar->GetName());

                    std::string escaped_full_string;
                    escaped_full_string.reserve(strlen((const char*)data[6]) * 2 + 1);
                    Sql_EscapeString(SqlHandle, escaped_full_string.data(), (const char*)data[6]);

                    const char* fmtQuery = "INSERT into audit_chat (speaker,type,message,datetime) VALUES('%s','SAY','%s',current_timestamp())";
                    if (Sql_Query(SqlHandle, fmtQuery, escaped_speaker, escaped_full_string.data()) == SQL_ERROR)
                    {
                        ShowError("packet_system::call: Failed to log inPrison MESSAGE_SAY.\n");
                    }
                }
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CChatMessagePacket(PChar, MESSAGE_SAY, (const char*)data[6]));
            }
            else
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
            }
        }
        else
        {
            switch (data.ref<uint8>(0x04))
            {
                case MESSAGE_SAY:
                {
                    if (map_config.audit_chat == 1 && map_config.audit_say == 1)
                    {
                        char escaped_speaker[16 * 2 + 1];
                        Sql_EscapeString(SqlHandle, escaped_speaker, (const char*)PChar->GetName());

                        std::string escaped_full_string;
                        escaped_full_string.reserve(strlen((const char*)data[6]) * 2 + 1);
                        Sql_EscapeString(SqlHandle, escaped_full_string.data(), (const char*)data[6]);

                        const char* fmtQuery = "INSERT into audit_chat (speaker,type,message,datetime) VALUES('%s','SAY','%s',current_timestamp())";
                        if (Sql_Query(SqlHandle, fmtQuery, escaped_speaker, escaped_full_string.data()) == SQL_ERROR)
                        {
                            ShowError("packet_system::call: Failed to log MESSAGE_SAY.\n");
                        }
                    }
                    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CChatMessagePacket(PChar, MESSAGE_SAY, (const char*)data[6]));
                }
                break;
                case MESSAGE_EMOTION:
                    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CChatMessagePacket(PChar, MESSAGE_EMOTION, (const char*)data[6]));
                    break;
                case MESSAGE_SHOUT:
                {
                    if (map_config.audit_chat == 1 && map_config.audit_shout == 1)
                    {
                        char escaped_speaker[16 * 2 + 1];
                        Sql_EscapeString(SqlHandle, escaped_speaker, (const char*)PChar->GetName());

                        std::string escaped_full_string;
                        escaped_full_string.reserve(strlen((const char*)data[6]) * 2 + 1);
                        Sql_EscapeString(SqlHandle, escaped_full_string.data(), (const char*)data[6]);

                        const char* fmtQuery = "INSERT into audit_chat (speaker,type,message,datetime) VALUES('%s','SHOUT','%s',current_timestamp())";
                        if (Sql_Query(SqlHandle, fmtQuery, escaped_speaker, escaped_full_string.data()) == SQL_ERROR)
                        {
                            ShowError("packet_system::call: Failed to log MESSAGE_SHOUT.\n");
                        }
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

                        if (map_config.audit_chat == 1 && map_config.audit_linkshell == 1)
                        {
                            char escaped_speaker[16 * 2 + 1];
                            Sql_EscapeString(SqlHandle, escaped_speaker, (const char*)PChar->GetName());

                            std::string ls_name((const char*)PChar->PLinkshell1->getName());
                            DecodeStringLinkshell((int8*)&ls_name[0], (int8*)&ls_name[0]);
                            char escaped_ls[19 * 2 + 1];
                            Sql_EscapeString(SqlHandle, escaped_ls, ls_name.data());

                            std::string escaped_full_string;
                            escaped_full_string.reserve(strlen((const char*)data[6]) * 2 + 1);
                            Sql_EscapeString(SqlHandle, escaped_full_string.data(), (const char*)data[6]);

                            const char* fmtQuery =
                                "INSERT into audit_chat (speaker,type,lsName,message,datetime) VALUES('%s','LINKSHELL','%s','%s',current_timestamp())";
                            if (Sql_Query(SqlHandle, fmtQuery, escaped_speaker, escaped_ls, escaped_full_string.data()) == SQL_ERROR)
                            {
                                ShowError("packet_system::call: Failed to log MESSAGE_LINKSHELL.\n");
                            }
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

                        if (map_config.audit_chat == 1 && map_config.audit_linkshell == 1)
                        {
                            char escaped_speaker[16 * 2 + 1];
                            Sql_EscapeString(SqlHandle, escaped_speaker, (const char*)PChar->GetName());

                            std::string ls_name((const char*)PChar->PLinkshell2->getName());
                            DecodeStringLinkshell((int8*)&ls_name[0], (int8*)&ls_name[0]);
                            char escaped_ls[19 * 2 + 1];
                            Sql_EscapeString(SqlHandle, escaped_ls, ls_name.data());

                            std::string escaped_full_string;
                            escaped_full_string.reserve(strlen((const char*)data[6]) * 2 + 1);
                            Sql_EscapeString(SqlHandle, escaped_full_string.data(), (const char*)data[6]);

                            const char* fmtQuery =
                                "INSERT into audit_chat (speaker,type,lsName,message,datetime) VALUES('%s','LINKSHELL','%s','%s',current_timestamp())";
                            if (Sql_Query(SqlHandle, fmtQuery, escaped_speaker, escaped_ls, escaped_full_string.data()) == SQL_ERROR)
                            {
                                ShowError("packet_system::call: Failed to log MESSAGE_LINKSHELL2.\n");
                            }
                        }
                    }
                }
                break;
                case MESSAGE_PARTY:
                {
                    if (PChar->PParty != nullptr)
                    {
                        int8 packetData[8]{};
                        ref<uint32>(packetData, 0) = PChar->PParty->GetPartyID();
                        ref<uint32>(packetData, 4) = PChar->id;
                        message::send(MSG_CHAT_PARTY, packetData, sizeof packetData, new CChatMessagePacket(PChar, MESSAGE_PARTY, (const char*)data[6]));

                        if (map_config.audit_chat == 1 && map_config.audit_party == 1)
                        {
                            char escaped_speaker[16 * 2 + 1];
                            Sql_EscapeString(SqlHandle, escaped_speaker, (const char*)PChar->GetName());

                            std::string escaped_full_string;
                            escaped_full_string.reserve(strlen((const char*)data[6]) * 2 + 1);
                            Sql_EscapeString(SqlHandle, escaped_full_string.data(), (const char*)data[6]);

                            const char* fmtQuery = "INSERT into audit_chat (speaker,type,message,datetime) VALUES('%s','PARTY','%s',current_timestamp())";
                            if (Sql_Query(SqlHandle, fmtQuery, escaped_speaker, escaped_full_string.data()) == SQL_ERROR)
                            {
                                ShowError("packet_system::call: Failed to log MESSAGE_PARTY.\n");
                            }
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
                            PChar->m_LastYell = gettick() + (map_config.yell_cooldown * 1000);
                            // ShowDebug(CL_CYAN" LastYell: %u \n" CL_RESET, PChar->m_LastYell);
                            int8 packetData[4]{};
                            ref<uint32>(packetData, 0) = PChar->id;

                            message::send(MSG_CHAT_YELL, packetData, sizeof packetData, new CChatMessagePacket(PChar, MESSAGE_YELL, (const char*)data[6]));
                        }
                        else // You must wait longer to perform that action.
                        {
                            PChar->pushPacket(new CMessageStandardPacket(PChar, 0, MsgStd::WaitLonger));
                        }

                        if (map_config.audit_chat == 1 && map_config.audit_yell == 1)
                        {
                            char escaped_speaker[16 * 2 + 1];
                            Sql_EscapeString(SqlHandle, escaped_speaker, (const char*)PChar->GetName());

                            std::string escaped_full_string;
                            escaped_full_string.reserve(strlen((const char*)data[6]) * 2 + 1);
                            Sql_EscapeString(SqlHandle, escaped_full_string.data(), (const char*)data[6]);

                            const char* fmtQuery = "INSERT into audit_chat (speaker,type,message,datetime) VALUES('%s','YELL','%s',current_timestamp())";
                            if (Sql_Query(SqlHandle, fmtQuery, escaped_speaker, escaped_full_string.data()) == SQL_ERROR)
                            {
                                ShowError("packet_system::call: Failed to log MESSAGE_YELL.\n");
                            }
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

                        if (map_config.audit_chat == 1 && map_config.audit_unity == 1)
                        {
                            char escaped_speaker[16 * 2 + 1];
                            Sql_EscapeString(SqlHandle, escaped_speaker, (const char*)PChar->GetName());

                            std::string escaped_full_string;
                            escaped_full_string.reserve(strlen((const char*)data[6]) * 2 + 1);
                            Sql_EscapeString(SqlHandle, escaped_full_string.data(), (const char*)data[6]);


                            const char* fmtQuery = "INSERT into audit_chat (speaker,type,message,datetime) VALUES('%s','SAY','%s',current_timestamp())";
                            if (Sql_Query(SqlHandle, fmtQuery, escaped_speaker, escaped_full_string.data()) == SQL_ERROR)
                            {
                                ShowError("packet_system::call: Failed to log inPrison MESSAGE_UNITY.\n");
                            }
                        }
                    }
                }
                break;
            }
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Whisper / Tell                                                       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0B6(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    if (jailutils::InPrison(PChar))
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
        return;
    }
    string_t RecipientName = string_t((const char*)data[6], 15);

    int8 packetData[64];
    strncpy((char*)packetData + 4, RecipientName.c_str(), RecipientName.length() + 1);
    ref<uint32>(packetData, 0) = PChar->id;
    message::send(MSG_CHAT_TELL, packetData, RecipientName.length() + 5, new CChatMessagePacket(PChar, MESSAGE_TELL, (const char*)data[21]));

    if (map_config.audit_chat == 1 && map_config.audit_tell == 1)
    {
        char escaped_speaker[16 * 2 + 1];
        Sql_EscapeString(SqlHandle, escaped_speaker, (const char*)PChar->GetName());

        char escaped_recipient[16 * 2 + 1];
        Sql_EscapeString(SqlHandle, escaped_recipient, &RecipientName[0]);

        std::string escaped_full_string;
        escaped_full_string.reserve(strlen((const char*)data[21]) * 2 + 1);
        Sql_EscapeString(SqlHandle, escaped_full_string.data(), (const char*)data[21]);

        const char* fmtQuery = "INSERT into audit_chat (speaker,type,recipient,message,datetime) VALUES('%s','TELL','%s','%s',current_timestamp())";
        if (Sql_Query(SqlHandle, fmtQuery, escaped_speaker, escaped_recipient, escaped_full_string.data()) == SQL_ERROR)
        {
            ShowError("packet_system::call: Failed to log MESSAGE_TELL.\n");
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Merit Mode (Setting of exp or limit points mode.)                    *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0BE(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint8 operation = data.ref<uint8>(0x05);

    switch (data.ref<uint8>(0x04))
    {
        case 2: // change mode
        {
            // TODO: you can switch mode anywhere except in besieged & under level restriction
            if (Sql_Query(SqlHandle, "UPDATE char_exp SET mode = %u WHERE charid = %u", operation, PChar->id) != SQL_ERROR)
            {
                PChar->MeritMode = operation;
                PChar->pushPacket(new CMenuMeritPacket(PChar));
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
                    switch (operation)
                    {
                        case 0:
                            PChar->PMeritPoints->LowerMerit(merit);
                            break;
                        case 1:
                            PChar->PMeritPoints->RaiseMerit(merit);
                            break;
                    }
                    PChar->pushPacket(new CMenuMeritPacket(PChar));
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

void SmallPacket0x0BF(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
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

void SmallPacket0x0C0(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
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

void SmallPacket0x0C3(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x0C4(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint8           SlotID         = data.ref<uint8>(0x06);
    uint8           LocationID     = data.ref<uint8>(0x07);
    uint8           action         = data.ref<uint8>(0x08);
    uint8           lsNum          = data.ref<uint8>(0x1B);
    CItemLinkshell* PItemLinkshell = (CItemLinkshell*)PChar->getStorage(LocationID)->GetItem(SlotID);

    if (PItemLinkshell != nullptr && PItemLinkshell->isType(ITEM_LINKSHELL))
    {
        // Create new linkshell..
        if (PItemLinkshell->getID() == 512)
        {
            uint32 LinkshellID    = 0;
            uint16 LinkshellColor = data.ref<uint16>(0x04);
            int8   DecodedName[21];
            int8   EncodedName[16];

            DecodeStringLinkshell(data[12], DecodedName);
            EncodeStringLinkshell(DecodedName, EncodedName);
            // TODO: Check if a linebreak is needed..

            LinkshellID = linkshell::RegisterNewLinkshell(DecodedName, LinkshellColor);
            if (LinkshellID != 0)
            {
                delete PItemLinkshell;
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
                Sql_EscapeStringLen(SqlHandle, extra, (const char*)PItemLinkshell->m_extra, sizeof(PItemLinkshell->m_extra));

                const char* Query =
                    "UPDATE char_inventory SET signature = '%s', extra = '%s', itemId = 513 WHERE charid = %u AND location = 0 AND slot = %u LIMIT 1";

                if (Sql_Query(SqlHandle, Query, DecodedName, extra, PChar->id, SlotID) != SQL_ERROR && Sql_AffectedRows(SqlHandle) != 0)
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
                    auto ret = Sql_Query(SqlHandle, "SELECT broken FROM linkshells WHERE linkshellid = %u LIMIT 1", PItemLinkshell->GetLSID());
                    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS && Sql_GetUIntData(SqlHandle, 0) == 1)
                    { // if the linkshell has been broken, break the item
                        PItemLinkshell->SetLSType(LSTYPE_BROKEN);
                        char extra[sizeof(PItemLinkshell->m_extra) * 2 + 1];
                        Sql_EscapeStringLen(SqlHandle, extra, (const char*)PItemLinkshell->m_extra, sizeof(PItemLinkshell->m_extra));
                        const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u LIMIT 1";
                        Sql_Query(SqlHandle, Query, extra, PChar->id, PItemLinkshell->getLocationID(), PItemLinkshell->getSlotID());
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
 *  Open/Close Mog House                                                 *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0CB(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    if (data.ref<uint8>(0x04) == 1)
    {
        // open
    }
    else if (data.ref<uint8>(0x04) == 2)
    {
        // close
    }
    else
    {
        ShowWarning(CL_RED "SmallPacket0x0CB : unknown byte <%.2X>\n" CL_RESET, data.ref<uint8>(0x04));
    }
}

/************************************************************************
 *                                                                       *
 *  Request Party Map Positions                                          *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0D2(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    PChar->ForAlliance([PChar](CBattleEntity* PPartyMember) {
        if (PPartyMember->getZone() == PChar->getZone() && ((CCharEntity*)PPartyMember)->m_moghouseID == PChar->m_moghouseID)
        {
            PChar->pushPacket(new CPartyMapPacket((CCharEntity*)PPartyMember));
        }
    });
}

/************************************************************************
 *                                                                       *
 *  Help Desk Report                                                     *
 *  help desk -> i want to report -> yes -> yes -> execute               *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0D3(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
}

/************************************************************************
 *                                                                       *
 *  Set Preferred Language                                               *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0DB(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    PChar->search.language = data.ref<uint8>(0x24);
}

/************************************************************************
 *                                                                       *
 *  Set Name Flags (Party, Away, Autogroup, etc.)                        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0DC(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    switch (data.ref<uint32>(0x04))
    {
        case NFLAG_INVITE:
            // /invite [on|off]
            PChar->nameflags.flags ^= FLAG_INVITE;
            // PChar->menuConfigFlags.flags ^= NFLAG_INVITE;
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
            // /anon [on|off]
            PChar->nameflags.flags ^= FLAG_ANON;
            if (PChar->nameflags.flags & FLAG_ANON)
            {
                PChar->pushPacket(new CMessageSystemPacket(0, 0, 175));
            }
            else
            {
                PChar->pushPacket(new CMessageSystemPacket(0, 0, 176));
            }
            break;
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

void SmallPacket0x0DD(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x0DE(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    PChar->bazaar.message.clear();
    PChar->bazaar.message.insert(0, (const char*)data[4], 120); // Maximum bazaar message limit: 120 characters

    char message[256];
    Sql_EscapeString(SqlHandle, message, PChar->bazaar.message.c_str());

    Sql_Query(SqlHandle, "UPDATE char_stats SET bazaar_message = '%s' WHERE charid = %u;", message, PChar->id);
}

/************************************************************************
 *                                                                       *
 *  Set Search Message                                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0E0(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    PChar->search.message.clear();
    PChar->search.message.insert(0, (const char*)data[4]);

    PChar->search.messagetype = data.ref<uint8>(0xA4);
}

/************************************************************************
 *                                                                       *
 *  Request Linkshell Message (/lsmes)                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0E1(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x0E2(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
                    PChar->PLinkshell1->setMessage(data[16], PChar->GetName());
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

void SmallPacket0x0E7(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
        PChar->status = STATUS_TYPE::SHUTDOWN;
        charutils::SendToZone(PChar, 1, 0);
    }
    else if (PChar->animation == ANIMATION_NONE)
    {
        uint8 ExitType = (data.ref<uint8>(0x06) == 1 ? 7 : 35);

        if (PChar->PPet == nullptr || (PChar->PPet->m_EcoSystem != ECOSYSTEM::AVATAR && PChar->PPet->m_EcoSystem != ECOSYSTEM::ELEMENTAL))
        {
            PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_HEALING, 0, 0, map_config.healing_tick_delay, 0));
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

void SmallPacket0x0E8(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
                PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_HEALING, 0, 0, map_config.healing_tick_delay, 0));
                return;
            }
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 345));
        }
        break;
        case ANIMATION_HEALING:
        {
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

void SmallPacket0x0EA(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

    PChar->animation = (PChar->animation == ANIMATION_SIT ? ANIMATION_NONE : ANIMATION_SIT);
    PChar->updatemask |= UPDATE_HP;
}

/************************************************************************
 *                                                                       *
 *  Special Release Request                                              *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0EB(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x0F1(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x0F2(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x0F4(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x0F5(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x0F6(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    PChar->PWideScanTarget = nullptr;
}

/************************************************************************
 *                                                                       *
 *  Mog House Place Furniture                                            *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0FA(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
    uint8 col         = data.ref<uint8>(0x09);
    uint8 level       = data.ref<uint8>(0x0A);
    uint8 row         = data.ref<uint8>(0x0B);
    uint8 rotation    = data.ref<uint8>(0x0C);

    if (containerID != LOC_MOGSAFE && containerID != LOC_MOGSAFE2)
    {
        return;
    }

    CItemFurnishing* PItem = (CItemFurnishing*)PChar->getStorage(containerID)->GetItem(slotID);

    if (PItem != nullptr && PItem->getID() == ItemID && PItem->isType(ITEM_FURNISHING))
    {
        if (PItem->getFlag() & ITEM_FLAG_WALLHANGING)
        {
            rotation = (col >= 2 ? 3 : 1);
        }

        bool wasInstalled = PItem->isInstalled();
        PItem->setInstalled(true);
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
        Sql_EscapeStringLen(SqlHandle, extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

        const char* Query = "UPDATE char_inventory "
                            "SET "
                            "extra = '%s' "
                            "WHERE location = %u AND slot = %u AND charid = %u";

        if (Sql_Query(SqlHandle, Query, extra, containerID, slotID, PChar->id) != SQL_ERROR && Sql_AffectedRows(SqlHandle) != 0 && !wasInstalled)
        {
            PChar->getStorage(LOC_STORAGE)->AddBuff(PItem->getStorage());

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

void SmallPacket0x0FB(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

    CItemFurnishing* PItem = (CItemFurnishing*)PItemContainer->GetItem(slotID);

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

            char extra[sizeof(PItem->m_extra) * 2 + 1];
            Sql_EscapeStringLen(SqlHandle, extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

            const char* Query = "UPDATE char_inventory "
                                "SET "
                                "extra = '%s' "
                                "WHERE location = %u AND slot = %u AND charid = %u";

            if (Sql_Query(SqlHandle, Query, extra, containerID, slotID, PChar->id) != SQL_ERROR && Sql_AffectedRows(SqlHandle) != 0)
            {
                uint8 NewSize = PItemContainer->GetSize() - RemovedSize;
                for (uint8 SlotID = PItemContainer->GetSize(); SlotID > NewSize; --SlotID)
                {
                    if (PItemContainer->GetItem(SlotID) != nullptr)
                    {
                        charutils::MoveItem(PChar, LOC_STORAGE, SlotID, ERROR_SLOTID);
                    }
                }
                PChar->getStorage(LOC_STORAGE)->AddBuff(-(int8)PItem->getStorage());

                PChar->pushPacket(new CInventorySizePacket(PChar));

                luautils::OnFurnitureRemoved(PChar, PItem);
            }
            PChar->pushPacket(new CInventoryItemPacket(PItem, containerID, PItem->getSlotID()));
            PChar->pushPacket(new CInventoryFinishPacket());
        }
        else
        {
            ShowError(CL_RED "SmallPacket0x0FB: furnishing can't be removed\n" CL_RESET);
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Mog House Plant Flowerpot
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0FC(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
        PPotItem->setStrength(xirand::GetRandomNumber(32));
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
    Sql_EscapeStringLen(SqlHandle, extra, (const char*)PPotItem->m_extra, sizeof(PPotItem->m_extra));
    const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u";
    Sql_Query(SqlHandle, Query, extra, PChar->id, PPotItem->getLocationID(), PPotItem->getSlotID());

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

void SmallPacket0x0FD(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
            Sql_EscapeStringLen(SqlHandle, extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));
            const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u";
            Sql_Query(SqlHandle, Query, extra, PChar->id, PItem->getLocationID(), PItem->getSlotID());
        }
    }

    PChar->pushPacket(new CFurnitureInteractPacket(PItem, containerID, slotID));
}

/************************************************************************
 *                                                                       *
 *  Mog House Uproot Flowerpot
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0FE(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

    uint8 isEmptyingPot = data.ref<uint8>(0x08);

    if (PItem->isPlanted())
    {
        if (isEmptyingPot == 0 && PItem->getStage() == FLOWERPOT_STAGE_MATURE_PLANT)
        {
            // Harvesting plant
            uint16 resultID;
            uint8  totalQuantity;
            std::tie(resultID, totalQuantity) = gardenutils::CalculateResults(PChar, PItem);
            uint8 stackSize                   = itemutils::GetItemPointer(resultID)->getStackSize();
            uint8 requiredSlots               = (uint8)ceil(float(totalQuantity) / stackSize);
            uint8 totalFreeSlots              = PChar->getStorage(LOC_MOGSAFE)->GetFreeSlotsCount() + PChar->getStorage(LOC_MOGSAFE2)->GetFreeSlotsCount();
            if (requiredSlots > totalFreeSlots || totalQuantity == 0)
            {
                PChar->pushPacket(new CMessageStandardPacket(MsgStd::MoghouseCantPickUp)); // Kupo... I can't pick anything right now, kupo.
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
        Sql_EscapeStringLen(SqlHandle, extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));
        const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u";
        Sql_Query(SqlHandle, Query, extra, PChar->id, PItem->getLocationID(), PItem->getSlotID());

        PChar->pushPacket(new CInventoryItemPacket(PItem, containerID, slotID));
        PChar->pushPacket(new CInventoryFinishPacket());
    }
}

/************************************************************************
 *                                                                       *
 *  Mog House Dry Flowerpot
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0FF(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

    if (PItem->isPlanted() && PItem->getStage() > FLOWERPOT_STAGE_INITIAL && PItem->getStage() < FLOWERPOT_STAGE_WILTED && !PItem->isDried())
    {
        PChar->pushPacket(new CMessageStandardPacket(itemID, 133)); // Your moogle dries the plant in the <item>.
        PChar->pushPacket(new CFurnitureInteractPacket(PItem, containerID, slotID));
        PItem->setDried(true);

        char extra[sizeof(PItem->m_extra) * 2 + 1];
        Sql_EscapeStringLen(SqlHandle, extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));
        const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u";
        Sql_Query(SqlHandle, Query, extra, PChar->id, PItem->getLocationID(), PItem->getSlotID());

        PChar->pushPacket(new CInventoryItemPacket(PItem, containerID, slotID));
        PChar->pushPacket(new CInventoryFinishPacket());
    }
}

/************************************************************************
 *                                                                       *
 *  Job Change                                                           *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x100(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DISPELABLE | EFFECTFLAG_ON_JOBCHANGE);

        PChar->ForParty([](CBattleEntity* PMember) { ((CCharEntity*)PMember)->PLatentEffectContainer->CheckLatentsPartyJobs(); });

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
        PChar->pushPacket(new CCharSyncPacket(PChar));
    }
}

/************************************************************************
 *                                                                       *
 *  Set Blue Magic Spells                                                *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x102(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
                            ShowExploit(CL_RED "SmallPacket0x102: Player %s trying to unset BLU spell they don't have set! \n" CL_RESET, PChar->GetName());
                        }
                        else
                        {
                            blueutils::SetBlueSpell(PChar, spell, spellIndex, false);
                        }
                    }
                    else
                    {
                        ShowDebug("SmallPacket0x102: Cannot resolve spell id %u \n", spellInQuestion);
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
                    blueutils::SetBlueSpell(PChar, spell, spellIndex, (spellToAdd > 0));
                    charutils::BuildingCharTraitsTable(PChar);
                    PChar->pushPacket(new CCharAbilitiesPacket(PChar));
                    PChar->pushPacket(new CCharJobExtraPacket(PChar, true));
                    PChar->pushPacket(new CCharJobExtraPacket(PChar, false));
                    PChar->pushPacket(new CCharStatsPacket(PChar));
                    PChar->UpdateHealth();
                }
                else
                {
                    ShowDebug("SmallPacket0x102: Cannot resolve spell id %u \n", spellInQuestion);
                }
            }
            else
            {
                ShowDebug("No match found. \n");
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
}

/************************************************************************
 *                                                                        *
 *  Closing the "View wares", sending a message to the bazaar            *
 *  that you have left the shop                                            *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x104(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    CCharEntity* PTarget = (CCharEntity*)PChar->GetEntity(PChar->BazaarID.targid, TYPE_PC);

    if (PTarget != nullptr && PTarget->id == PChar->BazaarID.id)
    {
        for (uint16 i = 0; i < PTarget->BazaarCustomers.size(); ++i)
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

void SmallPacket0x105(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    XI_DEBUG_BREAK_IF(PChar->BazaarID.id != 0);
    XI_DEBUG_BREAK_IF(PChar->BazaarID.targid != 0);

    uint32 charid = data.ref<uint32>(0x04);

    CCharEntity* PTarget = charid != 0 ? (CCharEntity*)PChar->loc.zone->GetCharByID(charid) : (CCharEntity*)PChar->GetEntity(PChar->m_TargID, TYPE_PC);

    if (PTarget != nullptr && PTarget->id == charid && (PTarget->nameflags.flags & FLAG_BAZAAR))
    {
        PChar->BazaarID.id     = PTarget->id;
        PChar->BazaarID.targid = PTarget->targid;

        EntityID_t EntityID = { PChar->id, PChar->targid };

        PTarget->pushPacket(new CBazaarCheckPacket(PChar, BAZAAR_ENTER));
        PTarget->BazaarCustomers.push_back(EntityID);

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

void SmallPacket0x106(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint8 Quantity = data.ref<uint8>(0x08);
    uint8 SlotID   = data.ref<uint8>(0x04);

    CCharEntity* PTarget = (CCharEntity*)PChar->GetEntity(PChar->BazaarID.targid, TYPE_PC);

    if (PTarget == nullptr || PTarget->id != PChar->BazaarID.id)
    {
        return;
    }

    // Validate purchase quantity..
    if (Quantity < 1)
    {
        // Exploit attempt..
        ShowExploit(CL_RED "Player %s purchasing invalid quantity %u from Player %s bazaar! \n" CL_RESET, PChar->GetName(), Quantity, PTarget->GetName());
        return;
    }

    CItemContainer* PBazaar         = PTarget->getStorage(LOC_INVENTORY);
    CItemContainer* PBuyerInventory = PChar->getStorage(LOC_INVENTORY);

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

    // Obtain the players gil..
    CItem* PCharGil = PBuyerInventory->GetItem(0);
    if (PCharGil == nullptr || !PCharGil->isType(ITEM_CURRENCY))
    {
        // Player has no gil..
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
            ShowExploit(CL_RED "Bazaar purchase exploit attempt by: %s\n" CL_RESET, PChar->GetName());
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
        for (uint16 i = 0; i < PTarget->BazaarCustomers.size(); ++i)
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

void SmallPacket0x109(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    CItemContainer* PStorage = PChar->getStorage(LOC_INVENTORY);

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

void SmallPacket0x10A(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    uint8  slotID = data.ref<uint8>(0x04);
    uint32 price  = data.ref<uint32>(0x08);

    CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(slotID);

    if (PItem->getReserve() > 0)
    {
        ShowError(CL_RED "SmallPacket0x10A: Player %s trying to bazaar a RESERVED item! [Item: %i | Slot ID: %i] \n" CL_RESET, PChar->GetName(), PItem->getID(),
                  slotID);
        return;
    }

    if ((PItem != nullptr) && !(PItem->getFlag() & ITEM_FLAG_EX) && (!PItem->isSubType(ITEM_LOCKED) || PItem->getCharPrice() != 0))
    {
        Sql_Query(SqlHandle, "UPDATE char_inventory SET bazaar = %u WHERE charid = %u AND location = 0 AND slot = %u;", price, PChar->id, slotID);

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

void SmallPacket0x10B(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    for (uint16 i = 0; i < PChar->BazaarCustomers.size(); ++i)
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

void SmallPacket0x10C(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    if (roeutils::RoeSystem.RoeEnabled)
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

void SmallPacket0x10D(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    if (roeutils::RoeSystem.RoeEnabled)
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

void SmallPacket0x10E(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    if (roeutils::RoeSystem.RoeEnabled)
    {
        uint16 recordID = data.ref<uint16>(0x04);
        roeutils::onRecordClaim(PChar, recordID);
    }
}

/************************************************************************
*                                                                        *
*  Request Currency1 tab                                                  *
*                                                                        *
************************************************************************/

void SmallPacket0x10F(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    PChar->pushPacket(new CCurrencyPacket1(PChar));
}

/************************************************************************
 *                                                                       *
 *  Fishing (New)                                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x110(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    // PrintPacket(data);
    if (PChar->animation != ANIMATION_FISHING_START)
    {
        return;
    }

    // uint32 charid = data.ref<uint32>(0x04);
    uint16 stamina = data.ref<uint16>(0x08);
    // uint16 ukn1 = data.ref<uint16>(0x0A); // Seems to always be zero with basic fishing, skill not high enough to test legendary fish.
    // uint16 targetid = data.ref<uint16>(0x0C);
    uint8 action = data.ref<uint8>(0x0E);
    // uint8 ukn2 = data.ref<uint8>(0x0F);
    uint32 special = data.ref<uint32>(0x10);
    fishingutils::FishingAction(PChar, static_cast<FISH_ACTION>(action), stamina, special);
}

/************************************************************************
 *                                                                        *
 *  Lock Style Request                                                   *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x111(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x112(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    // Send spark updates
    PChar->pushPacket(new CRoeSparkUpdatePacket(PChar));

    if (roeutils::RoeSystem.RoeEnabled)
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
void SmallPacket0x113(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

    PChar->animation = PChar->animation == chairId ? ANIMATION_NONE : chairId;
    PChar->updatemask |= UPDATE_HP;
}

/************************************************************************
 *                                                                       *
 *  Map Marker Request Packet                                            *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x114(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    PChar->pushPacket(new CMapMarkerPacket(PChar));
}

/************************************************************************
 *                                                                        *
 *  Request Currency2 tab                                                  *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x115(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
void SmallPacket0x116(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x117(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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

void SmallPacket0x118(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
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
void SmallPacket0x11B(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    // Rate limit Job Master Display
    auto lastJobMasterDisplayChange  = PChar->GetLocalVar("LastJobMasterDisplayTime");
    auto timeNowSeconds = std::chrono::time_point_cast<std::chrono::seconds>(server_clock::now());
    if (lastJobMasterDisplayChange == 0 || (timeNowSeconds.time_since_epoch().count() - lastJobMasterDisplayChange) > 2)
    {
        PChar->SetLocalVar("LastJobMasterDisplayTime", (uint32)timeNowSeconds.time_since_epoch().count());
    }
    else
    {
        ShowWarning(CL_YELLOW "SmallPacket0x11B: Rate limiting Job Master Display Change packet for %s\n" CL_RESET, PChar->GetName());
        return;
    }

    PChar->m_jobMasterDisplay = data.ref<uint8>(0x04) > 0;

    charutils::SaveJobMasterDisplay(PChar);
    PChar->pushPacket(new CCharUpdatePacket(PChar));
}

/************************************************************************
 *                                                                       *
 *  Jump (/jump)                                                         *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x11D(map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data)
{
    TracyZoneScoped;
    if (jailutils::InPrison(PChar))
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 316));
        return;
    }

    // Rate limit emotes
    auto lastEmoteTime  = PChar->GetLocalVar("LastEmoteTime");
    auto timeNowSeconds = std::chrono::time_point_cast<std::chrono::seconds>(server_clock::now());
    if (lastEmoteTime == 0 || (timeNowSeconds.time_since_epoch().count() - lastEmoteTime) > 2)
    {
        PChar->SetLocalVar("LastEmoteTime", (uint32)timeNowSeconds.time_since_epoch().count());
    }
    else
    {
        ShowWarning(CL_YELLOW "SmallPacket0x11D: Rate limiting jump packet for %s\n" CL_RESET, PChar->GetName());
        return;
    }

    const auto targetID    = data.ref<uint32>(0x04);
    const auto targetIndex = data.ref<uint16>(0x08);
    const auto extra       = data.ref<uint16>(0x0A);

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
    PacketSize[0x028] = 0x06; PacketParser[0x028] = &SmallPacket0x028;
    PacketSize[0x029] = 0x06; PacketParser[0x029] = &SmallPacket0x029;
    PacketSize[0x032] = 0x06; PacketParser[0x032] = &SmallPacket0x032;
    PacketSize[0x033] = 0x06; PacketParser[0x033] = &SmallPacket0x033;
    PacketSize[0x034] = 0x06; PacketParser[0x034] = &SmallPacket0x034;
    PacketSize[0x036] = 0x20; PacketParser[0x036] = &SmallPacket0x036;
    PacketSize[0x037] = 0x0A; PacketParser[0x037] = &SmallPacket0x037;
    PacketSize[0x03A] = 0x04; PacketParser[0x03A] = &SmallPacket0x03A;
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
