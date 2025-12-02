-----------------------------------
-- Making Amends
-----------------------------------
-- Log ID: 2, Quest ID: 3
-- Hakkuru-Rinkuru !pos -111 -4 101 240
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_AMENDS)

quest.reward =
{
    fameArea = xi.fameArea.WINDURST,
    fame     = 75,
    title    = xi.title.QUICK_FIXER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 2
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] = quest:progressEvent(274, 0, xi.item.BLOCK_OF_ANIMAL_GLUE),

            onEventFinish =
            {
                [274] = function(player, csid, option, npc)
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

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(275, 0, xi.item.BLOCK_OF_ANIMAL_GLUE)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { { xi.item.BLOCK_OF_ANIMAL_GLUE, 1 } }) then
                        return quest:progressEvent(277, 1500) -- "Obtained X gil." Text is baked into the CS, so gil needs to be given outside of the quest
                    end
                end,
            },

            ['Kuroido-Moido'] = quest:event(276),

            onEventFinish =
            {
                [277] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:addGil(1500)
                        quest:setMustZone(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] =
            {
                onTrigger = function(player, npc)
                    if quest:getMustZone(player) then
                        return quest:event(278)
                    else
                        return quest:event(281):replaceDefault()
                    end
                end,
            },

            ['Kuroido-Moido'] =
                        {
                onTrigger = function(player, npc)
                    if quest:getMustZone(player) then
                        return quest:event(279)
                    end
                end,
            },
        },
    },
}

return quest
