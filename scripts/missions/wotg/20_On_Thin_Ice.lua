-----------------------------------
-- On Thin Ice
-- Wings of the Goddess Mission 20
-----------------------------------
-- !addmission 5 19
-- Raustigne : !pos 3.979 -1.999 44.456 80
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.ON_THIN_ICE)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.PROOF_OF_VALOR },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Raustigne'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(147, player:getCampaignAllegiance(), 16, 1)
                end,
            },

            onEventFinish =
            {
                [147] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
