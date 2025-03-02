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

#include "common/socket.h"

#include <cstring>

#include "char_job_extra.h"
#include "utils/puppetutils.h"

#include "entities/automatonentity.h"
#include "entities/charentity.h"
#include "merit.h"
#include "monstrosity.h"

CCharJobExtraPacket::CCharJobExtraPacket(CCharEntity* PChar, bool mjob)
{
    this->setType(0x44);
    this->setSize(0xA0);

    JOBTYPE job      = JOB_NON;
    uint8   jobLevel = 0;

    if (mjob)
    {
        job      = PChar->GetMJob();
        jobLevel = PChar->GetMLevel();
    }
    else
    {
        job      = PChar->GetSJob();
        jobLevel = PChar->GetSLevel();
    }

    if (PChar->m_PMonstrosity != nullptr)
    {
        job = JOB_MON;
    }

    ref<uint8>(0x04) = job;
    if (!mjob)
    {
        ref<uint8>(0x05) = 0x01;
    }

    if (job == JOB_BLU)
    {
        std::memcpy(buffer_.data() + 0x08, &PChar->m_SetBlueSpells, 20);
    }
    else if (job == JOB_PUP)
    {
        auto PAutomaton = dynamic_cast<CAutomatonEntity*>(PChar->PPet);

        ref<uint8>(0x08) = PChar->getAutomatonHead();
        ref<uint8>(0x09) = PChar->getAutomatonFrame();
        ref<uint8>(0x0A) = PChar->getAutomatonAttachment(0);
        ref<uint8>(0x0B) = PChar->getAutomatonAttachment(1);
        ref<uint8>(0x0C) = PChar->getAutomatonAttachment(2);
        ref<uint8>(0x0D) = PChar->getAutomatonAttachment(3);
        ref<uint8>(0x0E) = PChar->getAutomatonAttachment(4);
        ref<uint8>(0x0F) = PChar->getAutomatonAttachment(5);
        ref<uint8>(0x10) = PChar->getAutomatonAttachment(6);
        ref<uint8>(0x11) = PChar->getAutomatonAttachment(7);
        ref<uint8>(0x12) = PChar->getAutomatonAttachment(8);
        ref<uint8>(0x13) = PChar->getAutomatonAttachment(9);
        ref<uint8>(0x14) = PChar->getAutomatonAttachment(10);
        ref<uint8>(0x15) = PChar->getAutomatonAttachment(11);

        ref<uint32>(0x18) = PChar->m_unlockedAttachments.heads;
        ref<uint32>(0x1C) = PChar->m_unlockedAttachments.frames;

        // unlocked attachments: bit # = itemID (second itemID, 8000+ one) & 0x1F (0-31), or itemID & 0xFF - (32*element)
        ref<uint32>(0x38) = PChar->m_unlockedAttachments.attachments[0];
        ref<uint32>(0x3C) = PChar->m_unlockedAttachments.attachments[1];
        ref<uint32>(0x40) = PChar->m_unlockedAttachments.attachments[2];
        ref<uint32>(0x44) = PChar->m_unlockedAttachments.attachments[3];
        ref<uint32>(0x48) = PChar->m_unlockedAttachments.attachments[4];
        ref<uint32>(0x4C) = PChar->m_unlockedAttachments.attachments[5];
        ref<uint32>(0x50) = PChar->m_unlockedAttachments.attachments[6];
        ref<uint32>(0x54) = PChar->m_unlockedAttachments.attachments[7];

        std::memcpy(buffer_.data() + 0x58, PChar->automatonInfo.m_automatonName.c_str(), PChar->automatonInfo.m_automatonName.size());

        // Activated automaton
        if (PAutomaton)
        {
            ref<uint16>(0x68) = PAutomaton->health.hp == 0 ? PAutomaton->GetMaxHP() : PAutomaton->health.hp;
            ref<uint16>(0x6A) = PAutomaton->GetMaxHP();
            ref<uint16>(0x6C) = PAutomaton->health.mp;
            ref<uint16>(0x6E) = PAutomaton->GetMaxMP();
        }
        else // Deactivated automaton
        {
            ref<uint16>(0x68) = PChar->automatonInfo.automatonHealth.maxhp;
            ref<uint16>(0x6A) = PChar->automatonInfo.automatonHealth.maxhp;
            ref<uint16>(0x6C) = PChar->automatonInfo.automatonHealth.maxmp;
            ref<uint16>(0x6E) = PChar->automatonInfo.automatonHealth.maxmp;
        }

        int32  meritbonus = PChar->PMeritPoints->GetMeritValue(MERIT_AUTOMATON_SKILLS, PChar);
        uint16 ameCap     = puppetutils::getSkillCap(PChar, SKILL_AUTOMATON_MELEE, jobLevel);
        uint16 ameBonus   = PChar->getMod(Mod::AUTO_MELEE_SKILL);
        uint16 araCap     = puppetutils::getSkillCap(PChar, SKILL_AUTOMATON_RANGED, jobLevel);
        uint16 araBonus   = PChar->getMod(Mod::AUTO_RANGED_SKILL);
        uint16 amaCap     = puppetutils::getSkillCap(PChar, SKILL_AUTOMATON_MAGIC, jobLevel);
        uint16 amaBonus   = PChar->getMod(Mod::AUTO_MAGIC_SKILL);

        ref<uint16>(0x70) = std::min(ameCap, PChar->GetSkill(SKILL_AUTOMATON_MELEE));
        ref<uint16>(0x72) = ameCap + ameBonus;

        ref<uint16>(0x74) = std::min(araCap, PChar->GetSkill(SKILL_AUTOMATON_RANGED));
        ref<uint16>(0x76) = araCap + araBonus;

        ref<uint16>(0x78) = std::min(amaCap, PChar->GetSkill(SKILL_AUTOMATON_MAGIC));
        ref<uint16>(0x7A) = amaCap + amaBonus;

        // No skill rank, so working skills are 0
        if (puppetutils::getSkillCap(PChar, SKILL_AUTOMATON_MAGIC, jobLevel) == 0)
        {
            ref<uint16>(0x78) = amaBonus + meritbonus;
            ref<uint16>(0x7A) = amaBonus + meritbonus;
        }

        // No skill rank, so working skills are 0
        if (puppetutils::getSkillCap(PChar, SKILL_AUTOMATON_RANGED, jobLevel) == 0)
        {
            ref<uint16>(0x74) = araBonus + meritbonus;
            ref<uint16>(0x76) = araBonus + meritbonus;
        }

        // Activated automaton
        if (PAutomaton)
        {
            ref<uint16>(0x80) = PAutomaton->stats.STR;
            ref<uint16>(0x82) = PAutomaton->getMod(Mod::STR);
            ref<uint16>(0x84) = PAutomaton->stats.DEX;
            ref<uint16>(0x86) = PAutomaton->getMod(Mod::DEX);
            ref<uint16>(0x88) = PAutomaton->stats.VIT;
            ref<uint16>(0x8A) = PAutomaton->getMod(Mod::VIT);
            ref<uint16>(0x8C) = PAutomaton->stats.AGI;
            ref<uint16>(0x8E) = PAutomaton->getMod(Mod::AGI);
            ref<uint16>(0x90) = PAutomaton->stats.INT;
            ref<uint16>(0x92) = PAutomaton->getMod(Mod::INT);
            ref<uint16>(0x94) = PAutomaton->stats.MND;
            ref<uint16>(0x96) = PAutomaton->getMod(Mod::MND);
            ref<uint16>(0x98) = PAutomaton->stats.CHR;
            ref<uint16>(0x9A) = PAutomaton->getMod(Mod::CHR);
        }
        else // Deactivated automaton
        {
            ref<uint16>(0x80) = PChar->automatonInfo.automatonStats.STR;
            ref<uint16>(0x82) = 0;
            ref<uint16>(0x84) = PChar->automatonInfo.automatonStats.DEX;
            ref<uint16>(0x86) = 0;
            ref<uint16>(0x88) = PChar->automatonInfo.automatonStats.VIT;
            ref<uint16>(0x8A) = 0;
            ref<uint16>(0x8C) = PChar->automatonInfo.automatonStats.AGI;
            ref<uint16>(0x8E) = 0;
            ref<uint16>(0x90) = PChar->automatonInfo.automatonStats.INT;
            ref<uint16>(0x92) = 0;
            ref<uint16>(0x94) = PChar->automatonInfo.automatonStats.MND;
            ref<uint16>(0x96) = 0;
            ref<uint16>(0x98) = PChar->automatonInfo.automatonStats.CHR;
            ref<uint16>(0x9A) = 0;
        }

        ref<uint8>(0x9C) = PChar->getMod(Mod::AUTO_ELEM_CAPACITY);
    }
    else if (PChar->m_PMonstrosity != nullptr)
    {
        ref<uint16>(0x08) = PChar->m_PMonstrosity->Species;

        for (std::size_t idx = 0; idx < 12; ++idx)
        {
            ref<uint16>(0x0C + (idx * 2)) = PChar->m_PMonstrosity->EquippedInstincts[idx];
        }
    }
}
