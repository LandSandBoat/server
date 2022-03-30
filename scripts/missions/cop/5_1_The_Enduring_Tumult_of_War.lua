-----------------------------------
-- The Enduring Tumult of War
-- Promathia 5-1
-----------------------------------
-- !addmission 6 448
-- Despachiaire :
-- Chasalvige   :
-- Anoki        :
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/zone')
-----------------------------------
local psoXjaID = require("scripts/zones/PsoXja/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.DESIRES_OF_EMPTINESS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] =
            {
                onTrigger = function(player, npc)
                    if
                        mission:getVar(player, 'Status') == 0 and
                        not mission:isVarBitsSet(player, 'Option', 0)
                    then
                        return mission:event(117):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [117] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Option', 0)
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Chasalvige'] =
            {
                onTrigger = function(player, npc)
                    if
                        mission:getVar(player, 'Status') == 0 and
                        not mission:isVarBitsSet(player, 'Option', 1)
                    then
                        return mission:event(761):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [761] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Option', 1)
                end,
            },
        },

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Anoki'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        if not mission:isVarBitsSet(player, 'Option', 2) then
                            return mission:event(724):importantEvent()
                        elseif not mission:isVarBitsSet(player, 'Option', 3) then
                            return mission:event(728):importantEvent()
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [724] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Option', 2)
                end,

                [728] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Option', 3)
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 0 then
                        return 306
                    end
                end,
            },

            onEventFinish =
            {
                [306] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:progressEvent(849)
                    end
                end,
            },

            onEventFinish =
            {
                [849] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,
            },
        },

        [xi.zone.PSOXJA] =
        {
            ['_i98'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if
                        missionStatus == 3 and
                        not GetMobByID(psoXjaID.mob.NUNYUNUWI):isSpawned()
                    then
                        SpawnMob(psoXjaID.mob.NUNYUNUWI):updateClaim(player)
                        return mission:messageSpecial(psoXjaID.text.TRAP_ACTIVATES)
                    elseif missionStatus == 4 then
                        if player:getZPos() < 318 then
                            return mission:event(69)
                        else
                            return mission:event(70)
                        end
                    end
                end,
            },

            ['_i99'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 4 then
                        return mission:progressEvent(2)
                    end
                end,
            },

            ['Nunyunuwi'] =
            {
                onMobDeath = function(mob, player, isKiller, noKiller)
                    if mission:getVar(player, 'Status') == 3 then
                        mission:setVar(player, 'Status', 4)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        player:getXPos() == -300 and
                        prevZone == xi.zone.BEAUCEDINE_GLACIER and
                        mission:getVar(player, 'Status') == 2
                    then
                        return 1
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 3)
                end,

                [2] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:complete(player)
                        player:setPos(-14.744, 0.036, -119.736, 1, 22)
                    end
                end,
            },
        },
    },
}

return mission
