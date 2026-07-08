-----------------------------------
-- Teacher's Pet
-----------------------------------
-- Log ID: 2, Quest ID: 28
-- Moreno-Toeno : !pos 169 -1.25 159 238
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.TEACHERS_PET)

quest.reward =
{
    fame     = 8,
    fameArea = xi.fameArea.WINDURST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Moreno-Toeno'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(437)
                    else
                        return quest:progressEvent(438, 0, xi.item.BIRD_FEATHER, xi.item.TWO_LEAF_MANDRAGORA_BUD)
                    end
                end,
            },

            onEventFinish =
            {
                [437] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [438] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Prog', 0)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status ~= xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Moreno-Toeno'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.BIRD_FEATHER, xi.item.TWO_LEAF_MANDRAGORA_BUD }) then
                        return quest:progressEvent(440, 250, xi.item.BIRD_FEATHER, xi.item.TWO_LEAF_MANDRAGORA_BUD)
                    end
                end,

                onTrigger = quest:event(439, 0, xi.item.BIRD_FEATHER, xi.item.TWO_LEAF_MANDRAGORA_BUD),
            },

            onEventFinish =
            {
                [440] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:addGil(250) -- "Obtained X gil." Text is baked into the CS, so gil needs to be given outside of the quest rewards.

                    -- From previous implementation, award 75 fame (67 + 8) on first completion,
                    -- and 8 fame for any subsequent trade.
                    if player:getQuestStatus(quest.areaId, quest.questId) == xi.questStatus.QUEST_ACCEPTED then
                        player:addFame(xi.fameArea.WINDURST, 67)
                    end

                    if quest:complete(player) then
                        xi.quest.setMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_THE_GRADE)
                    end
                end,
            },
        },
    },
}

return quest
