-----------------------------------
-- Courier Catastrophe
-- Seekers of Adoulin M4-1-2
-----------------------------------
-- !addmission 12 73
-- Levil        : !pos -87.204 3.350 12.655 256
-- Kipligg      : !pos -32 0 22 256
-- Port Storage : !pos 85.578 30.5 180.639 256
-----------------------------------
local westernAdoulinID = zones[xi.zone.WESTERN_ADOULIN]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.COURIER_CATASTROPHE)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.DONE_AND_DELIVERED },
}

local missionItems =
{
    { xi.item.EFT_SKIN,                    5 },
    { xi.item.LOCK_OF_MANTICORE_HAIR,      4 },
    { xi.item.BUFFALO_HORN,                1 },
    { xi.item.SQUARE_OF_MANTICORE_LEATHER, 1 },
    { xi.item.SQUARE_OF_BUFFALO_LEATHER,   1 },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Kipligg'] = mission:progressEvent(162, 256),
            ['Levil']   = mission:event(161),

            ['Port_Storage'] =
            {
                onTrade = function(player, npc, trade)
                    local requiredItems = mission:getVar(player, 'Option')

                    if npcUtil.tradeHasExactly(trade, { missionItems[requiredItems] }) then
                        return mission:progressEvent(167, 8, 0, 5, 0)
                    end
                end,

                onTrigger = function(player, npc)
                    local requiredItems = mission:getVar(player, 'Option')

                    return mission:messageSpecial(westernAdoulinID.text.TASKED_WITH_PROCURING, 0, missionItems[requiredItems][1], missionItems[requiredItems][2])
                end,
            },

            onEventFinish =
            {
                [167] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return mission
