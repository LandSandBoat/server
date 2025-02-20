-----------------------------------
-- The Real Gift
-----------------------------------
-- Log ID: 4, Quest ID: 22
-- !addquest 4 22
-- !additem 4484
-- Oswald  : !pos 47.119 -15.273 7.989 248
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_REAL_GIFT)

quest.reward =
{
    item     = xi.item.GLASS_FIBER_FISHING_ROD,
    title    = xi.title.THE_LOVE_DOCTOR,
    fameArea = xi.fameArea.SELBINA_RABAO,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.UNDER_THE_SEA) == xi.questStatus.QUEST_COMPLETED and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_SAND_CHARM) >= xi.questStatus.QUEST_COMPLETED and
                xi.settings.map.FISHING_ENABLE == true
        end,

        [xi.zone.SELBINA] =
        {
            ['Oswald'] = quest:progressEvent(73, xi.item.SHALL_SHELL), -- Bring me a shall shell

            onEventFinish =
            {
                [73] = function(player, csid, option, npc)
                    if option == 50 then
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

        [xi.zone.SELBINA] =
        {
            ['Oswald'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(74, xi.item.SHALL_SHELL) -- Shall shells yield pearls
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.SHALL_SHELL) then
                        return quest:progressEvent(75) -- You're so fantastic! Thank you!
                    end
                end,
            },

            onEventFinish =
            {
                [75] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.SELBINA] =
        {
            ['Oswald'] = quest:progressEvent(76):replaceDefault(),
            -- Thanks for all you've done.
        },
    },
}

return quest
