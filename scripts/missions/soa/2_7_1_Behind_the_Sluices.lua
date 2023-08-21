-----------------------------------
-- Behind the Sluices
-- Seekers of Adoulin M2-7-1
-----------------------------------
-- !addmission 12 31
-- Storage_Container       : !pos -150.198 -7.115 28.965 258
-- Sluice_Gate_6           : !pos -561.522 -7.500 60.002 258
-- Antiquated_Sluice_Gate  : !pos -529.361 -7.000 59.988 258
-- WATERWAY_FACILITY_CRANK : !addkeyitem 2450
-----------------------------------
local ralaID = zones[xi.zone.RALA_WATERWAYS]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.BEHIND_THE_SLUICES)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_LEAFKIN_MONARCH },
}

mission.sections =
{
    -- Get entry KI
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                not player:hasKeyItem(xi.ki.WATERWAY_FACILITY_CRANK) and
                missionStatus == 0
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Sluice_Gate_6'] = mission:messageSpecial(ralaID.text.PERHAPS_THE_WISEST, xi.ki.WATERWAY_FACILITY_CRANK),

            ['Storage_Container'] =
            {
                onTrigger = function(player, npc)
                    return mission:keyItem(xi.ki.WATERWAY_FACILITY_CRANK)
                end,
            },
        },
    },

    -- Got the KI -> Cutscene at Gate
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:hasKeyItem(xi.ki.WATERWAY_FACILITY_CRANK) and
                missionStatus == 0
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Sluice_Gate_6'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(359, 258, 102)
                end,
            },

            onEventFinish =
            {
                [359] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },
    },

    -- Enter Gate
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:hasKeyItem(xi.ki.WATERWAY_FACILITY_CRANK)
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Sluice_Gate_6'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(361)
                end,
            },

            onEventFinish =
            {
                [361] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,
            },
        },
    },

    -- Instance fight handled in Rala_Waterways_U\instances\behind_the_sluices.lua

    -- Returning from instanced battle (missionStatus == 3)
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                missionStatus == 3
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 353
                end,
            },

            onEventFinish =
            {
                [353] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Sluice_Gate_6'] = mission:event(361):replaceDefault(),
        },
    },
}

return mission
