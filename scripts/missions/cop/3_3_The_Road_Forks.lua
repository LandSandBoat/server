-----------------------------------
-- The Road Forks
-- Promathia 3-3
-----------------------------------
-- !addmission 6 325

-- San d'Oria Path
-- Arnau      : !pos 148 0 139 231
-- Chasalvige : !pos 96.432 -0.520 134.046 231
-- Guilloud   : !pos -123.770 -6.654 -469.062 2
-- Hinaree    : !pos -301.535 -10.199 97.698 230

-- Windurst Path
-- Ohbiru-Dohbiru    : !pos 23 -5 -193 238
-- Yoran-Oran        : !pos -109.987 -14 203.338 239
-- Kyume-Romeh       : !pos -58 -4 23 238
-- Honoi-Gomoi       : !pos -195 -11 -120 238
-- Loose Sand        : !pos 478.8 20 41.7 7
-- Cradle of Rebirth : !pos 320 -23 -15.9 7
-- Yujuju            : !pos 201.523 -4.785 138.978 240
-- Tosuka-Porika     : !pos -26 -6 103 238

-- Completion
-- Cid : !pos -12 -12 1 237
-----------------------------------
-- NOTE: This mission uses extended Mission Status.  See documentation for CoP MissionStatus for
-- predefined values.  These must not be changed!
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
-----------------------------------
local attohwaChasmID      = require('scripts/zones/Attohwa_Chasm/IDs')
local carpentersLandingID = require('scripts/zones/Carpenters_Landing/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.THE_ROAD_FORKS)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.TENDING_AGED_WOUNDS },
}

-- A 30 minute timer is started once obtaining the Mimeo Jewel for Windurst Path.  Create a
-- looping timer to monitor this, supply periodic messages, and check for breaking conditions
local jewelTimer
jewelTimer = function(player)
    if
        not player or
        not player:hasKeyItem(xi.ki.MIMEO_JEWEL)
    then
        return
    end

    local secondsRemaining = mission:getLocalVar(player, 'Timer') - os.time()
    if secondsRemaining <= 0 then
        -- There are some conditions that can instantly break the jewel.  Short-circuit out
        -- here and display the final message should that occur.
        player:messageSpecial(attohwaChasmID.text.MIMEO_JEWEL_OFFSET + 4, xi.ki.MIMEO_JEWEL)
        player:delKeyItem(xi.ki.MIMEO_JEWEL)
    else
        local messageOffset = mission:getLocalVar(player, 'Option')
        local nextMessageTime = 30 - (messageOffset * 6)
        local minutesRemaining = secondsRemaining / 60

        if minutesRemaining <= nextMessageTime then
            player:messageSpecial(attohwaChasmID.text.MIMEO_JEWEL_OFFSET + messageOffset - 1, xi.ki.MIMEO_JEWEL)
            mission:setLocalVar(player, 'Option', messageOffset + 1)
        end

        player:timer(3 * 1000, function()
            jewelTimer(player)
        end)
    end
end

