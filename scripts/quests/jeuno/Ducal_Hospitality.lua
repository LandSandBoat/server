-----------------------------------
-- Ducal Hospitality
-- Taillegeas - !gotoid 17772720
-- Log ID [3] - Quest ID [68]
-----------------------------------
local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.DUCAL_HOSPITALITY)

local questItemSets =
{
    [1] =
    {
        items =
        {
            xi.item.HANDFUL_OF_COUNTERFEIT_GIL,
            xi.item.LOAF_OF_GOBLIN_BREAD,
            xi.item.GOBLIN_DOLL,
            xi.item.GOBLIN_MUSHPOT,
            xi.item.GOBLIN_PIE,
        },
        textOption = 0,
    },

    [2] =
    {
        items =
        {
            xi.item.PILE_OF_CHOCOBO_BEDDING,
            xi.item.SET_OF_KAISERIN_COSMETICS,
            xi.item.MY_FIRST_MAGIC_KIT,
        },
        textOption = 1,
    },

    [3] =
    {
        items =
        {
            xi.item.PIECE_OF_EASTERN_PAPER,
            xi.item.SHURIKEN,
            xi.item.SILVER_OBI,
            xi.item.TONOSAMA_RICE_BALL,
        },
        textOption = 4,
    },

    [4] =
    {
        items =
        {
            xi.item.DART,
            xi.item.KONGOU_INAHO,
            xi.item.NYUMOMO_DOLL,
            xi.item.CONE_OF_SNOLL_GELATO,
        },
        textOption = 4,
    },

    [5] =
    {
        items =
        {
            xi.item.COPY_OF_FERNANS_DIARIES,
            xi.item.NAPHILLE_POCHETTE,
            xi.item.SPHENE_EARRING,
            xi.item.TURQUOISE_RING,
        },
        textOption = 4,
    }
}

quest.reward =
{
    fame = 50,
    fameArea = xi.fameArea.JEUNO,
    gil = 4000,
    title = xi.title.DUCAL_DUPE,
}

quest.sections =
{
    -- Quest: AVAILABLE
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN) and
                player:getFameLevel(xi.fameArea.JEUNO) >= 4
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Taillegeas'] =
            {
                onTrigger = function(player, npc)
                    local warriorsPathComplete = player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH) and 1 or 0
                    local questItemSet = math.random(#questItemSets)
                    quest:setVar(player, 'ItemSet', questItemSet)
                    return quest:progressEvent(10057, {
                        [0] = warriorsPathComplete,
                        [1] = questItemSets[questItemSet].items[1],
                        [2] = questItemSets[questItemSet].items[2],
                        [3] = questItemSets[questItemSet].items[3],
                        [4] = questItemSets[questItemSet].items[4] or 0,
                        [5] = questItemSets[questItemSet].items[5] or 0,
                        [6] = questItemSets[questItemSet].textOption,
                    })
                end,
            },

            onEventFinish =
            {
                [10057] = function(player, csid, option, npc)
                    if option == 10 then
                        return
                    else
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Quest: ACCEPTED
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Taillegeas'] =
            {
                onTrigger = function(player, npc)
                    local warriorsPathComplete = player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH) and 1 or 0
                    local questItemSet = quest:getVar(player, 'ItemSet')
                    return quest:progressEvent(10059, {
                        [0] = warriorsPathComplete,
                        [1] = questItemSets[questItemSet].items[1],
                        [2] = questItemSets[questItemSet].items[2],
                        [3] = questItemSets[questItemSet].items[3],
                        [4] = questItemSets[questItemSet].items[4] or 0,
                        [5] = questItemSets[questItemSet].items[5] or 0,
                        [6] = questItemSets[questItemSet].textOption,
                    })
                end,

                onTrade = function(player, npc, trade)
                    local warriorsPathComplete = player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH) and 1 or 0
                    local questItemSet = quest:getVar(player, 'ItemSet')
                    if
                        questItemSet > 0 and
                        npcUtil.tradeHasExactly(trade, questItemSets[questItemSet].items)
                    then
                        return quest:progressEvent(10058, {
                            [0] = warriorsPathComplete,
                            [6] = questItemSet - 1,
                        })
                    end
                end,
            },

            onEventFinish =
            {
                [10058] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        quest:setMustZone(player)
                    end
                end,
            },
        },

    },

    -- Quest: COMPLETED
    -- Allows for repeats of the quest
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Taillegeas'] =
            {
                onTrigger = function(player, npc)
                    local warriorsPathComplete = player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH) and 1 or 0
                    local questItemSet = quest:getVar(player, 'ItemSet')
                    if questItemSet > 0 then
                        -- Quest has been re-started and an item-set was assigned to the player
                        return quest:progressEvent(10059, {
                            [0] = warriorsPathComplete,
                            [1] = questItemSets[questItemSet].items[1],
                            [2] = questItemSets[questItemSet].items[2],
                            [3] = questItemSets[questItemSet].items[3],
                            [4] = questItemSets[questItemSet].items[4] or 0,
                            [5] = questItemSets[questItemSet].items[5] or 0,
                            [6] = questItemSets[questItemSet].textOption,
                        })
                    elseif quest:getMustZone(player) then
                        -- Player just completed the quest, needs to zone before re-starting
                        return quest:progressEvent(10060, { [0] = warriorsPathComplete })
                    else
                        -- Player has the quest active and needs the item list again
                        questItemSet = math.random(#questItemSets)
                        quest:setVar(player, 'ItemSet', questItemSet)
                        return quest:progressEvent(10057, {
                            [0] = warriorsPathComplete,
                            [1] = questItemSets[questItemSet].items[1],
                            [2] = questItemSets[questItemSet].items[2],
                            [3] = questItemSets[questItemSet].items[3],
                            [4] = questItemSets[questItemSet].items[4] or 0,
                            [5] = questItemSets[questItemSet].items[5] or 0,
                            [6] = questItemSets[questItemSet].textOption,
                        })
                    end
                end,

                onTrade = function(player, npc, trade)
                    local warriorsPathComplete = player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH) and 1 or 0
                    local questItemSet = quest:getVar(player, 'ItemSet')
                    if
                        questItemSet > 0 and
                        npcUtil.tradeHasExactly(trade, questItemSets[questItemSet].items)
                    then
                        return quest:progressEvent(10058, {
                            [0] = warriorsPathComplete,
                            [6] = questItemSet - 1,
                        })
                    end
                end,
            },

            onEventFinish =
            {
                [10057] = function(player, csid, option, npc)
                    if option == 10 then
                        quest:setVar(player, 'ItemSet', 0)
                    end
                end,

                [10058] = function(player, csid, option, npc)
                    if not quest:getMustZone(player) then -- if we don't check this we get double reward immediately after first completion
                        player:confirmTrade()
                        quest:setMustZone(player)
                        quest:setVar(player, 'ItemSet', 0)
                        npcUtil.giveCurrency(player, 'gil', 4000)
                        player:addFame(xi.fameArea.JEUNO, 50)
                    end
                end,
            },
        },
    },
}

return quest
