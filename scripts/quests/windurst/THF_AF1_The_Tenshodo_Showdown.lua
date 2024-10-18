-----------------------------------
-- The Tenshodo Showdown
-----------------------------------
-- Log ID: 2, Quest ID: 69
-- Nanaa Mihgo : !pos 62 -4 240 241
-- Harnek      : !pos 44 0 -19 245
-- Elfriede    : !pos 61 -15 10 248
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN)

quest.reward =
{
    fame = 30,
    fameArea = xi.fameArea.WINDURST,
    item = xi.item.MARAUDERS_KNIFE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getMainJob() == xi.job.THF and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] = quest:progressEvent(496),

            onEventFinish =
            {
                [496] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_THE_TENSHODO)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Harnek'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.LETTER_FROM_THE_TENSHODO) then
                        return quest:progressEvent(10021, 0, xi.ki.LETTER_FROM_THE_TENSHODO, xi.ki.TENSHODO_ENVELOPE)
                    elseif player:hasKeyItem(xi.ki.SIGNED_ENVELOPE) then
                        return quest:progressEvent(10022)
                    end
                end,
            },

            onEventFinish =
            {
                [10021] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.LETTER_FROM_THE_TENSHODO)
                    npcUtil.giveKeyItem(player, xi.ki.TENSHODO_ENVELOPE)
                    quest:setVar(player, 'Prog', 1)
                end,

                [10022] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.SIGNED_ENVELOPE)
                    end
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Elfriede'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.BOWL_OF_QUADAV_STEW) and
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(10004, 0, xi.ki.TENSHODO_ENVELOPE, xi.item.BOWL_OF_QUADAV_STEW)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:progressEvent(10002, 0, xi.ki.TENSHODO_ENVELOPE, xi.item.BOWL_OF_QUADAV_STEW)
                    elseif questProgress == 2 then
                        return quest:progressEvent(10003, 0, 0, xi.item.BOWL_OF_QUADAV_STEW)
                    end
                end,
            },

            onEventFinish =
            {
                [10002] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [10004] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:delKeyItem(xi.ki.TENSHODO_ENVELOPE)
                    npcUtil.giveKeyItem(player, xi.ki.SIGNED_ENVELOPE)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(497)
                    elseif questProgress == 1 then
                        return quest:progressEvent(498)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                not player:hasItem(xi.item.BOWL_OF_QUADAV_STEW)
        end,

        [xi.zone.BEADEAUX] =
        {
            ['Bronze_Quadav'] =
            {
                onSteal = function(player, target, ability, action)
                    return xi.item.BOWL_OF_QUADAV_STEW
                end
            },

            ['Garnet_Quadav'] =
            {
                onSteal = function(player, target, ability, action)
                    return xi.item.BOWL_OF_QUADAV_STEW
                end
            },

            ['Silver_Quadav'] =
            {
                onSteal = function(player, target, ability, action)
                    return xi.item.BOWL_OF_QUADAV_STEW
                end
            },

            ['Zircon_Quadav'] =
            {
                onSteal = function(player, target, ability, action)
                    return xi.item.BOWL_OF_QUADAV_STEW
                end
            }
        },

    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.AS_THICK_AS_THIEVES) == xi.questStatus.QUEST_AVAILABLE and
                player:getMainJob() == xi.job.THF and
                player:getMainLvl() < xi.settings.main.AF2_QUEST_LEVEL
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] = quest:event(503):replaceDefault(),
        },
    },
}

return quest
