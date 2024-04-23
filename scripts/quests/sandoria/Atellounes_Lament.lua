-----------------------------------
-- Atelloune's Lament
-- !addquest 0 114
-- Atelloune: !pos 122 0 82 230
-- LADYBUG_WING: !additem 2506
-- TRAINEE_GLOVES: !additem 15008
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.ATELLOUNES_LAMENT)

quest.reward =
{
    fame = 30,
    fameArea = xi.fameArea.SANDORIA,
    item = xi.item.TRAINEE_GLOVES,
}

quest.sections =
{
    -- Speak to Atelloune in Southern San d'Oria at (L-6) for a cutscene to start the quest.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 2 and
                player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.SEEING_SPOTS) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Atelloune'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(890)
                end,
            },

            onEventFinish =
            {
                [890] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Trade her a Ladybug Wing for a cutscene and to receive your reward.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Atelloune'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(892)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.LADYBUG_WING) then
                        return quest:progressEvent(891)
                    end
                end,
            },

            onEventFinish =
            {
                [891] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
