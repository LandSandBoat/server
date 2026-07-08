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

#pragma once

#include "base.h"

enum class GP_CLI_COMMAND_CONFIG_SETFLG : uint8_t
{
    On  = 1,
    Off = 2,
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x00DC
// This packet is sent by the client when changing certain configuration related values or settings.
GP_CLI_PACKET(GP_CLI_COMMAND_CONFIG,
              uint8_t  InviteFlg : 1;           // PS2: InviteFlg
              uint8_t  AwayFlg : 1;             // PS2: AwayFlg
              uint8_t  AnonymityFlg : 1;        // PS2: AnonymityFlg
              uint8_t  Language : 2;            // PS2: Language
              uint8_t  unused05 : 3;            // PS2: GmLevel
              uint8_t  unused08 : 1;            // PS2: InvisFlg
              uint8_t  unused09 : 1;            // PS2: InvulFlg
              uint8_t  unused10 : 1;            // PS2: IgnoreFlg
              uint8_t  unused11 : 2;            // PS2: SysMesFilterLevel
              uint8_t  unused13 : 1;            // PS2: GmNoPrintFlg
              uint8_t  AutoTargetOffFlg : 1;    // PS2: AutoTargetOffFlg
              uint8_t  AutoPartyFlg : 1;        // PS2: AutoPartyFlg
              uint8_t  unused16 : 8;            // PS2: JailNo
              uint8_t  unused24 : 1;            // PS2: (New; previously padding byte.)
              uint8_t  MentorFlg : 1;           // PS2: (New; previously padding byte.)
              uint8_t  NewAdventurerOffFlg : 1; // PS2: (New; previously padding byte.)
              uint8_t  DisplayHeadOffFlg : 1;   // PS2: (New; previously padding byte.)
              uint8_t  unused28 : 1;            // PS2: (New; previously padding byte.)
              uint8_t  RecruitFlg : 1;          // PS2: (New; previously padding byte.)
              uint8_t  unused30 : 2;            // PS2: (New; previously padding byte.)
              uint32_t unused00;                // PS2: (Other misc data.)
              uint32_t unused01;                // PS2: (Other misc data.)
              uint8_t  SetFlg;                  // PS2: SetFlg
              uint8_t  padding00[3];            // PS2: (New; did not exist.)
);
