-----------------------------------
-- A Stone's Throw Away
-----------------------------------
-- !addquest 9 56
-- Apolliane : !pos 447.088 -15.846 -320 265
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local morimarID = require('scripts/zones/Morimar_Basalt_Fields/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.A_STONES_THROW_AWAY)

quest.reward =
{
    fameArea = xi.quest.fame_area.ADOULIN,
    bayld    = 500,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.MORIMAR_BASALT_FIELDS] =
        {
            ['Apolliane'] = quest:progressEvent(2571),

            onEventFinish =
            {
                [2571] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MORIMAR_BASALT_FIELDS] =
        {
            ['Apolliane'] =
            {
                onTrade = function(player, npc, trade)
                    -- TODO: Morimar Basalt Fields HELM is not implemented at this time.  When it is,
                    -- on mining a Marble Nugget, set the Prog quest variable to 1, as this quest requires
                    -- the player to mine this object.
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.MARBLE_NUGGET) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(2573)
                    end
                end,

                onTrigger = quest:event(2572),
            },

            onEventFinish =
            {
                [2573] = function(player, csid, option, npc)
                    player:messageSpecial(morimarID.text.YOU_HAVE_LEARNED, xi.ki.DEMOLISHING)

                    if quest:complete(player) then
                        player:addKeyItem(xi.ki.DEMOLISHING)
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
