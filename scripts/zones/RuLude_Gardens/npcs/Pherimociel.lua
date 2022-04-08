-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Pherimociel
-- !pos -31.627 1.002 67.956 243
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(COP) == xi.mission.id.cop.A_PLACE_TO_RETURN and
        player:getCharVar("PromathiaStatus") == 1
    then
        local Hrandom = math.random()

        if Hrandom < 0.2 then
            player:startEvent(27) -- Observed while Three Paths is active
        elseif Hrandom < 0.6 then
            player:startEvent(28)
        else
            player:startEvent(29)
        end

    elseif
        player:getCurrentMission(COP) == xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS and
        player:getCharVar("PromathiaStatus") == 0
    then
        player:startEvent(10049)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10049 then
        player:setCharVar("PromathiaStatus", 1)
    end
end

return entity
