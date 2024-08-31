-----------------------------------
-- To Catch A Falling Star
-----------------------------------
-- Log ID: 2, Quest ID: 53
-- Sigismund    : !pos -110 -9 80 206
-- Tohopka      : !pos -106 -10 84 240
-- Twinkle Tree : !pos 156 -41 334 115
-----------------------------------
local westSarutabarutaID = zones[xi.zone.WEST_SARUTABARUTA]
-----------------------------------
local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.TO_CATCH_A_FALLING_STAR)

quest.reward =
{
    fame = 75,
    fameArea = xi.fameArea.WINDURST,
    item = xi.item.FISH_SCALE_SHIELD
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Sigismund'] = quest:progressEvent(196, 0, xi.item.STARFALL_TEAR),

            onEventFinish =
            {
                [196] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            -- Supporting Character dialogue after Accepted
            ['Tohopka'] = quest:event(198, 0, xi.item.STARFALL_TEAR, xi.item.HANDFUL_OF_PUGIL_SCALES),

            -- Quest Completion
            ['Sigismund'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(197, 0, xi.item.STARFALL_TEAR)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.STARFALL_TEAR, 1 } }) then
                        return quest:progressEvent(199)
                    end
                end
            },

            onEventFinish =
            {
                [199] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        -- Re-establish the Prog variable so Sigismund provides his After completion text
                        quest:setVar(player, 'Prog', 2)
                    end
                end
            }
        },

        [xi.zone.WEST_SARUTABARUTA] =
        {
            ['Twinkle_Tree'] =
            {
                onTrigger = function(player, npc)
                    if
                        VanadielHour() <= 3 and
                        quest:getVar(player, 'Prog') == 0
                    then
                        player:messageSpecial(westSarutabarutaID.text.FROST_DEPOSIT_TWINKLES)
                        player:messageSpecial(westSarutabarutaID.text.MELT_BARE_HANDS)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        VanadielHour() <= 3 and
                        npcUtil.tradeHasExactly(trade, { { xi.item.HANDFUL_OF_PUGIL_SCALES, 1 } }) and
                        not player:hasItem(xi.item.STARFALL_TEAR)
                    then
                        if npcUtil.giveItem(player, xi.item.STARFALL_TEAR) then
                            player:confirmTrade()
                            quest:setVar(player, 'Prog', 1)
                            player:messageSpecial(westSarutabarutaID.text.FROST_DEPOSIT_TWINKLES)
                            player:messageSpecial(westSarutabarutaID.text.MELT_BARE_HANDS)
                        end
                    end
                end
            }
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Sigismund'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog' == 2) then
                        return quest:progressEvent(200)
                    end
                end
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    -- Clear the Prog variable so this event only fires once
                    quest:setVar(player, 'Prog', 0)
                end
            }
        },

        [xi.zone.WEST_SARUTABARUTA] =
        {
            ['Twinkle_Tree'] =
            {
                onTrigger = function(player, npc)
                    if VanadielHour() <= 3 then
                        player:messageSpecial(westSarutabarutaID.text.FROST_DEPOSIT_TWINKLES)
                        player:messageSpecial(westSarutabarutaID.text.MELT_BARE_HANDS)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        VanadielHour() <= 3 and
                        npcUtil.tradeHasExactly(trade, { { xi.item.HANDFUL_OF_PUGIL_SCALES, 1 } }) and
                        not player:hasItem(xi.item.STARFALL_TEAR)
                    then
                        if npcUtil.giveItem(player, xi.item.STARFALL_TEAR) then
                            player:confirmTrade()
                            player:messageSpecial(westSarutabarutaID.text.FROST_DEPOSIT_TWINKLES)
                            player:messageSpecial(westSarutabarutaID.text.MELT_BARE_HANDS)
                        end
                    end
                end
            }
        },
    },
}

return quest
