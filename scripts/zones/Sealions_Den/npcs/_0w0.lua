-----------------------------------
-- Area: Sealion's Den
--  NPC: Iron Gate
-- !pos 612 132 774 32
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/missions")
require("scripts/globals/titles")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(COP) == xi.mission.id.cop.SLANDEROUS_UTTERINGS and player:getCharVar("PromathiaStatus") == 1 then
        player:startEvent(13)
    elseif EventTriggerBCNM(player, npc) then
        return
    elseif (player:getCurrentMission(COP) > xi.mission.id.cop.THE_WARRIOR_S_PATH) then
        player:startEvent(12)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
        return
end

entity.onEventFinish = function(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)

    if (EventFinishBCNM(player, csid, option)) then
        return
    end
    if (csid == 12 and option == 1) then
        player:setPos(-31.8, 0, -618.7, 190, 33)
    elseif (csid == 13) then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.SLANDEROUS_UTTERINGS)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR)
        player:addTitle(xi.title.THE_LOST_ONE)
    end
end

return entity
