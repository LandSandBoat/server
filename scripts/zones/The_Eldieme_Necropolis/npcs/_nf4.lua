-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Strange Apparatus
-- !pos 104 0 -179 195
-----------------------------------
require("scripts/globals/strangeapparatus")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.strangeApparatus.onTrade(player, trade, 3)
end

entity.onTrigger = function(player, npc)
    tpz.strangeApparatus.onTrigger(player, 1)
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 1 then
        tpz.strangeApparatus.onEventUpdate(player, option)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 3 then
        tpz.strangeApparatus.onEventFinish(player)
    end
end

return entity
