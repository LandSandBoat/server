-----------------------------------
-- The Bare Bones
-----------------------------------
-- Log ID: 1, Quest ID: 38
-- Degenhard : !pos -175 2 -135 235
-- Biggorf   : !pos -211.379 1.999 -142.024 235
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_BARE_BONES)

quest.reward =
{
    fame = 60,
    fameArea = xi.quest.fame_area.BASTOK,
    keyItem = xi.ki.MAP_OF_THE_DANGRUF_WADI,
    xp = 2000,
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Degenhard'] = quest:progressEvent(256),

            onEventFinish =
            {
                [256] = function(player, csid, option, npc)
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

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Biggorf'] = quest:progressEvent(257),

            ['Degenhard'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.BONE_CHIP) then
                        return quest:progressEvent(258)
                    end
                end,
            },

            onEventFinish =
            {
                [258] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
