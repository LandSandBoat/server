-----------------------------------
-- Area: Outer Horutoto Ruins
--  NPC: Strange Apparatus
-- !pos -574 0 739 194
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.strangeApparatus.onTrade(player, trade, 66)
end

entity.onTrigger = function(player, npc)
    xi.strangeApparatus.onTrigger(player, 64)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 64 then
        xi.strangeApparatus.onEventUpdate(player, option)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 66 then
        xi.strangeApparatus.onEventFinish(player)
    end
end

return entity
