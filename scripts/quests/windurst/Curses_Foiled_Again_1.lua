-----------------------------------
-- Curses, Foiled Again!
--
-- Shantotto : !pos 122 -2 112 239
-- BONE_CHIP : !additem 880
-- BOMB_ASH  : !additem 928
--
-- NOTE: The quest Blood and Glory may prevent you from flagging the quest,
--     : return with a job that does not meet the prerequisites for Blood and Glory.
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CURSES_FOILED_AGAIN_1)

quest.reward =
{
    fame     = 10,
    fameArea = WINDURST,
    item    = xi.items.BRASS_ROD,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] = quest:progressEvent(171, 0, 0, 0, 0, 0, 0, xi.items.BONE_CHIP, xi.items.BOMB_ASH),

            onEventFinish =
            {
                [171] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(172, 0, 0, 0, 0, 0, 0, xi.items.BONE_CHIP, xi.items.BOMB_ASH) -- Reminder text.
                end,

                onTrade = function(player, npc, trade)
                    local items =
                    {
                        { xi.items.BONE_CHIP, 2 },
                        { xi.items.BOMB_ASH,  1 },
                    }

                    if npcUtil.tradeHasExactly(trade, items) then
                        return quest:progressEvent(173, 0, 0, 0, 0, 0, 0, xi.items.BONE_CHIP, xi.items.BOMB_ASH)
                    else
                        return quest:event(172) -- Reminder text.
                    end
                end,
            },

            onEventFinish =
            {
                [173] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()

                        -- Set var now, so it's available for the next quest
                        xi.quest.setVar(player,
                            xi.quest.log_id.WINDURST,
                            xi.quest.id.windurst.CURSES_FOILED_AGAIN_1,
                            "Timer",
                            VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] = quest:event(174):replaceDefault(),
        },
    },
}

return quest
