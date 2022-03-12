-----------------------------------
-- Below the Arks
-- Promathia 1-2
-----------------------------------
-- !addmission 6 118
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require("scripts/globals/teleports")
require('scripts/globals/utils')
require('scripts/globals/zone')
require('scripts/missions/cop/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.BELOW_THE_ARKS)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS },
}

local promyvionOnZoneIn =
{
    function(player, prevZone)
        if mission:getVar(player, 'Option') == 0 then
            return 50
        end
    end,
}

-- TODO: This might be reused in Mothercrystals
local spireEventFinish = function(player, csid, option, npc)
    -- This variable is an offset based on a 0-indexed version promyvionCrags table.
    local promyvionId = (player:getZoneID() - 17) / 2

    player:addKeyItem(xi.ki.LIGHT_OF_HOLLA + promyvionId)
    player:messageSpecial(zones[player:getZoneID()].text.CANT_REMEMBER, xi.ki.LIGHT_OF_HOLLA + promyvionId)
    player:addExp(1500)
    player:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.EXITPROMHOLLA + promyvionId, 0, 1)
    mission:complete(player)
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
                onTrigger = xi.cop.helpers.shatteredTelepointOnTrigger,
            },

            onEventFinish =
            {
                [913] = xi.cop.helpers.shatteredTelepointEntry,
                [918] = xi.cop.helpers.shatteredTelepointSealMemory,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = xi.cop.helpers.shatteredTelepointOnTrigger,
            },

            onEventFinish =
            {
                [202] = xi.cop.helpers.shatteredTelepointEntry,
                [212] = xi.cop.helpers.shatteredTelepointSealMemory,
            },
        },

        [xi.zone.TAHRONGI_CANYON] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = xi.cop.helpers.shatteredTelepointOnTrigger,
            },

            onEventFinish =
            {
                [913] = xi.cop.helpers.shatteredTelepointEntry,
                [918] = xi.cop.helpers.shatteredTelepointSealMemory,
            },
        },

        [xi.zone.HALL_OF_TRANSFERENCE] =
        {
            ['_0e0'] =
            {
                onTrigger = xi.cop.helpers.cermetGateOnTrigger,
            },

            ['_0e1'] =
            {
                onTrigger = xi.cop.helpers.cermetGateOnTrigger,
            },

            ['_0e2'] =
            {
                onTrigger = xi.cop.helpers.cermetGateOnTrigger,
            },

            ['_0e3'] =
            {
                onTrigger = xi.cop.helpers.largeApparatusOnTrigger,
            },

            ['_0e5'] =
            {
                onTrigger = xi.cop.helpers.largeApparatusOnTrigger,
            },

            ['_0e7'] =
            {
                onTrigger = xi.cop.helpers.largeApparatusOnTrigger,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    return 108
                end,
            },

            onEventFinish =
            {
                [160] = function(player, csid, option, npc)
                    -- The same event is used by all Large Apparatus NPCs, so we need to determine where to send
                    -- the player.  For safety to not repeat this cutscene, the Option value isn't set until zoning
                    -- in, so instead, extract that information from the NPC name.  This will convert NPCs _0e3,
                    -- _0e5, and _0e7 to the value 1, 2, or 3 to align with the promyvionCrags table.

                    local cragLocation = math.ceil(tonumber(string.sub(npc:getName(), -1)) / 3)

                    if cragLocation == xi.cop.helpers.promyvionCrags.HOLLA then
                        player:setPos(92.033, 0, 80.380, 255, 16)
                    elseif cragLocation == xi.cop.helpers.promyvionCrags.DEM then
                        player:setPos(185.891, 0, -52.331, 128, 18)
                    elseif cragLocation == xi.cop.helpers.promyvionCrags.MEA then
                        player:setPos(-93.268, 0, 170.749, 162, 20)
                    end
                end,
            },
        },

        [xi.zone.PROMYVION_DEM] =
        {
            onZoneIn = promyvionOnZoneIn,

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
            onZoneIn = promyvionOnZoneIn,

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
            onZoneIn = promyvionOnZoneIn,

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
