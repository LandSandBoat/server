-----------------------------------
-- Unending Chase
-- Variable Prefix: [4][2]
-----------------------------------
-- ZONE,   NPC,      POS
-- Mhaura, Rycharde, !pos 17.451 -16.000 88.815 249
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.UNENDING_CHASE)

quest.reward =
{
    fame     = 120,
    fameArea = xi.fameArea.WINDURST,
    title    = xi.title.TWO_STAR_PURVEYOR,
    gil      = 2100,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.WAY_OF_THE_COOK) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getCharVar('Quest[4][1]DayCompleted') + 7 < VanadielUniqueDay() and
                        player:getFameLevel(xi.fameArea.WINDURST) > 2
                    then
                        if quest:getVar(player, 'Prog') == 0 then
                            return quest:progressEvent(82, xi.item.PUFFBALL) -- Unending Chase starting event.
                        else
                            return quest:progressEvent(84, xi.item.PUFFBALL) -- Unending Chase starting event after rejecting it.
                        end
                    else
                        return quest:event(75)
                    end
                end,
            },

            ['Take'] = quest:event(65),

            onEventFinish =
            {
                [82] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:setCharVar('Quest[4][1]DayCompleted', 0)  -- Delete previous quest (Rycharde the Chef) variables

                    if option == 77 then -- Accept quest option.
                        quest:begin(player)
                    end
                end,

                [84] = function(player, csid, option, npc)
                    if option == 78 then -- Accept quest option.
                        quest:begin(player)
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

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(85) -- No hurry dialog.
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.PUFFBALL }) then
                        return quest:progressEvent(83) -- Quest completed.
                    end
                end,
            },

            ['Take'] = quest:event(65),

            onEventFinish =
            {
                [83] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        quest:setVar(player, 'DayCompleted', VanadielUniqueDay()) -- Set completition day of quest.
                    end
                end,
            },
        },
    },
}

return quest
