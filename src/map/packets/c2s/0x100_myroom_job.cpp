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

#include "entities/charentity.h"
#include "items/item_weapon.h"
#include "job_points.h"
#include "latent_effect_container.h"
#include "lua/luautils.h"
#include "packets/char_job_extra.h"
#include "packets/char_jobs.h"
#include "packets/char_recast.h"
#include "packets/char_stats.h"
#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/menu_merit.h"
#include "packets/monipulator1.h"
#include "packets/monipulator2.h"
#include "packets/s2c/0x062_clistatus2.h"
#include "packets/s2c/0x0ac_command_data.h"
#include "recast_container.h"
#include "status_effect_container.h"
#include "utils/blueutils.h"
#include "utils/charutils.h"
#include "utils/puppetutils.h"

auto GP_CLI_COMMAND_MYROOM_JOB::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    auto pv = PacketValidator()
                  .mustEqual(PChar->loc.zone->CanUseMisc(MISC_MOGMENU) || PChar->m_moghouseID == PChar->id, true, "Player not in MH or zone with Moogle.");

    if (MainJobIndex)
    {
        pv.range("MainJobIndex", MainJobIndex, 0x01, MAX_JOBTYPE - 1)
            .mustEqual((PChar->jobs.unlocked & (1 << MainJobIndex)) != 0, true, "Main job not unlocked");
    }

    if (SupportJobIndex)
    {
        pv.range("SupportJobIndex", SupportJobIndex, 0x00, MAX_JOBTYPE - 1)
            .mustEqual((PChar->jobs.unlocked & (1 << SupportJobIndex)) != 0, true, "Support job not unlocked");
    }

    return pv;
}

void GP_CLI_COMMAND_MYROOM_JOB::process(MapSession* PSession, CCharEntity* PChar) const
{
    if ((MainJobIndex > 0x00) && (MainJobIndex < MAX_JOBTYPE) && (PChar->jobs.unlocked & (1 << MainJobIndex)))
    {
        const JOBTYPE prevjob = PChar->GetMJob();
        PChar->resetPetZoningInfo();

        charutils::SaveJobChangeGear(PChar);
        charutils::RemoveAllEquipment(PChar);
        PChar->SetMJob(MainJobIndex);
        PChar->SetMLevel(PChar->jobs.job[PChar->GetMJob()]);
        PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);

        // If removing RemoveAllEquipment, please add a charutils::CheckUnarmedItem(PChar) if main hand is empty.
        puppetutils::LoadAutomaton(PChar);

        if (MainJobIndex == JOB_BLU)
        {
            blueutils::LoadSetSpells(PChar);
        }
        else if (prevjob == JOB_BLU)
        {
            blueutils::UnequipAllBlueSpells(PChar);
        }

        bool canUseMeritMode = PChar->jobs.job[PChar->GetMJob()] >= 75 && charutils::hasKeyItem(PChar, KeyItem::LIMIT_BREAKER);
        if (!canUseMeritMode && PChar->MeritMode)
        {
            if (db::preparedStmt("UPDATE char_exp SET mode = ? WHERE charid = ? LIMIT 1", 0, PChar->id))
            {
                PChar->MeritMode = false;
            }
        }
    }

    if ((SupportJobIndex > 0x00) && (SupportJobIndex < MAX_JOBTYPE) && (PChar->jobs.unlocked & (1 << SupportJobIndex)))
    {
        JOBTYPE prevsjob = PChar->GetSJob();
        PChar->resetPetZoningInfo();

        PChar->SetSJob(SupportJobIndex);
        PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);

        charutils::CheckEquipLogic(PChar, SCRIPT_CHANGESJOB, prevsjob);
        puppetutils::LoadAutomaton(PChar);

        if (SupportJobIndex == JOB_BLU)
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

    // If the player has a teleport effect and they change jobs, cancel the teleport/warps you
    // Retail does cancel your teleport/warp if you change subs if someone else ports/warps
    if (auto PTeleportEffect = PChar->StatusEffectContainer->GetStatusEffect(EFFECT::EFFECT_TELEPORT))
    {
        PTeleportEffect->SetPower(0);
    }

    PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DISPELABLE | EFFECTFLAG_ROLL | EFFECTFLAG_ON_JOBCHANGE);

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

    PChar->pushPacket<CCharJobsPacket>(PChar);
    PChar->pushPacket<CCharStatusPacket>(PChar);
    PChar->pushPacket<CCharStatsPacket>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS2>(PChar);
    PChar->pushPacket<CCharRecastPacket>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_COMMAND_DATA>(PChar);
    PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
    PChar->pushPacket<CCharJobExtraPacket>(PChar, false);
    PChar->pushPacket<CMenuMeritPacket>(PChar);
    PChar->pushPacket<CMonipulatorPacket1>(PChar);
    PChar->pushPacket<CMonipulatorPacket2>(PChar);
    PChar->pushPacket<CCharSyncPacket>(PChar);
}
