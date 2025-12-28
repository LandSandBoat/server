-----------------------------------
-- Like Shining Subligars
-----------------------------------
-- Log ID: 5 (Outlands), Quest ID: 138
-- Heiji : !pos -1 -5 25 252
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.LIKE_A_SHINING_SUBLIGAR)

quest.reward =
{
    fameArea = xi.fameArea.NORG,
    fame     = 100,
    title    = xi.title.LOOKS_SUBLIME_IN_A_SUBLIGAR,
    item     = xi.item.SCROLL_OF_KURAYAMI_ICHI,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.NORG) >= 3
        end,

        [xi.zone.NORG] =
        {
            ['Heiji'] = quest:progressEvent(123),

            onEventFinish =
            {
                [123] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORG] =
        {
            ['Heiji'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(124, quest:getVar(player, 'Prog'))-- Update the player on the number of Rusty Subligars they have turned in
                end,

                onTrade = function(player, npc, trade)
                    local subligarsInTrade = trade:getItemQty(xi.item.RUSTY_SUBLIGAR)
                    local subligarsStored  = quest:getVar(player, 'Prog')
                    local subligarsTotal   = subligarsInTrade + subligarsStored

                    -- No subligars in trade or items other than subligars.
                    if
                        subligarsInTrade == 0 or
                        subligarsInTrade ~= trade:getItemCount()
                    then
                        return quest:event(124, subligarsStored)
                    end

                    -- Trade has only subligars. Check how many we have total.
                    if subligarsTotal >= 10 then
                        return quest:progressEvent(125) -- Complete quest
                    else
                        player:tradeComplete()
                        quest:setVar(player, 'Prog', subligarsTotal)
                        return quest:event(124, subligarsTotal)
                    end
                end,
            },

            onEventFinish =
            {
                [125] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                    end
                end,
            },
        },
    },
}

return quest
