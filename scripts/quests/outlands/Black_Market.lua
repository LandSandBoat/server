-----------------------------------
-- Black Market
-----------------------------------
-- Log ID: 5, Quest ID: 130
-- Muzaffar : !pos 16.678, -2.044, -14.600 252
-----------------------------------
local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.BLACK_MARKET)

quest.reward =
{
    title = xi.title.BLACK_MARKETEER,
}

local gilRewards = { 1500, 2000, 3000 }
local fameRewards = { 40, 50, 80 }

local function handleTurnIn(player, fameAmount, gilAmount)
    player:confirmTrade()
    player:addFame(xi.fameArea.NORG, fameAmount)
    npcUtil.giveCurrency(player, 'gil', gilAmount)
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.NORG] =
        {
            ['Muzaffar'] = quest:progressEvent(15),

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORG] =
        {
            ['Muzaffar'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.NORTHERN_FUR, 4 } }) then
                        return quest:progressEvent(17, xi.item.NORTHERN_FUR, xi.item.NORTHERN_FUR)
                    elseif npcUtil.tradeHasExactly(trade, { { xi.item.PIECE_OF_EASTERN_POTTERY, 4 } }) then
                        return quest:progressEvent(18, xi.item.PIECE_OF_EASTERN_POTTERY, xi.item.PIECE_OF_EASTERN_POTTERY)
                    elseif npcUtil.tradeHasExactly(trade, { { xi.item.SOUTHERN_MUMMY, 4 } }) then
                        return quest:progressEvent(19, xi.item.SOUTHERN_MUMMY, xi.item.SOUTHERN_MUMMY)
                    end
                end,

                onTrigger =  quest:event(16),
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        handleTurnIn(player, fameRewards[0], gilRewards[0])
                    end
                end,

                [18] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        handleTurnIn(player, fameRewards[1], gilRewards[1])
                    end
                end,

                [19] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        handleTurnIn(player, fameRewards[2], gilRewards[2])
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.NORG] =
        {
            ['Muzaffar'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(20)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.NORTHERN_FUR, 4 } }) then
                        return quest:progressEvent(17, 1199, 1199)
                    elseif npcUtil.tradeHasExactly(trade, { { xi.item.PIECE_OF_EASTERN_POTTERY, 4 } }) then
                        return quest:progressEvent(18, 1200, 1200)
                    elseif npcUtil.tradeHasExactly(trade, { { xi.item.SOUTHERN_MUMMY, 4 } }) then
                        return quest:progressEvent(19, 1201, 1201)
                    end
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    handleTurnIn(player, fameRewards[0], gilRewards[0])
                    player:addTitle(xi.title.BLACK_MARKETEER)
                end,

                [18] = function(player, csid, option, npc)
                    handleTurnIn(player, fameRewards[1], gilRewards[1])
                    player:addTitle(xi.title.BLACK_MARKETEER)
                end,

                [19] = function(player, csid, option, npc)
                    handleTurnIn(player, fameRewards[2], gilRewards[2])
                    player:addTitle(xi.title.BLACK_MARKETEER)
                end,
            },
        },
    },
}

return quest
