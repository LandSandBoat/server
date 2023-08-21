-----------------------------------
-- Anagnorisis
-- Seekers of Adoulin M4-5-1
-----------------------------------
-- !addmission 12 100
-- Levil          : !pos -87.204 3.350 12.655 256
-- Ploh Trishbahk : !pos 100.580 -40.150 -63.830 257
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.ANAGNORISIS)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.JUST_THE_THING },
}

local rewardItems =
{
    xi.item.ADOULINS_REFUGE,
    xi.item.YGNASS_RESOLVE,
    xi.item.ARCIELAS_GRACE,
}

local function findRewardItem(player)
    for _, necklaceItem in ipairs(rewardItems) do
        if player:hasItem(necklaceItem) then
            return necklaceItem
        end
    end

    return 0
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 0, 0, 4063, 1999, 4480, 0),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] =
            {
                onTrade = function(player, npc, trade)
                    local rewardItem = findRewardItem(player)

                    if npcUtil.tradeHasExactly(trade, rewardItem) then
                        return mission:progressEvent(1544, rewardItem, 23, 2964, 975, 4063, 1999, 1999, 4)
                    end
                end,

                onTrigger = function(player, npc)
                    if findRewardItem(player) ~= 0 then
                        return mission:progressEvent(1545, 257, 23, 2964, 0, 4063, 1999, 1999, 0)
                    else
                        return mission:progressEvent(1553, 257, 1, 1, 0, 66584575, 688478, 4905, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [1544] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                    end
                end,

                [1553] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
