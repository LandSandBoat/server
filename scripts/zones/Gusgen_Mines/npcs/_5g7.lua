-----------------------------------
-- Area: Gusgen Mines
--  NPC: Strange Apparatus
-- !pos 219 -39 255 196
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.strangeApparatus.onTrade(player, trade, 2)
end

entity.onTrigger = function(player, npc)
    xi.strangeApparatus.onTrigger(player, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 0 then
        xi.strangeApparatus.onEventUpdate(player, option)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 2 then
        xi.strangeApparatus.onEventFinish(player)
    end
end

return entity
