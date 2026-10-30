-----------------------------------
-- An Uneasy Peace
-- A Shantotto Ascension M14
-----------------------------------
-- !addmission 11 13
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.AN_UNEASY_PEACE)

mission.reward =
{
    keyItem     = xi.keyItem.BEHEMOTH_KEY,
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        -- Played once, on the first zone-in after winning Project: Shantottofication.
        [xi.zone.SACRIFICIAL_CHAMBER] =
        {
            onZoneIn = function(player, prevZone)
                if mission:getVar(player, 'Intro') == 0 then
                    return 5
                end
            end,

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    mission:setVar(player, 'Intro', 1)
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            onZoneIn = function(player, prevZone)
                if
                    prevZone == xi.zone.WINDURST_WATERS or
                    prevZone == xi.zone.WINDURST_WOODS
                then
                    return 511
                end
            end,

            onEventFinish =
            {
                [511] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
