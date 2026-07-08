-----------------------------------
-- Beauty and the Beast
-- Seekers of Adoulin M3-5
-----------------------------------
-- !addmission 12 57
-- Ploh Trishbahk : !pos 100.580 -40.150 -63.830 257
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.BEAUTY_AND_THE_BEAST)

mission.reward =
{
    keyItem     = xi.ki.PRISTINE_HAIR_RIBBON,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.WILDCAT_WITH_A_GOLD_PELT },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CEIZAK_BATTLEGROUNDS] =
        {
            ['Signs_of_a_Struggle'] = mission:progressEvent(21),

            onEventFinish =
            {
                [21] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] = mission:event(5063):importantOnce(),
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(143),
        },
    },
}

return mission
