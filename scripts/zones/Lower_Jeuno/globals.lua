-- Zone: Lower Jeuno (245)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/status")
-----------------------------------

LOWER_JEUNO = {
    --[[..............................................................................................
        Community Service Quest: player clicks a streetlamp
        ..............................................................................................]]
    lampTrigger = function(player, npc)
        local lampId = npc:getID()
        local lampNum = lampId - ID.npc.STREETLAMP_OFFSET
        local lampCs = 120 + lampNum

        if (GetServerVariable("[JEUNO]CommService") == player:getID()) then
            local hour = VanadielHour()
            if (hour >= 20 and hour < 21) then
                player:startEvent(lampCs, 4) -- It is too early to light it.  You must wait until nine o'clock.
            elseif (hour >= 21 or hour < 1) then
                if (npc:getAnimation() == tpz.anim.OPEN_DOOR) then
                    player:startEvent(lampCs, 2) -- The lamp is already lit.
                else
                    player:startEvent(lampCs, 1, lampNum) -- Light the lamp? Yes/No
                end
            else
                player:startEvent(lampCs, 3) -- You have failed to light the lamps in time.
            end

        else
            if (npc:getAnimation() == tpz.anim.OPEN_DOOR) then
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

        if (csid == lampCs and option == 1) then
            GetNPCByID(lampId):setAnimation(tpz.anim.OPEN_DOOR)

            local lampsRemaining = 12
            for i = 0, 11 do
                local lamp = GetNPCByID(ID.npc.STREETLAMP_OFFSET + i)
                if (lamp:getAnimation() == tpz.anim.OPEN_DOOR) then
                    lampsRemaining = lampsRemaining - 1
                end
            end

            if (lampsRemaining == 0) then
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
         0, 0, 19,
        -2, 0, 13,
        -5, 0, 13,
        -7, 0, 12,
        -9, 0, 12,        -- lamp 12 path 5
        -10, 0, 11,
        -18, 0, 15,
        -25, 0, 3,
        -19, 0, -1,
        -17, 0, -2,
        -18, 0, -5,
        -19, 0, -4,       -- lamp 11 path 12
        -19, 0, -8,
        -30, 0, -27,
        -32, 0, -29,
        -33, 0, -29,
        -33, 0, -29,      -- lamp 10 path 17
        -32, 0, -39,
        -35, 0, -43,
        -45, 0, -47,      -- lamp 9 path 20
        -53, 0, -61,      -- lamp 8 path 21
        -42, 0, -49,
        -41, 0, -49,
        -40, 0, -49,
        -40, 0, -49,
        -40, 0, -50,
        -46, 6, -63,
        -50, 6, -70,
        -58, 6, -75,
        -61, 6, -75,      -- lamp 7 path 30
        -61, 6, -83,
        -66, 6, -93,
        -73, 6, -96,      -- lamp 6 path 33
        -75, 6, -112,
        -77, 6, -116,
        -83, 1, -125,
        -84, 0, -127,
        -86, 0, -126,
        -81, 0, -111,     -- lamp 5 path 39
        -89, 0, -123,     -- lamp 4 path 40
        -88, 0, -134,
        -88, 0, -135,
        -93, 0, -143,
        -100, 0, -144,    -- lamp 3 path 44
        -109, 0, -158,    -- lamp 2 path 45
        -117, 0, -172,    -- lamp 1 path 46
        -115, 0, -182,
        -122, 0, -196,    -- clear path 48
        -123, 0, -196     -- end path 49
    },

    --[[..............................................................................................
        indices within lampPath that contain lamps
        ..............................................................................................]]
    lampPoints = {5, 12, 17, 20, 21, 30, 33, 39, 40, 44, 45, 46}
}

return LOWER_JEUNO
