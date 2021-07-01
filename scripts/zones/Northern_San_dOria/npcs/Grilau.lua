-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Grilau
-- !pos -241.987 6.999 57.887 231
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getCurrentMission(xi.mission.log_id.SANDORIA) ~= xi.mission.id.sandoria.NONE then
        player:startEvent(1008) -- Wrong Item
    else
        player:startEvent(1010) -- Mission not activated
    end
end

entity.onTrigger = function(player, npc)
    local PresOfPapsqueCompleted = player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.PRESTIGE_OF_THE_PAPSQUE)

    if player:getNation() ~= xi.nation.SANDORIA then
        player:startEvent(1011) -- for Non-San d'Orians
    else
        local currentMission = player:getCurrentMission(SANDORIA)
        local pRank = player:getRank(player:getNation())

        if currentMission ~= xi.mission.id.sandoria.THE_SECRET_WEAPON and pRank == 7 and PresOfPapsqueCompleted == true and getMissionRankPoints(player, 19) == 1 and player:getCharVar("SecretWeaponStatus") < 2 then
            player:startEvent(1041)
        elseif currentMission == xi.mission.id.sandoria.THE_SECRET_WEAPON and player:getCharVar("SecretWeaponStatus") == 3 then
            player:startEvent(1043)
        elseif currentMission ~= xi.mission.id.sandoria.NONE then
            player:startEvent(1001) -- Have mission already activated
        else
            local mission_mask, repeat_mask = getMissionMask(player)
            player:startEvent(1009, mission_mask, 0, 0 , 0 , 0 , repeat_mask) -- Mission List
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    finishMissionTimeline(player, 1, csid, option)

    if csid == 1041 and player:getCharVar("SecretWeaponStatus") == 0 then
        player:setCharVar("SecretWeaponStatus", 1)
    elseif csid == 1043 then
        finishMissionTimeline(player, 2, csid, option)
    end
end

return entity
