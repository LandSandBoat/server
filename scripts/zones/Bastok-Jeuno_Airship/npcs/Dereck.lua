-----------------------------------
-- Area: Bastok-Jeuno Airship
--  NPC: Dereck
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Bastok-Jeuno_Airship/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local vHour = VanadielHour()
    local vMin  = VanadielMinute()

    while vHour >= 6 do
        vHour = vHour - 6
    end

    local message = ID.text.WILL_REACH_BASTOK

    if (vHour ==  0) then
        if (vMin >= 13) then
            vHour = 3
            message = ID.text.WILL_REACH_JEUNO
        end
    elseif (vHour == 1) then
        vHour = 2
        message = ID.text.WILL_REACH_JEUNO
    elseif (vHour == 2) then
        vHour = 1
        message = ID.text.WILL_REACH_JEUNO
    elseif (vHour == 3) then
        if (vMin <= 11) then
            vHour = 0
            message = ID.text.WILL_REACH_JEUNO
        end
    elseif (vHour == 4) then
        vHour = 2
    elseif (vHour == 5) then
        vHour = 1
    end

    local vMinutes = 0

    if (message == ID.text.WILL_REACH_JEUNO) then
        vMinutes = (vHour * 60) + 11 - vMin
    else -- ID.text.WILL_REACH_BASTOK
        vMinutes = (vHour * 60) + 13 - vMin
    end

    if (vMinutes <= 30) then
        if ( message == ID.text.WILL_REACH_BASTOK) then
            message = ID.text.IN_BASTOK_MOMENTARILY
        else -- ID.text.WILL_REACH_JEUNO
            message = ID.text.IN_JEUNO_MOMENTARILY
        end
    elseif (vMinutes < 60) then
        vHour = 0
    end

    player:messageSpecial( message, math.floor((2.4 * vMinutes) / 60), math.floor( vMinutes / 60 + 0.5))
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
