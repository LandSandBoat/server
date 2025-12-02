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

#include "0x05d_motion.h"

#include "entities/charentity.h"
#include "items.h"
#include "lua/luautils.h"
#include "packets/s2c/0x029_battle_message.h"
#include "packets/s2c/0x05a_motionmes.h"
#include "utils/jailutils.h"

namespace
{

const std::set validBells = {
    DREAM_BELL,
    DREAM_BELL_P1,
    LADY_BELL,
    LADY_BELL_P1,
};

} // namespace

auto GP_CLI_COMMAND_MOTION::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<EmoteMode>(Mode)
        .range("Number", Number, Emote::Point, Emote::Aim);
}

void GP_CLI_COMMAND_MOTION::process(MapSession* PSession, CCharEntity* PChar) const
{
    if (jailutils::InPrison(PChar))
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
        return;
    }

    // Attempting to use bell emote without a bell.
    if (static_cast<Emote>(Number) == Emote::Bell)
    {
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

        if (!validBells.contains(static_cast<ITEMID>(mainWeapon)))
        {
            return;
        }

        if (Param < 0x06 || Param > 0x1e)
        {
            // Invalid note.
            return;
        }
    }
    // Attempting to use locked job emote.
    else if (static_cast<Emote>(Number) == Emote::Job && Param && !(PChar->jobs.unlocked & (1 << (Param - 0x1E))))
    {
        return;
    }

    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<GP_SERV_COMMAND_MOTIONMES>(PChar, UniqueNo, ActIndex, static_cast<Emote>(Number), static_cast<EmoteMode>(Mode), Param));

    luautils::OnPlayerEmote(PChar, static_cast<Emote>(Number));
}
