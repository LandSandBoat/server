-----------------------------------
-- Crying Over Onions
--
-- Kohlo-Lakolo, !pos -26.8 -6 190 240
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.WINDURST,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kohlo-Lakolo'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Reward') == 1 then
                        if
                            player:getMainLvl() >= 5 and
                            player:getFameLevel(xi.quest.fame_area.WINDURST) >= 5 and
                            not quest:getMustZone(player)
                        then
                            return quest:progressEvent(496) -- Quest starting event.
                        else
                            return quest:event(450)
                        end
                    else
                        if not quest:getMustZone(player) then
                            return quest:progressEvent(449) -- Get previous quest reward.
                        else
                            return quest:event(440)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [449] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.BOUNCER_CLUB) then
                        quest:setVar(player, 'Reward', 1)
                        quest:setMustZone(player)
                    end
                end,

                [496] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepeted in time.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kohlo-Lakolo'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(497)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:event(512) -- Reminder text.
                    else
                        return quest:event(498) -- Reminder text.
                    end
                end,
            },

            ['Gomada-Vulmada'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(500)
                    end
                end,
            },

            ['Papo-Hopo'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(501)
                    end
                end,
            },

            ['Pichichi'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(503)
                    end
                end,
            },

            ['Pyo_Nzon'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(502)
                    end
                end,
            },

            ['Shanruru'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(504)
                    end
                end,
            },

            ['Yafa_Yaa'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(499)
                    end
                end,
            },

            onEventFinish =
            {
                [497] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Honoi-Gomoi'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(774, 0, xi.item.STAR_SPINEL)
                    elseif quest:getVar(player, 'Prog') == 1 or quest:getVar(player, 'Prog') == 2 then
                        return quest:event(777) -- Reminder text before trade.
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:event(778) -- Reminder text after trade
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(776) -- Quest Complete.
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        (quest:getVar(player, 'Prog') == 1 or quest:getVar(player, 'Prog') == 2) and
                        npcUtil.tradeHasExactly(trade, xi.item.STAR_SPINEL)
                    then
                        return quest:progressEvent(775, 0, xi.item.STAR_SPINEL)
                    end
                end,
            },

            onEventFinish =
            {
                [774] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [775] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.STAR_NECKLACE) then
                        player:confirmTrade()
                        quest:setVar(player, 'Prog', 3)
                    end
                end,

                [776] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setLocalVar('[2][77]mustZone', 1)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(598) -- Optional, one time only, dialog.
                    end
                end,
            },

            onEventFinish =
            {
                [598] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PROMISE) == QUEST_AVAILABLE
        end,

        [xi.zone.PORT_WINDURST] =
        {
            -- New default texts.
            ['Gomada-Vulmada'] = quest:event(507):replaceDefault(),
            ['Papo-Hopo']      = quest:event(508):replaceDefault(),
            ['Pichichi']       = quest:event(511):replaceDefault(),
            ['Pyo_Nzon']       = quest:event(510):replaceDefault(),
            ['Shanruru']       = quest:event(504):replaceDefault(),
            ['Yafa_Yaa']       = quest:event(506):replaceDefault(),
        },
    },
}

return quest
