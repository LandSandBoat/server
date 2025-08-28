-----------------------------------
-- Mihgo's Amigo
-----------------------------------
-- Log ID: 2, Quest ID: 4
-- Nanaa Mihgo !pos 62 -4 240 241
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.MIHGOS_AMIGO)

quest.reward =
{
    fame     = 60,
    fameArea = xi.fameArea.NORG,
    title    = xi.title.CAT_BURGLAR_GROUPIE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN) ~= xi.questStatus.QUEST_ACCEPTED and -- Quest cannot be flagged if you have The Tenshodo Showdown in progress
                player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.AS_THICK_AS_THIEVES) ~= xi.questStatus.QUEST_ACCEPTED -- Quest cannot be flagged if you have As Thick as Thieves in progress
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS) == xi.questStatus.QUEST_ACCEPTED then
                        return quest:progressEvent(81) -- Start Quest "Mihgo's Amigo" with quest "Crying Over Onions" Activated
                    else
                        return quest:progressEvent(80)
                    end
                end,
            },

            onEventFinish =
            {
                [80] = function(player, csid, option, npc)
                    quest:begin(player)
                end,

                [81] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(82)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { { xi.item.YAGUDO_BEAD_NECKLACE, 4 } }) then
                        return quest:progressEvent(88, 200)
                    end
                end,
            },

            ['Cha_Lebagta'] = quest:event(85, 0, xi.item.YAGUDO_BEAD_NECKLACE),

            onEventFinish =
            {
                [88] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:addGil(200) -- "Obtained X gil." Text is baked into the CS, so gil needs to be given outside of the quest rewards.
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(89):replaceDefault()
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { { xi.item.YAGUDO_BEAD_NECKLACE, 4 } }) then
                        return quest:progressEvent(494, 200)
                    end
                end,
            },

            ['Cha_Lebagta'] = quest:event(91, 0, xi.item.YAGUDO_BEAD_NECKLACE):replaceDefault(),

            onEventFinish =
            {
                [494] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:addGil(200) -- "Obtained X gil." Text is baked into the CS, so gil needs to be given outside of the quest rewards.
                    end
                end,
            },
        },
    },
}

return quest
