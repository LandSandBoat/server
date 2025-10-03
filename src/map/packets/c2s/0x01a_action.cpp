/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "0x01a_action.h"

#include "ability.h"
#include "ai/ai_container.h"
#include "enmity_container.h"
#include "entities/charentity.h"
#include "entities/trustentity.h"
#include "items.h"
#include "latent_effect_container.h"
#include "packets/char_recast.h"
#include "packets/chocobo_digging.h"
#include "packets/message_system.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x052_eventucoff.h"
#include "recast_container.h"
#include "status_effect.h"
#include "status_effect_container.h"
#include "trade_container.h"
#include "utils/battleutils.h"

namespace
{
    const auto actionToStr = [](const GP_CLI_COMMAND_ACTION_ACTIONID actionIn)
    {
        return magic_enum::enum_name(actionIn);
    };
} // namespace

auto GP_CLI_COMMAND_ACTION::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_ACTION_ACTIONID>(ActionID);
}

void GP_CLI_COMMAND_ACTION::process(MapSession* PSession, CCharEntity* PChar) const
{
    const auto actionStr = fmt::format("Player Action: {}: {} -> ActIndex: {}", PChar->getName(), actionToStr(static_cast<GP_CLI_COMMAND_ACTION_ACTIONID>(ActionID)), ActIndex);
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

    switch (static_cast<GP_CLI_COMMAND_ACTION_ACTIONID>(ActionID))
    {
        case GP_CLI_COMMAND_ACTION_ACTIONID::Talk:
        {
            // Monstrosity: Can't really do anything while under Gestation until you click it off.
            //            : MONs can trigger doors, so we'll handle that later.
            if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_GESTATION))
            {
                return;
            }

            if (PChar->StatusEffectContainer->HasPreventActionEffect())
            {
                return;
            }

            if (PChar->m_Costume != 0 || PChar->animation == ANIMATION_SYNTH || (PChar->CraftContainer && PChar->CraftContainer->getItemsCount() > 0))
            {
                PChar->pushPacket<GP_SERV_COMMAND_EVENTUCOFF>(PChar, GP_SERV_COMMAND_EVENTUCOFF_MODE::Standard);
                return;
            }

            const CBaseEntity* PNpc = PChar->GetEntity(ActIndex, TYPE_NPC | TYPE_MOB);

            // MONs are allowed to use doors, but nothing else
            if (PChar->m_PMonstrosity != nullptr &&
                PNpc->look.size != 0x02 &&
                PChar->getZone() != ZONEID::ZONE_FERETORY &&
                !settings::get<bool>("main.MONSTROSITY_TRIGGER_NPCS"))
            {
                PChar->pushPacket<GP_SERV_COMMAND_EVENTUCOFF>(PChar, GP_SERV_COMMAND_EVENTUCOFF_MODE::Standard);
                return;
            }

            // NOTE: Moogles inside of mog houses are the exception for not requiring Spawned or Status checks.
            if (PNpc != nullptr && distance(PNpc->loc.p, PChar->loc.p) <= 6.0f && ((PNpc->PAI->IsSpawned() && PNpc->status == STATUS_TYPE::NORMAL) || PChar->m_moghouseID != 0))
            {
                PNpc->PAI->Trigger(PChar);
                PChar->m_charHistory.npcInteractions++;
            }

            // Releasing a trust
            if (auto* PTrust = dynamic_cast<CTrustEntity*>(PChar->GetEntity(ActIndex, TYPE_TRUST)))
            {
                PChar->RemoveTrust(PTrust);
            }

            if (!PChar->isNpcLocked())
            {
                PChar->eventPreparation->reset();
                PChar->pushPacket<GP_SERV_COMMAND_EVENTUCOFF>(PChar, GP_SERV_COMMAND_EVENTUCOFF_MODE::Standard);
            }
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::Attack:
        {
            if (PChar->isMounted())
            {
                PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_MOUNTED);
            }

            PChar->PAI->Engage(ActIndex);
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::CastMagic:
        {
            // Luopan can only be placed within 19 yalms of target
            // Magic AI needs to be updated to account for offset. For now, we'll clamp it.
            // clang-format off
            const position_t actionOffset =
            {
                std::clamp(CastMagic.PosX, -19.0f, 19.0f),
                std::clamp(CastMagic.PosZ, -19.0f, 19.0f),
                std::clamp(CastMagic.PosY, -19.0f, 19.0f),
                0, // moving (packet only contains x/y/z)
                0, // rotation (packet only contains x/y/z)
            };
            // clang-format on

            const auto spellId = static_cast<SpellID>(CastMagic.SpellId);
            PChar->PAI->Cast(ActIndex, spellId);

            // target offset used only for luopan placement as of now
            if (spellId >= SpellID::Geo_Regen && spellId <= SpellID::Geo_Gravity)
            {
                // reset the action offset position to prevent other spells from using previous position data
                PChar->m_ActionOffsetPos = {};

                // Need to set the target position plus offset for positioning correctly

                if (const auto* PTarget = dynamic_cast<CBattleEntity*>(PChar->GetEntity(ActIndex)); PTarget != nullptr)
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
        case GP_CLI_COMMAND_ACTION_ACTIONID::AttackOff:
        {
            if (!PChar->StatusEffectContainer->HasStatusEffect({ EFFECT_CHARM, EFFECT_CHARM_II }))
            {
                PChar->PAI->Disengage();
            }
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::Help:
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
                    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CFH));
                    return;
                }
            }

            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_CFH);
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::Weaponskill:
        {
            if (!PChar->PAI->IsEngaged() && settings::get<bool>("map.PREVENT_UNENGAGED_WS")) // Prevent Weaponskill usage if player isn't engaged.
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_WS);
                return;
            }

            PChar->PAI->WeaponSkill(ActIndex, Weaponskill.SkillId);
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::JobAbility:
        {
            if (PChar->animation != ANIMATION_NONE && PChar->animation != ANIMATION_ATTACK)
            {
                ShowWarning("GP_CLI_COMMAND_ACTION: Player %s trying to use a Job Ability from invalid state", PChar->getName());
                return;
            }

            // Don't allow BST to use ready before level 25
            if (PChar->PPet != nullptr && (!charutils::hasAbility(PChar, ABILITY_READY) || !PChar->PPet->PAI->IsEngaged()))
            {
                if (JobAbility.SkillId >= ABILITY_FOOT_KICK && JobAbility.SkillId <= ABILITY_PENTAPECK) // Is this a BST ability?
                {
                    PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA2);
                    return;
                }
            }

            PChar->PAI->Ability(ActIndex, JobAbility.SkillId);
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::HomepointMenu:
        {
            if (!PChar->isDead())
            {
                return;
            }

            if (PChar->m_PMonstrosity)
            {
                monstrosity::HandleDeathMenu(PChar, HomepointMenu.StatusId);
                return;
            }

            PChar->setCharVar("expLost", 0);
            charutils::HomePoint(PChar, true);
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::Assist:
        {
            battleutils::assistTarget(PChar, ActIndex);
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::RaiseMenu:
        {
            if (!PChar->m_hasRaise)
            {
                return;
            }

            if (HomepointMenu.StatusId == GP_CLI_COMMAND_ACTION_HOMEPOINTMENU::Accept)
            {
                PChar->Raise();
            }
            else
            {
                PChar->m_hasRaise = 0;
            }
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::Fish:
        {
            if (PChar->m_moghouseID != 0)
            {
                ShowWarningFmt("GP_CLI_COMMAND_ACTION: Player {} trying to fish in Mog House", PChar->getName());
                PChar->pushPacket<GP_SERV_COMMAND_EVENTUCOFF>(PChar, GP_SERV_COMMAND_EVENTUCOFF_MODE::Fishing);
                return;
            }

            if (PChar->StatusEffectContainer->HasPreventActionEffect())
            {
                return;
            }

            fishingutils::StartFishing(PChar);
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::ChangeTarget:
        {
            PChar->PAI->ChangeTarget(ActIndex);
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::Shoot:
        {
            if (PChar->animation != ANIMATION_NONE && PChar->animation != ANIMATION_ATTACK)
            {
                ShowWarning("GP_CLI_COMMAND_ACTION: Player %s trying to Ranged Attack from invalid state", PChar->getName());
                return;
            }

            PChar->PAI->RangedAttack(ActIndex);
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::ChocoboDig:
        {
            // Mounted Check.
            // Only rented and personal chocobos can dig.
            if (!PChar->isMounted() || PChar->m_mountId != MOUNT_CHOCOBO)
            {
                return;
            }

            const uint8 slotID = PChar->getStorage(LOC_INVENTORY)->SearchItem(GYSAHL_GREENS);
            if (slotID == ERROR_SLOTID)
            {
                PChar->pushPacket<CMessageSystemPacket>(GYSAHL_GREENS, 0, MsgStd::YouDontHaveAny);
                return;
            }

            // Consume Gysahl Green and push animation on dig attempt.
            if (luautils::OnChocoboDig(PChar))
            {
                charutils::UpdateItem(PChar, LOC_INVENTORY, slotID, -1);
                PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CChocoboDiggingPacket>(PChar));
            }
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::Dismount:
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
        case GP_CLI_COMMAND_ACTION_ACTIONID::TractorMenu:
        {
            if (TractorMenu.StatusId == GP_CLI_COMMAND_ACTION_TRACTORMENU::Accept && PChar->m_hasTractor != 0)
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
        case GP_CLI_COMMAND_ACTION_ACTIONID::SendResRdy:
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
        case GP_CLI_COMMAND_ACTION_ACTIONID::Quarry:
        case GP_CLI_COMMAND_ACTION_ACTIONID::Sprint:
        case GP_CLI_COMMAND_ACTION_ACTIONID::Scout:
            break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::Blockaid:
        {
            if (!PChar->StatusEffectContainer->HasStatusEffect(EFFECT_ALLIED_TAGS))
            {
                if (BlockAid.StatusId == GP_CLI_COMMAND_ACTION_BLOCKAID::Disable && PChar->getBlockingAid())
                {
                    PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::BlockaidCanceled);
                    PChar->setBlockingAid(false);
                }
                else if (BlockAid.StatusId == GP_CLI_COMMAND_ACTION_BLOCKAID::Enable && !PChar->getBlockingAid())
                {
                    PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::BlockaidActivated);
                    PChar->setBlockingAid(true);
                }
                else if (BlockAid.StatusId == GP_CLI_COMMAND_ACTION_BLOCKAID::Toggle)
                {
                    PChar->setBlockingAid(!PChar->getBlockingAid());
                    PChar->pushPacket<CMessageSystemPacket>(0, 0, PChar->getBlockingAid() ? MsgStd::BlockaidCurrentlyActive : MsgStd::BlockaidCurrentlyInactive);
                }
            }
            else
            {
                PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CannotUseCommandAtTheMoment);
            }
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::MonsterSkill:
        {
            monstrosity::HandleMonsterSkillActionPacket(PChar, *this);
        }
        break;
        case GP_CLI_COMMAND_ACTION_ACTIONID::Mount:
        {
            const auto mountKeyItem = static_cast<KeyItem>(static_cast<uint16_t>(KeyItem::CHOCOBO_COMPANION) + Mount.MountId);

            if (PChar->animation != ANIMATION_NONE)
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_PERFORM_ACTION);
            }
            else if (!PChar->loc.zone->CanUseMisc(MISC_MOUNT))
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
            }
            else if (PChar->GetMLevel() < 20)
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 20, 0, MSGBASIC_MOUNT_REQUIRED_LEVEL);
            }
            else if (charutils::hasKeyItem(PChar, mountKeyItem))
            {
                if (PChar->PRecastContainer->HasRecast(RECAST_ABILITY, 256, 60s))
                {
                    PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_WAIT_LONGER);

                    // add recast timer
                    // PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, 202);
                    return;
                }

                if (PChar->hasEnmityEXPENSIVE())
                {
                    PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_YOUR_MOUNT_REFUSES);
                    return;
                }

                PChar->m_mountId = Mount.MountId ? Mount.MountId + 1 : 0;
                PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(
                                                                  EFFECT_MOUNTED,
                                                                  EFFECT_MOUNTED,
                                                                  Mount.MountId ? Mount.MountId + 1 : 0,
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
    }
}
