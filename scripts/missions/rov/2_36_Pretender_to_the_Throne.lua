-----------------------------------
-- Pretender to the Throne
-- Rhapsodies of Vana'diel Mission 2-36
-----------------------------------
-- !addmission 13 126
-- qm_rov2_35 : !pos -1.302 -54.038 -603.471 289
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/utils')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------
local eschaRuAunID = require('scripts/zones/Escha_RuAun/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.PRETENDER_TO_THE_THRONE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.BANISHED },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.ESCHA_RUAUN] =
        {
            ['qm_rov2_35'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if
                        missionStatus == 0 and
                        player:hasKeyItem(xi.ki.MOST_CURIOUS_CURIO)
                    then
                        local nmBalamor = npc:getZone():queryEntitiesByName('Balamor')[1]

                        if not nmBalamor:isSpawned() then
                            SpawnMob(nmBalamor:getID()):updateClaim(player)

                            player:messageSpecial(eschaRuAunID.text.SENSE_OF_FOREBODING)
                            player:messageSpecial(eschaRuAunID.text.LOST_KEYITEM, xi.ki.MOST_CURIOUS_CURIO)
                            player:delKeyItem(xi.ki.MOST_CURIOUS_CURIO)

                            return mission:keyItem(xi.ki.MOST_CONFOUNDING_CURIO)
                        end
                    elseif missionStatus == 1 then
                        return mission:progressEvent(7, 2, 300, 200, 100, utils.MAX_UINT32 - 176261, 1204, 666668, 0)
                    end
                end,
            },

            ['Balamor'] =
            {
                onMobDeath = function(mob, player, optParams)
                    mission:setVar(player, 'Status', 1)

                    player:setTitle(xi.title.BANISHER_OF_THE_PROFANE)
                    player:delKeyItem(xi.ki.MOST_CONFOUNDING_CURIO)
                    player:messageSpecial(eschaRuAunID.text.LOST_KEYITEM, xi.ki.MOST_CONFOUNDING_CURIO)
                end,
            },

            afterZoneIn =
            {
                function(player)
                    if
                        player:hasKeyItem(xi.ki.MOST_CONFOUNDING_CURIO)
                    then
                        player:delKeyItem(xi.ki.MOST_CONFOUNDING_CURIO)
                        npcUtil.giveKeyItem(player, xi.ki.MOST_CURIOUS_CURIO)
                    end
                end,
            },

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
