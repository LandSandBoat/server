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

#include "0x09b_chocobo_race_req.h"

#include "entities/charentity.h"
#include "packets/basic.h"

auto GP_CLI_COMMAND_CHOCOBO_RACE_REQ::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_CHOCOBO_RACE_REQ_PARAM>(Param)
        .oneOf<GP_CLI_COMMAND_CHOCOBO_RACE_REQ_KIND>(Kind);
}

void GP_CLI_COMMAND_CHOCOBO_RACE_REQ::process(MapSession* PSession, CCharEntity* PChar) const
{
    ShowDebugFmt("GP_CLI_COMMAND_CHOCOBO_RACE_REQ: Not fully implemented. Param: {}, Kind: {}", Param, Kind);

    // NOTE: Can trigger with !cs 335 from Chocobo Circuit

    switch (static_cast<GP_CLI_COMMAND_CHOCOBO_RACE_REQ_KIND>(Kind))
    {
        case GP_CLI_COMMAND_CHOCOBO_RACE_REQ_KIND::Toteboard:
        {
            auto packet = std::make_unique<CBasicPacket>();
            packet->setType(0x73);
            packet->setSize(0x48);

            packet->ref<uint8>(0x04) = 0x01;

            // Lots of look data, maybe?
            packet->ref<uint32>(0x08) = 0x003B4879;
            packet->ref<uint32>(0x10) = 0x00B1C350;
            // etc.

            PChar->pushPacket(std::move(packet));
        }
        break;
        case GP_CLI_COMMAND_CHOCOBO_RACE_REQ_KIND::ChocoboList:
        {
            // Send Chocobo Race Data (4x 0x074)
            for (int idx = 0x01; idx <= 0x04; ++idx)
            {
                auto packet = std::make_unique<CBasicPacket>();
                packet->setType(0x74);
                packet->setSize(0xB3);

                packet->ref<uint8>(0x03) = 0x04;
                packet->ref<uint8>(0x04) = 0x03;

                packet->ref<uint8>(0x10) = idx;

                switch (idx)
                {
                    /*
                    [2023-11-13 12:33:14] Incoming packet 0x074:
                            |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
                        -----------------------------------------------------  ----------------------
                        0 | 74 5A 98 04 03 00 00 00 00 00 00 00 00 00 00 00    0 | tZ..............
                        1 | 01 00 08 00 28 00 00 00 03 00 00 C0 00 00 00 00    1 | ....(...........
                        2 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    2 | ................
                        3 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    3 | ................
                        4 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    4 | ................
                        5 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    5 | ................
                        6 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    6 | ................
                        7 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    7 | ................
                        8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
                        9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
                        A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
                        B | 00 00 00 00 -- -- -- -- -- -- -- -- -- -- -- --    B | ....------------
                    */
                    case 0x01:
                    {
                        packet->ref<uint8>(0x12) = 0x08;
                        packet->ref<uint8>(0x14) = 0x28; // Seen also as 0xC8
                        packet->ref<uint8>(0x18) = 0x03; // Seen also as 0x01
                        packet->ref<uint8>(0x1B) = 0xC0;
                        break;
                    }
                    /*
                    [2023-11-13 12:33:14] Incoming packet 0x074:
                            |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
                        -----------------------------------------------------  ----------------------
                        0 | 74 5A 98 04 03 00 00 00 00 00 00 00 00 00 00 00    0 | tZ..............
                        1 | 02 00 60 00 30 00 00 00 FF FF 00 00 00 02 24 13    1 | ..`.0.........$.
                        2 | 62 00 00 00 FF FF 40 40 00 82 02 15 41 00 00 00    2 | b.....@@....A...
                        3 | E0 C0 60 80 00 02 20 26 21 00 00 00 C0 80 C0 80    3 | ..`... &!.......
                        4 | 00 00 24 10 12 00 00 00 FF FF 80 00 00 02 40 10    4 | ..$...........@.
                        5 | 51 00 00 00 80 60 E0 C0 00 08 08 10 30 00 00 00    5 | Q....`......0...
                        6 | FF FF 00 00 00 0C 02 11 62 00 00 00 FF FF 40 40    6 | ........b.....@@
                        7 | 00 C6 20 22 00 00 00 00 00 00 00 00 00 00 00 00    7 | .. "............
                        8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
                        9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
                        A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
                        B | 00 00 00 00 -- -- -- -- -- -- -- -- -- -- -- --    B | ....------------
                    */
                    case 0x02:
                    {
                        // Stat and other data starting at 0x12
                        packet->ref<uint8>(0x04) = 0x01;
                        packet->ref<uint8>(0x14) = 0x12;

                        packet->ref<uint32>(0x18) = 0x0080FFFF;
                        packet->ref<uint32>(0x1C) = 0x13000A00;

                        break;
                    }
                    /*
                    [2023-11-13 12:33:14] Incoming packet 0x074:
                            |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
                        -----------------------------------------------------  ----------------------
                        0 | 74 5A 98 04 03 00 00 00 00 00 00 00 00 00 00 00    0 | tZ..............
                        1 | 03 00 A0 00 00 00 00 00 49 72 69 73 00 00 00 00    1 | ........Iris....
                        2 | 00 00 00 00 00 00 00 00 00 00 00 00 53 61 64 64    2 | ............Sadd
                        3 | 6C 65 00 00 00 00 00 00 00 00 00 00 00 00 00 00    3 | le..............
                        4 | 43 79 63 6C 6F 6E 65 00 00 00 00 00 00 00 00 00    4 | Cyclone.........
                        5 | 00 00 00 00 50 72 69 6E 74 65 6D 70 73 00 00 00    5 | ....Printemps...
                        6 | 00 00 00 00 00 00 00 00 54 72 69 73 74 61 6E 00    6 | ........Tristan.
                        7 | 00 00 00 00 00 00 00 00 00 00 00 00 4F 75 74 6C    7 | ............Outl
                        8 | 61 77 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | aw..............
                        9 | 48 75 72 72 69 63 61 6E 65 00 00 00 00 00 00 00    9 | Hurricane.......
                        A | 00 00 00 00 52 61 67 69 6E 67 00 00 00 00 00 00    A | ....Raging......
                        B | 00 00 00 00 -- -- -- -- -- -- -- -- -- -- -- --    B | ....------------
                    */
                    case 0x03:
                    {
                        // Name Data starting at 0x18
                        break;
                    }
                    /*
                    [2023-11-13 12:33:15] Incoming packet 0x074:
                            |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
                        -----------------------------------------------------  ----------------------
                        0 | 74 5A 99 04 03 00 00 00 00 00 00 00 00 00 00 00    0 | tZ..............
                        1 | 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    1 | ................
                        2 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    2 | ................
                        3 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    3 | ................
                        4 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    4 | ................
                        5 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    5 | ................
                        6 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    6 | ................
                        7 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    7 | ................
                        8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
                        9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
                        A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
                        B | 00 00 00 00 -- -- -- -- -- -- -- -- -- -- -- --    B | ....------------
                    */
                    case 0x04:
                    {
                        packet->ref<uint8>(0x04) = 0x9B;
                        packet->ref<uint8>(0x05) = 0x60;
                        packet->ref<uint8>(0x06) = 0x04;
                        packet->ref<uint8>(0x07) = 0x01;
                        packet->ref<uint8>(0x08) = 0x9B;
                        packet->ref<uint8>(0x30) = 0x01;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }

                PChar->pushPacket(std::move(packet));
            }
        }
        break;
    }
}
