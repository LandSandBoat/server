-----------------------------------
-- Delivering the Goods
-- Fochacha, Whitegate , !pos 3 -1 -10.781 50
-- Qutiba, Whitegate, !pos 92 -7.5 -130 50
-- Ulamaal, Whitegate, !pos 93 -7.5 -128 50
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.DELIVERING_THE_GOODS)

quest.reward =
{
    item = { { xi.item.IMPERIAL_BRONZE_PIECE, 3 } }
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Fochacha'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(39)
                end,
            },
            ['Qutiba'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(51)
                end,
            },
            ['Ulamaal'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(51)
                end,
            },

            onEventFinish =
            {
                [39] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Qutiba'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(40)
                end,
            },
            ['Ulamaal'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(40)
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Section: Complete quest
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Fochacha'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(41)
                end,
            },
            ['Qutiba'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(52)
                end,
            },
            ['Ulamaal'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(53)
                end,
            },

            onEventFinish =
            {
                [41] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setVar('Quest[6][62]Stage', getMidnight())

                        -- Player must zone before being able to flag the next quest
                        player:setLocalVar('Quest[6][62]mustZone', 1)
                    end
                end,
            },
        },
    },
}

return quest
