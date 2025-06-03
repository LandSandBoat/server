-----------------------------------
-- Like Shining Leggings
-----------------------------------
-- Log ID: 5 (Outlands), Quest ID: 139
-- Heizo : !pos -1 -5 25 252
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.LIKE_SHINING_LEGGINGS)

quest.reward =
{
    fameArea = xi.fameArea.NORG,
    fame     = 100,
    title    = xi.title.LOOKS_GOOD_IN_LEGGINGS,
    item     = xi.item.SCROLL_OF_DOKUMORI_ICHI,
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
            ['Heizo'] = quest:progressEvent(127),

            onEventFinish =
            {
                [127] = function(player, csid, option, npc)
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
            ['Heizo'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(128, quest:getVar(player, 'Prog'))-- Update the player on the number of Rusty Leggings they have turned in
                end,

                onTrade = function(player, npc, trade)
                    local legging = trade:getItemQty(xi.item.RUSTY_LEGGINGS)
                    local turnedInVar = quest:getVar(player, 'Prog')
                    local totalLeggings = legging + turnedInVar

                    if
                        legging > 0 and
                        legging == trade:getItemCount() -- Verifies that only Rusty Leggings are being traded
                    then
                        if turnedInVar + legging >= 10 then -- complete quest
                            return quest:progressEvent(129)
                        elseif turnedInVar <= 9 then -- turning in less than the amount needed to finish the quest
                            player:tradeComplete()
                            quest:setVar(player, 'Prog', totalLeggings)
                            return quest:event(128, totalLeggings) -- Update player on number of leggings turned in
                        end
                    else
                        return quest:event(128, turnedInVar) -- Update player on number of leggings turned in, but doesn't accept anything other than leggings
                    end
                end,
            },

            onEventFinish =
            {
                [129] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                    end
                end,
            },
        },
    },
}

return quest
