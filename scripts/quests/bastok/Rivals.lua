-----------------------------------
-- Rivals
-----------------------------------
-- Log ID: 1, Quest ID: 20
-- Detzo : !pos 5.365 6.999 9.891 234
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local bastokMinesID = require('scripts/zones/Bastok_Mines/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.RIVALS)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.items.WOLF_GORGET,
    title    = xi.title.CONTEST_RIGGER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 3
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Detzo'] = quest:progressEvent(93),

            onEventFinish =
            {
                [93] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Detzo'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.MYTHRIL_SALLET) then
                        return quest:progressEvent(94)
                    end
                end,

                onTrigger = quest:messageName(bastokMinesID.text.DETZO_RIVALS_DIALOG),
            },

            onEventFinish =
            {
                [94] = function(player, csid, option, npc)
                    -- TODO: Since Detzo 'borrows' the Mythril Sallet, need to verify if
                    -- a message is displayed for returning it (Obtained:, etc).

                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
