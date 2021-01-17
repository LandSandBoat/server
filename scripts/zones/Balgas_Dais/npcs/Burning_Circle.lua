-----------------------------------
-- Area: Balga's Dais
--  NPC: Burning Circle
-- Balga's Dais Burning Circle
-- !pos 299 -123 345 146
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/bcnm")
-----------------------------------

function onTrade(player, npc, trade)
    if TradeBCNM(player, npc, trade) then
        return
    end
end

function onTrigger(player, npc)
    if EventTriggerBCNM(player, npc) then
        return
    end
end

function onEventUpdate(player, csid, option)
    local res = EventUpdateBCNM(player, csid, option)
    return res
end

function onEventFinish(player, csid, option)
    if EventFinishBCNM(player, csid, option) then
        return
    end
end
