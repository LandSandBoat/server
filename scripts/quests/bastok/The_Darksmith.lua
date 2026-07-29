-----------------------------------
-- The Darksmith
-----------------------------------
-- Log ID: 1, Quest ID: 40
-- Mighty Fist : !pos -47 2 -30 237
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.THE_DARKSMITH)

quest.reward =
{
    fame     = 16,
    fameArea = xi.fameArea.BASTOK,
    gil      = 8000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.BASTOK) >= 3
        end,

        [xi.zone.METALWORKS] =
        {
            ['Mighty_Fist'] = quest:progressEvent(565),

            onEventFinish =
            {
                [565] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status ~= xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.METALWORKS] =
        {
            ['Mighty_Fist'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeMatches(trade, { { xi.item.CHUNK_OF_DARKSTEEL_ORE, 2 } }) then
                        return quest:progressEvent(566)
                    end
                end,

                onTrigger = function(player, npc)
                    if not quest:getMustZone(player) then
                        return quest:event(561) -- First trigger only. Reset on zone.
                    else
                        return quest:event(560) -- Subsequent triggers.
                    end
                end,
            },

            onEventFinish =
            {
                [561] = function(player, csid, option, npc)
                    quest:setMustZone(player)
                end,

                [566] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                    end
                end,
            },
        },
    },
}

return quest
