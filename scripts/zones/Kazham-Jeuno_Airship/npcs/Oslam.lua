-----------------------------------
-- Area: Kazham-Jeuno Airship
--  NPC: Oslam
-----------------------------------
local ID = zones[xi.zone.KAZHAM_JEUNO_AIRSHIP]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local vHour = VanadielHour()
    local vMin  = VanadielMinute()

    while vHour >= 1 do
        vHour = vHour - 6
    end

    local message = ID.text.WILL_REACH_KAZHAM

    if vHour == -5 then
        if vMin >= 48 then
            vHour = 3
            message = ID.text.WILL_REACH_JEUNO
        else
            vHour = 0
        end
    elseif vHour == -4 then
        vHour = 2
        message = ID.text.WILL_REACH_JEUNO
    elseif vHour == -3 then
        vHour = 1
        message = ID.text.WILL_REACH_JEUNO
    elseif vHour == -2 then
        if vMin <= 49 then
            vHour = 0
            message = ID.text.WILL_REACH_JEUNO
        else
            vHour = 3
        end
    elseif vHour == -1 then
        vHour = 2
    elseif vHour == 0 then
        vHour = 1
    end

    local vMinutes = (vHour * 60) + 48 - vMin
    if message == ID.text.WILL_REACH_JEUNO then
        vMinutes = (vHour * 60) + 49 - vMin
    end

    if vMinutes <= 30 then
        if message == ID.text.WILL_REACH_KAZHAM then
            message = ID.text.IN_KAZHAM_MOMENTARILY
        else -- ID.text.WILL_REACH_JEUNO
            message = ID.text.IN_JEUNO_MOMENTARILY
        end
    end

    player:messageSpecial(message, math.floor((2.4 * vMinutes) / 60), math.floor(vMinutes / 60 + 0.5))
end

return entity
