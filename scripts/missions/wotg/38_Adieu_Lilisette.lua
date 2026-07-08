-----------------------------------
-- Adieu, Lilisette
-- Wings of the Goddess Mission 38
-----------------------------------
-- !addmission 5 37
-- Lion Springs Door : !pos 96 0 106 80
-----------------------------------
require('scripts/missions/wotg/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.ADIEU_LILISETTE)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.BY_THE_FADING_LIGHT },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                xi.wotg.helpers.meetsMission38Reqs(player)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Lion_Springs'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(166, player:getCampaignAllegiance())
                end,
            },

            ['Rholont'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Check if this message changes if the player is aligned with a
                    -- different nation, and has/has not completed Face of the Future.

                    if player:getCampaignAllegiance() == 1 then
                        return mission:event(674, 80, 23)
                    end
                end,
            },

            onEventFinish =
            {
                [166] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
