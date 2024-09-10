-----------------------------------
-- Back to the Beginning
-- Wings of the Goddess Mission 2
-----------------------------------
-- !addmission 5 1
-- FIRES_OF_DISCONTENT  : !completequest 7 13
-- CLAWS_OF_THE_GRIFFON : !completequest 7 16
-- THE_TIGRESS_STRIKES  : !completequest 7 18
-- Cavernous Maws:
-- Batallia Downs           : !pos -48 0.1 435 105
-- Rolanberry Fields        : !pos -198 8 361 110
-- Sauromugue Champaign     : !pos 369 8 -227 120
-- Batallia Downs [S]       : !pos -48 0 435 84
-- Rolanberry Fields [S]    : !pos -198 8 360 91
-- Sauromugue Champaign [S] : !pos 369 8 -227 98
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.BACK_TO_THE_BEGINNING)

mission.reward =
{
    keyItem     = xi.ki.LIGHTSWORM,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.CAIT_SITH },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(501),

            onEventFinish =
            {
                [501] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.maws.addMaw(player)
                    end
                end,
            },
        },

        [xi.zone.ROLANBERRY_FIELDS] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(501),

            onEventFinish =
            {
                [501] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.maws.addMaw(player)
                    end
                end,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(501),

            onEventFinish =
            {
                [501] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.maws.addMaw(player)
                    end
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(701),

            onEventFinish =
            {
                [701] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.maws.addMaw(player)
                    end
                end,
            },
        },

        [xi.zone.ROLANBERRY_FIELDS_S] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(701),

            onEventFinish =
            {
                [701] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.maws.addMaw(player)
                    end
                end,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN_S] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(701),

            onEventFinish =
            {
                [701] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.maws.addMaw(player)
                    end
                end,
            },
        },
    },
}

return mission
