-----------------------------------
-- Area: Ghelsba_Outpost
--  NPC: Hut Door
-- !pos -165.357 -11.672 77.771 140
-----------------------------------
require("scripts/globals/bcnm")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:hasKeyItem(xi.ki.ORCISH_HUT_KEY)) then
        if (player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SAVE_THE_CHILDREN)) then
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

entity.onEventUpdate = function(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 3 or csid == 55) then
        player:delKeyItem(xi.ki.ORCISH_HUT_KEY)
        player:setMissionStatus(player:getNation(), 4)
    else
        if (EventFinishBCNM(player, csid, option)) then
            return
        end
    end
end

return entity
