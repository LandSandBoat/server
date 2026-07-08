-----------------------------------
-- Lost Memories
-----------------------------------
-- !addquest 8 9
-- Halver : !pos: 600 40 -515 132
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_LA_THEINE]
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.LOST_MEMORIES)

quest.reward = {
    keyItem     = xi.ki.VIAL_OF_LAMBENT_POTION,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getFameLevel(xi.fameArea.ABYSSEA_LATHEINE) < 5
        end,

        [xi.zone.ABYSSEA_LA_THEINE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(162)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getFameLevel(xi.fameArea.ABYSSEA_LATHEINE) >= 5
        end,

        [xi.zone.ABYSSEA_LA_THEINE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(165)
                end,
            },

            onEventFinish =
            {
                [165] = function(player, csid, option, npc)
                    if option ~= 0 then
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

        [xi.zone.ABYSSEA_LA_THEINE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(163)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { { xi.item.LAMBENT_SCALE, 2 } }) then
                        return quest:event(164)
                    end
                end,
            },

            onEventFinish =
            {
                [164] = function(player, csid, option, npc)
                    player:confirmTrade()
                    --TODO add repeat quest functionality?
                    player:addCurrency('cruor', 480)
                    player:messageSpecial(ID.text.CRUOR_TOTAL, 480, player:getCurrency('cruor'))
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
