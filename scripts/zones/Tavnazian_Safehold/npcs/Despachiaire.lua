-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Despachiaire
-- !pos 108 -40 -83 26
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
-- TODO:
-- Starts quests: "X Marks the Spot"
--                "Elderly Pursuits"
--                "Tango with a Tracker"
--                "Requiem of Sin"
-- Involved in:   "Secrets of Ovens Lost"
-- https://github.com/project-topaz/topaz/issues/1481

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local copCurrentMission = player:getCurrentMission(COP)
    local copMissionStatus = player:getCharVar("PromathiaStatus")
    local copMissions = tpz.mission.id.cop

    -- COP 2-2 "The Lost City"
    if copCurrentMission == copMissions.THE_LOST_CITY and copMissionStatus == 0 then
        player:startEvent(102)
    -- COP 4-1 "Sheltering Doubt"
    elseif copCurrentMission == copMissions.SHELTERING_DOUBT and copMissionStatus == 1 then
        player:startEvent(108)
    -- COP 4-4 "Slanderous Utterings" is an area approach handled in Tavnazian_Safehold/Zone.lua
    -- COP 5-1 "Sheltering Doubt" (optional)
    elseif
        copCurrentMission == copMissions.THE_ENDURING_TUMULT_OF_WAR and
        copMissionStatus == 0 and
        player:getCharVar("COP_optional_CS_Despachaire") == 0
    then
        player:startEvent(117)
    -- COP 5-3 "Three Paths"
    elseif copCurrentMission == copMissions.THREE_PATHS then
        if player:getCharVar("COP_Louverance_s_Path") == 0 then
            player:startEvent(118)
        else
            player:startEvent(134)
        end
    -- COP Default dialogue change
    elseif player:getCurrentMission(COP) > copMissions.DARKNESS_NAMED then
        player:startEvent(315) -- "Jeuno offered its help"; TODO: might trigger as early as 5-2?
    -- Default dialogue
    else
        player:startEvent(106)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 102 or csid == 108 then
        player:setCharVar("PromathiaStatus", 2)
    elseif csid == 117 then
        player:setCharVar("COP_optional_CS_Despachaire", 1)
    elseif csid == 118 then
        player:setCharVar("COP_Louverance_s_Path", 1)
    end

end

-- TODO: cutscenes including Despachiaire for reference
--Despachiaire     102 ++
--Despachiaire     104 ++
--Despachiaire     106 ++
--Despachiaire     107 ++
--Despachiaire     108 ++
--Despachiaire     110 ++
--Despachiaire     112 ++
--Despachiaire     117 ++
--Despachiaire     118 ++
--Despachiaire     132
--Despachiaire     133
--Despachiaire     134 ??
--Despachiaire     139
--Despachiaire     144 chat
--Despachiaire     149 XX
--Despachiaire     315 chat
--Despachiaire     317 chat
--Despachiaire     318 chat
--Despachiaire     505 CS
--Despachiaire     517 CS (despachiaire's wife)
--Despachiaire     518 CS (ulmia mother)
--Despachiaire     576 CS
--Despachiaire     577 chat
--Despachiaire     578 chat
--Despachiaire     579 chat
--Despachiaire     617 XX
--Despachiaire     618 XX
