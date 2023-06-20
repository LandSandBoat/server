-----------------------------------
-- Nashmeira's Plea
-- Aht Uhrgan Mission 44
-----------------------------------
-- !addmission 4 43
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-- blank_lamp    : !pos 206.55 -1.5 20.05 72
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.NASHMEIRAS_PLEA)

mission.reward =
{
    title       = xi.title.PREVENTER_OF_RAGNAROK,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.RAGNAROK },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.MYTHRIL_MIRROR) then
                        return mission:progressEvent(3156, { text_table = 0 })
                    else
                        return mission:progressEvent(3149, { text_table = 0 })
                    end
                end,
            },

            onEventFinish =
            {
                [3156] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MYTHRIL_MIRROR)
                end,
            },
        },

        [xi.zone.ALZADAAL_UNDERSEA_RUINS] =
        {
            ['blank_lamp'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(8)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return 10
                    end
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    if option == 0 then
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,

                [10] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                -- TODO: This is a workaround for _20m (Runic Seal) NPC onEventFinish not being
                -- called during event 116.  This will finish things up and send the player to the
                -- instance.
                [116] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        player:getLocalVar("INSTANCE_ID") == 7701
                    then
                        xi.instance.onEventFinish(player, csid, option)
                    end
                end,
            },
        },
    },
}

return mission
