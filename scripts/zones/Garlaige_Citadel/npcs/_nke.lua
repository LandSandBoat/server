-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Strange Apparatus
-- !pos 255 0 19 200
-----------------------------------
require("scripts/globals/strangeapparatus")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.strangeApparatus.onTrade(player, trade, 22)
end

entity.onTrigger = function(player, npc)
    tpz.strangeApparatus.onTrigger(player, 20)
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 20 then
        tpz.strangeApparatus.onEventUpdate(player, option)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 22 then
        tpz.strangeApparatus.onEventFinish(player)
    end
end

return entity
