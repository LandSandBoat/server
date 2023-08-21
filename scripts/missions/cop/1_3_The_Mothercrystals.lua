-----------------------------------
-- The Mothercrystals
-- Promathia 1-3
-----------------------------------
-- !addmission 6 128
-- Shattered Telepoint (Konschtat) : !pos 135 19 220 108
-- Shattered Telepoint (La Theine) : !pos 334 19 -60 102
-- Shattered Telepoint (Tahrongi)  : !pos 179 35 255 117
-----------------------------------
require('scripts/missions/cop/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS)

mission.reward =
{
    title = xi.title.ANCIENT_FLAME_FOLLOWER,
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.AN_INVITATION_WEST },
}

-- Some helper functions require access to this mission class in order to operate.  The below
-- functions wrap the helper to ensure that value gets to them.
local shatteredTelepointSealMemory = function(player, csid, option, npc)
    xi.cop.helpers.shatteredTelepointSealMemory(mission, player, csid, option, npc)
end

local largeApparatusOnTrigger = function(player, npc)
    return xi.cop.helpers.largeApparatusOnTrigger(mission, player, npc)
end

local largeApparatusOnEventFinish = function(player, csid, option, npc)
    xi.cop.helpers.largeApparatusOnEventFinish(mission, player, csid, option, npc)
end

local spireEventFinish = function(player, csid, option, npc)
    xi.cop.helpers.spireEventFinish(mission, player, csid, option, npc)
end

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
        return xi.cop.helpers.shatteredTelepointOnTrigger(mission, player, npc)
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
                [918] = shatteredTelepointSealMemory,
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
                [212] = shatteredTelepointSealMemory,
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
                [918] = shatteredTelepointSealMemory,
            },
        },

        [xi.zone.HALL_OF_TRANSFERENCE] =
        {
            ['_0e3'] =
            {
                onTrigger = largeApparatusOnTrigger,
            },

            ['_0e5'] =
            {
                onTrigger = largeApparatusOnTrigger,
            },

            ['_0e7'] =
            {
                onTrigger = largeApparatusOnTrigger,
            },

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
                [122] = largeApparatusOnEventFinish,
                [125] = largeApparatusOnEventFinish,
                [128] = largeApparatusOnEventFinish,

                [155] = function(player, csid, option, npc)
                    -- This event only happens once since there is no sealing component.
                    mission:setVar(player, 'Status', 1)
                    xi.cop.helpers.sendToPromyvionZone(player:getLocaLVar('toPromyvion'))
                end,
            },
        },

        [xi.zone.PROMYVION_DEM] =
        {
            onZoneIn = xi.cop.helpers.promyvionOnZoneIn,

            onEventFinish =
            {
                [51] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', xi.cop.helpers.promyvionCrags.DEM)
                end,

                [52] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', xi.cop.helpers.promyvionCrags.DEM)
                end,
            },
        },

        [xi.zone.SPIRE_OF_DEM] =
        {
            onEventFinish =
            {
                [32001] = spireEventFinish,
            },
        },

        [xi.zone.PROMYVION_HOLLA] =
        {
            onZoneIn = xi.cop.helpers.promyvionOnZoneIn,

            onEventFinish =
            {
                [51] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', xi.cop.helpers.promyvionCrags.HOLLA)
                end,

                [52] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', xi.cop.helpers.promyvionCrags.HOLLA)
                end,
            },
        },

        [xi.zone.SPIRE_OF_HOLLA] =
        {
            onEventFinish =
            {
                [32001] = spireEventFinish,
            },
        },

        [xi.zone.PROMYVION_MEA] =
        {
            onZoneIn = xi.cop.helpers.promyvionOnZoneIn,

            onEventFinish =
            {
                [51] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', xi.cop.helpers.promyvionCrags.MEA)
                end,

                [52] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', xi.cop.helpers.promyvionCrags.MEA)
                end,
            },
        },

        [xi.zone.SPIRE_OF_MEA] =
        {
            onEventFinish =
            {
                [32001] = spireEventFinish,
            },
        },
    },
}

return mission
