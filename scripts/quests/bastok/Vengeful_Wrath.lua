-----------------------------------
-- Vengeful Wrath
-----------------------------------
-- Log ID: 1, Quest ID: 32
-- Goraow : !pos 38 .1 14 234
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.VENGEFUL_WRATH)

quest.reward =
{
    fameArea = xi.fameArea.BASTOK,
    gil      = 900,
    title    = xi.title.AVENGER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.BASTOK) >= 3
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Goraow'] = quest:progressEvent(106),

            onEventFinish =
            {
                [106] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status ~= xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Goraow'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.QUADAV_HELM) then
                        return quest:progressEvent(107)
                    end
                end,
            },

            onEventFinish =
            {
                [107] = function(player, csid, option, npc)
                    player:confirmTrade()

                    if player:getQuestStatus(quest.areaId, quest.questId) == xi.questStatus.QUEST_ACCEPTED then
                        player:addFame(xi.fameArea.BASTOK, 112)
                    end

                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
