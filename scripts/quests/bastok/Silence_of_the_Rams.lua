-----------------------------------
-- Silence of the Rams
-----------------------------------
-- Log ID: 1, Quest ID: 48
-- Paujean : !pos -93.738 4.649 34.373 236
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local portBastokID = require('scripts/zones/Port_Bastok/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.SILENCE_OF_THE_RAMS)

quest.reward =
{
    fame     = 125,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.items.PURPLE_BELT,
    title    = xi.title.PURPLE_BELT,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.NORG) >= 2
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Paujean'] = quest:progressEvent(195),

            onEventFinish =
            {
                [195] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Paujean'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.items.LUMBERING_HORN, xi.items.RAMPAGING_HORN }) then
                        return quest:progressEvent(196)
                    end
                end,

                onTrigger = quest:messageName(portBastokID.text.PAUJEAN_DIALOG_1),
            },

            onEventFinish =
            {
                [196] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
