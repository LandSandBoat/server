-----------------------------------
-- A Fate Decided
-- Promathia 8-2
-----------------------------------
-- !addmission 6 818
-- Grand Palace of Hu'Xzoi Particle Gate (!pos 1 0.1 -320 34)
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require("scripts/globals/teleports")
require('scripts/globals/titles')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GRAND_PALACE_OF_HUXZOI] =
        {

            ['_iya'] = -- Gate of the Gods
            {
                onTrigger = function(player, npc)
                    return mission:messageSpecial(zones[npc:getZoneID()].text.PORTAL_DOES_NOT_RESPOND)
                end,
            },

            ['_iyb'] = -- East Particle Gate
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(2)
                    else
                        return mission:progressEvent(56)
                    end
                end,
            },

            ['_iyc'] = -- West Partical Gate
            {
                onTrigger = function(player, npc)
                    return mission:messageSpecial(zones[npc:getZoneID()].text.GATE_DOES_NOT_RESPOND)
                end,
            },

            ['_iyq'] = -- Cermet Portal
            {
                onTrigger = function(player,npc)
                    if mission:getVar(player, 'Status') == 1 and not GetMobByID(zones[npc:getZoneID()].mob.IXGHRAH):isSpawned() then
                        return SpawnMob(zones[npc:getZoneID()].mob.IXGHRAH):updateClaim(player)
                    elseif mission:getVar(player, 'Status') == 2 then
                        return mission:progressEvent(3)
                    end
                end,
            },

            ['_0y0'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(173)
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option)
                    mission:setVar(player, 'Status', 1)
                end,

                [3] = function(player, csid, option)
                    mission:complete(player)
                end,
            },
        }
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.GRAND_PALACE_OF_HUXZOI] =
        {
            ['_iya'] = -- Gate of the Gods
            {
                onTrigger = function(player, npc)
                    return mission:event(52)
                end,
            },

            ['_iyb'] = -- East Particle Gate
            {
                onTrigger = function(player, npc)
                    return mission:event(56)
                end,
            },

            ['_iyc'] = -- West Particle Gate
            {
                onTrigger = function(player, npc)
                    return mission:event(172)
                end,
            },

            ['_iyq'] = -- Cermet Portal
            {
                onTrigger = function(player,npc)
                    return mission:messageSpecial(zones[npc:getZoneID()].text.PORTAL_DOES_NOT_RESPOND)
                end,
            },

            ['_0y0'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(173)
                end,
            },

            onEventFinish =
            {
                [52] = function(player, csid, option)
                    if option == 1 then
                        player:setPos(-419.995, 0, 248.483, 191, xi.zone.THE_GARDEN_OF_RUHMET)
                    end
                end,
            },
        },
    },
}

return mission
