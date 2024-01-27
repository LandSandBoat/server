-----------------------------------
-- The Clue
-- Variable Prefix: [4][5]
-----------------------------------
-- ZONE,   NPC,      POS
-- Mhaura, Rycharde, !pos 17.451 -16.000 88.815 249
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_CLUE)
-----------------------------------

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.WINDURST,
    title    = xi.title.FOUR_STAR_PURVEYOR,
    gil      = 3000,
}

quest.sections =
{
    -- Section: Quest is available and never interacted.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.WINDURST) > 4 and
                player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.EXPERTISE) == QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar('Quest[4][4]DayCompleted') + 7 < VanadielUniqueDay() then
                        if quest:getVar(player, 'Prog') == 0 then
                            return quest:progressEvent(90, xi.item.CRAWLER_EGG) -- Starting event.
                        else
                            return quest:progressEvent(91, xi.item.CRAWLER_EGG) -- Starting event after rejecting.
                        end
                    end
                end,
            },

            ['Take'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(64) -- Default message after clompleting Expertise quest and before accepting The Clue quest.
                end,
            },

            onEventFinish =
            {
                [90] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:setCharVar('Quest[4][4]DayCompleted', 0)  -- Delete previous quest (Rycharde the Chef) variables
                    if option == 83 then -- Accept quest option.
                        quest:begin(player)
                    end
                end,

                [91] = function(player, csid, option, npc)
                    if option == 83 then -- Accept quest option.
                        quest:begin(player)
                    end
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(143)
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Take'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(65)
                end,
            },

            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(85) -- No hurry dialog.
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.CRAWLER_EGG, 4 } }) then
                        return quest:progressEvent(92) -- Quest completed.
                    else
                        local count      = trade:getItemCount()
                        local crawlerEgg = trade:hasItemQty(xi.item.CRAWLER_EGG, trade:getItemCount())

                        if crawlerEgg and count < 4 then
                            return quest:event(93)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [92] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        quest:setVar(player, 'DayCompleted', VanadielUniqueDay()) -- Set completition day of quest.
                    end
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(143)
                end,
            },
        },
    },
}

return quest
