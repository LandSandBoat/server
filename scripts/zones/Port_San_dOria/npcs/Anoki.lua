-----------------------------------
-- Area: Port San d'Oria
--  NPC: Anoki
-- Standard Info NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR and player:getCharVar("COP_optional_CS_Anoki") == 0) then
        player:startEvent(724)
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR and player:getCharVar("COP_optional_CS_Anoki") == 1) then
        player:startEvent(728)
    else
        player:startEvent(519)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 724) then
        player:setCharVar("COP_optional_CS_Anoki", 1)
    elseif (csid == 728) then
        player:setCharVar("COP_optional_CS_Anoki", 2)
    end
end

return entity
