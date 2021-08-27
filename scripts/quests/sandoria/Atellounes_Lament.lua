-----------------------------------
-- Atelloune's Lament
-- !addquest 0 114
-- Atelloune: !pos 122 0 82 230
-- LADYBUG_WING: !additem 2506
-- TRAINEE_GLOVES: !additem 15008
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/items')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.ATELLOUNES_LAMENT)

quest.reward =
{
    fame = 30,
    item = xi.items.TRAINEE_GLOVES,
}

quest.sections = {
    -- Speak to Atelloune in Southern San d'Oria at (L-6) for a cutscene to start the quest.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                   player:getFameLevel(SANDORIA) >= 2 and
                   player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SEEING_SPOTS) == QUEST_COMPLETED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] = {
            ['Atelloune'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(890)
                end,
            },

            onEventFinish = {
                [890] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Trade her a Ladybug Wing for a cutscene and to receive your reward.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] = {
            ['Atelloune'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(892)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.LADYBUG_WING) then
                        return quest:progressEvent(891)
                    end
                end,
            },

            onEventFinish = {
                [891] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:complete(player)
                end,
            },
        },
    },

    -- Return to default action
}

return quest
