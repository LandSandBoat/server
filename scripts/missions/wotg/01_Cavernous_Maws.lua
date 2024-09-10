-----------------------------------
-- Cavernous Maws
-- Wings of the Goddess Mission 1
-----------------------------------
-- !addmission 5 0
-- Cavernous Maws:
-- Batallia Downs       : !pos -48 0.1 435 105
-- Rolanberry Fields    : !pos -198 8 361 110
-- Sauromugue Champaign : !pos 369 8 -227 120
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.CAVERNOUS_MAWS)

mission.reward =
{
    keyItem     = xi.ki.PURE_WHITE_FEATHER,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.BACK_TO_THE_BEGINNING },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                xi.settings.main.ENABLE_WOTG == 1
        end,

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['Cavernous_Maw'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(500, 0)
                end,
            },

            onEventFinish =
            {
                [500] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.maws.gotoRandomMaw(player)
                    end
                end,
            },
        },

        [xi.zone.ROLANBERRY_FIELDS] =
        {
            ['Cavernous_Maw'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(500, 1)
                end,
            },

            onEventFinish =
            {
                [500] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.maws.gotoRandomMaw(player)
                    end
                end,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN] =
        {
            ['Cavernous_Maw'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(500, 2)
                end,
            },

            onEventFinish =
            {
                [500] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.maws.gotoRandomMaw(player)
                    end
                end,
            },
        },
    },
}

return mission
