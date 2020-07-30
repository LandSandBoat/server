
-----------------------------------
-- Area: Celestial Nexus
-- NPC:  _515
-----------------------------------

require("scripts/globals/bcnm")

-----------------------------------
-- onTrade Action
-----------------------------------

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
