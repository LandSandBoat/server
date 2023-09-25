-----------------------------------
-- Area: Windurst Waters
--  NPC: Zabirego-Hajigo
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local fame = player:getFameLevel(2)
    if fame == 9 then
        player:startEvent(784)
    else
        player:startEvent(687 + fame)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
