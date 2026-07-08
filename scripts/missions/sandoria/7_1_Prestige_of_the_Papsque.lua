-----------------------------------
-- Prestige of the Papsque
-- San d'Oria M7-1
-----------------------------------
-- !addmission 0 18
-- Ambrotien             : !pos 93.419 -0.001 -57.347 230
-- Grilau                : !pos -241.987 6.999 57.887 231
-- Endracion             : !pos -110 1 -34 230
-- Papal Chambers (_6fc) : !pos 131 -11 122 231
-- qm4                   : !pos -695 -40 21 100
-----------------------------------
local westRonfaureID = zones[xi.zone.WEST_RONFAURE]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.PRESTIGE_OF_THE_PAPSQUE)

mission.reward =
{
    rankPoints = 1000,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 18 then
        mission:begin(player)
    end
end

mission.sections =
{
    -- Player has no active missions
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
                [2009] = handleAcceptMission,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
            },
        },
    },

    -- Player has accepted the mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['_6fc'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(7)
                    elseif missionStatus == 1 then
                        return mission:progressEvent(9)
                    elseif player:hasKeyItem(xi.ki.ANCIENT_SAN_DORIAN_TABLET) then
                        return mission:progressEvent(8)
                    end
                end,
            },

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [8] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.ANCIENT_SAN_DORIAN_TABLET)
                    end
                end,
            },
        },

        [xi.zone.WEST_RONFAURE] =
        {
            ['qm4'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        not GetMobByID(westRonfaureID.mob.MARAUDER_DVOGZOG):isSpawned()
                    then
                        if player:getLocalVar('Mission[0][18]Stage') == 1 then
                            player:setLocalVar('Mission[0][18]Stage', 0)
                            player:setMissionStatus(mission.areaId, 2)
                            return mission:keyItem(xi.ki.ANCIENT_SAN_DORIAN_TABLET)
                        else
                            SpawnMob(westRonfaureID.mob.MARAUDER_DVOGZOG):updateClaim(player)
                            return mission:messageSpecial(westRonfaureID.text.SOMETHING_IS_AMISS)
                        end
                    end
                end,
            },

            ['Marauder_Dvogzog'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        player:setLocalVar('Mission[0][18]Stage', 1)
                    end
                end,
            },
        },
    },
}

return mission
