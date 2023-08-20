-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Strange Apparatus
-- !pos 255 0 19 200
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.strangeApparatus.onTrade(player, trade, 22)
end

entity.onTrigger = function(player, npc)
    xi.strangeApparatus.onTrigger(player, 20)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 20 then
        xi.strangeApparatus.onEventUpdate(player, option)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 22 then
        xi.strangeApparatus.onEventFinish(player)
    end
end

return entity
