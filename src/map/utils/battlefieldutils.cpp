
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
#include <cstring>

#include "../ai/ai_container.h"
#include "../alliance.h"
#include "../battlefield.h"
#include "../battlefield_handler.h"
#include "../entities/charentity.h"
#include "../entities/mobentity.h"
#include "../packets/entity_update.h"
#include "../party.h"
#include "../treasure_pool.h"
#include "battlefieldutils.h"
#include "charutils.h"
#include "itemutils.h"
#include "mobutils.h"
#include "zoneutils.h"

namespace battlefieldutils
{
    /*************************************************************
    Returns the losing exit position for this BCNM.
    ****************************************************************/
    void getLosePosition(CBattlefield* battlefield, int (&pPosition)[4])
    {
        if (battlefield == nullptr)
        {
            return;
        }

        switch (battlefield->GetZoneID())
        {
            case 139: // Horlais Peak
                pPosition[0] = -503;
                pPosition[1] = 158;
                pPosition[2] = -212;
                pPosition[3] = 131;
                break;
        }
    }

    void getStartPosition(uint16 zoneid, float (&pPosition)[4])
    {
        switch (zoneid)
        {
            case 139: // Horlais Peak
                pPosition[0] = -503;
                pPosition[1] = 158;
                pPosition[2] = -212;
                pPosition[3] = 131;
                break;
            case 144: // Waug. Shrine
                pPosition[0] = -361;
                pPosition[1] = 100;
                pPosition[2] = -260;
                pPosition[3] = 131;
                break;
            case 146: // Balgas Dias
                pPosition[0] = 317;
                pPosition[1] = -126;
                pPosition[2] = 380;
                pPosition[3] = 131;
                break;
            case 165: // Throne Room
                pPosition[0] = 114;
                pPosition[1] = -8;
                pPosition[2] = 0;
                pPosition[3] = 131;
                break;
            case 206: // QuBia Arena
                pPosition[0] = -241;
                pPosition[1] = -26;
                pPosition[2] = 20;
                pPosition[3] = 131;
                break;
        }
    }

    /*************************************************************
    Returns the winning exit position for this BCNM.
    ****************************************************************/
    void getWinPosition(CBattlefield* battlefield, int (&pPosition)[4])
    {
        if (battlefield == nullptr)
        {
            return;
        }

        switch (battlefield->GetZoneID())
        {
            case 139: // Horlais Peak
                pPosition[0] = 445;
                pPosition[1] = -38;
                pPosition[2] = -19;
                pPosition[3] = 200;
                break;
        }
    }
}; // namespace battlefieldutils
