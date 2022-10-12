-----------------------------------
-- Somber Dreams
-- Rhapsodies of Vana'diel Mission 2-18
-----------------------------------
-- !addmission 13 86
-- qm_cetus : !pos -127.055 -7.849 600.22 89
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------
local graubergID = require('scripts/zones/Grauberg_[S]/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.SOMBER_DREAMS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.OF_LIGHT_AND_DARKNESS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['qm_cetus'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 0 then
                        local nmCetus = npc:getZone():queryEntitiesByName('Cetus')

                        if not nmCetus:isSpawned() then
                            SpawnMob(nmCetus:getID()):updateClaim(player)

                            return mission:messageSpecial(graubergID.text.SENSE_OF_FOREBODING)
                        end
                    elseif missionStatus == 1 then
                        return mission:progressEvent(48, 0, 300, 200, 100, 0, utils.MAX_UINT32 - 33554432, 3, 4095)
                    end
                end,
            },

            ['Cetus'] =
            {
                onMobDeath = function(mob, player, isKiller, noKiller)
                    mission:setVar(player, 'Status', 1)
                end,
            },

            onEventFinish =
            {
                [48] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,
            },
        },

        [xi.zone.WALK_OF_ECHOES] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    -- TODO: Find if there's a message displayed if not charactersAvailable.

                    if
                        prevZone == xi.zone.GRAUBERG_S and
                        mission:getVar(player, 'Status') == 2 and
                        xi.rhapsodies.charactersAvailable(player)
                    then
                        return 28
                    end
                end,
            },

            onEventUpdate =
            {
                [28] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(3, 0, 1756, 0, utils.MAX_UINT32 - 805302015, utils.MAX_UINT32 - 805298431, utils.MAX_UINT32 - 805306367, 1)
                    end
                end,
            },

            onEventFinish =
            {
                [28] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
