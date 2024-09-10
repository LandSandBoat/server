-----------------------------------
-- The Secrets of Worship
-- Promathia 4-3
-----------------------------------
-- !addmission 6 428
-- Justinius   : !pos 76 -34 68 26
-- Walnut Door : !pos 111 -41 41 26
-- Iron Gate   : !pos 52.58 -24.1 740.02 25
-- Wooden Gate : !pos 45.500 -1.500 10.000 28
-- ???         : !pos 102.669 -3.111 127.279 28 (Varies in area)
-----------------------------------
local sacrariumID = zones[xi.zone.SACRARIUM]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.THE_SECRETS_OF_WORSHIP)

local profQmOnTrigger = function(player, npc)
    local missionStatus = mission:getVar(player, 'Status')
    local isSpawnPoint = npc:getLocalVar('hasProfessorMariselle') == 1

    if
        missionStatus == 3 and
        not player:hasKeyItem(xi.ki.RELIQUIARIUM_KEY) and
        isSpawnPoint
    then
        GetMobByID(sacrariumID.mob.OLD_PROFESSOR_MARISELLE):setSpawn(npc:getXPos(), npc:getYPos(), npc:getZPos(), 0)
        for i = 1, 2 do
            GetMobByID(sacrariumID.mob.OLD_PROFESSOR_MARISELLE + i):setSpawn(npc:getXPos(), npc:getYPos(), npc:getZPos(), 0)
        end

        npcUtil.popFromQM(player, npc, sacrariumID.mob.OLD_PROFESSOR_MARISELLE, { radius = 2, hide = 0 })
        return mission:messageSpecial(sacrariumID.text.EVIL_PRESENCE)
    elseif
        mission:getLocalVar(player, 'hasKilled') == 1 and
        not player:hasKeyItem(xi.ki.RELIQUIARIUM_KEY)
    then
        npcUtil.giveKeyItem(player, xi.ki.RELIQUIARIUM_KEY)
        return mission:noAction()
    end
end

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.SLANDEROUS_UTTERINGS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['_0qa'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(111)
                    end
                end,
            },

            ['Justinius'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:event(131):importantEvent()
                    end
                end,
            },

            ['Parelbriaux'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:event(137)
                    end
                end,
            },

            onEventFinish =
            {
                [111] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.MISAREAUX_COAST] =
        {
            ['_0p8'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 1 then
                        return mission:progressEvent(9)
                    elseif missionStatus > 1 then
                        return mission:event(502)
                    end
                end,
            },

            onEventFinish =
            {
                [9] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:setVar(player, 'Status', 2)
                        player:setPos(-220.075, -15.999, 79.634, 62, 28)
                    end
                end,

                [502] = function(player, csid, option, npc)
                    if option == 0 then
                        player:setPos(-220.075, -15.999, 79.634, 62, 28)
                    end
                end,
            },
        },

        [xi.zone.SACRARIUM] =
        {
            ['_0s8'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if player:getXPos() > 45 then
                        if missionStatus == 2 then
                            return mission:progressEvent(6, 0, xi.ki.RELIQUIARIUM_KEY)
                        elseif missionStatus == 3 and player:hasKeyItem(xi.ki.RELIQUIARIUM_KEY) then
                            return mission:progressEvent(5)
                        end
                    else
                        return mission:messageSpecial(sacrariumID.text.CANNOT_OPEN_SIDE)
                    end
                end,
            },

            ['qm_prof_0'] = profQmOnTrigger,
            ['qm_prof_1'] = profQmOnTrigger,
            ['qm_prof_2'] = profQmOnTrigger,
            ['qm_prof_3'] = profQmOnTrigger,
            ['qm_prof_4'] = profQmOnTrigger,
            ['qm_prof_5'] = profQmOnTrigger,

            ['Old_Professor_Mariselle'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mission:getVar(player, 'Status') == 3 then
                        mission:setLocalVar(player, 'hasKilled', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [6] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 3)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        ['_0s8'] =
        {
            onTrigger = function(player, npc)
                if player:getXPos() > 45 then
                    if player:hasKeyItem(xi.ki.RELIQUIARIUM_KEY) then
                        player:startEvent(110)
                    end
                else
                    return mission:messageSpecial(sacrariumID.text.CANNOT_OPEN_SIDE)
                end
            end,
        },
    },
}

return mission
