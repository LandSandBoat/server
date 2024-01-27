-----------------------------------
-- The Siren's Tear
-----------------------------------
-- Log ID: 1, Quest ID: 0
-- Wahid       : !pos 26.305 -1 -66.403 234
-- Otto        : !pos -145.929 -7.48 13.701 236
-- Carmelo     : !pos -146.476 -7.48 -10.889 236
-- Echo Hawk   : !pos -0.965 5.999 -15.567 234
-- qm1 (moves) : !pos 309.6 2.6 324 106
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_SIRENS_TEAR)

quest.reward =
{
    fame = 120,
    fameArea = xi.quest.fame_area.BASTOK,
    gil = 150,
    title = xi.title.TEARJERKER,
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Wahid']     = quest:progressEvent(81),
            ['Echo_Hawk'] = quest:event(5),

            onEventFinish =
            {
                [81] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Otto'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(5)
                    end
                end,
            },

            ['Carmelo'] = quest:progressEvent(6),

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Section: Quest completed
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Carmelo'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') < 2 and
                        not player:findItem(xi.item.SIRENS_TEAR)
                    then
                        return quest:progressEvent(19)
                    end
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Section accepted or completed
    {
        check = function(player, status, vars)
            return status ~= QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Wahid'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.SIRENS_TEAR) then
                        return quest:progressEvent(82)
                    end
                end,
            },

            onEventFinish =
            {
                [82] = function(player, csid, option, npc)
                    -- This is called even after the initial complete to handle quest var cleanup
                    -- CLuaBaseEntity::completeQuest() will only actually complete the quest the
                    -- first time the player finishes this.
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
