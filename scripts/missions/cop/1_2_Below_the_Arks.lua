-----------------------------------
-- Below the Arks
-- Promathia 1-2
-----------------------------------
-- !addmission 6 118
-- Pherimociel                     : !pos -31.627 1.002 67.956 243
-- Shattered Telepoint (Konschtat) : !pos 135 19 220 108
-- Shattered Telepoint (La Theine) : !pos 334 19 -60 102
-- Shattered Telepoint (Tahrongi)  : !pos 179 35 255 117
-----------------------------------
require('scripts/missions/cop/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.BELOW_THE_ARKS)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS },
}

-- Some helper functions require access to this mission class in order to operate.  The below
-- functions wrap the helper to ensure that value gets to them.
local cermetGateOnTrigger = function(player, npc)
    return xi.cop.helpers.cermetGateOnTrigger(mission, player, npc)
end

local shatteredTelepointOnTrigger = function(player, npc)
    if mission:getVar(player, 'Status') == 1 then
        return xi.cop.helpers.shatteredTelepointOnTrigger(mission, player, npc)
    end
end

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

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Pherimociel'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 0 then
                        return mission:progressEvent(24)
                    elseif missionStatus == 1 then
                        return mission:event(25):replaceDefault()
                    end
                end,
            },

            ['High_Wind'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:event(33)
                    end
                end,
            },

            ['Rainhard'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:event(34)
                    end
                end,
            },

            onEventFinish =
            {
                [24] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Monberaux'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:event(9)
                    end
                end,
            },
        },

        [xi.zone.KONSCHTAT_HIGHLANDS] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = shatteredTelepointOnTrigger,
            },

            onEventFinish =
            {
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
                [913] = xi.cop.helpers.shatteredTelepointEntry,
                [918] = shatteredTelepointSealMemory,
            },
        },

        [xi.zone.HALL_OF_TRANSFERENCE] =
        {
            ['_0e0'] =
            {
                onTrigger = cermetGateOnTrigger,
            },

            ['_0e1'] =
            {
                onTrigger = cermetGateOnTrigger,
            },

            ['_0e2'] =
            {
                onTrigger = cermetGateOnTrigger,
            },

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
                    return 108
                end,
            },

            onEventFinish =
            {
                [122] = largeApparatusOnEventFinish,
                [125] = largeApparatusOnEventFinish,
                [128] = largeApparatusOnEventFinish,

                [160] = function(player, csid, option, npc)
                    -- The same event is used by all Large Apparatus NPCs, so we need to determine where to send
                    -- the player.  For safety to not repeat this cutscene, the Option value isn't set until zoning
                    -- in, so instead, extract that information from the NPC name.  This will convert NPCs _0e3,
                    -- _0e5, and _0e7 to the value 1, 2, or 3 to align with the promyvionCrags table.

                    local cragLocation = math.ceil(tonumber(string.sub(npc:getName(), -1)) / 3)

                    xi.cop.helpers.sendToPromyvionZone(player, cragLocation)
                end,
            },
        },

        [xi.zone.PROMYVION_DEM] =
        {
            onZoneIn = xi.cop.helpers.promyvionOnZoneIn,

            onEventFinish =
            {
                [50] = function(player, csid, option, npc)
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
                [50] = function(player, csid, option, npc)
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
                [50] = function(player, csid, option, npc)
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
