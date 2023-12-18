/*
===========================================================================

  Copyright (c) 2010-2019 Darkstar Dev Teams

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

#include "anticheat.h"
#include "map.h"
#include "packets/chat_message.h"
#include "utils/charutils.h"
#include "utils/zoneutils.h"
#include "zone.h"

namespace anticheat
{
    // List of jail cell locations
    int32 g_jailCells[][4] = {
        // Floor 1 (Bottom)
        { -620, 11, 660, 0 },
        { -180, 11, 660, 0 },
        { 260, 11, 660, 0 },
        { 700, 11, 660, 0 },
        { -620, 11, 220, 0 },
        { -180, 11, 220, 0 },
        { 260, 11, 220, 0 },
        { 700, 11, 220, 0 },
        { -620, 11, -220, 0 },
        { -180, 11, -220, 0 },
        { 260, 11, -220, 0 },
        { 700, 11, -220, 0 },
        { -620, 11, -620, 0 },
        { -180, 11, -620, 0 },
        { 260, 11, -620, 0 },
        { 700, 11, -620, 0 },

        // Floor 2 (Top)
        { -620, -400, 660, 0 },
        { -180, -400, 660, 0 },
        { 260, -400, 660, 0 },
        { 700, -400, 660, 0 },
        { -620, -400, 220, 0 },
        { -180, -400, 220, 0 },
        { 260, -400, 220, 0 },
        { 700, -400, 220, 0 },
        { -620, -400, -220, 0 },
        { -180, -400, -220, 0 },
        { 260, -400, -220, 0 },
        { 700, -400, -220, 0 },
        { -620, -400, -620, 0 },
        { -180, -400, -620, 0 },
        { 260, -400, -620, 0 },
        { 700, -400, -620, 0 },
    };

    // Action bitmask of the cheat
    CheatAction GetCheatPunitiveAction(CheatID cheatid, char* warningmsg, size_t warningsize)
    {
        const char* fmtQuery = "SELECT action_bitmask, warning_message FROM cheat_types WHERE cheatid = %u";
        int32       ret      = _sql->Query(fmtQuery, static_cast<uint32>(cheatid));

        if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            if (warningmsg != nullptr)
            {
                memset(warningmsg, 0, warningsize);
                char* warnptr = (char*)_sql->GetData(1);
                if (warnptr != nullptr)
                {
                    strncpy(warningmsg, warnptr, warningsize - 1);
                }
            }
            return (CheatAction)_sql->GetUIntData(0);
        }
        return CHEAT_ACTION_NOTHING;
    }

    // Jail character
    bool JailChar(CCharEntity* PChar, uint32 cellid)
    {
        if (PChar == nullptr)
        {
            return false;
        }
        // If given cell id is invalid default to cell #1
        if ((cellid == 0) || (cellid > 32))
        {
            cellid = 1;
        }
        const char* fmtQuery = "INSERT INTO char_vars SET charid = %u, varname = 'inJail', value = %i ON DUPLICATE KEY UPDATE value = %i;";
        _sql->Query(fmtQuery, PChar->id, cellid, cellid);
        PChar->loc.p.x         = (float)g_jailCells[cellid - 1][0];
        PChar->loc.p.y         = (float)g_jailCells[cellid - 1][1];
        PChar->loc.p.z         = (float)g_jailCells[cellid - 1][2];
        PChar->loc.p.rotation  = (uint8)g_jailCells[cellid - 1][3];
        PChar->loc.destination = ZONEID::ZONE_MORDION_GAOL;
        PChar->status          = STATUS_TYPE::DISAPPEAR;
        PChar->loc.boundary    = 0;
        PChar->m_moghouseID    = 0;
        PChar->clearPacketList();
        charutils::SendToZone(PChar, 2, zoneutils::GetZoneIPP(PChar->loc.destination));
        return true;
    }

    // Log and possibly jail
    bool ReportCheatIncident(CCharEntity* PChar, CheatID cheatid, uint32 cheatarg, const char* description)
    {
        if (PChar == nullptr)
        {
            return false;
        }
        if (!settings::get<bool>("map.ANTICHEAT_ENABLED"))
        {
            return false;
        }
        // Check what we should do
        char        warningmsg[256] = { 0 };
        CheatAction action          = GetCheatPunitiveAction(cheatid, warningmsg, sizeof(warningmsg));
        if (action & CHEAT_ACTION_LOG)
        {
            // Log intgo cheat_incidents table
            const char* fmtQuery = "INSERT INTO cheat_incidents SET charid = %u, cheatid = %u, cheatarg = %u, description= '%s';";
            _sql->Query(fmtQuery, PChar->id, static_cast<uint32>(cheatid), cheatarg, description != nullptr ? description : "");
        }
        if (action & CHEAT_ACTION_WARN)
        {
            // The message in the warning column in DB is sent as a system message to the offender
            PChar->pushPacket(new CChatMessagePacket(PChar, CHAT_MESSAGE_TYPE::MESSAGE_SYSTEM_1, warningmsg));
        }
        if ((action & CHEAT_ACTION_JAIL) && (!settings::get<bool>("map.ANTICHEAT_JAIL_DISABLE")))
        {
            // Send to jail only if both the cheat type requires it *and* the admin
            // has not disabled auto-jailing globally.
            JailChar(PChar);
        }
        return true;
    }

} // namespace anticheat
