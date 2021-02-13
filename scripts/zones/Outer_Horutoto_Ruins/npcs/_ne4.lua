-----------------------------------
-- Area: Outer Horutoto Ruins
--  NPC: Strange Apparatus
-- !pos -574 0 739 194
-----------------------------------
require("scripts/globals/strangeapparatus")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.strangeApparatus.onTrade(player, trade, 66)
end

entity.onTrigger = function(player, npc)
    tpz.strangeApparatus.onTrigger(player, 64)
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 64 then
        tpz.strangeApparatus.onEventUpdate(player, option)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 66 then
        tpz.strangeApparatus.onEventFinish(player)
    end
end

return entity
