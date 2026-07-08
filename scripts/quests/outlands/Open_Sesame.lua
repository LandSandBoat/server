-----------------------------------
-- Open Sesame
-----------------------------------
-- Log ID: 5, Quest ID: 165
-- Lokpix : !pos -61.942 3.949 224.900 114
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.OPEN_SESAME)

quest.reward =
{
    fameArea = xi.fameArea.SELBINA_RABAO,
    fame     = 30,
    keyItem  = xi.ki.LOADSTONE,
}

local tradeOptions =
{
    [1] = { xi.item.METEORITE,   1 },
    [2] = { xi.item.SOIL_GEM,    1 },
    [3] = { xi.item.SOIL_GEODE, 12 },
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.EASTERN_ALTEPA_DESERT] =
        {
            ['Lokpix'] = quest:progressEvent(20),

            onEventFinish =
            {
                [20] = function(player, csid, option, npc)
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

        [xi.zone.EASTERN_ALTEPA_DESERT] =
        {
            ['Lokpix'] =
            {
                onTrade = function(player, npc, trade)
                    for i = 1, #tradeOptions do
                        if
                            trade:getItemQty(tradeOptions[i][1]) == tradeOptions[i][2] and
                            trade:getItemQty(xi.item.TREMORSTONE) == 1
                        then
                            return quest:progressEvent(22)
                        end
                    end

                    return quest:event(23)
                end,

                onTrigger = function(player, npc)
                    return quest:event(21)
                end,
            },

            onEventFinish =
            {
                [22] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.EASTERN_ALTEPA_DESERT] =
        {
            ['Lokpix'] = quest:event(24):replaceDefault()
        },
    },
}

return quest