mission.sections =
{
    -- San d'Oria Path
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and player:getMissionStatus(mission.areaId, xi.mission.status.COP.SANDORIA) <= 14
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Arnau'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.SANDORIA) == 1 then
                        return mission:progressEvent(51)
                    end
                end,
            },

            ['Chasalvige'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.SANDORIA)

                    if missionStatus == 2 then
                        return mission:progressEvent(38)
                    elseif missionStatus == 5 then
                        return mission:event(6):replaceDefault()
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.SANDORIA) == 0 then
                        return 14
                    end
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1, xi.mission.status.COP.SANDORIA)
                end,

                [38] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5, xi.mission.status.COP.SANDORIA)
                end,

                [51] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2, xi.mission.status.COP.SANDORIA)
                end,
            },
        },

        [xi.zone.CARPENTERS_LANDING] =
        {
            ['Guilloud'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.SANDORIA)

                    if missionStatus == 5 then
                        if mission:getLocalVar(player, 'ivyDefeated') == 1 then
                            local isSanDorian = player:getNation() == xi.nation.SANDORIA and 1 or 0

                            return mission:progressEvent(0, isSanDorian)
                        elseif not GetMobByID(carpentersLandingID.mob.OVERGROWN_IVY):isSpawned() then
                            player:messageText(npc, carpentersLandingID.text.YOU_WISH_TO_KNOW_MISTALLE)
                            player:messageText(npc, carpentersLandingID.text.SQUASH_ANOTHER_WORM)
                            SpawnMob(carpentersLandingID.mob.OVERGROWN_IVY):updateClaim(player)
                            return mission:noAction()
                        else
                            return mission:messageName(carpentersLandingID.text.BEGONE_TRESPASSER):setPriority(1000)
                        end
                    end
                end,
            },

            ['Overgrown_Ivy'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.SANDORIA) == 5 then
                        mission:setLocalVar(player, 'ivyDefeated', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 9, xi.mission.status.COP.SANDORIA)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hinaree'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.SANDORIA)

                    if missionStatus == 9 then
                        return mission:progressEvent(23)
                    elseif missionStatus == 14 then
                        return mission:event(24):replaceDefault()
                    end
                end,
            },

            onEventFinish =
            {
                [23] = function(player, csid, option, npc)
                    -- End of San d'Oria Path
                    player:setMissionStatus(mission.areaId, 14, xi.mission.status.COP.SANDORIA)
                end,
            },
        },
    },

    -- Windurst Path
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and player:getMissionStatus(mission.areaId, xi.mission.status.COP.WINDURST) <= 14
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Honoi-Gomoi'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.WINDURST)

                    if missionStatus == 5 then
                        return mission:progressEvent(874)
                    elseif missionStatus == 6 then
                        return mission:event(879, 0, xi.ki.CRACKED_MIMEO_MIRROR):importantEvent()
                    end
                end,
            },

            ['Kyume-Romeh'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.WINDURST)

                    if missionStatus == 3 then
                        return mission:progressEvent(873)
                    elseif missionStatus == 5 then
                        return mission:event(878):importantEvent()
                    end
                end,
            },

            ['Ohbiru-Dohbiru'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.WINDURST)

                    if missionStatus == 1 then
                        return mission:progressEvent(872)
                    elseif missionStatus == 2 then
                        return mission:event(877):importantEvent()
                    end
                end,
            },

            ['Tosuka-Porika'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.WINDURST)

                    if missionStatus == 11 then
                        return mission:progressEvent(875)
                    elseif missionStatus == 12 then
                        return mission:event(881):importantEvent()
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.WINDURST) == 0 then
                        return 871
                    end
                end,
            },

            onEventFinish =
            {
                [871] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1, xi.mission.status.COP.WINDURST)
                end,

                [872] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2, xi.mission.status.COP.WINDURST)
                end,

                [873] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5, xi.mission.status.COP.WINDURST)
                end,

                [874] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.CRACKED_MIMEO_MIRROR)
                    player:setMissionStatus(mission.areaId, 6, xi.mission.status.COP.WINDURST)
                end,

                [875] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 12, xi.mission.status.COP.WINDURST)
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Yoran-Oran'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.WINDURST)

                    if missionStatus == 2 then
                        return mission:progressEvent(469)
                    elseif missionStatus == 3 then
                        return mission:event(474):importantEvent()
                    elseif missionStatus == 6 then
                        return mission:progressEvent(470, 0, xi.ki.MIMEO_FEATHER, xi.ki.CRACKED_MIMEO_MIRROR, xi.ki.MIMEO_JEWEL)
                    elseif missionStatus == 8 then
                        if player:hasKeyItem(xi.ki.MIMEO_FEATHER) then
                            return mission:progressEvent(471)
                        else
                            return mission:event(476, 0, xi.ki.MIMEO_FEATHER, 0, xi.ki.MIMEO_JEWEL):importantEvent()
                        end
                    elseif missionStatus == 9 then
                        return mission:event(477):importantEvent()
                    elseif missionStatus == 12 then
                        return mission:progressEvent(472)
                    elseif missionStatus == 14 then
                        return mission:event(478):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [469] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3, xi.mission.status.COP.WINDURST)
                end,

                [470] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.CRACKED_MIMEO_MIRROR)
                    player:setMissionStatus(mission.areaId, 8, xi.mission.status.COP.WINDURST)
                end,

                [471] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MIMEO_FEATHER)
                    player:delKeyItem(xi.ki.SECOND_MIMEO_FEATHER)
                    player:delKeyItem(xi.ki.THIRD_MIMEO_FEATHER)

                    player:setMissionStatus(mission.areaId, 9, xi.mission.status.COP.WINDURST)
                end,

                [472] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 14, xi.mission.status.COP.WINDURST)
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Yujuju'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.WINDURST)

                    if missionStatus == 9 then
                        return mission:progressEvent(592)
                    elseif missionStatus == 11 then
                        return mission:event(593):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [592] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 11, xi.mission.status.COP.WINDURST)
                end,
            },
        },

        [xi.zone.ATTOHWA_CHASM] =
        {
            ['Cradle_of_Rebirth'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.MIMEO_JEWEL) then
                        local animationNpc = GetNPCByID(npc:getID() + 1)

                        animationNpc:entityAnimationPacket('krtu')
                        return mission:progressEvent(2)
                    end
                end,
            },

            ['Lioumere'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:getMissionStatus(mission.areaId, xi.mission.status.COP.WINDURST) == 8 and
                        mission:getVar(player, 'Status') == 0
                    then
                        mission:setVar(player, 'Status', 1)
                    end
                end,
            },

            ['Loose_Sand'] =
            {
                onTrigger = function(player, npc)
                    if player:checkDistance(npc) < 0.5 then
                        if
                            player:getMissionStatus(mission.areaId, xi.mission.status.COP.WINDURST) == 8
                        then
                            local lioumereStatus = mission:getVar(player, 'Status')

                            if
                                lioumereStatus == 0 and
                                not GetMobByID(attohwaChasmID.mob.LIOUMERE):isSpawned()
                            then
                                SpawnMob(attohwaChasmID.mob.LIOUMERE):updateClaim(player)
                                return mission:noAction()
                            elseif
                                lioumereStatus == 1 and
                                not player:hasKeyItem(xi.ki.MIMEO_JEWEL)
                            then
                                npcUtil.giveKeyItem(player, xi.ki.MIMEO_JEWEL)
                                mission:setLocalVar(player, 'Option', 0)
                                mission:setLocalVar(player, 'Timer', os.time() + 30 * 60)
                                jewelTimer(player)
                                return mission:noAction()
                            end
                        end
                    else
                        return mission:messageSpecial(attohwaChasmID.text.MUST_MOVE_CLOSER)
                    end
                end,
            },

            onZoneOut =
            {
                function(player)
                    if player:hasKeyItem(xi.ki.MIMEO_JEWEL) then
                        player:messageSpecial(attohwaChasmID.text.MIMEO_JEWEL_OFFSET + 4)
                        player:delKeyItem(xi.ki.MIMEO_JEWEL)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MIMEO_JEWEL)

                    npcUtil.giveKeyItem(player, xi.ki.MIMEO_FEATHER)
                    npcUtil.giveKeyItem(player, xi.ki.SECOND_MIMEO_FEATHER)
                    npcUtil.giveKeyItem(player, xi.ki.THIRD_MIMEO_FEATHER)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getMissionStatus(mission.areaId, xi.mission.status.COP.SANDORIA) == 14 and
                player:getMissionStatus(mission.areaId, xi.mission.status.COP.WINDURST) == 14
        end,

        [xi.zone.METALWORKS] =
        {
            ['Cid'] = mission:progressEvent(847),

            onEventFinish =
            {
                [847] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
