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

#include "0x102_extended_job.h"

#include "blue_spell.h"
#include "entities/charentity.h"
#include "packets/s2c/0x061_clistatus.h"
#include "packets/s2c/0x0ac_command_data.h"
#include "recast_container.h"
#include "utils/blueutils.h"
#include "utils/charutils.h"
#include "utils/petutils.h"
#include "utils/puppetutils.h"

auto GP_CLI_COMMAND_EXTENDED_JOB::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    auto pv = PacketValidator();

    // Packet is used for 3 different systems. Validation differs based on the job.
    if ((PChar->GetMJob() == JOB_BLU || PChar->GetSJob() == JOB_BLU) && Data.bluData.JobIndex == JOB_BLU)
    {
        // Case 1: Blue Mage spells
        // TODO: Check if they own the spell they are trying to equip.
    }
    else if (((PChar->GetMJob() == JOB_PUP || PChar->GetSJob() == JOB_PUP) && Data.pupData.JobIndex == JOB_PUP))
    {
        // Case 2: Puppetmaster attachments
        pv.mustEqual(dynamic_cast<CAutomatonEntity*>(PChar->PPet), nullptr, "Player has a deployed automaton.");
        // TODO: Check if they own the attachments they are trying to equip.
    }
    else if (PChar->loc.zone->GetID() == ZONE_FERETORY && PChar->m_PMonstrosity != nullptr)
    {
        // Case 3: Monstrosity equipment change
        if (Data.monData.Flags0.SpeciesFlag)
        {
            // Player requesting a species change
            // TODO: Capture actual accepted IDs in a vector in a namespace
            pv.range("SpeciesIndex", Data.monData.SpeciesIndex, 1, 511);
        }

        if (Data.monData.Flags0.InstinctFlag)
        {
            // Player requesting an instinct change
            for (std::size_t idx = 0; idx < 12; ++idx)
            {
                // Ignore instincts being unequipped or unset
                if (Data.monData.Slots[idx] != 0xFFFF && Data.monData.Slots[idx] != 0x0)
                {
                    // TODO: Capture actual range in a vector in a namespace
                    pv.range("Slots", Data.monData.Slots[idx], 3, 799);
                }
            }
        }

        if (Data.monData.Flags0.Descriptor1Flag)
        {
            // 0 to unset. Last entry has ID 248.
            pv.range("Descriptor1Index", Data.monData.Descriptor1Index, 0, 248);
        }

        if (Data.monData.Flags0.Descriptor2Flag)
        {
            // 0 to unset. Last entry has ID 248.
            pv.range("Descriptor2Index", Data.monData.Descriptor2Index, 0, 248);
        }
    }
    else
    {
        return PacketValidationResult().addError("Did not match any of the extended job system.");
    }

    return pv;
}

