-----------------------------------
-- The Basics
-- Variable Prefix: [4][6]
-----------------------------------
-- ZONE,    NPC,      POS
-- Mhaura,  Rycharde, !pos 17.451 -16.000 88.815 249
-- Selbina, Valgeir,  !pos 57.496 -15.273 20.229 248
-----------------------------------
local selbinaID = zones[xi.zone.SELBINA]
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_BASICS)

quest.reward =
{
    fame     = 120,
    fameArea = xi.fameArea.WINDURST,
    item     = xi.item.TEA_SET,
    title    = xi.title.FIVE_STAR_PURVEYOR,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and player:getFameLevel(xi.fameArea.WINDURST) > 4 and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_CLUE) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar('Quest[4][5]DayCompleted') + 7 < VanadielUniqueDay() then
                        return quest:progressEvent(94) -- Quest starting event.
                    end
                end,
            },

            ['Take'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(66)
                end,
            },

            onEventFinish =
            {
                [94] = function(player, csid, option, npc)
                    if option == 85 then -- Accept quest option.
                        player:setCharVar('Quest[4][5]DayCompleted', 0)  -- Delete previous quest (The clue) variables.
                        npcUtil.giveKeyItem(player, xi.ki.MHAURAN_COUSCOUS) -- Give Key Item to player.
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
                    return quest:event(144)
                end,
            },
        },
    },

    -- Section: Quest accepeted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            -- TODO: Find information about the ferry free ride. NPC involved and number of times it allows for free rides.
            -- KNOWN: It isnt mandatory to take the ferry.

            ['Rycharde'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { xi.item.BAKED_POPOTO }) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(96) -- Quest completed.
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(95)
                end,
            },

            onEventFinish =
            {
                [96] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        player:addExp(2000)
                        quest:setVar(player, 'CommentaryValgeir', 1)
                        quest:setVar(player, 'CommentaryRycharde', 1)
                    end
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(106) -- Deliver Key Item.
                    else
                        return quest:event(145)
                    end
                end,
            },

            onEventFinish =
            {
                [106] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.item.BAKED_POPOTO)
                    player:delKeyItem(xi.ki.MHAURAN_COUSCOUS)
                    player:messageSpecial(selbinaID.text.KEYITEM_OBTAINED + 1, xi.ki.MHAURAN_COUSCOUS)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

    },

    -- Section: Quest completed. Handle optional post quest dialogs and default interactions.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'CommentaryRycharde') == 1 then
                        return quest:event(97) -- Optional dialog.
                    else
                        return quest:event(98):replaceDefault() -- Default message after clompleting this quest.
                    end
                end,
            },

            ['Take'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(67):replaceDefault() -- Default message after clompleting this quest.
                end,
            },

            onEventFinish =
            {
                [97] = function(player, csid, option, npc)
                    quest:setVar(player, 'CommentaryRycharde', 0)
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'CommentaryValgeir') == 1 then
                        return quest:event(107) -- Optional dialog.
                    else
                        return quest:event(146):replaceDefault() -- Default message after clompleting this quest.
                    end
                end,
            },

            onEventFinish =
            {
                [107] = function(player, csid, option, npc)
                    quest:setVar(player, 'CommentaryValgeir', 0)
                end,
            },
        },
    },
}

return quest
