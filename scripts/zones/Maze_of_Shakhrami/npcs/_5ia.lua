-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: Strange Apparatus
-- !pos 375 20 -259 198
-----------------------------------
require("scripts/globals/strangeapparatus")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.strangeApparatus.onTrade(player, trade, 55)
end

entity.onTrigger = function(player, npc)
    tpz.strangeApparatus.onTrigger(player, 53)
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 53 then
        tpz.strangeApparatus.onEventUpdate(player, option)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 55 then
        tpz.strangeApparatus.onEventFinish(player)
    end
end

return entity
