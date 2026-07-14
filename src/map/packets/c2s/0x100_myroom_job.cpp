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

#include "0x100_myroom_job.h"

#include "ai/ai_container.h"
#include "ai/states/magic_state.h"
#include "entities/char_entity.h"
#include "items/item_weapon.h"
#include "job_points.h"
#include "latent_effect_container.h"
#include "lua/luautils.h"
#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/s2c/0x01b_job_info.h"
#include "packets/s2c/0x061_clistatus.h"
#include "packets/s2c/0x062_clistatus2.h"
#include "packets/s2c/0x063_miscdata_merits.h"
#include "packets/s2c/0x063_miscdata_monstrosity.h"
#include "packets/s2c/0x0ac_command_data.h"
#include "packets/s2c/0x119_abil_recast.h"
#include "recast_container.h"
#include "status_effect_container.h"
#include "utils/blueutils.h"
#include "utils/charutils.h"
#include "utils/puppetutils.h"

auto GP_CLI_COMMAND_MYROOM_JOB::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    auto pv = PacketValidator(PChar)
                  .blockedBy({ BlockedState::InEvent })
                  .mustEqual(PChar->loc.zone->CanUseMisc(xi::ZoneMisc::Mogmenu) || PChar->m_moghouseID == PChar->id, true, "Player not in MH or zone with Moogle.");

    if (this->MainJobIndex)
    {
        pv.range("MainJobIndex", this->MainJobIndex, 0x01, MAX_JOBTYPE - 1)
            .mustEqual((PChar->jobs.unlocked & (1 << this->MainJobIndex)) != 0, true, "Main job not unlocked");
    }

    if (this->SupportJobIndex)
    {
        pv.range("SupportJobIndex", this->SupportJobIndex, 0x00, MAX_JOBTYPE - 1)
            .mustEqual((PChar->jobs.unlocked & (1 << this->SupportJobIndex)) != 0, true, "Support job not unlocked");
    }

    return pv;
}

void GP_CLI_COMMAND_MYROOM_JOB::process(MapSession* PSession, CCharEntity* PChar) const
{
    const JOBTYPE prevMainJob = PChar->GetMJob();
    const JOBTYPE prevSubJob  = PChar->GetSJob();
    const bool    hadBlueMage = prevMainJob == JOB_BLU || prevSubJob == JOB_BLU;

    const bool changingMainJob = this->MainJobIndex > 0x00;

    if (changingMainJob)
    {
        PChar->resetPetZoningInfo();

        charutils::SaveJobChangeGear(PChar);
        charutils::RemoveAllEquipment(PChar);
        PChar->SetMJob(this->MainJobIndex);

        // New main matches the current sub, swap them like retail.
        if (PChar->GetSJob() == PChar->GetMJob())
        {
            PChar->SetSJob(prevMainJob);
        }

        PChar->SetMLevel(PChar->jobs.job[PChar->GetMJob()]);
        PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);

        // If removing RemoveAllEquipment, please add a charutils::CheckUnarmedItem(PChar) if main hand is empty.
        puppetutils::LoadAutomaton(PChar);

        bool canUseMeritMode = PChar->jobs.job[PChar->GetMJob()] >= 75 && charutils::hasKeyItem(PChar, KeyItem::LIMIT_BREAKER);
        if (!canUseMeritMode && PChar->MeritMode)
        {
            if (db::preparedStmt("UPDATE char_exp SET mode = ? WHERE charid = ? LIMIT 1", 0, PChar->id))
            {
                PChar->MeritMode = false;
            }
        }
    }

    // Reject a sub change that equals the current main.
    const bool changingSubJob    = this->SupportJobIndex > 0x00;
    const bool subJobMatchesMain = this->SupportJobIndex == PChar->GetMJob();

    if (changingSubJob && !subJobMatchesMain)
    {
        PChar->resetPetZoningInfo();

        PChar->SetSJob(this->SupportJobIndex);
        PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);

        puppetutils::LoadAutomaton(PChar);

        xi::DamageType subType = xi::DamageType::None;
        if (auto* weapon = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_SUB]))
        {
            subType = weapon->getDmgType();
        }

        if (subType > xi::DamageType::None && subType < xi::DamageType::HandToHand)
        {
            charutils::UnequipItem(PChar, SLOT_SUB);
        }
    }

    // Refresh blue magic for the resulting jobs.
    const bool hasBlueMage = PChar->GetMJob() == JOB_BLU || PChar->GetSJob() == JOB_BLU;
    if (hasBlueMage && !hadBlueMage)
    {
        blueutils::LoadSetSpells(PChar);
    }
    else if (hasBlueMage)
    {
        blueutils::ValidateBlueSpells(PChar);
    }
    else if (hadBlueMage)
    {
        blueutils::UnequipAllBlueSpells(PChar);
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

    // If the player has a teleport effect and they change jobs, cancel the teleport/warps you
    // Retail does cancel your teleport/warp if you change subs if someone else ports/warps
    if (auto PTeleportEffect = PChar->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Teleport))
    {
        PTeleportEffect->SetPower(0);
    }

    PChar->StatusEffectContainer->DelStatusEffectsByFlag(xi::StatusEffectFlag::Dispelable | xi::StatusEffectFlag::Roll | xi::StatusEffectFlag::OnJobchange);

    // Changing jobs interrupts any spell being cast.
    if (PChar->PAI->IsCurrentState<CMagicState>())
    {
        PChar->PAI->InterruptStates();
    }

    // clang-format off
    PChar->ForParty([](CBattleEntity* PMember)
    {
        static_cast<CCharEntity*>(PMember)->PLatentEffectContainer->CheckLatentsPartyJobs();
    });
    // clang-format on

    PChar->UpdateHealth();

    PChar->health.hp = PChar->GetMaxHP();
    PChar->health.mp = PChar->GetMaxMP();
    PChar->updatemask |= UPDATE_HP;

    charutils::SaveCharStats(PChar);

    PChar->pushPacket<GP_SERV_COMMAND_JOB_INFO>(PChar);
    PChar->pushPacket<CCharStatusPacket>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS2>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_ABIL_RECAST>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_COMMAND_DATA>(PChar);
    charutils::SendExtendedJobPackets(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MERITS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MONSTROSITY1>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MONSTROSITY2>(PChar);
    PChar->pushPacket<CCharSyncPacket>(PChar);
}
