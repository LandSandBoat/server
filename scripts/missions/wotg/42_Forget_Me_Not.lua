-----------------------------------
-- Forget Me Not
-- Wings of the Goddess Mission 42
-----------------------------------
-- !addmission 5 41
-- Cavernous Maws:
-- Batallia Downs           : !pos -48 0.1 435 105
-- Rolanberry Fields        : !pos -198 8 361 110
-- Sauromugue Champaign     : !pos 369 8 -227 120
-- Batallia Downs [S]       : !pos -48 0 435 84
-- Rolanberry Fields [S]    : !pos -198 8 360 91
-- Sauromugue Champaign [S] : !pos 369 8 -227 98
-----------------------------------
require('scripts/missions/wotg/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.FORGET_ME_NOT)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.PILLAR_OF_HOPE },
}

local completeMissionOnZoneIn =
{
    function(player, prevZone)
        if mission:complete(player) then
            xi.wotg.helpers.removeMemoryFragments(player)
        end
    end,
}

local mawOnEventFinish = function(player, csid, option, npc)
    mission:setVar(player, 'Status', 1)
    mission:setVar(player, 'Option', player:getZoneID())

    player:setPos(800, 71.839, 770, 63, xi.zone.GRAUBERG_S)
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(4, 0, 1, 2964, 1700, 43, 0, 0, 0),

            onZoneIn = completeMissionOnZoneIn,

            onEventFinish =
            {
                [4] = mawOnEventFinish,
            },
        },

        [xi.zone.ROLANBERRY_FIELDS] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(503, 1, 26, 0, 6912, 235686, 1205, 183377, 1),

            onZoneIn = completeMissionOnZoneIn,

            onEventFinish =
            {
                [503] = mawOnEventFinish,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(503, 2, 0, 0, 0, 0, 651, 636808, 1),

            onZoneIn = completeMissionOnZoneIn,

            onEventFinish =
            {
                [503] = mawOnEventFinish,
            },
        },

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(8, 0, 0, 0, 0, 0, 6553607, 0, 1),

            onZoneIn = completeMissionOnZoneIn,

            onEventFinish =
            {
                [8] = mawOnEventFinish,
            },
        },

        [xi.zone.ROLANBERRY_FIELDS_S] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(703, 1, 0, 0, 0, 0, 0, 3, 1),

            onZoneIn = completeMissionOnZoneIn,

            onEventFinish =
            {
                [703] = mawOnEventFinish,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN_S] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(703, 2, 300, 200, 100, 0, 5439495, 0, 1),

            onZoneIn = completeMissionOnZoneIn,

            onEventFinish =
            {
                [703] = mawOnEventFinish,
            },
        },

        [xi.zone.GRAUBERG_S] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 33
                    end
                end,
            },

            onEventUpdate =
            {
                [33] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(12, 23, 1756, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [33] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)

                    xi.maws.goToMaw(player, mission:getVar(player, 'Option'))
                end,
            },
        },
    },
}

return mission
