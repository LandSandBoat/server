-----------------------------------
-- Reap What You sow
-----------------------------------
-- Log ID: 2, Quest ID: 29
-- Mashuu-Ajuu : !pos 129 -6 167 238
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW)

quest.reward =
{
    item = xi.item.STATIONERY_SET,
    fame = 75,
    fameArea = xi.fameArea.WINDURST,
}

local function handleTurnIn(trade)
    if npcUtil.tradeHasExactly(trade, xi.item.SOBBING_FUNGUS) then
        return quest:progressEvent(475, xi.settings.main.GIL_RATE * 500)
    elseif npcUtil.tradeHasExactly(trade, xi.item.DEATHBALL) then
        return quest:progressEvent(477, xi.settings.main.GIL_RATE * 700)
    end
end

local function handleComplete(player, gil, repeated)
    repeated = repeated or false
    if
        repeated or
        quest:complete(player)
    then
        player:confirmTrade()
        player:addGil(gil)
        quest:setMustZone(player)
        if repeated then
            player:addFame(8)
            quest:setVar(player, 'Prog', 0)
        end
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LET_SLEEPING_DOGS_LIE) ~= xi.questStatus.QUEST_ACCEPTED and
                not xi.quest.getMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.LET_SLEEPING_DOGS_LIE)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mashuu-Ajuu'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getFameLevel(xi.fameArea.WINDURST) < 4 or
                        player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.LET_SLEEPING_DOGS_LIE) -- if player fame is 4 or higher then Let Sleeping Dogs Lie takes priority if not completed
                    then
                        return quest:progressEvent(463, 0, xi.item.SOBBING_FUNGUS, xi.item.BAG_OF_HERB_SEEDS)
                    end
                end,
            },

            onEventFinish =
            {
                [463] = function(player, csid, option, npc)
                    if
                        option == 3 and
                        npcUtil.giveItem(player, xi.item.BAG_OF_HERB_SEEDS)
                    then
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

        [xi.zone.WINDURST_WATERS] =
        {
            ['Akkeke'] = quest:event(468, 0, xi.item.POPOTO),

            ['Chomoro-Kyotoro'] = quest:event(472),

            ['Foi-Mui'] = quest:event(466, 0, xi.item.EAR_OF_MILLIONCORN),

            ['Kirarara'] = quest:event(465),

            ['Koko_Lihzeh'] = quest:event(471, 0, xi.item.FAERIE_APPLE),

            ['Paku-Nakku'] = quest:event(467),

            ['Mashuu-Ajuu'] =
            {
                onTrade = function(player, npc, trade)
                    return handleTurnIn(trade)
                end,

                onTrigger = function(player, npc)
                    return quest:progressEvent(464, 0, xi.item.SOBBING_FUNGUS, xi.item.BAG_OF_HERB_SEEDS)
                end,
            },

            ['Rukuku'] = quest:event(470),

            onEventFinish =
            {
                [475] = function(player, csid, option, npc)
                    handleComplete(player, xi.settings.main.GIL_RATE * 500)
                end,

                [477] = function(player, csid, option, npc)
                    handleComplete(player, xi.settings.main.GIL_RATE * 700)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mashuu-Ajuu'] = quest:event(476),
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                not quest:getMustZone(player) and
                quest:getVar(player, 'Prog') == 0
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mashuu-Ajuu'] =
            {
                onTrade = function(player, npc, trade)
                    return handleTurnIn(trade)
                end,

                onTrigger = function(player, npc)
                    return quest:progressEvent(479, 0, xi.item.SOBBING_FUNGUS, xi.item.BAG_OF_HERB_SEEDS)
                end,
            },

            onEventFinish =
            {
                [479] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                not quest:getMustZone(player) and
                quest:getVar(player, 'Prog') == 1
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Akkeke'] = quest:event(468, 0, xi.item.POPOTO),

            ['Chomoro-Kyotoro'] = quest:event(472),

            ['Foi-Mui'] = quest:event(466, 0, xi.item.EAR_OF_MILLIONCORN),

            ['Kirarara'] = quest:event(465),

            ['Koko_Lihzeh'] = quest:event(471, 0, xi.item.FAERIE_APPLE),

            ['Paku-Nakku'] = quest:event(467),

            ['Mashuu-Ajuu'] =
            {
                onTrade = function(player, npc, trade)
                    return handleTurnIn(trade)
                end,

                onTrigger = function(player, npc)
                    return quest:progressEvent(464, 0, xi.item.SOBBING_FUNGUS, xi.item.BAG_OF_HERB_SEEDS)
                end,
            },

            ['Rukuku'] = quest:event(470),

            onEventFinish =
            {
                [475] = function(player, csid, option, npc)
                    handleComplete(player, xi.settings.main.GIL_RATE * 500, true)
                end,

                [477] = function(player, csid, option, npc)
                    handleComplete(player, xi.settings.main.GIL_RATE * 700, true)
                end,
            },
        },
    },
}

return quest
