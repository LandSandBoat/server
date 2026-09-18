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

#include "data/enums/key_item.h"
#include "utils/charutils.h"

GP_SERV_COMMAND_EMOTE_LIST::GP_SERV_COMMAND_EMOTE_LIST(const CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.JobEmotes.WAR = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureWarrior);
    packet.JobEmotes.MNK = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureMonk);
    packet.JobEmotes.WHM = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureWhiteMage);
    packet.JobEmotes.BLM = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureBlackMage);
    packet.JobEmotes.RDM = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureRedMage);
    packet.JobEmotes.THF = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureThief);
    packet.JobEmotes.PLD = charutils::hasKeyItem(PChar, xi::KeyItem::JobGesturePaladin);
    packet.JobEmotes.DRK = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureDarkKnight);
    packet.JobEmotes.BST = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureBeastmaster);
    packet.JobEmotes.BRD = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureBard);
    packet.JobEmotes.RNG = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureRanger);
    packet.JobEmotes.SAM = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureSamurai);
    packet.JobEmotes.NIN = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureNinja);
    packet.JobEmotes.DRG = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureDragoon);
    packet.JobEmotes.SMN = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureSummoner);
    packet.JobEmotes.BLU = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureBlueMage);
    packet.JobEmotes.COR = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureCorsair);
    packet.JobEmotes.PUP = charutils::hasKeyItem(PChar, xi::KeyItem::JobGesturePuppetmaster);
    packet.JobEmotes.DNC = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureDancer);
    packet.JobEmotes.SCH = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureScholar);
    packet.JobEmotes.GEO = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureGeomancer);
    packet.JobEmotes.RUN = charutils::hasKeyItem(PChar, xi::KeyItem::JobGestureRuneFencer);

    packet.Chairs.Chair1  = charutils::hasKeyItem(PChar, xi::KeyItem::ImperialChair);
    packet.Chairs.Chair2  = charutils::hasKeyItem(PChar, xi::KeyItem::DecorativeChair);
    packet.Chairs.Chair3  = charutils::hasKeyItem(PChar, xi::KeyItem::OrnateStool);
    packet.Chairs.Chair4  = charutils::hasKeyItem(PChar, xi::KeyItem::RefinedChair);
    packet.Chairs.Chair5  = charutils::hasKeyItem(PChar, xi::KeyItem::PortableContainer);
    packet.Chairs.Chair6  = charutils::hasKeyItem(PChar, xi::KeyItem::ChocoboChair);
    packet.Chairs.Chair7  = charutils::hasKeyItem(PChar, xi::KeyItem::EphramadianThrone);
    packet.Chairs.Chair8  = charutils::hasKeyItem(PChar, xi::KeyItem::ShadowThrone);
    packet.Chairs.Chair9  = charutils::hasKeyItem(PChar, xi::KeyItem::LeafBench);
    packet.Chairs.Chair10 = charutils::hasKeyItem(PChar, xi::KeyItem::AstralCube);
    packet.Chairs.Chair11 = charutils::hasKeyItem(PChar, xi::KeyItem::ChocoboChairIi);
}
