-----------------------------------
-- Fear of the Dark III
-----------------------------------
-- !addquest 8 2
-- Secodiand : !pos -489.5 -2.8 759.2 132
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_LA_THEINE]
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.FEAR_OF_THE_DARK_III)

quest.reward = {
    fame     = 10,
    fameArea = xi.fameArea.ABYSSEA_LATHEINE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.ABYSSEA_LA_THEINE] =
        {
            ['Secodiand'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(161)
                end,
            },

            onEventFinish =
            {
                [161] = function(player, csid, option, npc)
                    if option ~= 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status ~= xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.ABYSSEA_LA_THEINE] =
        {
            ['Secodiand'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(159)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { { xi.item.CLIONID_WING, 3 } }) then
                        return quest:event(160)
                    end
                end,
            },

            onEventFinish =
            {
                [160] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:addCurrency('cruor', 200)
                    player:messageSpecial(ID.text.CRUOR_TOTAL, 200, player:getCurrency('cruor'))
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
