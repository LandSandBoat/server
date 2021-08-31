-----------------------------------
-- Area: Sealion's Den
--  NPC: Sueleen
-- !pos 612 132 774 32
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(COP) > xi.mission.id.cop.THE_WARRIOR_S_PATH) then
        player:startEvent(12)
    elseif (player:getCurrentMission(COP) == xi.mission.id.cop.FLAMES_IN_THE_DARKNESS and player:getCharVar("PromathiaStatus") == 1) then
        player:startEvent(16)
    elseif (player:getCurrentMission(COP) == xi.mission.id.cop.CALM_BEFORE_THE_STORM and player:hasKeyItem(xi.ki.LETTERS_FROM_ULMIA_AND_PRISHE)) then
        player:startEvent(17)
    else
        player:startEvent(20)
    end
end

entity.onEventUpdate = function(player, csid, option)
    -- printf("onUpdate CSID: %u", csid)
    -- printf("onUpdate RESULT: %u", option)
end

entity.onEventFinish = function(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)

    if (csid == 12 and option == 1) then
        xi.teleport.to(player, xi.teleport.id.SEA)
    elseif (csid == 16) then
        player:setCharVar("PromathiaStatus", 2)
    elseif (csid == 17) then
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.CALM_BEFORE_THE_STORM)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIOR_S_PATH)
        player:setCharVar("PromathiaStatus", 0)
        player:setCharVar("COP_Dalham_KILL", 0)
        player:setCharVar("COP_Boggelmann_KILL", 0)
        player:setCharVar("Cryptonberry_Executor_KILL", 0)
    end
end

return entity
