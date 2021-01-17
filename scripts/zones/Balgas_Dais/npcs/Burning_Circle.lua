-----------------------------------
-- Area: Balga's Dais
--  NPC: Burning Circle
-- Balga's Dais Burning Circle
-- !pos 299 -123 345 146
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if TradeBCNM(player, npc, trade) then
        return
    end
end

entity.onTrigger = function(player, npc)
    if EventTriggerBCNM(player, npc) then
        return
    end
end

entity.onEventUpdate = function(player, csid, option)
    local res = EventUpdateBCNM(player, csid, option)
    return res
end

entity.onEventFinish = function(player, csid, option)
    if EventFinishBCNM(player, csid, option) then
        return
    end
end

return entity
