-----------------------------------
-- Escha Ru'Aun
-- Rhapsodies of Vana'diel Mission 2-29
-----------------------------------
-- !addmission 13 110
-- Undulating Confluence : !pos -48.977 -23.309 572.489 25
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.ESCHA_RUAUN)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_DECISIVE_HEROINE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.MISAREAUX_COAST] =
        {
            ['Undulating_Confluence'] =
            {
                onTrigger = function(player, npc)
                    -- NOTE: Returned values for this mission are based on all mission completion.

                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(18, 0, utils.MAX_UINT32 - 8411, 79658, 1575, 65281404, 5329899, 4095, 393333)
                    end
                end,
            },

            onEventFinish =
            {
                [18] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.ESCHA_RUAUN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 2
                    end
                end,
            },

            onEventUpdate =
            {
                [2] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(2, 300, 200, 100, utils.MAX_UINT32 - 187409, 794, 568754, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
