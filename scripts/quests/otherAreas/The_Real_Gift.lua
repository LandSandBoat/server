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
    title = xi.title.THE_LOVE_DOCTOR,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.UNDER_THE_SEA) == xi.questStatus.QUEST_COMPLETED and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_SAND_CHARM) == xi.questStatus.QUEST_COMPLETED
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
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') ~= 0 or
                        not npcUtil.tradeMatches(trade, { { xi.item.SHALL_SHELL, 1 } })
                    then
                        return
                    end

                    -- Retail gives the rod and takes the shell before the event starts.
                    if not npcUtil.giveItem(player, xi.item.GLASS_FIBER_FISHING_ROD, { silent = true }) then
                        player:messageSpecial(zones[xi.zone.SELBINA].text.ITEM_CANNOT_BE_OBTAINED + 4, xi.item.GLASS_FIBER_FISHING_ROD)
                        return
                    end

                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 1)

                    return quest:progressEvent(75)
                end,

                onTrigger = function(player, npc)
                    -- The reward was already given if the player disconnected during the event.
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(75)
                    end

                    return quest:event(74, xi.item.SHALL_SHELL) -- Shall shells yield pearls
                end,
            },

            onEventFinish =
            {
                [75] = function(player, csid, option, npc)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        quest:complete(player)
                    then
                        player:addFame(xi.fameArea.SANDORIA, 10)
                        player:addFame(xi.fameArea.BASTOK, 10)
                        player:messageSpecial(zones[xi.zone.SELBINA].text.ITEM_OBTAINED, xi.item.GLASS_FIBER_FISHING_ROD)
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
