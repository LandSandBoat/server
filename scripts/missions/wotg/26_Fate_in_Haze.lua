-----------------------------------
-- Fate in Haze
-- Wings of the Goddess Mission 26
-----------------------------------
-- !addmission 5 25
-- Lion Springs Door : !pos 96 0 106 80
-----------------------------------
require('scripts/missions/wotg/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.FATE_IN_HAZE)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.THE_SCENT_OF_BATTLE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                xi.wotg.helpers.meetsMission26Reqs(player)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Lion_Springs'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(151, player:getCampaignAllegiance(), 0, 1, 0)
                end,
            },

            ['Rholont'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Check if this message changes if the player is aligned with a
                    -- different nation, and has/has not completed Blood of Heroes.

                    if player:getCampaignAllegiance() == 1 then
                        return mission:event(656)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 1 then
                        return 154
                    elseif missionStatus == 2 then
                        return 155
                    end
                end,
            },

            onEventUpdate =
            {
                [154] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(player:getCampaignAllegiance(), 0, 1756)
                    end
                end,

                [155] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(player:getCampaignAllegiance(), 0, 1756)
                    end
                end,
            },

            onEventFinish =
            {
                [151] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                    player:setPos(100.801, 1, 103.211, 31, xi.zone.SOUTHERN_SAN_DORIA_S)
                end,

                [154] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                    player:setPos(100.801, 1, 103.211, 31, xi.zone.SOUTHERN_SAN_DORIA_S)
                end,

                [155] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
