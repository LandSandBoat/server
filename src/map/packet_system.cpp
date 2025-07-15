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
#include "common/database.h"
#include "common/logging.h"
#include "common/mmo.h"
#include "common/task_manager.h"
#include "common/timer.h"
#include "common/utils.h"

#include <cstring>
#include <utility>

#include "alliance.h"
#include "enmity_container.h"
#include "fishingcontest.h"
#include "ipc_client.h"
#include "item_container.h"
#include "latent_effect_container.h"
#include "linkshell.h"
#include "map_networking.h"
#include "map_server.h"
#include "map_session.h"
#include "mob_modifier.h"
#include "monstrosity.h"
#include "packet_system.h"

#include "party.h"
#include "recast_container.h"
#include "roe.h"
#include "spell.h"
#include "status_effect_container.h"
#include "trade_container.h"
#include "universal_container.h"
#include "zone.h"

#include "ai/ai_container.h"

#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "entities/trustentity.h"

#include "items/item_shop.h"

#include "lua/luautils.h"

#include "packets/basic.h"
#include "packets/bazaar_message.h"
#include "packets/blacklist_edit_response.h"
#include "packets/c2s/0x00a_login.h"
#include "packets/c2s/0x00c_gameok.h"
#include "packets/c2s/0x00d_netend.h"
#include "packets/c2s/0x00f_clstat.h"
#include "packets/c2s/0x011_zone_transition.h"
#include "packets/c2s/0x015_pos.h"
#include "packets/c2s/0x016_charreq.h"
#include "packets/c2s/0x017_charreq2.h"
#include "packets/c2s/0x01b_friendpass.h"
#include "packets/c2s/0x01c_unknown.h"
#include "packets/c2s/0x01e_gm.h"
#include "packets/c2s/0x01f_gmcommand.h"
#include "packets/c2s/0x028_item_dump.h"
#include "packets/c2s/0x029_item_move.h"
#include "packets/c2s/0x02b_translate.h"
#include "packets/c2s/0x02c_itemsearch.h"
#include "packets/c2s/0x032_trade_req.h"
#include "packets/c2s/0x033_trade_res.h"
#include "packets/c2s/0x034_trade_list.h"
#include "packets/c2s/0x036_item_transfer.h"
#include "packets/c2s/0x037_item_use.h"
#include "packets/c2s/0x03a_item_stack.h"
#include "packets/c2s/0x03b_subcontainer.h"
#include "packets/c2s/0x041_trophy_entry.h"
#include "packets/c2s/0x042_trophy_absence.h"
#include "packets/c2s/0x058_recipe.h"
#include "packets/c2s/0x059_effectend.h"
#include "packets/c2s/0x05a_reqconquest.h"
#include "packets/c2s/0x05b_eventend.h"
#include "packets/c2s/0x05c_eventendxzy.h"
#include "packets/c2s/0x060_passwards.h"
#include "packets/c2s/0x061_clistatus.h"
#include "packets/c2s/0x063_dig.h"
#include "packets/c2s/0x066_fishing.h"
#include "packets/c2s/0x078_group_checkid.h"
#include "packets/c2s/0x083_shop_buy.h"
#include "packets/c2s/0x084_shop_sell_req.h"
#include "packets/c2s/0x085_shop_sell_set.h"
#include "packets/c2s/0x09b_chocobo_race_req.h"
#include "packets/c2s/0x0a0_switch_proposal.h"
#include "packets/c2s/0x0a1_switch_vote.h"
#include "packets/c2s/0x0a2_dice.h"
#include "packets/c2s/0x0aa_guild_buy.h"
#include "packets/c2s/0x0ab_guild_buylist.h"
#include "packets/c2s/0x0ac_guild_sell.h"
#include "packets/c2s/0x0ad_guild_selllist.h"
#include "packets/c2s/0x0b5_chat_std.h"
#include "packets/c2s/0x0b6_chat_name.h"
#include "packets/c2s/0x0b7_assist_channel.h"
#include "packets/c2s/0x0be_merits.h"
#include "packets/c2s/0x0bf_job_points_spend.h"
#include "packets/c2s/0x0c0_job_points_req.h"
#include "packets/c2s/0x0c3_group_comlink_make.h"
#include "packets/c2s/0x0c4_group_comlink_active.h"
#include "packets/c2s/0x0cb_myroom_is.h"
#include "packets/c2s/0x0d2_map_group.h"
#include "packets/c2s/0x0d3_faq_gmcall.h"
#include "packets/c2s/0x0d4_faq_gmparam.h"
#include "packets/c2s/0x0d5_ack_gmmsg.h"
#include "packets/c2s/0x0d8_dungeon_param.h"
#include "packets/c2s/0x0de_inspect_message.h"
#include "packets/c2s/0x0e0_set_usermsg.h"
#include "packets/c2s/0x0e1_get_lsmsg.h"
#include "packets/c2s/0x0e2_set_lsmsg.h"
#include "packets/c2s/0x0e4_get_lspriv.h"
#include "packets/c2s/0x0e7_reqlogout.h"
#include "packets/c2s/0x0e8_camp.h"
#include "packets/c2s/0x0ea_sit.h"
#include "packets/c2s/0x0eb_reqsubmapnum.h"
#include "packets/c2s/0x0f0_rescue.h"
#include "packets/c2s/0x0f1_buffcancel.h"
#include "packets/c2s/0x0f2_submapchange.h"
#include "packets/c2s/0x0f4_tracking_list.h"
#include "packets/c2s/0x0f5_tracking_start.h"
#include "packets/c2s/0x0f6_tracking_end.h"
#include "packets/c2s/0x0fa_myroom_layout.h"
#include "packets/c2s/0x0fb_myroom_bankin.h"
#include "packets/c2s/0x0fc_myroom_plant_add.h"
#include "packets/c2s/0x0fd_myroom_plant_check.h"
#include "packets/c2s/0x0fe_myroom_plant_crop.h"
#include "packets/c2s/0x0ff_myroom_plant_stop.h"
#include "packets/c2s/0x100_myroom_job.h"
#include "packets/c2s/0x102_extended_job.h"
#include "packets/c2s/0x104_bazaar_exit.h"
#include "packets/c2s/0x105_bazaar_list.h"
#include "packets/c2s/0x106_bazaar_buy.h"
#include "packets/c2s/0x109_bazaar_open.h"
#include "packets/c2s/0x10a_bazaar_itemset.h"
#include "packets/c2s/0x10b_bazaar_close.h"
#include "packets/c2s/0x10c_roe_start.h"
#include "packets/c2s/0x10d_roe_remove.h"
#include "packets/c2s/0x10e_roe_claim.h"
#include "packets/c2s/0x10f_currencies_1.h"
#include "packets/c2s/0x110_fishing_2.h"
#include "packets/c2s/0x113_sitchair.h"
#include "packets/c2s/0x114_map_markers.h"
#include "packets/c2s/0x115_currencies_2.h"
#include "packets/c2s/0x116_unity_menu.h"
#include "packets/c2s/0x117_unity_quest.h"
#include "packets/c2s/0x118_unity_toggle.h"
#include "packets/c2s/0x119_emote_list.h"
#include "packets/c2s/0x11b_mastery_display.h"
#include "packets/c2s/0x11c_party_request.h"
#include "packets/c2s/0x11d_jump.h"
#include "packets/char_appearance.h"
#include "packets/char_check.h"
#include "packets/char_emotion.h"
#include "packets/char_recast.h"
#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/chat_message.h"
#include "packets/chocobo_digging.h"
#include "packets/cs_position.h"
#include "packets/fish_ranking.h"
#include "packets/inventory_finish.h"
#include "packets/macroequipset.h"
#include "packets/menu_config.h"
#include "packets/menu_jobpoints.h"
#include "packets/message_basic.h"
#include "packets/message_standard.h"
#include "packets/message_system.h"
#include "packets/party_define.h"
#include "packets/party_invite.h"
#include "packets/position.h"
#include "packets/release.h"
#include "packets/roe_questlog.h"
#include "packets/roe_sparkupdate.h"
#include "packets/roe_update.h"
#include "packets/server_message.h"
#include "packets/trade_action.h"
#include "packets/trade_update.h"

