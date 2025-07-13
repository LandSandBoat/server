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

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x000A
// This packet is sent by the client when requesting to log into a zone.
// This is the first packet sent by the client to the world server when beginning its communications.
GP_CLI_PACKET(GP_CLI_COMMAND_LOGIN,
              uint8_t  LoginPacketCheck; // PS2: LoginPacketCheck
              uint8_t  padding00;        // PS2: dam__
              uint16_t unknown00;        // PS2: MyPort
              uint32_t unknown01;        // PS2: MyIP
              uint32_t UniqueNo;         // PS2: UniqueNo
              uint16_t GrapIDTbl[9];     // PS2: GrapIDTbl
              char     sName[15];        // PS2: sName
              char     sAccunt[15];      // PS2: sAccunt
              uint8_t  Ticket[16];       // PS2: Ticket
              uint32_t Ver;              // PS2: Ver
              uint8_t  sPlatform[4];     // PS2: sPlatform
              uint16_t uCliLang;         // PS2: uCliLang
              uint16_t dammyArea;        // PS2: dammyArea
);
