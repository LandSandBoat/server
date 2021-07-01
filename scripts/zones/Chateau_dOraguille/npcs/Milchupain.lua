-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Milchupain
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
        player:startEvent(516)

    else
        local sandyMissions = xi.mission.id.sandoria
        local currentMission = player:getCurrentMission(SANDORIA)
        local missionStatus = player:getMissionStatus(player:getNation())

        -- San d'Oria 9-2 "The Heir to the Light" (optional)
        if currentMission == sandyMissions.THE_HEIR_TO_THE_LIGHT and missionStatus > 1 then
            if missionStatus > 4 then
                player:startEvent(35)
            else
                player:startEvent(34)
            end

        -- San d'Oria 8-2 "Lightbringer" (optional)
        elseif
            player:hasCompletedMission(xi.mission.log_id.SANDORIA, sandyMissions.LIGHTBRINGER) and
            player:getRank(player:getNation()) == 9 and player:getRankPoints() == 0
        then
            player:showText(npc, ID.text.LIGHTBRINGER_EXTRA + 3)
        elseif currentMission == sandyMissions.LIGHTBRINGER and missionStatus == 6 then
            player:startEvent(36)

        else
            player:startEvent(516)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