#include "utils/auctionutils.h"
#include "utils/battleutils.h"
#include "utils/blacklistutils.h"
#include "utils/charutils.h"
#include "utils/dboxutils.h"
#include "utils/fishingutils.h"
#include "utils/itemutils.h"
#include "utils/jailutils.h"
#include "utils/synthutils.h"
#include "utils/zoneutils.h"

uint8 PacketSize[512];

std::function<void(MapSession* const, CCharEntity* const, CBasicPacket&)> PacketParser[512];

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

/************************************************************************
 *                                                                       *
 *  Unknown Packet                                                       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x000(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    ShowWarning("parse: Unhandled game packet %03hX from user: %s", (data.ref<uint16>(0) & 0x1FF), PChar->getName());
}

/************************************************************************
 *                                                                       *
 *  Player Action                                                        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x01A(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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

    const auto actionStr = fmt::format("Player Action: {}: {} ({}) -> targid: {}", PChar->getName(), actionToStr(action), hex8ToString(action), TargID);
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
            PChar->loc.zone->UpdateEntityPacket(PChar, ENTITY_UPDATE, UPDATE_HP);
        }
        break;
        case 0x13: // tractor menu
        {
            if (data.ref<uint8>(0x0C) == 0 && PChar->m_hasTractor != 0) // ACCEPTED TRACTOR
            {
                PChar->loc.p           = PChar->m_StartActionPos;
                PChar->loc.destination = PChar->getZone();
                PChar->status          = STATUS_TYPE::DISAPPEAR;
                PChar->loc.boundary    = 0;
                PChar->clearPacketList();
                charutils::SendToZone(PChar, PChar->loc.destination);
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
            uint8   MountID      = data.ref<uint8>(0x0C);
            KeyItem mountKeyItem = static_cast<KeyItem>(static_cast<uint16_t>(KeyItem::CHOCOBO_COMPANION) + MountID);

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
            else if (charutils::hasKeyItem(PChar, mountKeyItem))
            {
                if (PChar->PRecastContainer->HasRecast(RECAST_ABILITY, 256, 60s))
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
                                                                  0s,
                                                                  30min,
                                                                  0,
                                                                  0x40), // previously known as nameflag "FLAG_CHOCOBO"
                                                              EffectNotice::Silent);

                PChar->PRecastContainer->Add(RECAST_ABILITY, 256, 60s);
                PChar->pushPacket<CCharRecastPacket>(PChar);

                luautils::OnPlayerMount(PChar);
            }
        }
        break;
        default:
        {
            ShowWarningFmt("CLIENT {} PERFORMING UNHANDLED ACTION {} ({})", PChar->getName(), actionStr, hex8ToString(action));
            return;
        }
        break;
    }
}

// GP_CLI_COMMAND_BLACK_LIST
// https://github.com/atom0s/XiPackets/tree/main/world/client/0x003C
// Client is asking for blist because it wasn't initialized correctly?
void SmallPacket0x03C(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    blacklistutils::SendBlacklist(PChar);
}

/************************************************************************
 *                                                                       *
 *  Incoming Blacklist Command                                           *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x03D(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    const auto name = db::escapeString(asStringFromUntrustedSource(data[0x08], 15));
    const auto cmd  = data.ref<uint8>(0x18);

    const auto sendFailPacket = [&]()
    {
        PChar->pushPacket<CBlacklistEditResponsePacket>(0, "", 0x02);
    };

    const auto [charid, accid] = charutils::getCharIdAndAccountIdFromName(name);
    if (!charid)
    {
        sendFailPacket();
        return;
    }

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
 *  Server Message Request                                               *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x04B(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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
        const auto rset = db::preparedStmt("SELECT version_mismatch FROM accounts_sessions WHERE charid = ?", PChar->id);
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
                selfEntry.submitTime = earth_time::vanadiel_timestamp();
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

void SmallPacket0x04D(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    dboxutils::HandlePacket(PChar, data);
}

/************************************************************************
 *                                                                       *
 *  Auction House                                                        *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x04E(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    auctionutils::HandlePacket(PChar, data);
}

/************************************************************************
 *                                                                       *
 *  Equipment Change                                                     *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x050(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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

void SmallPacket0x051(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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

void SmallPacket0x052(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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
void SmallPacket0x053(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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

/************************************************************************
 *                                                                       *
 *  Emote (/jobemote [job])                                              *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x05D(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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

void SmallPacket0x05E(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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
                PChar->pushPacket<CCSPositionPacket>(PChar, PChar->loc.p, POSMODE::RESET);

                PChar->status = STATUS_TYPE::NORMAL;
                return;
            }
            else if (PChar->m_PMonstrosity != nullptr) // Not allowed to use zonelines while MON
            {
                PChar->loc.p.rotation += 128;

                PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CouldNotEnter); // You could not enter the next area.
                PChar->pushPacket<CCSPositionPacket>(PChar, PChar->loc.p, POSMODE::RESET);

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
                    PChar->pushPacket<CCSPositionPacket>(PChar, PChar->loc.p, POSMODE::RESET);

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
        PChar->pushPacket<CCSPositionPacket>(PChar, PChar->loc.p, POSMODE::RESET);

        PChar->status = STATUS_TYPE::NORMAL;

        return;
    }

    charutils::SendToZone(PChar, destination);
}

/************************************************************************
 *                                                                       *
 *  Key Items (Mark As Seen)                                             *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x064(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;
    uint8 KeyTable = data.ref<uint8>(0x4A);

    if (KeyTable >= PChar->keys.tables.size())
    {
        return;
    }

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
 *  Party Invite                                                         *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x06E(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    // Alias for clarity
    auto* PInviter = PChar;

    uint32 inviteeCharId = data.ref<uint32>(0x04);
    uint16 inviteeTargId = data.ref<uint16>(0x08);

    // cannot invite yourself
    if (PInviter->id == inviteeCharId)
    {
        return;
    }

    if (jailutils::InPrison(PInviter))
    {
        // Initiator is in prison.  Send error message.
        PInviter->pushPacket<CMessageBasicPacket>(PInviter, PInviter, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
        return;
    }

    // Block invite if target has blacklisted the initiator
    if (blacklistutils::IsBlacklisted(inviteeCharId, PInviter->id))
    {
        return;
    }

    switch (data.ref<uint8>(0x0A))
    {
        case INVITE_PARTY: // party - must by party leader or solo
        {
            if (PInviter->PParty == nullptr || PInviter->PParty->GetLeader() == PInviter)
            {
                if (PInviter->PParty && PInviter->PParty->IsFull())
                {
                    PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::CannotInvite);
                    break;
                }

                CCharEntity* PInvitee = nullptr;

                if (inviteeTargId != 0)
                {
                    CBaseEntity* PEntity = PInviter->GetEntity(inviteeTargId, TYPE_PC);
                    if (PEntity && PEntity->id == inviteeCharId)
                    {
                        PInvitee = (CCharEntity*)PEntity;
                    }
                }
                else
                {
                    PInvitee = zoneutils::GetChar(inviteeCharId);
                }

                if (PInvitee)
                {
                    ShowDebug("%s sent party invite to %s", PInviter->getName(), PInvitee->getName());

                    // make sure invitee isn't dead or in jail, they aren't a party member and don't already have an invite pending, and your party is not full
                    if (PInvitee->isDead() || jailutils::InPrison(PInvitee) || PInvitee->InvitePending.id != 0 || PInvitee->PParty != nullptr)
                    {
                        ShowDebug("%s is dead, in jail, has a pending invite, or is already in a party", PInvitee->getName());
                        PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::CannotInvite);
                        break;
                    }

                    // check /blockaid
                    if (PInvitee->getBlockingAid())
                    {
                        ShowDebug("%s is blocking party invites", PInvitee->getName());
                        // Target is blocking assistance
                        PInviter->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::TargetIsCurrentlyBlocking);
                        // Interaction was blocked
                        PInvitee->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::BlockedByBlockaid);
                        // You cannot invite that person at this time.
                        PInviter->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CannotInvite);
                        break;
                    }

                    if (PInvitee->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
                    {
                        ShowDebug("%s has level sync, unable to send invite", PInvitee->getName());
                        PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::CannotInviteLevelSync);
                        break;
                    }

                    PInvitee->InvitePending.id     = PInviter->id;
                    PInvitee->InvitePending.targid = PInviter->targid;

                    PInvitee->pushPacket<CPartyInvitePacket>(inviteeCharId, inviteeTargId, PInviter->getName(), INVITE_PARTY);

                    ShowDebug("Sent party invite packet to %s", PInvitee->getName());

                    if (PInviter->PParty && PInviter->PParty->GetSyncTarget())
                    {
                        PInvitee->pushPacket<CMessageStandardPacket>(PInvitee, 0, 0, MsgStd::LevelSyncWarning);
                    }
                }
                else
                {
                    // on another server (hopefully)
                    message::send(ipc::PartyInvite{
                        .inviteeId     = inviteeCharId,
                        .inviteeTargId = inviteeTargId,
                        .inviterId     = PInviter->id,
                        .inviterTargId = PInviter->targid,
                        .inviterName   = PInviter->getName(),
                        .inviteType    = INVITE_PARTY,
                    });
                }
            }
            else // in party but not leader, cannot invite
            {
                ShowDebug("%s is not party leader, cannot send invite", PInviter->getName());
                PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::NotPartyLeader);
            }
        }
        break;
        case INVITE_ALLIANCE: // alliance - must be unallied party leader or alliance leader of a non-full alliance
        {
            if (PInviter->PParty && PInviter->PParty->GetLeader() == PInviter &&
                (PInviter->PParty->m_PAlliance == nullptr ||
                 (PInviter->PParty->m_PAlliance->getMainParty() == PInviter->PParty && !PInviter->PParty->m_PAlliance->isFull())))
            {
                CCharEntity* PInvitee = nullptr;

                if (inviteeTargId != 0)
                {
                    CBaseEntity* PEntity = PInviter->GetEntity(inviteeTargId, TYPE_PC);
                    if (PEntity && PEntity->id == inviteeCharId)
                    {
                        PInvitee = (CCharEntity*)PEntity;
                    }
                }
                else
                {
                    PInvitee = zoneutils::GetChar(inviteeCharId);
                }

                if (PInvitee)
                {
                    ShowDebug("%s sent alliance invite to %s", PInviter->getName(), PInvitee->getName());

                    // check /blockaid
                    if (PInvitee->getBlockingAid())
                    {
                        ShowDebug("%s is blocking alliance invites", PInvitee->getName());
                        // Target is blocking assistance
                        PInviter->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::TargetIsCurrentlyBlocking);
                        // Interaction was blocked
                        PInvitee->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::BlockedByBlockaid);
                        // You cannot invite that person at this time.
                        PInviter->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CannotInvite);
                        break;
                    }

                    // make sure intvitee isn't dead or in jail, they are an unallied party leader and don't already have an invite pending
                    if (PInvitee->isDead() || jailutils::InPrison(PInvitee) || PInvitee->InvitePending.id != 0 || PInvitee->PParty == nullptr ||
                        PInvitee->PParty->GetLeader() != PInvitee || PInvitee->PParty->m_PAlliance)
                    {
                        ShowDebug("%s is dead, in jail, has a pending invite, or is already in a party/alliance", PInvitee->getName());
                        PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::CannotInvite);
                        break;
                    }

                    if (PInvitee->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
                    {
                        ShowDebug("%s has level sync, unable to send invite", PInvitee->getName());
                        PInviter->pushPacket<CMessageStandardPacket>(PInviter, 0, 0, MsgStd::CannotInviteLevelSync);
                        break;
                    }

                    PInvitee->InvitePending.id     = PInviter->id;
                    PInvitee->InvitePending.targid = PInviter->targid;

                    PInvitee->pushPacket<CPartyInvitePacket>(inviteeCharId, inviteeTargId, PInviter->getName(), INVITE_ALLIANCE);

                    ShowDebug("Sent party invite packet to %s", PInvitee->getName());
                }
                else
                {
                    // on another server (hopefully)
                    message::send(ipc::PartyInvite{
                        .inviteeId     = inviteeCharId,
                        .inviteeTargId = inviteeTargId,
                        .inviterId     = PInviter->id,
                        .inviterTargId = PInviter->targid,
                        .inviterName   = PInviter->getName(),
                        .inviteType    = INVITE_ALLIANCE,
                    });
                }
            }
        }
        break;
        default:
        {
            ShowError("SmallPacket0x06E : unknown byte <%.2X>", data.ref<uint8>(0x0A));
        }
        break;
    }
}

/************************************************************************
 *                                                                       *
 *  Party / Alliance Command 'Leave'                                     *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x06F(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    if (PChar->PParty)
    {
        switch (data.ref<uint8>(0x04))
        {
            case INVITE_PARTY: // party - anyone may remove themself from party regardless of leadership or alliance
            {
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
            }
            break;
            case INVITE_ALLIANCE: // alliance - any party leader in alliance may remove their party
            {
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
            }
            break;
            default:
            {
                ShowError("SmallPacket0x06F : unknown byte <%.2X>", data.ref<uint8>(0x04));
            }
            break;
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Party / Alliance Command 'Breakup'                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x070(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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

void SmallPacket0x071(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    const auto type       = data.ref<uint8>(0x0A);
    const auto victimName = db::escapeString(asStringFromUntrustedSource(data[0x0C], 15));

    switch (type)
    {
        case 0: // party - party leader may remove member of his own party
        {
            if (PChar->PParty && PChar->PParty->GetLeader() == PChar)
            {
                CCharEntity* PVictim = dynamic_cast<CCharEntity*>(PChar->PParty->GetMemberByName(victimName));
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
                    if (const auto victimId = charutils::getCharIdFromName(victimName))
                    {
                        const auto rset = db::preparedStmt("DELETE FROM accounts_parties WHERE partyid = ? AND charid = ?", PChar->id, victimId);
                        if (rset && rset->rowsAffected())
                        {
                            ShowDebug("%s has removed %s from party", PChar->getName(), victimName);

                            if (PChar->PParty && PChar->PParty->m_PAlliance)
                            {
                                message::send(ipc::AllianceReload{
                                    .allianceId = PChar->PParty->m_PAlliance->m_AllianceID,
                                });
                            }
                            else // No alliance, notify party.
                            {
                                message::send(ipc::PartyReload{
                                    .partyId = PChar->PParty->GetPartyID(),
                                });
                            }

                            // Notify the player they were just kicked -- they are no longer in the DB and party/alliance reloads won't notify them.
                            message::send(ipc::PlayerKick{
                                .victimId = victimId,
                            });
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
                message::send(ipc::LinkshellRemove{
                    .requesterId   = PChar->id,
                    .requesterRank = PItemLinkshell->GetLSType(),
                    .victimName    = victimName,
                    .linkshellId   = PChar->PLinkshell1->getID(),
                });
            }
        }
        break;
        case 2: // linkshell2
        {
            // Ensure the player has a linkshell equipped
            CItemLinkshell* PItemLinkshell = (CItemLinkshell*)PChar->getEquip(SLOT_LINK2);
            if (PChar->PLinkshell2 && PItemLinkshell)
            {
                message::send(ipc::LinkshellRemove{
                    .requesterId   = PChar->id,
                    .requesterRank = PItemLinkshell->GetLSType(),
                    .victimName    = victimName,
                    .linkshellId   = PChar->PLinkshell2->getID(),
                });
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
                    PVictim = dynamic_cast<CCharEntity*>(PChar->PParty->m_PAlliance->partyList[i]->GetMemberByName(victimName));
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
                    uint32 allianceID = PChar->PParty->m_PAlliance->m_AllianceID;

                    if (const auto victimId = charutils::getCharIdFromName(victimName))
                    {
                        const auto rset = db::preparedStmt(
                            "SELECT partyid FROM accounts_parties WHERE charid = ? AND allianceid = ? AND partyflag & ?",
                            victimId, PChar->PParty->m_PAlliance->m_AllianceID, PARTY_LEADER | PARTY_SECOND | PARTY_THIRD);

                        FOR_DB_SINGLE_RESULT(rset)
                        {
                            uint32 partyid = rset->get<uint32>("partyid");

                            const auto rset2 = db::preparedStmt("UPDATE accounts_parties SET allianceid = 0, partyflag = partyflag & ~? WHERE partyid = ?",
                                                                PARTY_SECOND | PARTY_THIRD, partyid);
                            if (rset2 && rset2->rowsAffected())
                            {
                                ShowDebug("%s has removed %s party from alliance", PChar->getName(), victimName);

                                // notify party they were removed
                                message::send(ipc::PartyReload{
                                    .partyId = partyid,
                                });

                                // notify alliance a party was removed
                                message::send(ipc::AllianceReload{
                                    .allianceId = allianceID,
                                });
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

void SmallPacket0x074(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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
        message::send(ipc::PartyInviteResponse{
            .inviteeId     = PChar->id,
            .inviteeTargId = PChar->targid,
            .inviterId     = PChar->InvitePending.id,
            .inviterTargId = PChar->InvitePending.targid,
            .inviteAnswer  = InviteAnswer,
        });

        PChar->InvitePending.clean();
    }

    PChar->InvitePending.clean();
}

/************************************************************************
 *                                                                       *
 *  Party List Request                                                   *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x076(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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
 *  Group Permission Change                                              *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x077(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    const auto memberName = db::escapeString(asStringFromUntrustedSource(data[0x04], 15));
    const auto type       = data.ref<uint8>(0x14);
    const auto permission = data.ref<uint8>(0x15);

    switch (type)
    {
        case 0: // party
        {
            if (PChar->PParty != nullptr && PChar->PParty->GetLeader() == PChar)
            {
                ShowDebug(fmt::format("(Party) Altering permissions of {} to {}", memberName, permission));
                PChar->PParty->AssignPartyRole(memberName, permission);
            }
        }
        break;
        case 1: // linkshell
        {
            CItemLinkshell* PItemLinkshell = (CItemLinkshell*)PChar->getEquip(SLOT_LINK1);
            if (PChar->PLinkshell1 && PItemLinkshell)
            {
                message::send(ipc::LinkshellRankChange{
                    .requesterId   = PChar->id,
                    .requesterRank = PItemLinkshell->GetLSType(),
                    .memberName    = memberName,
                    .linkshellId   = PChar->PLinkshell1->getID(),
                    .newRank       = permission,
                });
            }
        }
        break;
        case 2: // linkshell2
        {
            CItemLinkshell* PItemLinkshell = (CItemLinkshell*)PChar->getEquip(SLOT_LINK2);
            if (PChar->PLinkshell2 && PItemLinkshell)
            {
                message::send(ipc::LinkshellRankChange{
                    .requesterId   = PChar->id,
                    .requesterRank = PItemLinkshell->GetLSType(),
                    .memberName    = memberName,
                    .linkshellId   = PChar->PLinkshell2->getID(),
                    .newRank       = permission,
                });
            }
        }
        break;
        case 5: // alliance
        {
            if (PChar->PParty && PChar->PParty->m_PAlliance && PChar->PParty->GetLeader() == PChar &&
                PChar->PParty->m_PAlliance->getMainParty() == PChar->PParty)
            {
                ShowDebug(fmt::format("(Alliance) Changing leader to {}", memberName));
                PChar->PParty->m_PAlliance->assignAllianceLeader(memberName);

                message::send(ipc::AllianceReload{
                    .allianceId = PChar->PParty->m_PAlliance->m_AllianceID,
                });
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
 *  Begin Synthesis                                                      *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x096(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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
    if (PChar->m_LastSynthTime + 15s > timer::now())
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
 *                                                                       *
 *  Set Chat Filters / Preferred Language                                *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x0DB(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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

void SmallPacket0x0DC(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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
        PChar->pushPacket<CCharStatusPacket>(PChar);
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

void SmallPacket0x0DD(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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
 *                                                                        *
 *  Roe Quest Log Request                                                 *
 *                                                                        *
 ************************************************************************/

