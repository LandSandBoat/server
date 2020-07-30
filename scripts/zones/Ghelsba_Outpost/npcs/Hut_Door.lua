-----------------------------------
-- Area: Ghelsba_Outpost
-- NPC:  Hut Door
-- !pos -165.357 -11.672 77.771 140
-------------------------------------
require("scripts/globals/bcnm")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/missions")

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:hasKeyItem(tpz.ki.ORCISH_HUT_KEY)) then
        if (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.SAVE_THE_CHILDREN)) then
            player:startEvent(3)
        else
            player:startEvent(55)
        end
    else
        if (EventTriggerBCNM(player, npc)) then
            return
        end
    end
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    if (csid == 3 or csid == 55) then
        player:delKeyItem(tpz.ki.ORCISH_HUT_KEY)
        player:setCharVar("MissionStatus", 4)
    else
        if (EventFinishBCNM(player, csid, option)) then
            return
        end
    end
end
