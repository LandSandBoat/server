-----------------------------------
-- For Whom Do We Toil?
-- Seekers of Adoulin M2-5-2
-----------------------------------
-- !addmission 12 23
-- Sluice_Gate_6 : !pos -561.522 -7.500 60.002 258
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.FOR_WHOM_DO_WE_TOIL)

mission.reward =
{
    keyItem     = xi.ki.NOTE_DETAILING_SEDITIOUS_PLANS,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.AIMING_FOR_YGNAS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(126),
        },

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Sluice_Gate_6'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if
                        missionStatus == 1 and
                        mission:getVar(player, 'failCount') < 3 and
                        mission:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        return mission:progressEvent(343)
                    elseif missionStatus == 2 then
                        mission:complete(player)

                        return mission:noAction()
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return 356
                    end
                end,
            },

            onEventFinish =
            {
                [343] = function(player, csid, option, npc)
                    if option == 0 then
                        -- Password: HGSI entered correctly both times
                        mission:complete(player)
                    elseif option == 1 then
                        -- Incorrect Password was Entered
                        mission:incrementVar(player, 'failCount', 1)
                    else
                        -- Failed to answer, 'Of Course it won't help' during CS
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,

                [356] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Wegellion'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMissionStatus(mission.areaId) > 0 and
                        mission:getVar(player, 'Option') == 0
                    then
                        return mission:progressEvent(1504, 257, 9, 3)
                    end
                end,
            },

            onEventFinish =
            {
                [1504] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 1)
                end,
            },
        },

        [xi.zone.CELENNIA_MEMORIAL_LIBRARY] =
        {
            ['Yafafa']  = mission:event(1),
            ['History'] = mission:event(1003, 1),

            onEventUpdate =
            {
                [1003] = function(player, csid, option, npc)
                    -- Was shown the password
                    if option == 1 then
                        if mission:getVar(player, 'failCount') == 3 then
                            mission:setVar(player, 'failCount', 0)
                            mission:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                        end

                        player:updateEvent(284)
                    end
                end,
            },
        },
    },
}

return mission
