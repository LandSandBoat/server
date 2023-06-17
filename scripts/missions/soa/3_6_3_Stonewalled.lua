-----------------------------------
-- Stonewalled
-- Seekers of Adoulin M3-6-3
-----------------------------------
-- !addmission 12 67
-- Hollowed Pathway : !pos 215.371 39.025 -446.368 267
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/utils')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.STONEWALLED)

mission.reward =
{
    keyItem     = xi.ki.SOUL_SIPHON,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.SALVATION },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(152),
        },

        [xi.zone.KAMIHR_DRIFTS] =
        {
            ['Crawling_Cave'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.AUREATE_BALL_OF_FUR) then
                        npcUtil.giveKeyItem(player, xi.ki.AUREATE_BALL_OF_FUR)

                        return mission:noAction()
                    end
                end,
            },
        },

        [xi.zone.CIRDAS_CAVERNS_U] =
        {
            onEventFinish =
            {
                -- TODO: The assumption for this mission script is to catch Event 1000 which is
                -- sent once the battlefield has been cleared.  This needs to be verified upon
                -- implementation of the instance.
                [1000] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                    player:setPos(-100.727, 29.696, 216.184, 64, xi.zone.CIRDAS_CAVERNS)
                end,
            },
        },

        [xi.zone.CIRDAS_CAVERNS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 30
                    end
                end,
            },

            onEventUpdate =
            {
                [30] = function(player, csid, option, npc)
                    -- TODO: This may be unnecessary, but was observed in capture
                    if option == 1 then
                        player:updateEvent(200, 0, 200, 100, utils.MAX_UINT32 - 365347, 1957, 44223, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [30] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setPos(-210.208, 40.218, -447.346, 243, xi.zone.KAMIHR_DRIFTS)
                    end
                end,
            },
        },
    },
}

return mission
