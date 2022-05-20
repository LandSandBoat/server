-----------------------------------
-- Area: Heaven's Tower
--  NPC: Jatata
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getNation() == xi.nation.WINDURST then
        player:startEvent(77)
    else
        player:startEvent(78)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
