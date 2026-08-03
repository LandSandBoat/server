-----------------------------------
-- Area: Windurst Waters
--  NPC: Jatan-Paratan
-- !pos -59 -4 22 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local hour = VanadielHour()

    -- He is the house flutist and plays through the evening, so he talks about the
    -- music at night and makes small talk about the restaurant during the day.
    if hour >= 18 or hour <= 6 then
        player:startEvent(611)
    elseif math.randomInt(1, 2) == 1 then
        player:startEvent(610)
    else
        player:startEvent(615)
    end
end

return entity
