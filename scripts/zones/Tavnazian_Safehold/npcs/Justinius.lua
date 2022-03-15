-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Justinius
-- Involved in mission : COP2-3
-- !pos 76 -34 68 26
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

-- Cache COP missions for later reference
local copMissions = xi.mission.id.cop

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local copCurrentMission = player:getCurrentMission(COP)
    local copMissionStatus = player:getCharVar("PromathiaStatus")

    -- COP 4-1
    if copCurrentMission == copMissions.SHELTERING_DOUBT and copMissionStatus == 2 then
        player:startEvent(109)
    -- COP 4-2
    elseif copCurrentMission == copMissions.THE_SAVAGE then
        if copMissionStatus == 2 then
            player:startEvent(110) -- finish mission
        else
            player:startEvent(130) -- optional dialogue
        end
    -- else
        -- TODO: True default is 265, need to investigate this message
        -- player:startEvent(123)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 109 then
        player:setCharVar("PromathiaStatus", 3)
    elseif csid == 110 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(xi.mission.log_id.COP, copMissions.THE_SAVAGE)
        player:addMission(xi.mission.log_id.COP, copMissions.THE_SECRETS_OF_WORSHIP)
        player:addTitle(xi.title.NAGMOLADAS_UNDERLING)
    end
end

return entity
