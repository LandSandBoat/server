-----------------------------------
-- Area: Ordelle's Caves
--  NPC: Strange Apparatus
-- !pos -294 28 -100 193
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.strangeApparatus.onTrade(player, trade, 5)
end

entity.onTrigger = function(player, npc)
    xi.strangeApparatus.onTrigger(player, 3)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 3 then
        xi.strangeApparatus.onEventUpdate(player, option)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 5 then
        xi.strangeApparatus.onEventFinish(player)
    end
end

return entity
