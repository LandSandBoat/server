-----------------------------------
-- All at Sea
-----------------------------------
-- Log ID: 2, Quest ID: 23
-- Paytah      !pos 77.609 -5.000 119.549
-- Baren-Moren !pos -66.226 -2.009 -148.883
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.ALL_AT_SEA)

quest.reward =
{
    item = xi.item.LEATHER_RING,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 3
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Paytah'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(291)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.item.RIPPED_CAP) then
                        return quest:progressEvent(292)
                    end
                end,
            },

            onEventFinish =
            {
                [292] = function(player, csid, option, npc)
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
            ['Odilia'] = quest:event(294),

            ['Paytah'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(293)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.item.SAILORS_CAP) then
                        return quest:progressEvent(295)
                    end
                end,
            },

            onEventFinish =
            {
                [295] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        quest:setMustZone(player)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Baren-Moren'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 1 then
                        return quest:event(548, 0, xi.item.DHALMEL_HIDE)
                    elseif progress == 2 then
                        return quest:event(550, xi.item.SAILORS_CAP, xi.item.DHALMEL_HIDE)
                    else
                        return
                    end
                end,

                onTrade = function(player, npc, trade)
                    local progress = quest:getVar(player, 'Prog')

                    if
                        progress == 0 and
                        npcUtil.tradeHas(trade, xi.item.RIPPED_CAP)
                    then
                        return quest:progressEvent(547, 0, xi.item.DHALMEL_HIDE)
                    elseif
                        progress >= 1 and
                        npcUtil.tradeHas(trade, { { xi.item.DHALMEL_HIDE, 4 } }) and
                        not player:hasItem(xi.item.SAILORS_CAP)
                    then
                        if progress == 1 then
                            return quest:progressEvent(549) -- First time getting the Sailor's Cap
                        elseif progress == 2 then
                            return quest:progressEvent(549, 0, 0, 1) -- Everytime after
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [547] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 1)
                end,

                [549] = function(player, csid, option, npc)
                    if option == 0 then
                        player:confirmTrade()
                        npcUtil.giveItem(player, xi.item.SAILORS_CAP)
                        npcUtil.giveItem(player, xi.item.DHALMEL_MANTLE)
                        quest:setVar(player, 'Prog', 2)
                    elseif option == 1 then
                        player:confirmTrade()
                        npcUtil.giveItem(player, xi.item.SAILORS_CAP)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                quest:getMustZone(player)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Odilia'] = quest:event(297),

            ['Paytah'] = quest:event(296),
        },
    },
}

return quest
