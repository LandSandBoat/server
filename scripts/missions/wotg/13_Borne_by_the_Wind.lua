-----------------------------------
-- Borne by the Wind
-- Wings of the Goddess Mission 13
-----------------------------------
-- !addmission 5 12
-- Bulwark_Gate : !pos -447.174 -1.831 342.417 98
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.BORNE_BY_THE_WIND)

mission.reward =
{
    keyItem     = xi.ki.UNDERPASS_HATCH_KEY,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.A_NATION_ON_THE_BRINK },
}

mission.sections =
{
    -- Go to Sauromugue Champaign (S) and check the Bulwark Gate at (F-6). You will receive Underpass Hatch Key after a long cutscene.
    -- Windower Alert:
    --
    -- Disable fastCS during this cutscene it will freeze at this time.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Radford'] = mission:event(177, 87, 23),
        },

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Velda-Galda'] = mission:event(180, 94, 3),
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN_S] =
        {
            ['Bulwark_Gate'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: What are these args from caps?
                    -- Observed: 98, 5, 1756, 0, 0, 0, 0, 0
                    return mission:progressEvent(5, 98, 0, 2963, 0, 0, 0, 1, 0)
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
