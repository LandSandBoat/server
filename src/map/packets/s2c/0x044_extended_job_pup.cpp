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

#include "0x044_extended_job_pup.h"

#include "entities/automaton_entity.h"
#include "entities/char_entity.h"
#include "merit.h"
#include "utils/puppetutils.h"

GP_SERV_COMMAND_EXTENDED_JOB::PUP::PUP(CCharEntity* PChar, const bool mjob)
{
    auto& packet = this->data();

    const auto  PAutomaton = dynamic_cast<CAutomatonEntity*>(PChar->PPet);
    const uint8 jobLevel   = mjob ? PChar->GetMLevel() : PChar->GetSLevel();

    packet.Job            = JOB_PUP;
    packet.IsSubJob       = !mjob;
    packet.Head           = PChar->getAutomatonHead();
    packet.Frame          = PChar->getAutomatonFrame();
    packet.UnlockedHeads  = PChar->m_unlockedAttachments.heads;
    packet.UnlockedFrames = PChar->m_unlockedAttachments.frames;
    for (int i = 0; i < 12; ++i)
    {
        packet.Attachments[i] = PChar->getAutomatonAttachment(i);
    }

    for (int i = 0; i < 8; ++i)
    {
        packet.UnlockedAttachments[i] = PChar->m_unlockedAttachments.attachments[i];
    }

    std::memcpy(packet.Name, PChar->automatonInfo_.automatonName.c_str(), std::min(PChar->automatonInfo_.automatonName.size(), sizeof(packet.Name)));

    if (PAutomaton)
    {
        packet.HP    = PAutomaton->health.hp == 0 ? PAutomaton->GetMaxHP() : PAutomaton->health.hp;
        packet.MaxHP = PAutomaton->GetMaxHP();
        packet.MP    = PAutomaton->health.mp;
        packet.MaxMP = PAutomaton->GetMaxMP();
    }
    else
    {
        packet.HP    = PChar->automatonInfo_.automatonHealth.maxhp;
        packet.MaxHP = PChar->automatonInfo_.automatonHealth.maxhp;
        packet.MP    = PChar->automatonInfo_.automatonHealth.maxmp;
        packet.MaxMP = PChar->automatonInfo_.automatonHealth.maxmp;
    }

    const int32  meritbonus = PChar->PMeritPoints->GetMeritValue(MERIT_AUTOMATON_SKILLS, PChar);
    const uint16 ameCap     = puppetutils::getSkillCap(PChar, SKILL_AUTOMATON_MELEE, jobLevel);
    const uint16 ameBonus   = PChar->getMod(Mod::AUTO_MELEE_SKILL) + meritbonus;
    const uint16 araCap     = puppetutils::getSkillCap(PChar, SKILL_AUTOMATON_RANGED, jobLevel);
    const uint16 araBonus   = PChar->getMod(Mod::AUTO_RANGED_SKILL) + meritbonus;
    const uint16 amaCap     = puppetutils::getSkillCap(PChar, SKILL_AUTOMATON_MAGIC, jobLevel);
    const uint16 amaBonus   = PChar->getMod(Mod::AUTO_MAGIC_SKILL) + meritbonus;

    packet.MeleeSkill     = std::min(ameCap, PChar->GetSkill(SKILL_AUTOMATON_MELEE)) + ameBonus;
    packet.MeleeSkillCap  = ameCap + ameBonus;
    packet.RangedSkill    = std::min(araCap, PChar->GetSkill(SKILL_AUTOMATON_RANGED)) + araBonus;
    packet.RangedSkillCap = araCap + araBonus;
    packet.MagicSkill     = std::min(amaCap, PChar->GetSkill(SKILL_AUTOMATON_MAGIC)) + amaBonus;
    packet.MagicSkillCap  = amaCap + amaBonus;

    if (puppetutils::getSkillCap(PChar, SKILL_AUTOMATON_MAGIC, jobLevel) == 0)
    {
        packet.MagicSkill    = amaBonus;
        packet.MagicSkillCap = amaBonus;
    }

    if (puppetutils::getSkillCap(PChar, SKILL_AUTOMATON_RANGED, jobLevel) == 0)
    {
        packet.RangedSkill    = araBonus;
        packet.RangedSkillCap = araBonus;
    }

    if (PAutomaton)
    {
        packet.STR      = PAutomaton->stats.STR;
        packet.BonusSTR = PAutomaton->getMod(Mod::STR);
        packet.DEX      = PAutomaton->stats.DEX;
        packet.BonusDEX = PAutomaton->getMod(Mod::DEX);
        packet.VIT      = PAutomaton->stats.VIT;
        packet.BonusVIT = PAutomaton->getMod(Mod::VIT);
        packet.AGI      = PAutomaton->stats.AGI;
        packet.BonusAGI = PAutomaton->getMod(Mod::AGI);
        packet.INT      = PAutomaton->stats.INT;
        packet.BonusINT = PAutomaton->getMod(Mod::INT);
        packet.MND      = PAutomaton->stats.MND;
        packet.BonusMND = PAutomaton->getMod(Mod::MND);
        packet.CHR      = PAutomaton->stats.CHR;
        packet.BonusCHR = PAutomaton->getMod(Mod::CHR);
    }
    else
    {
        packet.STR = PChar->automatonInfo_.automatonStats.STR;
        packet.DEX = PChar->automatonInfo_.automatonStats.DEX;
        packet.VIT = PChar->automatonInfo_.automatonStats.VIT;
        packet.AGI = PChar->automatonInfo_.automatonStats.AGI;
        packet.INT = PChar->automatonInfo_.automatonStats.INT;
        packet.MND = PChar->automatonInfo_.automatonStats.MND;
        packet.CHR = PChar->automatonInfo_.automatonStats.CHR;
    }

    packet.BonusElementalCapacity = PChar->getMod(Mod::AUTO_ELEM_CAPACITY);
}
