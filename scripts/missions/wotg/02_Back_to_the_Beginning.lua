-----------------------------------
-- Back to the Beginning
-- Wings of the Goddess Mission 2
-----------------------------------
-- TODO:
-- !addmission 4 0
-- Cavernous Maws:
-- Batallia Downs       : !pos -48 0.1 435 105
-- Rolanberry Fields    : !pos -198 8 361 110
-- Sauromugue Champaign : !pos 369 8 -227 120
-----------------------------------
require("scripts/globals/keyitems")
require('scripts/globals/maws')
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.BACK_TO_THE_BEGINNING)

mission.reward =
{
    keyItem     = xi.ki.LIGHTWORM,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.CAIT_SITH },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                   xi.maws.meetsMission2Reqs(player)
        end,

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(500),

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
            ['Cavernous_Maw'] = mission:progressEvent(500),

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
            ['Cavernous_Maw'] = mission:progressEvent(500),

            onEventFinish =
            {
                [500] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.maws.gotoRandomMaw(player)
                    end
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(500),

            onEventFinish =
            {
                [500] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.maws.gotoRandomMaw(player)
                    end
                end,
            },
        },

        [xi.zone.ROLANBERRY_FIELDS_S] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(500),

            onEventFinish =
            {
                [500] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.maws.gotoRandomMaw(player)
                    end
                end,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN_S] =
        {
            ['Cavernous_Maw'] = mission:progressEvent(500),

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
