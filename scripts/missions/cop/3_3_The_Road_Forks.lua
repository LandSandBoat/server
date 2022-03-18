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
-- Honoi-Gumoi       : !pos -195 -11 -120 238
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
require('scripts/globals/keyitems')
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
    if not player then
        return
    end

    local secondsRemaining = mission:getLocalVar(player, 'Timer') - os.time()

    if
        player:hasKeyItem(xi.ki.MIMEO_JEWEL) and
        secondsRemaining <= 0
    then
        -- There are some conditions that can instantly break the jewel.  Short-circuit out
        -- here and display the final message should that occur.
        player:messageSpecial(attohwaChasmID.text.MIMEO_JEWEL_OFFSET + 4)
        player:delKeyItem(xi.ki.MIMEO_JEWEL)
    else
        local messageOffset = mission:getLocalVar(player, 'Option')
        local nextMessageTime = 30 - (messageOffset * 6)
        local minutesRemaining = secondsRemaining / 60

        if minutesRemaining <= nextMessageTime then
            player:messageSpecial(attohwaChasmID.text.MIMEO_JEWEL_OFFSET + messageOffset - 1) -- TODO: Might need KI Arg
            mission:setLocalVar(player, 'Option', messageOffset + 1)
        end

        player:timer(3 * 1000, function() jewelTimer(player) end)
    end
end

