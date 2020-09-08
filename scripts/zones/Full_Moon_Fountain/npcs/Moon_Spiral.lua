-----------------------------------
-- Area: Full Moon Fountain
-- NPC:  Moon Spiral
-- Involved in Quests: The Moonlit Path
-- !pos -302 9 -260 170
-----------------------------------

require("scripts/globals/bcnm")
require("scripts/globals/quests")
require("scripts/globals/missions")

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
