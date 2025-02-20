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

#include "fishing.h"

/* OLD FISHING PACKET - Used for old fishing minigame. Requires setting animation to 50 at fishing start and 38 when you receive a bite. Seems to still work but
   breaks client's target info after fishing this->type = 0x81; this->size = 0x0C;

    unsigned char packet[] =
    {
                                0x90, 0x27, 0x07, 0x80, 0x0e, 0x11, 0x08, 0x14, 0x00, 0x69, 0x74, 0x73,
        0x4b, 0x00, 0x00, 0x00, 0x97, 0x00, 0x00, 0x00
    };

    std::memcpy(buffer_.data()+4, &packet, 20);

    ref<uint16>(data, (0x04)) = stamina;
    ref<uint8>(data, (0x06)) = id3;
    ref<uint8>(data, (0x07)) = regen;
    ref<uint8>(data, (0x08)) = id1;
    ref<uint8>(data, (0x09)) = id2;
    ref<uint8>(data, (0x0A)) = id4;
    ref<uint8>(data, (0x0B)) = time;
        // "Unknown, can be 0x00 or 0x01 but most likely has to do how fast the rod moves around"
    ref<uint8>(data, (0x0C)) = unknown1;
        // something to do with stamina
    ref<uint8>(data, (0x10)) = unknown2;
*/

// New Fishing Packet: Mini-Game Data.

CFishingPacket::CFishingPacket(uint16 stamina, uint16 regen, uint16 response, uint16 hitDmg, uint16 arrowDelay, uint16 missRegen, uint16 gameTime, uint8 sense,
                               uint32 special)
{
    this->setType(0x115);
    this->setSize(0x1A);

    ref<uint16>(0x04) = stamina;    // fish HP, generally in thousands - (100 + x)(floor(fishLvl / 2) + 18)
    ref<uint16>(0x06) = arrowDelay; // how long you have to hit the arrows, generally low 10s, max 15? Increased by 2 by Penguin Ring
    ref<uint16>(0x08) = regen;      // how much stamina fish regains/loses per frame.  base 128 -drain +regen - reduced by same factor of 'x' affected by: advanced
                                    // support, apron/smock, ebisu rod
    ref<uint16>(0x0A) = response;   // fish movement, how active the fish is moving left to right (multiples of 20) - Increased by 2 by Penguin Ring
    ref<uint16>(0x0C) = hitDmg;     // fish attack, how much damage is caused to fishes stamina from successful arrows -  Value only changes with fishing rods
                                    // (decreasing with improved rods)
    ref<uint16>(0x0E) = missRegen;  // fish heal, how much stamina fish heals from wrong arrow press - Value changes with fishing rods, but also changes with an
                                    // "angler's discernment" proc, as well as Heron Ring. On angler's discernment proc, this value is decreased by 30%. If Heron
                                    // Ring is equipped with fishing support in effect, this value also decreases (investigating on decrease amount, seems like
                                    // 10% decrease rounded to nearest 10 or 20 if not integer result).
    ref<uint16>(0x10) = gameTime;   // how long you have to reel the fish in (base 60s)
    ref<uint8>(0x12) =
        sense;                   // 0 = small fish/item, 1 = large fish/monster (battle music), 2 = small fish/item (lightbulb), 3 = large fish/monster (lightbulb + fight music)
    ref<uint32>(0x14) = special; // value will be returned in 0x110 on catch (LSB represents % chance of getting gold arrows while fishing) - value increases on
                                 // use of "Duck ring" or on angler's discernment proc, both of which increase chance of gold arrows
}
