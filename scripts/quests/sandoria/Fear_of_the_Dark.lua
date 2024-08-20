-----------------------------------
-- Fear of the Dark
-----------------------------------
-- Log ID: 0, Quest ID: 78
-- Secodiand : !pos -160 -0 137 231
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.FEAR_OF_THE_DARK)

quest.reward =
{
    gil      = 200 * xi.settings.main.GIL_RATE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Secodiand'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(19)
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status >= xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Secodiand'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.BAT_WING, 2 } }) then
                        return quest:progressEvent(18)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(17)
                end,
            },

            onEventFinish =
            {
                [18] = function(player, csid, option, npc)
                    player:tradeComplete()
                        if player:getQuestStatus(quest.areaId, quest.questId) == xi.questStatus.QUEST_ACCEPTED then
                            player:addFame(xi.fameArea.SANDORIA, 30)
                        else
                            player:addFame(xi.fameArea.SANDORIA, 5)
                        end
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
