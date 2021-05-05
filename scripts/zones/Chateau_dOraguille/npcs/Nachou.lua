-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Nachou
-- Type: Standard NPC
-- !pos -39.965 -3.999 34.292 233
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local missionStatus = player:getMissionStatus(player:getNation())

    -- San d'Oria 9-2 "The Heir to the Light" (optional dialogues)
    if
        player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and
        (missionStatus == 2 or missionStatus == 5)
    then
        if missionStatus == 5 then
            player:startEvent(6)
        else
            player:startEvent(4)
        end

    -- Default dialogue
    else
        player:startEvent(523)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
