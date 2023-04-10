-----------------------------------
-- Path of Darkness
-- Aht Uhrgan Mission 42
-----------------------------------
-- !addmission 4 40
-- Rodin-Comidin : !pos 17.205 -5.999 51.161 50
-- blank_lamp    : !pos 206.55 -1.5 20.05 72
-- _1e1 (Door)   : !pos 23 -6 -63 50
-----------------------------------
require('scripts/globals/instance')
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.PATH_OF_DARKNESS)

mission.reward =
{
    title       = xi.title.NAJAS_COMRADE_IN_ARMS,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.FANGS_OF_THE_LION },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = mission:event(3148, { text_table = 0 }),

            ['Rodin-Comidin'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.NYZUL_ISLE_ROUTE) then
                        return mission:progressEvent(3142, { text_table = 0 })
                    else
                        return mission:progressEvent(3141, { text_table = 0 })
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    -- Naja Salaheem interactions require the 9th argument set to 0.
                    -- This is because Aht Uhrgan Whitegate uses 2 different dats.
                    if player:getMissionStatus(mission.areaId) > 0 then
                        local blockedDialog = mission:getLocalVar(player, 'blockedDialog')

                        return mission:progressEvent(3143, { [6] = blockedDialog, text_table = 0 })
                    end
                end,
            },

            onEventFinish =
            {
                [3142] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.NYZUL_ISLE_ROUTE)
                end,

                [3143] = function(player, csid, option, npc)
                    mission:setLocalVar(player, 'blockedDialog', 1)
                    player:setPos(23.978, -6, -64.624, 63)
                end,
            },
        },

        [xi.zone.ALZADAAL_UNDERSEA_RUINS] =
        {
            ['blank_lamp'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(6)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return 7
                    end
                end,
            },

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    if option == 0 then
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,

                [7] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                -- TODO: This is a workaround for _20m (Runic Seal) NPC onEventFinish not being
                -- called during event 116.  This will finish things up and send the player to the
                -- instance.
                [116] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        player:getLocalVar("INSTANCE_ID") == 7700
                    then
                        xi.instance.onEventFinish(player, csid, option)
                    end
                end,
            },
        },
    },
}

return mission
