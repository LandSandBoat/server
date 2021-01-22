-----------------------------------
-- Area: Crawlers' Nest
--  NPC: Strange Apparatus
-- !pos 214 0 -339 197
-----------------------------------
require("scripts/globals/strangeapparatus")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.strangeApparatus.onTrade(player, trade, 2)
end

entity.onTrigger = function(player, npc)
    tpz.strangeApparatus.onTrigger(player, 0)
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 0 then
        tpz.strangeApparatus.onEventUpdate(player, option)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 2 then
        tpz.strangeApparatus.onEventFinish(player)
    end
end

return entity
