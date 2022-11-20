-----------------------------------
-- Area: Misareaux Coast
--  NPC: Dilapidated Gate
-- Entrance to Riverne Site #B01
-- !pos -259 -30 276 25
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/Misareaux_Coast/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local copCurrentMission = player:getCurrentMission(xi.mission.log_id.COP)
    local copMissions = xi.mission.id.cop

    -- Bahamut Battle (requires COP to be completed)
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_ACCEPTED and
        player:getCharVar('StormsOfFate') == 0
    then
        player:startEvent(559)
    -- Can pass after completing COP 2-4
    elseif
        copCurrentMission > copMissions.AN_ETERNAL_MELODY or
        player:hasCompletedMission(xi.mission.log_id.COP, copMissions.THE_LAST_VERSE)
    then
        player:startEvent(552)
    else
        player:messageSpecial(ID.text.DOOR_CLOSED)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 559 then
        player:setCharVar('StormsOfFate', 1)
    end
end

return entity
