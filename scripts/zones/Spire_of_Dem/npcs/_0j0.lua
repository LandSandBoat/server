-----------------------------------
-- Area: Spire_of_Dem
-- NPC:  Web of Recollections
-- !pos 0.000 -2.0 247.992 19
-----------------------------------

require("scripts/globals/bcnm")

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)
    EventTriggerBCNM(player, npc)
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

-----------------------------------
-- onEventFinish Action
-----------------------------------

function onEventFinish(player, csid, option)
    EventFinishBCNM(player, csid, option)
end
