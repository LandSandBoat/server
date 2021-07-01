-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ambrotien
-- !pos 93.419 -0.001 -57.347 230
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getCurrentMission(xi.mission.log_id.SANDORIA) ~= xi.mission.id.sandoria.NONE then
        player:startEvent(2008) -- Wrong Item
    else
        player:startEvent(2010) -- Mission not activated
    end
end

entity.onTrigger = function(player, npc)

    local PresOfPapsqueCompleted = player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.PRESTIGE_OF_THE_PAPSQUE)

    if player:getNation() ~= xi.nation.SANDORIA then
        player:startEvent(2011) -- for Non-San d'Orians
    else
        local currentMission = player:getCurrentMission(SANDORIA)
        local pRank = player:getRank(player:getNation())

        if currentMission == xi.mission.id.sandoria.RANPERRES_FINAL_REST and player:hasKeyItem(xi.ki.ANCIENT_SANDORIAN_BOOK) then
            player:startEvent(1036)
        elseif currentMission == xi.mission.id.sandoria.RANPERRES_FINAL_REST and player:getMissionStatus(player:getNation()) == 4 then
            if player:getLocalVar("RanperresRest") == 1 then -- Requires player to zone.
                player:startEvent(1038)
            else
                player:startEvent(1040)
            end
        elseif currentMission == xi.mission.id.sandoria.RANPERRES_FINAL_REST and player:getMissionStatus(player:getNation()) == 7 then
            player:startEvent(1034)
        elseif currentMission ~= xi.mission.id.sandoria.THE_SECRET_WEAPON and pRank == 7 and PresOfPapsqueCompleted == true and getMissionRankPoints(player, 19) and player:getCharVar("SecretWeaponStatus") < 2 then
            player:startEvent(1042)
        elseif currentMission == xi.mission.id.sandoria.THE_SECRET_WEAPON and player:getCharVar("SecretWeaponStatus") == 3 then
            player:startEvent(1044)
        elseif currentMission ~= xi.mission.id.sandoria.NONE then
            player:startEvent(2001) -- Have mission already activated
        else
            local mission_mask, repeat_mask = getMissionMask(player)
            player:startEvent(2009, mission_mask, 0, 0 , 0 , 0 , repeat_mask) -- Mission List
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    finishMissionTimeline(player, 2, csid, option)
    if csid == 1036 then
        player:delKeyItem(xi.ki.ANCIENT_SANDORIAN_BOOK)
        player:setLocalVar("RanperresRest", 1) -- set to require a zone
        player:setMissionStatus(player:getNation(), 4)
    elseif csid == 1040 then
        player:setMissionStatus(player:getNation(), 5)
    elseif csid == 1034 then
        finishMissionTimeline(player, 1, csid, option)
    elseif csid == 1042 and player:getCharVar("SecretWeaponStatus") == 0 then
        player:setCharVar("SecretWeaponStatus", 1)
    elseif csid == 1044 then
        finishMissionTimeline(player, 1, csid, option)
    end

end

return entity
