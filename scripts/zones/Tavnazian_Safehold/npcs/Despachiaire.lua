-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Despachiaire
-- !pos 108 -40 -83 26
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local currentCOPMission = player:getCurrentMission(COP)
    local LouverancePathStatut = player:getCharVar("COP_Louverance_s_Path")

    if (currentCOPMission  == tpz.mission.id.cop.THE_LOST_CITY and player:getCharVar("PromathiaStatus") == 0) then
        player:startEvent(102)
    elseif (currentCOPMission  == tpz.mission.id.cop.SHELTERING_DOUBT and player:getCharVar("PromathiaStatus") == 1) then
        player:startEvent(108)
    elseif (currentCOPMission  == tpz.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR and player:getCharVar("COP_optional_CS_Despachaire") == 0) then
        player:startEvent(117) --117
    elseif (currentCOPMission  == tpz.mission.id.cop.THREE_PATHS and LouverancePathStatut == 0) then
        player:startEvent(118)
    elseif (currentCOPMission  == tpz.mission.id.cop.THREE_PATHS and LouverancePathStatut == 1 ) then
        player:startEvent(134)
    else
        player:startEvent(106)
    end

end
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
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 102 or csid == 108) then
        player:setCharVar("PromathiaStatus", 2)
    elseif (csid == 117) then
        player:setCharVar("COP_optional_CS_Despachaire", 1)
    elseif (csid == 118) then
        player:setCharVar("COP_Louverance_s_Path", 1)
    end

end
