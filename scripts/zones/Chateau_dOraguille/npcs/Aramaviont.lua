-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Aramaviont
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    -- This NPC is relevant only to San d'Orians on missions
    if player:getNation() ~= xi.nation.SANDORIA then
        player:startEvent(518)

    else
        local sandyMissions = xi.mission.id.sandoria
        local currentMission = player:getCurrentMission(SANDORIA)
        local missionStatus = player:getMissionStatus(player:getNation())

        -- San d'Oria Rank 10 (optional dialogue)
        if player:getCharVar("SandoEpilogue") == 1 then
            player:startEvent(11)

        -- San d'Oria 9-2 "The Heir to the Light" (optional dialogue)
        elseif currentMission == sandyMissions.THE_HEIR_TO_THE_LIGHT and missionStatus > 1 then
            if missionStatus > 4 then
                player:startEvent(14)
            else
                player:startEvent(13)
            end

        else
            player:startEvent(518)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
