-----------------------------------
-- Area: Kazham
--  NPC: Shey Wayatih
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local vHour = VanadielHour()
    local vMin  = VanadielMinute()

    while vHour >= 1 do
        vHour = vHour - 6
    end

    if vHour == -5 then
        vHour = 1
    elseif vHour == -4 then
        vHour = 2
    elseif vHour == -3 then
        vHour = 3
    elseif vHour == -2 then
        vHour = 4
    elseif vHour == -1 then
        vHour = 5
    end

    local seconds = math.floor(2.4 * ((vHour * 60) + vMin))

    player:startEvent(303, seconds, 0, 0, 0, 0, 0, 0, 0)
end

return entity
