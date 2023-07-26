-----------------------------------
-- Area: Celennia Memorial Library (284)
--  NPC: Door: Back to Town
-- !pos -92.357 -3.050 -82.322 284
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(26)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 26 and option == 1 then
        player:setPos(-86.2, -0.15, -76, 220, 257)
    end
end

return entity
