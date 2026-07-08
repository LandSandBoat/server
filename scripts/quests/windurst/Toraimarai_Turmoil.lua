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
    gil      = 4500,
    fame     = 100,
    fameArea = xi.fameArea.WINDURST,
    title    = xi.title.CERTIFIED_RHINOSTERY_VENTURER,
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
        -- Initial completion
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.STARMITE_SHELL, 3 } }) then
                        return quest:progressEvent(791)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(786, 4500, xi.keyItem.RHINOSTERY_CERTIFICATE, xi.item.STARMITE_SHELL) -- Reminder text.
                end,
            },

            ['Leepe-Hoppe'] = quest:event(790, 0, xi.ki.RHINOSTERY_CERTIFICATE),

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
            ['Polikal-Ramikal'] = quest:event(391),

            ['Yoran-Oran'] = quest:event(392),
        },
    },

    {
        -- Repeat completion
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeHasExactly(trade, { { xi.item.STARMITE_SHELL, 3 } })
                    then
                        return quest:progressEvent(791)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:event(786, 4500, xi.keyItem.RHINOSTERY_CERTIFICATE, xi.item.STARMITE_SHELL) -- Reminder text.
                    else
                        return quest:event(795, 4500, 0, xi.item.STARMITE_SHELL) -- Repeat dialog.
                    end
                end,
            },

            onEventFinish =
            {
                [791] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        quest:setVar(player, 'Prog', 0)
                        player:confirmTrade()
                        player:addFame(xi.fameArea.WINDURST, 50)
                        npcUtil.giveCurrency(player, 'gil', 4500)
                    end
                end,

                [795] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },
}

return quest
