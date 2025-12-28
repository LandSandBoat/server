-----------------------------------
-- Prelude of Black and White
-----------------------------------
-- Log ID: 0, Quest ID: 88
-----------------------------------
-- _6h1      : !pos -37 -3 31 233
-- Narcheral : !pos 129 -11 126 231
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE)

quest.reward =
{
    item = xi.item.HEALERS_DUCKBILLS,
    fame = 40,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.MESSENGER_FROM_BEYOND) and
                player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
                player:getMainJob() == xi.job.WHM
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['_6h1'] = quest:progressEvent(551),

            onEventFinish =
            {
                [551] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Narcheral'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.CANTEEN_OF_YAGUDO_HOLY_WATER, xi.item.MOCCASINS }) then
                        return quest:progressEvent(691)
                    end
                end,
            },

            onEventFinish =
            {
                [691] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
