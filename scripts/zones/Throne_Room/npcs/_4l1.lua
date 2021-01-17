-----------------------------------
-- Area: Throne Room
-- NPC:  Throne Room
-- Type: Door
-- !pos -111 -6 0 165
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/bcnm")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(player:getNation()) == tpz.mission.id.nation.SHADOW_LORD and player:getCharVar("MissionStatus") == 2) then
        player:startEvent(6)
    elseif (EventTriggerBCNM(player, npc)) then
        return 1
    end
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    if (csid == 6) then
        player:setCharVar("MissionStatus", 3)
    elseif (EventFinishBCNM(player, csid, option)) then
        return
    end
end
