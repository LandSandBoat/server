-----------------------------------
-- Area: Windurst-Jeuno Airship
--  NPC: Gabriele
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Windurst-Jeuno_Airship/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local vHour = VanadielHour()
    local vMin  = VanadielMinute()

    while vHour >= 4 do
        vHour = vHour - 6
    end

    local message = ID.text.WILL_REACH_WINDURST

    if vHour == -2 then
        if vMin >= 47 then
            vHour = 3
            message = ID.text.WILL_REACH_JEUNO
        else
            vHour = 0
        end
    elseif vHour == -1 then
        vHour = 2
        message = ID.text.WILL_REACH_JEUNO
    elseif vHour == 0 then
        vHour = 1
        message = ID.text.WILL_REACH_JEUNO
    elseif vHour == 1 then
        if vMin <= 40 then
            vHour = 0
            message = ID.text.WILL_REACH_JEUNO
        else
            vHour = 3
        end
    elseif vHour == 2 then
        vHour = 2
    elseif vHour == 3 then
        vHour = 1
    end

    local vMinutes = 0

    if message == ID.text.WILL_REACH_JEUNO then
        vMinutes = (vHour * 60) + 47 - vMin
    else -- ID.text.WILL_REACH_WINDURST
        vMinutes = (vHour * 60) + 40 - vMin
    end

    if vMinutes <= 30 then
        if message == ID.text.WILL_REACH_WINDURST then
            message = ID.text.IN_WINDURST_MOMENTARILY
        else -- ID.text.WILL_REACH_JEUNO
            message = ID.text.IN_JEUNO_MOMENTARILY
        end
    elseif vMinutes < 60 then
        vHour = 0
    end

    player:messageSpecial(message, math.floor((2.4 * vMinutes) / 60), math.floor( vMinutes / 60 + 0.5))
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
