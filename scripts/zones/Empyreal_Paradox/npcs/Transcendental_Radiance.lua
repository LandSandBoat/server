-----------------------------------
-- Area: Empyreal_Paradox
--  NPC: Transcendental Radiance
-- !pos 540 0 -594 36
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    if TradeBCNM(player, npc, trade) then
        return
    end

end

entity.onTrigger = function(player, npc)
    -- player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN);
    -- player:setCharVar("PromathiaStatus",3)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus") == 1) then
        player:startEvent(2)
    elseif player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_ACCEPTED and
        player:getCharVar('ApocalypseNigh') == 3 then
        player:startEvent(4)
    elseif (EventTriggerBCNM(player, npc)) then
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 2 then
        player:setCharVar("PromathiaStatus", 2)
    elseif csid == 4 then
        player:setCharVar("ApocalypseNigh", 4)
    elseif EventFinishBCNM(player, csid, option) then
        return
    end
end

return entity
