-----------------------------------
-- Smoke on the Mountain
-----------------------------------
-- Log ID: 1, Quest ID: 15
-- Hungry Wolf : !pos -25.861 -11 -30.172 237
-- Offa : !pos -281.628 -15.971 -140.607 235
-- ??? (Campfire) !pos 461.841 -21.515 -580.105 107
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN)

quest.reward =
{
    fame     = 10,
    fameArea = xi.fameArea.BASTOK,
    gil      = 300,
    title    = xi.title.HOT_DOG,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.METALWORKS] =
        {
            ['Hungry_Wolf'] = quest:progressEvent(428),

            onEventFinish =
            {
                [428] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status >= xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Hungry_Wolf'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeMatches(trade, { { xi.item.GALKAN_SAUSAGE, 1 } }) then
                        return quest:progressEvent(429)
                    end
                end,
            },

            onEventFinish =
            {
                [429] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Offa'] = quest:event(222):oncePerZone(),
        },
    },
}

return quest
