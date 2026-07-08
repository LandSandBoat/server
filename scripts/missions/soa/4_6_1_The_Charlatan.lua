-----------------------------------
-- The Charlatan
-- Seekers of Adoulin M4-6-1
-----------------------------------
-- !addmission 12 105
-- Levil           : !pos -87.204 3.350 12.655 256
-- Ploh Trishbahk  : !pos 100.580 -40.150 -63.830 257
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_CHARLATAN)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.ROYAL_BLESSINGS },
}

local rewardItems =
{
    xi.item.ADOULINS_REFUGE_P1,
    xi.item.YGNASS_RESOLVE_P1,
    xi.item.ARCIELAS_GRACE_P1,
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 127, 0, 0, 0, 1999, 4),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Option') == 0 then
                        return mission:progressEvent(1538, 257, 16744959, utils.MAX_UINT32 - 1, 0, 0, 1487, 1997, 0)
                    else
                        return mission:progressEvent(1548, 257, 23, 2964, 0, 0, 1487, 1997, 0)
                    end
                end,
            },

            onEventUpdate =
            {
                [1538] = function(player, csid, option, npc)
                    if option == 4 then
                        player:updateEvent(0, 0, 65535, 900, 0, 0, 0, 0)
                    else
                        player:updateEvent(option)
                    end
                end,

                [1548] = function(player, csid, option, npc)
                    if option == 4 then
                        player:updateEvent(0, 0, 65535, 900, 0, 0, 0, 0)
                    else
                        player:updateEvent(option)
                    end
                end,
            },

            onEventFinish =
            {
                [1538] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, rewardItems[option]) then
                        mission:complete(player)
                    else
                        mission:setVar(player, 'Option', 1)
                    end

                    -- Experience is given after this cutscene regardless of mission complete.
                    player:addExp(500 * xi.settings.EXP_RATE)
                end,

                [1548] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, rewardItems[option]) then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
