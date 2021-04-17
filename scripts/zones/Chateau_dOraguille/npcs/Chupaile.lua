-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Chupaile
-- Standard Info NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    -- This NPC is relevant only to San d'Orians on missions
    if player:getNation() ~= xi.nation.SANDORIA then
        player:startEvent(514)

    else
        local sandyMissions = xi.mission.id.sandoria
        local currentMission = player:getCurrentMission(SANDORIA)
        local missionStatus = player:getMissionStatus(player:getNation())

        -- San d'Oria 5-2 "The Shadow Lord" (optional)
        -- Only after speaking to Halver and obtaining Rank 6 and before entering the Great Hall
        if currentMission == sandyMissions.THE_SHADOW_LORD and missionStatus == 5 then
            player:startEvent(86)
        else
            player:startEvent(514)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
