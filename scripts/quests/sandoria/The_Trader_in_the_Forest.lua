-----------------------------------
-- The Trader in the Forest
-----------------------------------
-- Log ID: 0, Quest ID: 7
-- Abeaule : !pos -136 -2 56 231
-- Phairet : !pos -57 -2 -502 100
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_TRADER_IN_THE_FOREST)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.SANDORIA,
    item     = xi.item.ROBE,
    title    = xi.title.GREEN_GROCER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Abeaule'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(524)
                    else
                        return quest:progressEvent(592)
                    end
                end,
            },

            onEventFinish =
            {
                [524] = function(player, csid, option, npc)
                    if option == 0 and npcUtil.giveItem(player, xi.item.SUPPLIES_ORDER) then
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [592] = function(player, csid, option, npc)
                    if option == 0 and npcUtil.giveItem(player, xi.item.SUPPLIES_ORDER) then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 0)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Abeaule'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.CLUMP_OF_BATAGREENS) then
                        return quest:progressEvent(525)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:progressEvent(593)
                end,
            },

            onEventFinish =
            {
                [525] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,

                [593] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveItem(player, xi.item.SUPPLIES_ORDER)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED or status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WEST_RONFAURE] =
        {
            ['Phairet'] =
            {
                -- Phairet will continue to accept Supplies Order after the quest has been
                -- completed, should the player have purchased a batagreen, or picked up
                -- an additional order prior to completion.
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.SUPPLIES_ORDER) then
                        return quest:progressEvent(124)
                    elseif
                        npcUtil.tradeHas(trade, { { 'gil', 50 } }) and
                        npcUtil.giveItem(player, xi.item.CLUMP_OF_BATAGREENS)
                    then
                        player:confirmTrade()

                    -- Rejection for invalid trades only occurs after supplies order has been
                    -- traded, or the quest has been completed.
                    elseif
                        player:hasCompletedQuest(quest.areaId, quest.questId) or
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(125)
                    end
                end,

                onTrigger = function(player, npc)
                    if
                        player:hasCompletedQuest(quest.areaId, quest.questId) or
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(127, xi.item.CLUMP_OF_BATAGREENS)
                    end
                end,
            },

            onEventFinish =
            {
                [124] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.CLUMP_OF_BATAGREENS) then
                        player:confirmTrade()

                        if player:getQuestStatus(quest.areaId, quest.questId) == xi.questStatus.QUEST_ACCEPTED then
                            quest:setVar(player, 'Prog', 2)
                        end
                    end
                end,
            },
        },
    },
}

return quest
