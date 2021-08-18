-----------------------------------
-- For Whom Do We Toil?
-- Seekers of Adoulin M2-5-2
-----------------------------------
-- !addmission 12 23
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.FOR_WHOM_DO_WE_TOIL)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.AIMING_FOR_YGNAS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.THE_CELENNIA_MEMORIAL_LIBRARY] =
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

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.THE_CELENNIA_MEMORIAL_LIBRARY] =
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
                    if option == 0 then
                        if mission:complete(player) then
                            npcUtil.giveKeyItem(player, xi.ki.NOTE_DETAILING_SEDITIOUS_PLANS)
                        end
                    else -- Wrong password
                        -- TODO: Lockout after 3 mistakes
                    end
                end,
            },
        },
    },
}

return mission
