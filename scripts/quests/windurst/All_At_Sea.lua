-----------------------------------
-- All at Sea
-----------------------------------
-- !addquest 2 23
-- Paytah !gotoid 17760350
-- Baren-Moren !gotoid 17752232
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.ALL_AT_SEA)

quest.reward =
{
    item = xi.item.LEATHER_RING,
    fame = 30,
    fameArea = xi.fameArea.WINDURST,
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
                    return quest:progressEvent(291)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.RIPPED_CAP) then
                        return quest:progressEvent(292)
                    end
                end,
            },

            ['Odilia'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:event(290) -- berate brother for talking to stranger
                    end
                end,
            },

            onEventFinish =
            {
                [291] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

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
            ['Paytah'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(293) -- crying
                end,

                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'Prog') == 4 then
                        if npcUtil.tradeHasExactly(trade, xi.item.SAILORS_CAP) then
                            return quest:progressEvent(295) -- Sailor's Cap turn in
                        else
                            return quest:progressEvent(298) -- Can't accept what isn't theirs
                        end
                    end
                end,
            },

            ['Odilia'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(294) -- remark on ripped cap
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
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(548, 0, xi.item.DHALMEL_HIDE) -- Dhalmel Hide reminder
                    end
                end,

                onTrade = function(player, npc, trade)
                    local questProgress = quest:getVar(player, 'Prog')
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.RIPPED_CAP) and
                        questProgress <= 1
                    then
                        return quest:progressEvent(547, 0, xi.item.DHALMEL_HIDE) -- Need Dhalmel Hide to repair
                    elseif
                        npcUtil.tradeHasExactly(trade, { { xi.item.DHALMEL_HIDE, 4 } }) and
                        questProgress >= 2 and
                        not player:hasItem(xi.item.SAILORS_CAP)
                    then
                        return quest:progressEvent(549)
                    elseif questProgress > 2 then
                        return quest:progressEvent(550, xi.item.SAILORS_CAP, xi.item.DHALMEL_HIDE) -- if you lose cap you can get another
                    end
                end,
            },

            onEventFinish =
            {
                [547] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 2)
                end,

                [549] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 2 then -- first turnin
                        if npcUtil.giveItem(player, { xi.item.SAILORS_CAP, xi.item.DHALMEL_MANTLE }) then
                            player:confirmTrade()
                            quest:setVar(player, 'Prog', 3)
                        end
                    else
                        if npcUtil.giveItem(player, { xi.item.SAILORS_CAP }) then
                            player:confirmTrade()
                        end
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Paytah'] =
            {
                onTrigger = function(player, npc)
                    if quest:getMustZone(player) then
                        return quest:progressEvent(296)
                    end
                end,
            },

            ['Odilia'] =
            {
                onTrigger = function(player, npc)
                    if quest:getMustZone(player) then
                        return quest:progressEvent(297)
                    else
                        return quest:event(290):replaceDefault()
                    end
                end,
            },
        }
    }
}

return quest
