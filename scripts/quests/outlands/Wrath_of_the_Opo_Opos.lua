-----------------------------------
-- Wrath of the Opo-Opos
-----------------------------------
-- Log ID: 5, Quest ID: 160
-- Cermet Headstone : !pos 491 20 301 123
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local yuhtungaID = require('scripts/zones/Yuhtunga_Jungle/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.WRATH_OF_THE_OPO_OPOS)

quest.reward =
{
    item  = xi.items.OPO_OPO_NECKLACE,
    title = xi.title.FRIEND_OF_THE_OPO_OPOS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.YUHTUNGA_JUNGLE] =
        {
            ['Cermet_Headstone'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.GARNET) then
                        return quest:progressEvent(202, xi.items.GARNET)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:messageSpecial(yuhtungaID.text.TOUCHING_RED_JEWEL)
                end,
            },

            onEventFinish =
            {
                [202] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
