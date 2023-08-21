-----------------------------------
-- I'm on a Boat
-----------------------------------
-- !addquest 9 55
-- Choubollet      : !pos 380.818 -2.094 290.792 262
-- Castoff_Point_4 : !pos 220 0.800 146 262
-----------------------------------
local foretID = zones[xi.zone.FORET_DE_HENNETIEL]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.IM_ON_A_BOAT)

quest.reward =
{
    fameArea = xi.quest.fame_area.ADOULIN,
    bayld    = 500,
}

local requiredTradeItems =
{
    { xi.item.SQUARE_OF_DHALMEL_LEATHER, 3 },
    { xi.item.UMBRIL_OOZE,               1 },
    { xi.item.TWITHERYM_SCALE,           1 },
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.FORET_DE_HENNETIEL] =
        {
            ['Choubollet'] = quest:progressEvent(2561),

            onEventFinish =
            {
                [2561] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.FORET_DE_HENNETIEL] =
        {
            ['Choubollet'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, requiredTradeItems)
                    then
                        return quest:progressEvent(2576)
                    end
                end,

                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.WATERCRAFT) then
                        return quest:event(2562)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(2563)
                    else
                        return quest:event(2577)
                    end
                end,
            },

            ['Castoff_Point_4'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.WATERCRAFT) then
                        local hasTitle = player:hasTitle(xi.title.TOXIN_TUSSLER) and 1 or 0

                        return quest:event(19, 4, hasTitle)
                    end
                end,
            },

            ['Castoff_Point_5'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.WATERCRAFT) then
                        local hasTitle = player:hasTitle(xi.title.TOXIN_TUSSLER) and 1 or 0

                        return quest:event(19, 5, hasTitle)
                    end
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    local castoffPointNum = tonumber(string.sub(npc:getName(), -1))
                    local questProgress   = quest:getVar(player, 'Prog')

                    if option == 1 and questProgress < 2 then
                        if castoffPointNum == 4 then
                            quest:setVar(player, 'Prog', 1)
                            player:messageSpecial(foretID.text.STARTED_TO_LEARN_BOAT)
                        elseif castoffPointNum == 5 then
                            quest:setVar(player, 'Prog', 2)
                            player:messageName(foretID.text.FIGURED_OUT_BOAT, nil)
                        end
                    elseif option == 3 then
                        player:addTitle(xi.title.TOXIN_TUSSLER)
                    end
                end,

                [2563] = function(player, csid, option, npc)
                    player:messageSpecial(foretID.text.YOU_HAVE_LEARNED, xi.ki.WATERCRAFTING)

                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.WATERCRAFT)
                        player:addKeyItem(xi.ki.WATERCRAFTING)
                    end
                end,

                [2576] = function(player, csid, option, npc)
                    player:confirmTrade()

                    npcUtil.giveKeyItem(player, xi.ki.WATERCRAFT)
                end,
            },
        },
    },
}

return quest
