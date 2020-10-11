-----------------------------------
-- Area: Port San d'Oria
--  NPC: Anoki
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR and player:getCharVar("COP_optional_CS_Anoki") == 0) then
        player:startEvent(724)
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR and player:getCharVar("COP_optional_CS_Anoki") == 1) then
        player:startEvent(728)
    else
        player:startEvent(519)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 724) then
        player:setCharVar("COP_optional_CS_Anoki", 1)
    elseif (csid == 728) then
        player:setCharVar("COP_optional_CS_Anoki", 2)
    end
end
