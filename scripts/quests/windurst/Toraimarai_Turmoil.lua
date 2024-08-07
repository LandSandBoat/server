-----------------------------------
-- Toraimarai Turmoil
-----------------------------------
-- !addquest 2 80
-- Ohbiru-Dohbiru : !pos 23 -5 -193 238
-- Leepe-Hoppe    ! !pos -131 20 -174 238
-- Polikal-Ramikal: !pos 15 -18 195 239
-- Yoran-Oran     : !pos -110 -14 203 239
-- Giddeus Spring : !pos -258 -2 -249 145
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)

quest.reward =
{
    gil  = 4500,
    fame = 100,
    fameArea = xi.fameArea.WINDURST,
    title = xi.title.CERTIFIED_RHINOSTERY_VENTURER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.BLUE_RIBBON_BLUES) and
                player:getFameLevel(xi.fameArea.WINDURST) >= 6 and
                not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] = quest:progressEvent(785, 4500, xi.keyItem.RHINOSTERY_CERTIFICATE, xi.item.STARMITE_SHELL),

            onEventFinish =
            {
                [785] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.RHINOSTERY_CERTIFICATE)
                    end
                end,
            },
        },
    },

    {
        --initial completion
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] =
            {
                onTrigger = quest:event(786, 4500, xi.keyItem.RHINOSTERY_CERTIFICATE, xi.item.STARMITE_SHELL), -- Reminder text.

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.STARMITE_SHELL, 3 } }) then
                        return quest:progressEvent(791)
                    end
                end,
            },

            ['Leepe-Hoppe'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(790, 0, xi.ki.RHINOSTERY_CERTIFICATE)
                end,
            },

            onEventFinish =
            {
                [791] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Polikal-Ramikal'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(391)
                end,
            },

            ['Yoran-Oran'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(392)
                end,
            },
        },
    },

    {
        --repeat completion
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] =
            {
                onTrigger = quest:event(795, 4500, 0, xi.item.STARMITE_SHELL), -- repeat dialog

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.STARMITE_SHELL, 3 } }) then
                        return quest:progressEvent(791)
                    end
                end,
            },

            onEventFinish =
            {
                [791] = function(player, csid, option, npc)
                    player:confirmTrade()

                    --From previous implementation, award 100 fame on first completion,
                    -- and 50 fame for any subsequent trade.
                    player:addFame(xi.fameArea.WINDURST, 50)
                    npcUtil.giveCurrency(player, 'gil', 4500)
                end,
            },
        },
    },
}

return quest
