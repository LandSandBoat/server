-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: Strange Apparatus
-- !pos 375 20 -259 198
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.strangeApparatus.onTrade(player, trade, 55)
end

entity.onTrigger = function(player, npc)
    xi.strangeApparatus.onTrigger(player, 53)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 53 then
        xi.strangeApparatus.onEventUpdate(player, option)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 55 then
        xi.strangeApparatus.onEventFinish(player)
    end
end

return entity