void SmallPacket0x112(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
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

template <typename T>
void ValidatedPacketHandler(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    const T* packet = data.as<T>();

    if (const auto result = packet->validate(PSession, PChar); result.valid())
    {
        packet->process(PSession, PChar);
    }
    else
    {
        ShowWarningFmt("Invalid {} packet from {}: {} ", packet->getName(), PChar->name, result.errorString());
    }
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
    PacketSize[0x00A] = 0x2E; PacketParser[0x00A] = &ValidatedPacketHandler<GP_CLI_COMMAND_LOGIN>;
    PacketSize[0x00C] = 0x00; PacketParser[0x00C] = &ValidatedPacketHandler<GP_CLI_COMMAND_GAMEOK>;
    PacketSize[0x00D] = 0x04; PacketParser[0x00D] = &ValidatedPacketHandler<GP_CLI_COMMAND_NETEND>;
    PacketSize[0x00F] = 0x00; PacketParser[0x00F] = &ValidatedPacketHandler<GP_CLI_COMMAND_CLSTAT>;
    PacketSize[0x011] = 0x00; PacketParser[0x011] = &ValidatedPacketHandler<GP_CLI_COMMAND_ZONE_TRANSITION>;
    PacketSize[0x015] = 0x10; PacketParser[0x015] = &ValidatedPacketHandler<GP_CLI_COMMAND_POS>;
    PacketSize[0x016] = 0x04; PacketParser[0x016] = &ValidatedPacketHandler<GP_CLI_COMMAND_CHARREQ>;
    PacketSize[0x017] = 0x00; PacketParser[0x017] = &ValidatedPacketHandler<GP_CLI_COMMAND_CHARREQ2>;
    PacketSize[0x01A] = 0x0E; PacketParser[0x01A] = &SmallPacket0x01A;
    PacketSize[0x01B] = 0x00; PacketParser[0x01B] = &ValidatedPacketHandler<GP_CLI_COMMAND_FRIENDPASS>;
    PacketSize[0x01C] = 0x00; PacketParser[0x01C] = &ValidatedPacketHandler<GP_CLI_COMMAND_UNKNOWN>;
    PacketSize[0x01E] = 0x00; PacketParser[0x01E] = &ValidatedPacketHandler<GP_CLI_COMMAND_GM>;
    PacketSize[0x01F] = 0x00; PacketParser[0x01F] = &ValidatedPacketHandler<GP_CLI_COMMAND_GMCOMMAND>;
    PacketSize[0x028] = 0x06; PacketParser[0x028] = &ValidatedPacketHandler<GP_CLI_COMMAND_ITEM_DUMP>;
    PacketSize[0x029] = 0x06; PacketParser[0x029] = &ValidatedPacketHandler<GP_CLI_COMMAND_ITEM_MOVE>;
    PacketSize[0x02B] = 0x00; PacketParser[0x02B] = &ValidatedPacketHandler<GP_CLI_COMMAND_TRANSLATE>;
    PacketSize[0x02C] = 0x00; PacketParser[0x02C] = &ValidatedPacketHandler<GP_CLI_COMMAND_ITEMSEARCH>;
    PacketSize[0x032] = 0x06; PacketParser[0x032] = &ValidatedPacketHandler<GP_CLI_COMMAND_TRADE_REQ>;
    PacketSize[0x033] = 0x06; PacketParser[0x033] = &ValidatedPacketHandler<GP_CLI_COMMAND_TRADE_RES>;
    PacketSize[0x034] = 0x06; PacketParser[0x034] = &ValidatedPacketHandler<GP_CLI_COMMAND_TRADE_LIST>;
    PacketSize[0x036] = 0x20; PacketParser[0x036] = &ValidatedPacketHandler<GP_CLI_COMMAND_ITEM_TRANSFER>;
    PacketSize[0x037] = 0x0A; PacketParser[0x037] = &ValidatedPacketHandler<GP_CLI_COMMAND_ITEM_USE>;
    PacketSize[0x03A] = 0x04; PacketParser[0x03A] = &ValidatedPacketHandler<GP_CLI_COMMAND_ITEM_STACK>;
    PacketSize[0x03B] = 0x10; PacketParser[0x03B] = &ValidatedPacketHandler<GP_CLI_COMMAND_SUBCONTAINER>;
    PacketSize[0x03C] = 0x00; PacketParser[0x03C] = &SmallPacket0x03C;
    PacketSize[0x03D] = 0x00; PacketParser[0x03D] = &SmallPacket0x03D;
    PacketSize[0x041] = 0x00; PacketParser[0x041] = &ValidatedPacketHandler<GP_CLI_COMMAND_TROPHY_ENTRY>;
    PacketSize[0x042] = 0x00; PacketParser[0x042] = &ValidatedPacketHandler<GP_CLI_COMMAND_TROPHY_ABSENCE>;
    PacketSize[0x04B] = 0x00; PacketParser[0x04B] = &SmallPacket0x04B;
    PacketSize[0x04D] = 0x00; PacketParser[0x04D] = &SmallPacket0x04D;
    PacketSize[0x04E] = 0x1E; PacketParser[0x04E] = &SmallPacket0x04E;
    PacketSize[0x050] = 0x04; PacketParser[0x050] = &SmallPacket0x050;
    PacketSize[0x051] = 0x24; PacketParser[0x051] = &SmallPacket0x051;
    PacketSize[0x052] = 0x26; PacketParser[0x052] = &SmallPacket0x052;
    PacketSize[0x053] = 0x44; PacketParser[0x053] = &SmallPacket0x053;
    PacketSize[0x058] = 0x0A; PacketParser[0x058] = &ValidatedPacketHandler<GP_CLI_COMMAND_RECIPE>;
    PacketSize[0x059] = 0x00; PacketParser[0x059] = &ValidatedPacketHandler<GP_CLI_COMMAND_EFFECTEND>;
    PacketSize[0x05A] = 0x02; PacketParser[0x05A] = &ValidatedPacketHandler<GP_CLI_COMMAND_REQCONQUEST>;
    PacketSize[0x05B] = 0x0A; PacketParser[0x05B] = &ValidatedPacketHandler<GP_CLI_COMMAND_EVENTEND>;
    PacketSize[0x05C] = 0x00; PacketParser[0x05C] = &ValidatedPacketHandler<GP_CLI_COMMAND_EVENTENDXZY>;
    PacketSize[0x05D] = 0x08; PacketParser[0x05D] = &SmallPacket0x05D;
    PacketSize[0x05E] = 0x0C; PacketParser[0x05E] = &SmallPacket0x05E;
    PacketSize[0x060] = 0x00; PacketParser[0x060] = &ValidatedPacketHandler<GP_CLI_COMMAND_PASSWARDS>;
    PacketSize[0x061] = 0x04; PacketParser[0x061] = &ValidatedPacketHandler<GP_CLI_COMMAND_CLISTATUS>;
    PacketSize[0x063] = 0x00; PacketParser[0x063] = &ValidatedPacketHandler<GP_CLI_COMMAND_DIG>;
    PacketSize[0x064] = 0x26; PacketParser[0x064] = &SmallPacket0x064;
    PacketSize[0x066] = 0x0A; PacketParser[0x066] = &ValidatedPacketHandler<GP_CLI_COMMAND_FISHING>;
    PacketSize[0x06E] = 0x06; PacketParser[0x06E] = &SmallPacket0x06E;
    PacketSize[0x06F] = 0x00; PacketParser[0x06F] = &SmallPacket0x06F;
    PacketSize[0x070] = 0x00; PacketParser[0x070] = &SmallPacket0x070;
    PacketSize[0x071] = 0x00; PacketParser[0x071] = &SmallPacket0x071;
    PacketSize[0x074] = 0x00; PacketParser[0x074] = &SmallPacket0x074;
    PacketSize[0x076] = 0x00; PacketParser[0x076] = &SmallPacket0x076;
    PacketSize[0x077] = 0x00; PacketParser[0x077] = &SmallPacket0x077;
    PacketSize[0x078] = 0x00; PacketParser[0x078] = &ValidatedPacketHandler<GP_CLI_COMMAND_GROUP_CHECKID>;
    PacketSize[0x083] = 0x08; PacketParser[0x083] = &ValidatedPacketHandler<GP_CLI_COMMAND_SHOP_BUY>;
    PacketSize[0x084] = 0x06; PacketParser[0x084] = &ValidatedPacketHandler<GP_CLI_COMMAND_SHOP_SELL_REQ>;
    PacketSize[0x085] = 0x04; PacketParser[0x085] = &ValidatedPacketHandler<GP_CLI_COMMAND_SHOP_SELL_SET>;
    PacketSize[0x096] = 0x12; PacketParser[0x096] = &SmallPacket0x096;
    PacketSize[0x09B] = 0x00; PacketParser[0x09B] = &ValidatedPacketHandler<GP_CLI_COMMAND_CHOCOBO_RACE_REQ>;
    PacketSize[0x0A0] = 0x00; PacketParser[0x0A0] = &ValidatedPacketHandler<GP_CLI_COMMAND_SWITCH_PROPOSAL>;
    PacketSize[0x0A1] = 0x00; PacketParser[0x0A1] = &ValidatedPacketHandler<GP_CLI_COMMAND_SWITCH_VOTE>;
    PacketSize[0x0A2] = 0x00; PacketParser[0x0A2] = &ValidatedPacketHandler<GP_CLI_COMMAND_DICE>;
    PacketSize[0x0AA] = 0x00; PacketParser[0x0AA] = &ValidatedPacketHandler<GP_CLI_COMMAND_GUILD_BUY>;
    PacketSize[0x0AB] = 0x00; PacketParser[0x0AB] = &ValidatedPacketHandler<GP_CLI_COMMAND_GUILD_BUYLIST>;
    PacketSize[0x0AC] = 0x00; PacketParser[0x0AC] = &ValidatedPacketHandler<GP_CLI_COMMAND_GUILD_SELL>;
    PacketSize[0x0AD] = 0x00; PacketParser[0x0AD] = &ValidatedPacketHandler<GP_CLI_COMMAND_GUILD_SELLLIST>;
    PacketSize[0x0B5] = 0x00; PacketParser[0x0B5] = &ValidatedPacketHandler<GP_CLI_COMMAND_CHAT_STD>;
    PacketSize[0x0B6] = 0x00; PacketParser[0x0B6] = &ValidatedPacketHandler<GP_CLI_COMMAND_CHAT_NAME>;
    PacketSize[0x0B7] = 0x00; PacketParser[0x0B7] = &ValidatedPacketHandler<GP_CLI_COMMAND_ASSIST_CHANNEL>;
    PacketSize[0x0BE] = 0x00; PacketParser[0x0BE] = &ValidatedPacketHandler<GP_CLI_COMMAND_MERITS>;
    PacketSize[0x0BF] = 0x04; PacketParser[0x0BF] = &ValidatedPacketHandler<GP_CLI_COMMAND_JOB_POINTS_SPEND>;
    PacketSize[0x0C0] = 0x00; PacketParser[0x0C0] = &ValidatedPacketHandler<GP_CLI_COMMAND_JOB_POINTS_REQ>;
    PacketSize[0x0C3] = 0x00; PacketParser[0x0C3] = &ValidatedPacketHandler<GP_CLI_COMMAND_GROUP_COMLINK_MAKE>;
    PacketSize[0x0C4] = 0x0E; PacketParser[0x0C4] = &ValidatedPacketHandler<GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE>;
    PacketSize[0x0CB] = 0x04; PacketParser[0x0CB] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_IS>;
    PacketSize[0x0D2] = 0x04; PacketParser[0x0D2] = &ValidatedPacketHandler<GP_CLI_COMMAND_MAP_GROUP>;
    PacketSize[0x0D3] = 0x00; PacketParser[0x0D3] = &ValidatedPacketHandler<GP_CLI_COMMAND_FAQ_GMCALL>;
    PacketSize[0x0D4] = 0x04; PacketParser[0x0D4] = &ValidatedPacketHandler<GP_CLI_COMMAND_FAQ_GMPARAM>;
    PacketSize[0x0D5] = 0x08; PacketParser[0x0D5] = &ValidatedPacketHandler<GP_CLI_COMMAND_ACK_GMMSG>;
    PacketSize[0x0D8] = 0x00; PacketParser[0x0D8] = &ValidatedPacketHandler<GP_CLI_COMMAND_DUNGEON_PARAM>;
    PacketSize[0x0DB] = 0x00; PacketParser[0x0DB] = &SmallPacket0x0DB;
    PacketSize[0x0DC] = 0x0A; PacketParser[0x0DC] = &SmallPacket0x0DC;
    PacketSize[0x0DD] = 0x08; PacketParser[0x0DD] = &SmallPacket0x0DD;
    PacketSize[0x0DE] = 0x40; PacketParser[0x0DE] = &ValidatedPacketHandler<GP_CLI_COMMAND_INSPECT_MESSAGE>;
    PacketSize[0x0E0] = 0x00; PacketParser[0x0E0] = &ValidatedPacketHandler<GP_CLI_COMMAND_SET_USERMSG>;
    PacketSize[0x0E1] = 0x00; PacketParser[0x0E1] = &ValidatedPacketHandler<GP_CLI_COMMAND_GET_LSMSG>;
    PacketSize[0x0E2] = 0x00; PacketParser[0x0E2] = &ValidatedPacketHandler<GP_CLI_COMMAND_SET_LSMSG>;
    PacketSize[0x0E4] = 0x00; PacketParser[0x0E4] = &ValidatedPacketHandler<GP_CLI_COMMAND_GET_LSPRIV>;
    PacketSize[0x0E7] = 0x04; PacketParser[0x0E7] = &ValidatedPacketHandler<GP_CLI_COMMAND_REQLOGOUT>;
    PacketSize[0x0E8] = 0x04; PacketParser[0x0E8] = &ValidatedPacketHandler<GP_CLI_COMMAND_CAMP>;
    PacketSize[0x0EA] = 0x04; PacketParser[0x0EA] = &ValidatedPacketHandler<GP_CLI_COMMAND_SIT>;
    PacketSize[0x0EB] = 0x00; PacketParser[0x0EB] = &ValidatedPacketHandler<GP_CLI_COMMAND_REQSUBMAPNUM>;
    PacketSize[0x0F0] = 0x04; PacketParser[0x0F0] = &ValidatedPacketHandler<GP_CLI_COMMAND_RESCUE>;
    PacketSize[0x0F1] = 0x04; PacketParser[0x0F1] = &ValidatedPacketHandler<GP_CLI_COMMAND_BUFFCANCEL>;
    PacketSize[0x0F2] = 0x04; PacketParser[0x0F2] = &ValidatedPacketHandler<GP_CLI_COMMAND_SUBMAPCHANGE>;
    PacketSize[0x0F4] = 0x04; PacketParser[0x0F4] = &ValidatedPacketHandler<GP_CLI_COMMAND_TRACKING_LIST>;
    PacketSize[0x0F5] = 0x00; PacketParser[0x0F5] = &ValidatedPacketHandler<GP_CLI_COMMAND_TRACKING_START>;
    PacketSize[0x0F6] = 0x00; PacketParser[0x0F6] = &ValidatedPacketHandler<GP_CLI_COMMAND_TRACKING_END>;
    PacketSize[0x0FA] = 0x00; PacketParser[0x0FA] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_LAYOUT>;
    PacketSize[0x0FB] = 0x00; PacketParser[0x0FB] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_BANKIN>;
    PacketSize[0x0FC] = 0x00; PacketParser[0x0FC] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_PLANT_ADD>;
    PacketSize[0x0FD] = 0x00; PacketParser[0x0FD] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_PLANT_CHECK>;
    PacketSize[0x0FE] = 0x00; PacketParser[0x0FE] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_PLANT_CROP>;
    PacketSize[0x0FF] = 0x00; PacketParser[0x0FF] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_PLANT_STOP>;
    PacketSize[0x100] = 0x04; PacketParser[0x100] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_JOB>;
    PacketSize[0x102] = 0x52; PacketParser[0x102] = &ValidatedPacketHandler<GP_CLI_COMMAND_EXTENDED_JOB>;
    PacketSize[0x104] = 0x02; PacketParser[0x104] = &ValidatedPacketHandler<GP_CLI_COMMAND_BAZAAR_EXIT>;
    PacketSize[0x105] = 0x06; PacketParser[0x105] = &ValidatedPacketHandler<GP_CLI_COMMAND_BAZAAR_LIST>;
    PacketSize[0x106] = 0x06; PacketParser[0x106] = &ValidatedPacketHandler<GP_CLI_COMMAND_BAZAAR_BUY>;
    PacketSize[0x109] = 0x00; PacketParser[0x109] = &ValidatedPacketHandler<GP_CLI_COMMAND_BAZAAR_OPEN>;
    PacketSize[0x10A] = 0x06; PacketParser[0x10A] = &ValidatedPacketHandler<GP_CLI_COMMAND_BAZAAR_ITEMSET>;
    PacketSize[0x10B] = 0x00; PacketParser[0x10B] = &ValidatedPacketHandler<GP_CLI_COMMAND_BAZAAR_CLOSE>;
    PacketSize[0x10C] = 0x04; PacketParser[0x10C] = &ValidatedPacketHandler<GP_CLI_COMMAND_ROE_START>;
    PacketSize[0x10D] = 0x04; PacketParser[0x10D] = &ValidatedPacketHandler<GP_CLI_COMMAND_ROE_REMOVE>;
    PacketSize[0x10E] = 0x04; PacketParser[0x10E] = &ValidatedPacketHandler<GP_CLI_COMMAND_ROE_CLAIM>;
    PacketSize[0x10F] = 0x02; PacketParser[0x10F] = &ValidatedPacketHandler<GP_CLI_COMMAND_CURRENCIES_1>;
    PacketSize[0x110] = 0x0A; PacketParser[0x110] = &ValidatedPacketHandler<GP_CLI_COMMAND_FISHING_2>;
    PacketSize[0x112] = 0x00; PacketParser[0x112] = &SmallPacket0x112;
    PacketSize[0x113] = 0x06; PacketParser[0x113] = &ValidatedPacketHandler<GP_CLI_COMMAND_SITCHAIR>;
    PacketSize[0x114] = 0x00; PacketParser[0x114] = &ValidatedPacketHandler<GP_CLI_COMMAND_MAP_MARKERS>;
    PacketSize[0x115] = 0x02; PacketParser[0x115] = &ValidatedPacketHandler<GP_CLI_COMMAND_CURRENCIES_2>;
    PacketSize[0x116] = 0x00; PacketParser[0x116] = &ValidatedPacketHandler<GP_CLI_COMMAND_UNITY_MENU>;
    PacketSize[0x117] = 0x00; PacketParser[0x117] = &ValidatedPacketHandler<GP_CLI_COMMAND_UNITY_QUEST>;
    PacketSize[0x118] = 0x00; PacketParser[0x118] = &ValidatedPacketHandler<GP_CLI_COMMAND_UNITY_TOGGLE>;
    PacketSize[0x119] = 0x00; PacketParser[0x119] = &ValidatedPacketHandler<GP_CLI_COMMAND_EMOTE_LIST>;
    PacketSize[0x11B] = 0x00; PacketParser[0x11B] = &ValidatedPacketHandler<GP_CLI_COMMAND_MASTERY_DISPLAY>;
    PacketSize[0x11C] = 0x08; PacketParser[0x11C] = &ValidatedPacketHandler<GP_CLI_COMMAND_PARTY_REQUEST>;
    PacketSize[0x11D] = 0x00; PacketParser[0x11D] = &ValidatedPacketHandler<GP_CLI_COMMAND_JUMP>;
    // clang-format on
}