void GP_CLI_COMMAND_EXTENDED_JOB::process(MapSession* PSession, CCharEntity* PChar) const
{
    if ((PChar->GetMJob() == JOB_BLU || PChar->GetSJob() == JOB_BLU) && Data.bluData.JobIndex == JOB_BLU)
    {
        const auto bluData = Data.bluData;

        // This may be a request to add or remove set spells, so lets check.

        const uint8 spellToAdd      = bluData.SpellId; // this is non-zero if client wants to add.
        uint8       spellInQuestion = 0;
        int8        spellIndex      = -1;

        if (spellToAdd == 0x00)
        {
            for (uint8 i = 0; i < sizeof(bluData.Spells); i++)
            {
                if (bluData.Spells[i] > 0)
                {
                    spellInQuestion = bluData.Spells[i];
                    spellIndex      = i;
                    auto* spell     = static_cast<CBlueSpell*>(spell::GetSpell(
                        static_cast<SpellID>(spellInQuestion + 0x200))); // the spells in this packet are offsetted by 0x200 from their spell IDs.

                    if (spell != nullptr)
                    {
                        if (PChar->m_SetBlueSpells[spellIndex] == 0x00)
                        {
                            ShowWarning("GP_CLI_COMMAND_EXTENDED_JOB: Player %s trying to unset BLU spell they don't have set!", PChar->getName());
                            return;
                        }
                        else
                        {
                            blueutils::SetBlueSpell(PChar, spell, spellIndex, false);
                        }
                    }
                    else
                    {
                        ShowDebug("GP_CLI_COMMAND_EXTENDED_JOB: Cannot resolve spell id %u ", spellInQuestion);
                        return;
                    }
                }
            }

            charutils::BuildingCharTraitsTable(PChar);
            PChar->pushPacket<GP_SERV_COMMAND_COMMAND_DATA>(PChar);
            charutils::SendExtendedJobPackets(PChar);
            PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS>(PChar);
            PChar->UpdateHealth();
        }
        else
        {
            // loop all 20 slots and find which index they are playing with
            for (uint8 i = 0; i < sizeof(bluData.Spells); i++)
            {
                if (bluData.Spells[i] > 0)
                {
                    spellInQuestion = bluData.Spells[i];
                    spellIndex      = i;
                    break;
                }
            }

            if (spellIndex != -1 && spellInQuestion != 0)
            {
                CBlueSpell* spell = static_cast<CBlueSpell*>(spell::GetSpell(
                    static_cast<SpellID>(spellInQuestion + 0x200))); // the spells in this packet are offsetted by 0x200 from their spell IDs.

                if (spell != nullptr)
                {
                    const uint8 mLevel = PChar->m_LevelRestriction != 0 && PChar->m_LevelRestriction < PChar->GetMLevel() ? PChar->m_LevelRestriction : PChar->GetMLevel();
                    const uint8 sLevel = floor(mLevel / 2);

                    if (mLevel < spell->getJob(PChar->GetMJob()) && sLevel < spell->getJob(PChar->GetSJob()))
                    {
                        ShowWarning("GP_CLI_COMMAND_EXTENDED_JOB: Player %s trying to set BLU spell at invalid level!", PChar->getName());
                        return;
                    }

                    blueutils::SetBlueSpell(PChar, spell, spellIndex, true);
                    charutils::BuildingCharTraitsTable(PChar);
                    PChar->pushPacket<GP_SERV_COMMAND_COMMAND_DATA>(PChar);
                    charutils::SendExtendedJobPackets(PChar);
                    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS>(PChar);
                    PChar->UpdateHealth();
                }
                else
                {
                    ShowDebug("GP_CLI_COMMAND_EXTENDED_JOB: Cannot resolve spell id %u ", spellInQuestion);
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
                const auto spellId = static_cast<SpellID>(PChar->m_SetBlueSpells[i] + 0x200);
                auto*      PSpell  = spell::GetSpell(spellId);
                if (auto* PBlueSpell = dynamic_cast<CBlueSpell*>(PSpell))
                {
                    PChar->PRecastContainer->Add(RECAST_MAGIC, static_cast<Recast>(PBlueSpell->getID()), 60s);
                }
            }
        }
    }
    else if ((PChar->GetMJob() == JOB_PUP || PChar->GetSJob() == JOB_PUP) && Data.pupData.JobIndex == JOB_PUP)
    {
        const auto pupData = Data.pupData;

        if (pupData.ItemId == 0x00)
        {
            // remove all attachments specified
            for (uint8 i = 0; i < sizeof(pupData.Slots); i++)
            {
                if (pupData.Slots[i] != 0)
                {
                    // Minus 2 since the first two slots in packet are reserved for head and frame.
                    puppetutils::setAttachment(PChar, i - 2, 0x00);
                }
            }
        }
        else
        {
            if (pupData.Slots[static_cast<uint8_t>(AutomatonSlot::Head)] != 0)
            {
                puppetutils::setHead(PChar, pupData.Slots[static_cast<uint8_t>(AutomatonSlot::Head)]);
                petutils::CalculateAutomatonStats(PChar, PChar->PPet);
            }
            else if (pupData.Slots[static_cast<uint8_t>(AutomatonSlot::Frame)] != 0)
            {
                puppetutils::setFrame(PChar, pupData.Slots[static_cast<uint8_t>(AutomatonSlot::Frame)]);
                petutils::CalculateAutomatonStats(PChar, PChar->PPet);
            }
            else
            {
                for (uint8 i = 0; i < sizeof(pupData.Slots); i++)
                {
                    if (pupData.Slots[i] != 0)
                    {
                        // Minus 2 since the first two slots in packet are reserved for head and frame.
                        puppetutils::setAttachment(PChar, i - 2, pupData.Slots[i]);
                    }
                }
            }
        }

        charutils::SendExtendedJobPackets(PChar);
        puppetutils::SaveAutomaton(PChar);
    }
    else if (PChar->loc.zone->GetID() == ZONE_FERETORY && PChar->m_PMonstrosity != nullptr)
    {
        monstrosity::HandleEquipChangePacket(PChar, Data.monData);
    }
}
