-----------------------------------
-- Sin Hunting
-----------------------------------
-- Log ID: 2, Quest ID: 72
-- !addquest 2 72
-- Perih Vashai : !pos 117 -3 92 241
-- Perchond     : !pos -182.844 4 -164.948 166
-- Alexius      : !pos 105 1 382 104
-- qm2 (???)    : !pos -10.946 -1 313.810 104
-----------------------------------
-- The pinch of glittersand drops from the Evil Weapons around the Waters of Oblivion.
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.SIN_HUNTING)

quest.reward =
{
    fame     = 20,
    fameArea = xi.fameArea.WINDURST,
    item     = xi.item.SNIPING_BOW,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getMainJob() == xi.job.RNG and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] = quest:progressEvent(523),

            onEventFinish =
            {
                [523] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.CHIEFTAINNESSS_TWINSTONE_EARRING)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(527)
                    else
                        return quest:event(524)
                    end
                end,
            },

            ['Kapeh_Myohrye'] = quest:event(526),
            ['Muhk_Johldy']   = quest:event(525),

            onEventFinish =
            {
                [527] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.CHIEFTAINNESSS_TWINSTONE_EARRING)
                        player:delKeyItem(xi.ki.PERCHONDS_ENVELOPE)
                    end
                end,
            },
        },

        [xi.zone.RANGUEMONT_PASS] =
        {
            ['Perchond'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeMatches(trade, { { xi.item.PINCH_OF_GLITTERSAND, 1 } })
                    then
                        return quest:progressEvent(5)
                    end
                end,

                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    if prog == 0 then
                        return quest:progressEvent(3, 0, xi.item.PINCH_OF_GLITTERSAND)
                    elseif prog == 1 then
                        return quest:event(4, 0, xi.item.PINCH_OF_GLITTERSAND)
                    elseif prog == 2 or prog == 3 then
                        return quest:event(6) -- Reminder to deliver the envelope.
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [5] = function(player, csid, option, npc)
                    if option == 0 then
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, xi.ki.PERCHONDS_ENVELOPE)
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        },

        [xi.zone.JUGNER_FOREST] =
        {
            ['Alexius'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    if prog == 2 then
                        return quest:progressEvent(10)
                    elseif prog == 3 then
                        return quest:event(11)
                    end
                end,
            },

            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(13, 0, xi.item.PINCH_OF_GLITTERSAND)
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 3)
                    end
                end,

                [13] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Kapeh_Myohrye'] = quest:event(530):replaceDefault(),
            ['Muhk_Johldy']   = quest:event(529):replaceDefault(),
        },
    },
}

return quest
