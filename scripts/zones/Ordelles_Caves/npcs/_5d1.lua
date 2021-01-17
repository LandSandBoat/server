-----------------------------------
-- Area: Ordelle's Caves
--  NPC: Strange Apparatus
-- !pos -294 28 -100 193
-----------------------------------
require("scripts/globals/strangeapparatus")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.strangeApparatus.onTrade(player, trade, 5)
end

entity.onTrigger = function(player, npc)
    tpz.strangeApparatus.onTrigger(player, 3)
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 3 then
        tpz.strangeApparatus.onEventUpdate(player, option)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 5 then
        tpz.strangeApparatus.onEventFinish(player)
    end
end

return entity
