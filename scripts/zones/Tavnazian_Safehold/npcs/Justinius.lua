-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Justinius
-- Involved in mission : COP2-3
-- !pos 76 -34 68 26
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/missions")
-----------------------------------

-- Cache COP missions for later reference
local copMissions = tpz.mission.id.cop

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local copCurrentMission = player:getCurrentMission(COP)
    local copMissionStatus = player:getCharVar("PromathiaStatus")

    -- COP 2-3
    if copCurrentMission == copMissions.DISTANT_BELIEFS and copMissionStatus == 3 then
        player:startEvent(113)
    -- COP 2-4
    elseif copCurrentMission == copMissions.AN_ETERNAL_MELODY and copMissionStatus == 1 then
        player:startEvent(127) -- optional dialogue
    -- COP 4-1
    elseif copCurrentMission == copMissions.SHELTERING_DOUBT and copMissionStatus == 2 then
        player:startEvent(109)
    -- COP 4-2
    elseif copCurrentMission == copMissions.THE_SAVAGE then
        if copMissionStatus == 2 then
            player:startEvent(110) -- finish mission
        else
            player:startEvent(130) -- optional dialogue
        end
    else
        player:startEvent(123)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 113 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, copMissions.DISTANT_BELIEFS)
        player:addMission(tpz.mission.log_id.COP, copMissions.AN_ETERNAL_MELODY)
    elseif csid == 109 then
        player:setCharVar("PromathiaStatus", 3)
    elseif csid == 110 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, copMissions.THE_SAVAGE)
        player:addMission(tpz.mission.log_id.COP, copMissions.THE_SECRETS_OF_WORSHIP)
        player:addTitle(tpz.title.NAGMOLADAS_UNDERLING)
    end

end
