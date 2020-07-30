-----------------------------------
-- Area: Navukgo Execution Chamber
--  NPC: Decorative Bronze Gate
-- Involved in Missions: TOAU-22
-- !pos -601 10 -100 64
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/bcnm")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(TOAU) == tpz.mission.id.toau.SHIELD_OF_DIPLOMACY and player:getCharVar("AhtUrganStatus") == 1) then
        player:startEvent(2)
    elseif (EventTriggerBCNM(player, npc)) then
        return
    end
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    if (csid == 2) then
        player:setCharVar("AhtUrganStatus", 2)
    elseif (EventFinishBCNM(player, csid, option)) then
        return
    end
end
