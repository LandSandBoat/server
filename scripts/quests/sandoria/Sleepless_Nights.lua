-----------------------------------
-- Sleepless Nights
-----------------------------------
-- Log ID: 0, Quest ID: 80
-----------------------------------
-- Paouala : !pos 158 -6 17 230
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.SLEEPLESS_NIGHTS)

quest.reward =
{
    gil   = 5000,
    title = xi.title.SHEEPS_MILK_DELIVERER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 2
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Paouala'] = quest:progressEvent(85),

            onEventFinish =
            {
                [85] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Paouala'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.item.JUG_OF_MARYS_MILK) then
                        return quest:progressEvent(84)
                    end
                end,

                onTrigger = quest:event(83),
            },

            onEventFinish =
            {
                [84] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Paouala'] = quest:event(81):replaceDefault(),
        },
    },
}

return quest
