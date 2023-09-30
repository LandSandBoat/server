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

namespace
{
    uint8 JOB_MON = 23;
} // namespace

CCharJobExtraPacket::CCharJobExtraPacket(CCharEntity* PChar, bool mjob)
{
    this->setType(0x44);
    this->setSize(0xA0);

    uint8 job = JOB_NON;

    if (mjob)
    {
        job = PChar->GetMJob();
    }
    else
    {
        job = PChar->GetSJob();
    }

    if (PChar->loc.zone->GetID() == ZONE_FERETORY && PChar->m_PMonstrosity != nullptr)
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
        memcpy(data + (0x08), &PChar->m_SetBlueSpells, 20);
    }
    else if (job == JOB_PUP && PChar->PAutomaton != nullptr)
    {
        ref<uint8>(0x08) = PChar->PAutomaton->getHead();
        ref<uint8>(0x09) = PChar->PAutomaton->getFrame();
        ref<uint8>(0x0A) = PChar->PAutomaton->getAttachment(0);
        ref<uint8>(0x0B) = PChar->PAutomaton->getAttachment(1);
        ref<uint8>(0x0C) = PChar->PAutomaton->getAttachment(2);
        ref<uint8>(0x0D) = PChar->PAutomaton->getAttachment(3);
        ref<uint8>(0x0E) = PChar->PAutomaton->getAttachment(4);
        ref<uint8>(0x0F) = PChar->PAutomaton->getAttachment(5);
        ref<uint8>(0x10) = PChar->PAutomaton->getAttachment(6);
        ref<uint8>(0x11) = PChar->PAutomaton->getAttachment(7);
        ref<uint8>(0x12) = PChar->PAutomaton->getAttachment(8);
        ref<uint8>(0x13) = PChar->PAutomaton->getAttachment(9);
        ref<uint8>(0x14) = PChar->PAutomaton->getAttachment(10);
        ref<uint8>(0x15) = PChar->PAutomaton->getAttachment(11);

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

        memcpy(data + (0x58), PChar->PAutomaton->GetName().c_str(), PChar->PAutomaton->GetName().size());

        ref<uint16>(0x68) = PChar->PAutomaton->health.hp == 0 ? PChar->PAutomaton->GetMaxHP() : PChar->PAutomaton->health.hp;
        ref<uint16>(0x6A) = PChar->PAutomaton->GetMaxHP();
        ref<uint16>(0x6C) = PChar->PAutomaton->health.mp;
        ref<uint16>(0x6E) = PChar->PAutomaton->GetMaxMP();

        // TODO: this is a lot of calculations that could be avoided if these were properly initialized in the Automaton when first loading your character
        int32  meritbonus = PChar->PMeritPoints->GetMeritValue(MERIT_AUTOMATON_SKILLS, PChar);
        uint16 ameCap     = puppetutils::getSkillCap(PChar, SKILL_AUTOMATON_MELEE);
        uint16 ameBonus   = PChar->getMod(Mod::AUTO_MELEE_SKILL) + meritbonus;
        ref<uint16>(0x70) = std::min(ameCap, PChar->GetSkill(SKILL_AUTOMATON_MELEE)) + ameBonus;
        ref<uint16>(0x72) = ameCap + ameBonus;

        uint16 araCap     = puppetutils::getSkillCap(PChar, SKILL_AUTOMATON_RANGED);
        uint16 araBonus   = PChar->getMod(Mod::AUTO_RANGED_SKILL) + meritbonus;
        ref<uint16>(0x74) = std::min(araCap, PChar->GetSkill(SKILL_AUTOMATON_RANGED)) + araBonus;
        ref<uint16>(0x76) = araCap + araBonus;

        uint16 amaCap     = puppetutils::getSkillCap(PChar, SKILL_AUTOMATON_MAGIC);
        uint16 amaBonus   = PChar->getMod(Mod::AUTO_MAGIC_SKILL) + meritbonus;
        ref<uint16>(0x78) = std::min(amaCap, PChar->GetSkill(SKILL_AUTOMATON_MAGIC)) + amaBonus;
        ref<uint16>(0x7A) = amaCap + amaBonus;

        ref<uint16>(0x80) = PChar->PAutomaton->stats.STR;
        ref<uint16>(0x82) = PChar->PAutomaton->getMod(Mod::STR);
        ref<uint16>(0x84) = PChar->PAutomaton->stats.DEX;
        ref<uint16>(0x86) = PChar->PAutomaton->getMod(Mod::DEX);
        ref<uint16>(0x88) = PChar->PAutomaton->stats.VIT;
        ref<uint16>(0x8A) = PChar->PAutomaton->getMod(Mod::VIT);
        ref<uint16>(0x8C) = PChar->PAutomaton->stats.AGI;
        ref<uint16>(0x8E) = PChar->PAutomaton->getMod(Mod::AGI);
        ref<uint16>(0x90) = PChar->PAutomaton->stats.INT;
        ref<uint16>(0x92) = PChar->PAutomaton->getMod(Mod::INT);
        ref<uint16>(0x94) = PChar->PAutomaton->stats.MND;
        ref<uint16>(0x96) = PChar->PAutomaton->getMod(Mod::MND);
        ref<uint16>(0x98) = PChar->PAutomaton->stats.CHR;
        ref<uint16>(0x9A) = PChar->PAutomaton->getMod(Mod::CHR);

        ref<uint8>(0x9C) = PChar->getMod(Mod::AUTO_ELEM_CAPACITY);
    }
    else if (job == JOB_MON && PChar->loc.zone->GetID() == ZONE_FERETORY && PChar->m_PMonstrosity != nullptr)
    {
        /*
             |  0  1  2  3   4  5  6  7   8  9  A  B   C  D  E  F    | 0123456789ABCDEF
        -----+----------------------------------------------------  -+------------------
           0 | 44 50 55 01  17 00 00 00  FD 01 00 FF  FA 02 05 03    | DPU.............
          10 | 07 03 09 03  00 00 00 00  00 00 00 00  00 00 00 00    | ................
          20 | 00 00 00 00  09 7D 08 00  28 04 64 02  33 00 64 20    | .....}..(.d.3.d
          30 | 00 6C FB 38  00 00 20 00  00 00 00 00  20 A0 03 00    | .l.8.. ..... ...
          40 | 4C DC E3 28  00 00 00 00  00 00 00 00  00 00 00 00    | L..(............
          50 | 00 00 00 00  FD 81 09 7D  00 06 00 00  7B 00 00 00    | .......}....{...
          60 | 00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00    | ................
          70 | 00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00    | ................
          80 | 00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00    | ................
          90 | 00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00    | ................
        */

        ref<uint16>(0x08) = PChar->m_PMonstrosity->Species;

        for (std::size_t idx = 0; idx < 12; ++idx)
        {
            ref<uint8>(0x0C + (idx * 2)) = PChar->m_PMonstrosity->EquippedInstincts[idx];
        }

        /*
        ref<uint8>(0x0C) = 0x00;
        ref<uint8>(0x0D) = 0x03;
        ref<uint8>(0x0E) = 0x00;
        ref<uint8>(0x0F) = 0x03;


        ref<uint8>(0x10) = 0x07;
        ref<uint8>(0x11) = 0x03;
        ref<uint8>(0x12) = 0x09;
        ref<uint8>(0x13) = 0x03;
        ref<uint8>(0x14) = 0x00;
        ref<uint8>(0x15) = 0x00;
        ref<uint8>(0x16) = 0x00;
        ref<uint8>(0x17) = 0x00;
        ref<uint8>(0x18) = 0x00;
        ref<uint8>(0x19) = 0x00;
        ref<uint8>(0x1A) = 0x00;
        ref<uint8>(0x1B) = 0x00;
        ref<uint8>(0x1C) = 0x00;
        ref<uint8>(0x1D) = 0x00;
        ref<uint8>(0x1E) = 0x00;
        ref<uint8>(0x1F) = 0x00;

        ref<uint8>(0x20) = 0x00;
        ref<uint8>(0x21) = 0x00;
        ref<uint8>(0x22) = 0x00;
        ref<uint8>(0x23) = 0x00;
        ref<uint8>(0x24) = 0x09;
        ref<uint8>(0x25) = 0x7D;
        ref<uint8>(0x26) = 0x08;
        ref<uint8>(0x27) = 0x00;
        ref<uint8>(0x28) = 0x28;
        ref<uint8>(0x29) = 0x04;
        ref<uint8>(0x2A) = 0x64;
        ref<uint8>(0x2B) = 0x02;
        ref<uint8>(0x2C) = 0x33;
        ref<uint8>(0x2D) = 0x00;
        ref<uint8>(0x2E) = 0x64;
        ref<uint8>(0x2F) = 0x20;

        ref<uint8>(0x30) = 0x00;
        ref<uint8>(0x31) = 0x6C;
        ref<uint8>(0x32) = 0xFB;
        ref<uint8>(0x33) = 0x38;
        ref<uint8>(0x34) = 0x00;
        ref<uint8>(0x35) = 0x00;
        ref<uint8>(0x36) = 0x20;
        ref<uint8>(0x37) = 0x00;
        ref<uint8>(0x38) = 0x00;
        ref<uint8>(0x39) = 0x00;
        ref<uint8>(0x3A) = 0x00;
        ref<uint8>(0x3B) = 0x00;
        ref<uint8>(0x3C) = 0x20;
        ref<uint8>(0x3D) = 0xA0;
        ref<uint8>(0x3E) = 0x03;
        ref<uint8>(0x3F) = 0x00;

        ref<uint8>(0x40) = 0x4C;
        ref<uint8>(0x41) = 0xDC;
        ref<uint8>(0x42) = 0xE3;
        ref<uint8>(0x43) = 0x28;
        ref<uint8>(0x44) = 0x00;
        ref<uint8>(0x45) = 0x00;
        ref<uint8>(0x46) = 0x00;
        ref<uint8>(0x47) = 0x00;
        ref<uint8>(0x48) = 0x00;
        ref<uint8>(0x49) = 0x00;
        ref<uint8>(0x4A) = 0x00;
        ref<uint8>(0x4B) = 0x00;
        ref<uint8>(0x4C) = 0x00;
        ref<uint8>(0x4D) = 0x00;
        ref<uint8>(0x4E) = 0x00;
        ref<uint8>(0x4F) = 0x00;

        ref<uint8>(0x50) = 0x00;
        ref<uint8>(0x51) = 0x00;
        ref<uint8>(0x52) = 0x00;
        ref<uint8>(0x53) = 0x00;
        ref<uint8>(0x54) = 0xFD;
        ref<uint8>(0x55) = 0x81;
        ref<uint8>(0x56) = 0x09;
        ref<uint8>(0x57) = 0x7D;
        ref<uint8>(0x58) = 0x00;
        ref<uint8>(0x59) = 0x06;
        ref<uint8>(0x5A) = 0x00;
        ref<uint8>(0x5B) = 0x00;
        ref<uint8>(0x5C) = 0x7B;
        ref<uint8>(0x5D) = 0x00;
        ref<uint8>(0x5E) = 0x00;
        ref<uint8>(0x5F) = 0x00;

        // Random things from other packet caps
        ref<uint8>(0x6C) = 0x01;
        ref<uint8>(0x6E) = 0x01;
        ref<uint8>(0x77) = 0x01;
        ref<uint8>(0x87) = 0x24;
        ref<uint8>(0x8A) = 0x28;
        ref<uint8>(0x96) = 0x19;
        */
    }
}
