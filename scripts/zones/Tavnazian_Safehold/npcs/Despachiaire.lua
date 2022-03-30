-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Despachiaire
-- !pos 108 -40 -83 26
-- TODO:
-- Starts quests: "X Marks the Spot"
--                "Elderly Pursuits"
--                "Tango with a Tracker"
--                "Requiem of Sin"
-- Involved in:   "Secrets of Ovens Lost"
-- https://github.com/project-topaz/topaz/issues/1481
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local copCurrentMission = player:getCurrentMission(COP)
    local copMissions = xi.mission.id.cop

    -- COP 5-3 "Three Paths"
    if copCurrentMission == copMissions.THREE_PATHS then
        if player:getCharVar("COP_Louverance_s_Path") == 0 then
            player:startEvent(118)
        else
            player:startEvent(134)
        end
    -- COP Default dialogue change
    elseif player:getCurrentMission(COP) > copMissions.DARKNESS_NAMED then
        player:startEvent(315) -- "Jeuno offered its help"
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 118 then
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

return entity
