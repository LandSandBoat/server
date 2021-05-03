-----------------------------------
-- The Temple of Uggalepih
-- Zilart M4
-----------------------------------
require('scripts/globals/interaction/mission')
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH)

mission.reward =
{
    keyItem     = xi.ki.DARK_FRAGMENT,
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE },
    title       = xi.title.BEARER_OF_THE_WISEWOMANS_HOPE,
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(8)
                end,
            },
        },

        [xi.zone.KAZHAM] = {
            ['Jakoh_Wahcondalo'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(115)
                end,
            },
        },

        [xi.zone.SACRIFICIAL_CHAMBER] = {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    mission:event(7)
                end,

                [7] = function(player, csid, option, npc)
                    mission:event(8)
                end,

                [8] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.SACRIFICIAL_CHAMBER_KEY)
                    mission:complete()
                end,
            },
        },
    },

    -- Players not on mission should still receive BCNM title
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission ~= mission.missionId
        end,

        [xi.zone.SACRIFICIAL_CHAMBER] = {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    player:addTitle(xi.title.BEARER_OF_THE_WISEWOMANS_HOPE)
                end,
            },
        },
    },
}

return mission
