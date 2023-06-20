-----------------------------------
-- Wandering Souls
-----------------------------------
-- Log ID: 5, Quest ID: 161
-- Cermet Headstone : !pos -107 -8 450 113
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local terigganID = require('scripts/zones/Cape_Teriggan/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.WANDERING_SOULS)

quest.reward =
{
    item  = xi.items.FLAGELLANTS_ROPE,
    title = xi.title.BEARER_OF_BONDS_BEYOND_TIME,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.CAPE_TERIGGAN] =
        {
            ['Cermet_Headstone'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.RAIN_LILY) then
                        return quest:progressEvent(202, xi.items.RAIN_LILY)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:messageSpecial(terigganID.text.MUST_BE_A_WAY_TO_SOOTHE)
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
