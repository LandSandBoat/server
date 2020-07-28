-----------------------------------
-- Area: Navukgo Execution Chamber
--  NPC: Cast Bronze Gate (Inside BCNM)
-- !pos 282 -123 380 64
-----------------------------------
require("scripts/globals/bcnm")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (EventTriggerBCNM(player, npc)) then
        return
    end
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    if (EventFinishBCNM(player, csid, option)) then
        return
    end
end
