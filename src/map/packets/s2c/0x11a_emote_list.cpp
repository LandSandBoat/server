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

#include "0x11a_emote_list.h"

#include "entities/charentity.h"
#include "enums/key_items.h"
#include "utils/charutils.h"

GP_SERV_COMMAND_EMOTE_LIST::GP_SERV_COMMAND_EMOTE_LIST(const CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.JobEmotes.WAR = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_WARRIOR);
    packet.JobEmotes.MNK = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_MONK);
    packet.JobEmotes.WHM = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_WHITE_MAGE);
    packet.JobEmotes.BLM = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_BLACK_MAGE);
    packet.JobEmotes.RDM = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_RED_MAGE);
    packet.JobEmotes.THF = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_THIEF);
    packet.JobEmotes.PLD = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_PALADIN);
    packet.JobEmotes.DRK = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_DARK_KNIGHT);
    packet.JobEmotes.BST = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_BEASTMASTER);
    packet.JobEmotes.BRD = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_BARD);
    packet.JobEmotes.RNG = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_RANGER);
    packet.JobEmotes.SAM = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_SAMURAI);
    packet.JobEmotes.NIN = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_NINJA);
    packet.JobEmotes.DRG = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_DRAGOON);
    packet.JobEmotes.SMN = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_SUMMONER);
    packet.JobEmotes.BLU = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_BLUE_MAGE);
    packet.JobEmotes.COR = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_CORSAIR);
    packet.JobEmotes.PUP = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_PUPPETMASTER);
    packet.JobEmotes.DNC = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_DANCER);
    packet.JobEmotes.SCH = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_SCHOLAR);
    packet.JobEmotes.GEO = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_GEOMANCER);
    packet.JobEmotes.RUN = charutils::hasKeyItem(PChar, KeyItem::JOB_GESTURE_RUNE_FENCER);

    packet.Chairs.Chair1  = charutils::hasKeyItem(PChar, KeyItem::IMPERIAL_CHAIR);
    packet.Chairs.Chair2  = charutils::hasKeyItem(PChar, KeyItem::DECORATIVE_CHAIR);
    packet.Chairs.Chair3  = charutils::hasKeyItem(PChar, KeyItem::ORNATE_STOOL);
    packet.Chairs.Chair4  = charutils::hasKeyItem(PChar, KeyItem::REFINED_CHAIR);
    packet.Chairs.Chair5  = charutils::hasKeyItem(PChar, KeyItem::PORTABLE_CONTAINER);
    packet.Chairs.Chair6  = charutils::hasKeyItem(PChar, KeyItem::CHOCOBO_CHAIR);
    packet.Chairs.Chair7  = charutils::hasKeyItem(PChar, KeyItem::EPHRAMADIAN_THRONE);
    packet.Chairs.Chair8  = charutils::hasKeyItem(PChar, KeyItem::SHADOW_THRONE);
    packet.Chairs.Chair9  = charutils::hasKeyItem(PChar, KeyItem::LEAF_BENCH);
    packet.Chairs.Chair10 = charutils::hasKeyItem(PChar, KeyItem::ASTRAL_CUBE);
    packet.Chairs.Chair11 = charutils::hasKeyItem(PChar, KeyItem::CHOCOBO_CHAIR_II);
}