mission.sections =
{
    -- San d'Oria Path
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Arnau'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.SANDORIA) == 1 then
                        return mission:progressEvent(51)
                    end
                end,
            },

            ['Chasalvige'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.SANDORIA) == 2 then
                        return mission:progressEvent(38)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.SANDORIA) == 0 then
                        return 14
                    end
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1, xi.mission.status.SANDORIA)
                end,

                [38] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5, xi.mission.status.SANDORIA)
                end,

                [51] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2, xi.mission.status.SANDORIA)
                end,
            },
        },

        [xi.zone.CARPENTERS_LANDING] =
        {
            ['Guilloud'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.SANDORIA)

                    if mission:getLocalVar(player, 'ivyDefeated') == 1 then
                        return mission:progressEvent(0)
                    elseif
                        missionStatus == 5 and
                        not GetMobByID(carpentersLandingID.mob.OVERGROWN_IVY):isSpawned()
                    then
                        player:messageSpecial(carpentersLandingID.text.YOU_WISH_TO_KNOW_MISTALLE) -- TODO: Make sure this shows Guilloud's name
                        player:messageSpecial(carpentersLandingID.text.SQUASH_ANOTHER_WORM)
                        SpawnMob(carpentersLandingID.mob.OVERGROWN_IVY):updateClaim(player)
                        return mission:noAction()
                    end
                end,
            },

            ['Overgrown_Ivy'] =
            {
                onMobDeath = function(mob, player, isKiller, noKiller)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.SANDORIA) == 3 then
                        mission:setLocalVar(player, 'ivyDefeated', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 9, xi.mission.status.SANDORIA)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hinaree'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.SANDORIA) == 9 then
                        return mission:progressEvent(23)
                    end
                end,
            },

            onEventFinish =
            {
                [23] = function(player, csid, option, npc)
                    -- End of San d'Oria Path
                    player:setMissionStatus(mission.areaId, 14, xi.mission.status.SANDORIA)
                end,
            },
        },
    },

    -- Windurst Path
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Honoi-Gumoi'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.WINDURST) == 5 then
                        return mission:progressEvent(874)
                    end
                end,
            },

            ['Kyume-Romeh'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.WINDURST) == 3 then
                        return mission:progressEvent(873)
                    end
                end,
            },

            ['Ohbiru-Dohbiru'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.WINDURST) == 1 then
                        return mission:progressEvent(872)
                    end
                end,
            },

            ['Tosuka-Porika'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.WINDURST) == 11 then
                        return mission:progressEvent(875)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.WINDURST) == 0 then
                        return 871
                    end
                end,
            },

            onEventFinish =
            {
                [871] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1, xi.mission.status.WINDURST)
                end,

                [872] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2, xi.mission.status.WINDURST)
                end,

                [873] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5, xi.mission.status.WINDURST)
                end,

                [874] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.CRACKED_MIMEO_MIRROR)
                    player:setMissionStatus(mission.areaId, 6, xi.mission.status.WINDURST)
                end,

                [875] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 12, xi.mission.status.WINDURST)
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Yoran-Oran'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.WINDURST)

                    if missionStatus == 2 then
                        return mission:progressEvent(469)
                    elseif missionStatus == 6 then
                        return mission:progressEvent(470, 0, xi.ki.MIMEO_FEATHER, xi.ki.CRACKED_MIMEO_MIRROR, xi.ki.MIMEO_JEWEL)
                    elseif
                        missionStatus == 8 and
                        player:hasKeyItem(xi.ki.MIMEO_FEATHER)
                    then
                        return mission:progressEvent(471)
                    elseif missionStatus == 12 then
                        return mission:progressEvent(472)
                    end
                end,
            },

            onEventFinish =
            {
                [469] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3, xi.mission.status.WINDURST)
                end,

                [470] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.CRACKED_MIMEO_MIRROR)
                    player:setMissionStatus(mission.areaId, 8, xi.mission.status.WINDURST)
                end,

                [471] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MIMEO_FEATHER)
                    player:delKeyItem(xi.ki.SECOND_MIMEO_FEATHER)
                    player:delKeyItem(xi.ki.THIRD_MIMEO_FEATHER)

                    player:setMissionStatus(mission.areaId, 9, xi.mission.status.WINDURST)
                end,

                [472] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 14, xi.mission.status.WINDURST)
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Yujuju'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.WINDURST) == 9 then
                        return mission:progressEvent(592)
                    end
                end,
            },

            onEventFinish =
            {
                [592] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 11, xi.mission.status.WINDURST)
                end,
            },
        },

        [xi.zone.ATTOHWA_CHASM] =
        {
            ['Cradle_of_Rebirth'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.MIMEO_JEWEL) then
                        player:delKeyItem(xi.ki.MIMEO_JEWEL)
                        player:messageSpecial(attohwaChasmID.text.KEYITEM_LOST, xi.ki.MIMEO_JEWEL)

                        npcUtil.giveKeyItem(player, xi.ki.MIMEO_FEATHER)
                        npcUtil.giveKeyItem(player, xi.ki.SECOND_MIMEO_FEATHER)
                        npcUtil.giveKeyItem(player, xi.ki.THIRD_MIMEO_FEATHER)

                        return mission:noAction()
                    end
                end,
            },

            ['Lioumere'] =
            {
                onMobDeath = function(mob, player, isKiller, noKiller)
                    if
                        player:getMissionStatus(mission.areaId, xi.mission.status.WINDURST) == 8 and
                        mission:getVar(player, 'Status') == 0
                    then
                        mission:setVar(player, 'Status', 1)
                    end
                end,
            },

            ['Loose_Sand'] =
            {
                onTrigger = function(player, npc)
                    if player:checkDistance(npc) <= 0.5 then
                        if
                            player:getMissionStatus(mission.areaId, xi.mission.status.WINDURST) == 8
                        then
                            local lioumereStatus = mission:getVar(player, 'Status')

                            if
                                lioumereStatus == 0 and
                                not GetMobByID(attohwaChasmID.mob.LIOUMERE):isSpawned()
                            then
                                SpawnMob(ID.mob.LIOUMERE):updateClaim(player)
                            elseif
                                lioumereStatus == 1 and
                                not player:hasKeyItem(xi.ki.MIMEO_JEWEL)
                            then
                                npcUtil.giveKeyItem(xi.ki.MIMEO_JEWEL)
                                mission:setLocalVar(player, 'Timer', os.time() + 30 * 60)
                                jewelTimer(player)
                            end
                        end
                    else
                        return mission:messageSpecial(attohwaChasmID.text.MUST_MOVE_CLOSER)
                    end
                end,
            },

            afterZoneIn =
            {
                function(player)
                    if player:hasKeyItem(xi.ki.MIMEO_JEWEL) then
                        player:messageSpecial(attohwaChasmID.text.MIMEO_JEWEL_OFFSET + 4)
                        player:delKeyItem(xi.ki.MIMEO_JEWEL)
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
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getMissionStatus(mission.areaId, xi.mission.status.SANDORIA) == 14 and
                player:getMissionStatus(mission.areaId, xi.mission.status.WINDURST) == 14
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
