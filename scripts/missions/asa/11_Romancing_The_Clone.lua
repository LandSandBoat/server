-----------------------------------
-- Romancing The Clone
-- A Shantotto Ascension M11
-----------------------------------
-- !addmission 11 10
-- Aldo : !pos 19.7 3.9 -59 245
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.ROMANCING_THE_CLONE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.SISTERS_IN_ARMS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        -- Played once, on the first zone-in after winning Battaru Royale.
        [xi.zone.FULL_MOON_FOUNTAIN] =
        {
            onZoneIn = function(player, prevZone)
                if mission:getVar(player, 'Intro') == 0 then
                    return 64
                end
            end,

            onEventFinish =
            {
                [64] = function(player, csid, option, npc)
                    mission:setVar(player, 'Intro', 1)
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] = mission:progressEvent(10101),

            onEventFinish =
            {
                [10101] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
