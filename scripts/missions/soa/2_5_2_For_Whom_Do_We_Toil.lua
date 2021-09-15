-----------------------------------
-- For Whom Do We Toil?
-- Seekers of Adoulin M2-5-2
-----------------------------------
-- !addmission 12 23
-- Sluice_Gate_6 : !pos -561.522 -7.500 60.002 258
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
require('scripts/settings/main')
-----------------------------------
local ID = require('scripts/zones/Western_Adoulin/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.FOR_WHOM_DO_WE_TOIL)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.AIMING_FOR_YGNAS },
}

mission.sections =
{
    -- Enter Rala Waterways for a Cutscene
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 356
                end,
            },

            onEventFinish =
            {
                [356] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },
    },

    -- Proceed to the dead end at (C-6) and click the Sluice Gate.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        -- Reminders
        [xi.zone.CELENNIA_MEMORIAL_LIBRARY] =
        {
            ['Yafafa'] = mission:event(1),
            ['History'] = mission:event(1003, 1),
        },

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Sluice_Gate_6'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(343)
                end,
            },

            onEventFinish =
            {
                [343] = function(player, csid, option, npc)
                    if option == 0 then -- Password: HGSI
                        if mission:complete(player) then
                            npcUtil.giveKeyItem(player, xi.ki.NOTE_DETAILING_SEDITIOUS_PLANS)
                        end
                    elseif option == 1 then -- Wrong password before CS
                        -- TODO: Lockout after 3 mistakes
                        player:setMissionStatus(mission.areaId, 2)
                    else -- Wrong password during CS
                        player:setMissionStatus(mission.areaId, 3)
                    end
                end,
            },
        },
    },

    -- Get the password again from the Library
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.CELENNIA_MEMORIAL_LIBRARY] =
        {
            ['Yafafa'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(1)
                end,
            },

            ['History'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(1003, 1)
                end,
            },

            onEventUpdate =
            {
                [1003] = function(player, csid, option, npc)
                    -- Was shown the password
                    if option == 1 then
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,
            },
        },
    },

    -- Click the gate one more time for the KI
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 3
        end,


        [xi.zone.RALA_WATERWAYS] =
        {
            ['Sluice_Gate_6'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: This is a guess, check this
                    if mission:complete(player) then
                        npcUtil.giveKeyItem(player, xi.ki.NOTE_DETAILING_SEDITIOUS_PLANS)
                        return 0
                    end
                end,
            },
        },
    },

}

return mission
