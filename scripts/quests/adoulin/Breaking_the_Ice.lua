-----------------------------------
-- Breaking the Ice
-----------------------------------
-- !addquest 9 54
-- Traiffeaux : !pos 437.451 63 -290.512 267
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local kamihrID = require('scripts/zones/Kamihr_Drifts/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.BREAKING_THE_ICE)

quest.reward =
{
    fameArea = xi.quest.fame_area.ADOULIN,
    bayld    = 500,
}

local requiredTradeItems =
{
    { xi.items.RABBIT_HIDE, 3 },
    { xi.items.RAAZ_TUSK,   1 },
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.KAMIHR_DRIFTS] =
        {
            ['Traiffeaux'] = quest:progressEvent(24),

            onEventFinish =
            {
                [24] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.KAMIHR_DRIFTS] =
        {
            ['Traiffeaux'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, requiredTradeItems) then
                        -- NOTE: This event may cause Windower to hang part-way through.

                        return quest:progressEvent(26)
                    end
                end,

                onTrigger = quest:event(25),
            },

            onEventFinish =
            {
                [26] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.PAIR_OF_FUZZY_EARMUFFS)
                    player:messageSpecial(kamihrID.text.YOU_HAVE_LEARNED, xi.ki.FRAGMENTING)

                    if quest:complete(player) then
                        player:confirmTrade()
                        player:addKeyItem(xi.ki.FRAGMENTING)
                    end
                end,
            },
        },
    },
}

return quest
