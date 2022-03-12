-----------------------------------
-- The Mothercrystals
-- Promathia 1-3
-----------------------------------
-- !addmission 6 128
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require("scripts/globals/teleports")
require('scripts/globals/utils')
require('scripts/globals/zone')
require('scripts/missions/cop/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.AN_INVITATION_WEST },
}

local shatteredTelepointOnTrigger = function(player, npc)
    if
        xi.cop.helpers.numPromyvionCompleted(player) == 1 and
        not xi.cop.helpers.hasCompletedPromyvion(player, player:getZoneID()) and
        mission:getVar(player, 'Option') == 0
    then
        local zoneId = player:getZoneID()

        player:setLocalVar('toPromyvion', xi.cop.helpers.shatteredTelepointInfo[zoneId][1])
        return mission:progressEvent(xi.cop.helpers.shatteredTelepointInfo[zoneId][2] - 1)
    else
        return xi.cop.helpers.shatteredTelepointOnTrigger(player, npc)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.KONSCHTAT_HIGHLANDS] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = shatteredTelepointOnTrigger,
            },

            onEventFinish =
            {
                [912] = xi.cop.helpers.sendToZoneOnFinish,
                [913] = xi.cop.helpers.shatteredTelepointEntry,
                [918] = xi.cop.helpers.shatteredTelepointSealMemory,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = shatteredTelepointOnTrigger,
            },

            onEventFinish =
            {
                [201] = xi.cop.helpers.sendToZoneOnFinish,
                [202] = xi.cop.helpers.shatteredTelepointEntry,
                [212] = xi.cop.helpers.shatteredTelepointSealMemory,
            },
        },

        [xi.zone.TAHRONGI_CANYON] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = shatteredTelepointOnTrigger,
            },

            onEventFinish =
            {
                [912] = xi.cop.helpers.sendToZoneOnFinish,
                [913] = xi.cop.helpers.shatteredTelepointEntry,
                [918] = xi.cop.helpers.shatteredTelepointSealMemory,
            },
        },

        [xi.zone.HALL_OF_TRANSFERENCE] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        xi.cop.helpers.numPromyvionCompleted(player) == 2 and
                        not xi.cop.helpers.hasCompletedPromyvion(player, prevZone) and
                        mission:getVar(player, 'Status') == 0
                    then
                        player:setLocalVar('toPromyvion', xi.cop.helpers.shatteredTelepointInfo[prevZone][1])
                        return 155
                    end
                end,
            },

            onEventFinish =
            {
                [123] = xi.cop.helpers.largeApparatusOnEventFinish,
                [125] = xi.cop.helpers.largeApparatusOnEventFinish,
                [128] = xi.cop.helpers.largeApparatusOnEventFinish,

                [155] = function(player, csid, option, npc)
                    -- This event only happens once since there is no sealing component.
                    mission:setVar(player, 'Status', 1)
                    xi.cop.helpers.sendToPromyvionZone(player:getLocaLVar('toPromyvion'))
                end,
            },
        },

        [xi.zone.SPIRE_OF_DEM] =
        {
            onEventFinish =
            {
                [32001] = xi.cop.helpers.spireEventFinish,
            },
        },

        [xi.zone.PROMYVION_HOLLA] =
        {
            onZoneIn = xi.cop.helpers.promyvionOnZoneIn,

            onEventFinish =
            {
                [50] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', xi.cop.helpers.promyvionCrags.HOLLA)
                end,
            },
        },

        [xi.zone.SPIRE_OF_HOLLA] =
        {
            onEventFinish =
            {
                [32001] = xi.cop.helpers.spireEventFinish,
            },
        },

        [xi.zone.PROMYVION_MEA] =
        {
            onZoneIn = xi.cop.helpers.promyvionOnZoneIn,

            onEventFinish =
            {
                [50] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', xi.cop.helpers.promyvionCrags.MEA)
                end,
            },
        },

        [xi.zone.SPIRE_OF_MEA] =
        {
            onEventFinish =
            {
                [32001] = xi.cop.helpers.spireEventFinish,
            },
        },
    },
}

return mission
