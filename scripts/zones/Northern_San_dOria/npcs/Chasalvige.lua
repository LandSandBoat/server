-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Chasalvige
-- Type: Standard Info NPC
--  Involved in Mission: The Road Forks
--  Involved in Mission: Promathia Mission 5 - Three Paths
-- !pos 96.432 -0.520 134.046 231
--
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("EMERALD_WATERS_Status") == 3) then
        player:startEvent(38) --COP event
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR and player:getCharVar("COP_optional_CS_chasalvigne") == 0) then
        player:startEvent(761)
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Ulmia_s_Path") == 2) then
        player:startEvent(762)
    else
        player:startEvent(6)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 38) then
        player:setCharVar("EMERALD_WATERS_Status", 4)
    elseif (csid == 761) then
        player:setCharVar("COP_optional_CS_chasalvigne", 1)
    elseif (csid == 762) then
        player:setCharVar("COP_Ulmia_s_Path", 3)
    end
end
