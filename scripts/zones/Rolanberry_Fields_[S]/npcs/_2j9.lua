-----------------------------------
--  NPC: Sturdy Door
-- !pos -379.508 -30.299 -781.057 91
-- Teleports Players to Crawler's Nest S
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(103)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 103 and option == 1 then
        player:setPos(0, 0, 0, 0, xi.zone.CRAWLERS_NEST_S)
    end
end

return entity
