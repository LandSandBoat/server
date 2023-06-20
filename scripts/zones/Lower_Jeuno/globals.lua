-- Zone: Lower Jeuno (245)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------

local lowerJeunoGlobal =
{
    --[[..............................................................................................
        Community Service Quest: player clicks a streetlamp
        ..............................................................................................]]
    lampTrigger = function(player, npc)
        local lampId = npc:getID()
        local lampNum = lampId - ID.npc.STREETLAMP_OFFSET
        local lampCs = 120 + lampNum

        if GetServerVariable("[JEUNO]CommService") == player:getID() then
            local hour = VanadielHour()
            if hour >= 20 and hour < 21 then
                player:startEvent(lampCs, 4) -- It is too early to light it.  You must wait until nine o'clock.
            elseif hour >= 21 or hour < 1 then
                if npc:getAnimation() == xi.anim.OPEN_DOOR then
                    player:startEvent(lampCs, 2) -- The lamp is already lit.
                else
                    player:startEvent(lampCs, 1, lampNum) -- Light the lamp? Yes/No
                end
            else
                player:startEvent(lampCs, 3) -- You have failed to light the lamps in time.
            end

        else
            if npc:getAnimation() == xi.anim.OPEN_DOOR then
                player:startEvent(lampCs, 5) -- The lamp is lit.
            else
                player:startEvent(lampCs, 6) -- You examine the lamp. It seems that it must be lit manually.
            end
        end
    end,

    --[[..............................................................................................
        Community Service Quest: end of event triggered by lamp click
        ..............................................................................................]]
    lampEventFinish = function(player, csid, option, lampNum)
        local lampId = ID.npc.STREETLAMP_OFFSET + lampNum
        local lampCs = 120 + lampNum

        if csid == lampCs and option == 1 then
            GetNPCByID(lampId):setAnimation(xi.anim.OPEN_DOOR)

            local lampsRemaining = 12
            for i = 0, 11 do
                local lamp = GetNPCByID(ID.npc.STREETLAMP_OFFSET + i)
                if lamp:getAnimation() == xi.anim.OPEN_DOOR then
                    lampsRemaining = lampsRemaining - 1
                end
            end

            if lampsRemaining == 0 then
                player:messageSpecial(ID.text.LAMP_MSG_OFFSET)
            else
                player:messageSpecial(ID.text.LAMP_MSG_OFFSET + 1, lampsRemaining)
            end
        end
    end,

    --[[..............................................................................................
        the path that Vhana Ehgaklywha will walk to light the lamps
        ..............................................................................................]]
    lampPath =
    {
        { x = 0, y = 0, z = 19 },
        { x = -2, y = 0, z = 13 },
        { x = -5, y = 0, z = 13 },
        { x = -7, y = 0, z = 12 },
        { x = -9, y = 0, z = 12 },        -- lamp 12 path 5
        { x = -10, y = 0, z = 11 },
        { x = -18, y = 0, z = 15 },
        { x = -25, y = 0, z = 3 },
        { x = -19, y = 0, z = -1 },
        { x = -17, y = 0, z = -2 },
        { x = -18, y = 0, z = -5 },
        { x = -19, y = 0, z = -4 },       -- lamp 11 path 12
        { x = -19, y = 0, z = -8 },
        { x = -30, y = 0, z = -27 },
        { x = -32, y = 0, z = -29 },
        { x = -33, y = 0, z = -29 },
        { x = -33, y = 0, z = -29 },      -- lamp 10 path 17
        { x = -32, y = 0, z = -39 },
        { x = -35, y = 0, z = -43 },
        { x = -45, y = 0, z = -47 },      -- lamp 9 path 20
        { x = -53, y = 0, z = -61 },      -- lamp 8 path 21
        { x = -42, y = 0, z = -49 },
        { x = -41, y = 0, z = -49 },
        { x = -40, y = 0, z = -49 },
        { x = -40, y = 0, z = -49 },
        { x = -40, y = 0, z = -50 },
        { x = -46, y = 6, z = -63 },
        { x = -50, y = 6, z = -70 },
        { x = -58, y = 6, z = -75 },
        { x = -61, y = 6, z = -75 },      -- lamp 7 path 30
        { x = -61, y = 6, z = -83 },
        { x = -66, y = 6, z = -93 },
        { x = -73, y = 6, z = -96 },      -- lamp 6 path 33
        { x = -75, y = 6, z = -112 },
        { x = -77, y = 6, z = -116 },
        { x = -83, y = 1, z = -125 },
        { x = -84, y = 0, z = -127 },
        { x = -86, y = 0, z = -126 },
        { x = -81, y = 0, z = -111 },     -- lamp 5 path 39
        { x = -89, y = 0, z = -123 },     -- lamp 4 path 40
        { x = -88, y = 0, z = -134 },
        { x = -88, y = 0, z = -135 },
        { x = -93, y = 0, z = -143 },
        { x = -100, y = 0, z = -144 },    -- lamp 3 path 44
        { x = -109, y = 0, z = -158 },    -- lamp 2 path 45
        { x = -117, y = 0, z = -172 },    -- lamp 1 path 46
        { x = -115, y = 0, z = -182 },
        { x = -122, y = 0, z = -196 },    -- clear path 48
        { x = -123, y = 0, z = -196 },     -- end path 49
    },

    --[[..............................................................................................
        indices within lampPath that contain lamps
        ..............................................................................................]]
    lampPoints = { 5, 12, 17, 20, 21, 30, 33, 39, 40, 44, 45, 46 }
}

return lowerJeunoGlobal
