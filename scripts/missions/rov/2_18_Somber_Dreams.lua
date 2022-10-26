-----------------------------------
-- Somber Dreams
-- Rhapsodies of Vana'diel Mission 2-18
-----------------------------------
-- !addmission 13 86
-- qm_cetus : !pos -127.055 -7.849 600.22 89
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/titles')
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
                        local nmCetus = npc:getZone():queryEntitiesByName('Cetus')[1]

                        if not nmCetus:isSpawned() then
                            SpawnMob(nmCetus:getID()):updateClaim(player)

                            return mission:messageSpecial(graubergID.text.SENSE_OF_FOREBODING)
                        end
                    elseif missionStatus == 1 then
                        -- NOTE: The second-to-last parameter appears to be progress-based for previous
                        -- WotG missions; however, has no impact on this event.

                        return mission:progressEvent(48)
                    end
                end,
            },

            ['qm_conflux'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 2 then
                        return mission:progressEvent(49, 89, 23, 2964, 0, 0, 6881300, 0, 0)
                    end
                end,
            },

            ['Cetus'] =
            {
                onMobDeath = function(mob, player, isKiller, noKiller)
                    -- NOTE: Current Cetus implementation is set to level 150 until fully implemented.  In addition,
                    -- when this mob is implemented, there is a 15 minute (non-displayed) timer mechanice for fight
                    -- length, and on failure, the player must zone prior to being able to pop again.  Logging out
                    -- does not stop this timer.

                    mission:setVar(player, 'Status', 1)
                    player:setTitle(xi.title.ABYSSAL_PURVEYOR)
                end,
            },

            onEventFinish =
            {
                [48] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,

                [49] = function(player, csid, option, npc)
                    if option == 99 then
                        player:setPos(-700.042, 0.4, -441.301, 192, xi.zone.WALK_OF_ECHOES)
                    end
                end,
            },
        },

        [xi.zone.WALK_OF_ECHOES] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    -- TODO: Find if there's a message displayed if not charactersAvailable.  At this time, the event
                    -- will not trigger, and mission will not be completed.

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
                        local wotgProgress = player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.MAIDEN_OF_THE_DUSK) and 3 or 0

                        -- NOTE: There are two impacted lines that depend on the below update parameter.  First is "Come off it!" where if parameter
                        -- is 0, it will not display Cait Sith's name, and if non-zero it will.  The last change is if 3, Lilisette disappears back
                        -- to her new realm (post-Maiden of the Dusk), as opposed to running off.

                        player:updateEvent(wotgProgress)
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
