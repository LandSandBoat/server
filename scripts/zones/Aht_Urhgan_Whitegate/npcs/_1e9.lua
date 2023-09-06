-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: _1e9 (Gate: The Pit)
-- !pos 80 -1.949 -107.94
-- Used to enter 'The Colosseum' zone.
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(133)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 133 and option == 1 then
        player:setPos(-600, 0, 40, 254, 71)
    end
end

return entity
