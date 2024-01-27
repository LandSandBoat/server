-----------------------------------
-- The Promise
--
-- Kohlo-Lakolo, !pos -26.8 -6 190 240
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PROMISE)

local function timedEvents(player, inTime, outATime)
    if
        quest:getVar(player, 'Prog') == 1 and
        player:getRank(xi.nation.WINDURST) < 9
    then
        return quest:event(inTime)
    else
        return quest:event(outATime)
    end
end

local function finalEvents(player, inTime, outATime)
    if player:getCharVar('SOBfinalEvent') == 1 then
        return quest:event(inTime)
    else
        return quest:event(outATime)
    end
end

quest.reward =
{
    fame     = 10,
    fameArea = xi.quest.fame_area.WINDURST,
    item     = xi.item.PROMISE_BADGE,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WILD_CARD)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kohlo-Lakolo'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMainLvl() >= 5 and
                        player:getFameLevel(xi.quest.fame_area.WINDURST) >= 5 and
                        not quest:getMustZone(player)
                    then
                        if player:getRank(xi.nation.WINDURST) < 9 then
                            return quest:progressEvent(513, 0, xi.ki.INVISIBLE_MAN_STICKER) -- Quest starting event in time.
                        else
                            return quest:progressEvent(532, 0, xi.ki.INVISIBLE_MAN_STICKER) -- Quest starting event late.
                        end
                    else
                        if player:getRank(xi.nation.WINDURST) < 9 then
                            return quest:event(505) -- Default text in time.
                        else
                            return quest:event(535) -- Default text late.
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [513] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1) -- Start in time.
                end,

                [532] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepeted.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kohlo-Lakolo'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.INVISIBLE_MAN_STICKER) then
                        if quest:getVar(player, 'Prog') == 1 then
                            if player:getRank(xi.nation.WINDURST) < 9 then
                                return quest:progressEvent(522, 0, xi.ki.INVISIBLE_MAN_STICKER) -- Quest Complete. In time.
                            else
                                return quest:progressEvent(542, 0, xi.ki.INVISIBLE_MAN_STICKER) -- Quest Complete. Started in time, arrived late.
                            end
                        else
                            return quest:progressEvent(534, 0, xi.ki.INVISIBLE_MAN_STICKER) -- Quest Complete. Started late.
                        end
                    else
                        if quest:getVar(player, 'Prog') == 1 then
                            if player:getRank(xi.nation.WINDURST) < 9 then
                                return quest:event(514) -- Reminder. In time.
                            else
                                return quest:event(543, 0, xi.ki.INVISIBLE_MAN_STICKER) -- Reminder. Started in time, but are late.
                            end
                        else
                            return quest:event(533, 0, xi.ki.INVISIBLE_MAN_STICKER) -- Reminder. Started late.
                        end
                    end
                end,
            },

            ['Gomada-Vulmada'] =
            {
                onTrigger = function(player, npc)
                    return timedEvents(player, 518, 528)
                end,
            },

            ['Papo-Hopo'] =
            {
                onTrigger = function(player, npc)
                    return timedEvents(player, 515, 525)
                end,
            },

            ['Pichichi'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 1 or
                        player:getRank(xi.nation.WINDURST) >= 9
                    then
                        return quest:event(530)
                    end
                end,
            },

            ['Pyo_Nzon'] =
            {
                onTrigger = function(player, npc)
                    return timedEvents(player, 517, 527)
                end,
            },

            ['Shanruru'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 0 or
                        player:getRank(xi.nation.WINDURST) >= 9
                    then
                        return quest:event(529)
                    end
                end,
            },

            ['Yafa_Yaa'] =
            {
                onTrigger = function(player, npc)
                    return timedEvents(player, 516, 526)
                end,
            },

            onEventFinish =
            {
                [522] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setCharVar('SOBfinalEvent', 1)
                    end
                end,

                [534] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setCharVar('SOBfinalEvent', 1)
                    end
                end,

                [542] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setCharVar('SOBfinalEvent', 1)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Chamama'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.INVISIBLE_MAN_STICKER) then
                        return quest:event(800)
                    elseif quest:getVar(player, 'Chamama') > 0 then
                        return quest:event(798, 0, xi.item.SHOALWEED, xi.ki.INVISIBLE_MAN_STICKER)
                    else
                        return quest:progressEvent(797, 0, xi.item.SHOALWEED, xi.ki.INVISIBLE_MAN_STICKER)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Chamama') == 1 and
                        npcUtil.tradeHasExactly(trade, xi.item.SHOALWEED) and
                        not player:hasKeyItem(xi.ki.INVISIBLE_MAN_STICKER)
                    then
                        return quest:progressEvent(799, 0, 0, xi.ki.INVISIBLE_MAN_STICKER)
                    end
                end,
            },

            onEventFinish =
            {
                [797] = function(player, csid, option, npc)
                    quest:setVar(player, 'Chamama', 1)
                end,

                [799] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.INVISIBLE_MAN_STICKER)
                end,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Gomada-Vulmada'] =
            {
                onTrigger = function(player, npc)
                    return finalEvents(player, 540, 590)
                end,
            },

            ['Kohlo-Lakolo'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar('SOBfinalEvent') == 1 then
                        if player:hasKeyItem(xi.ki.DARK_MANA_ORB) then
                            return quest:progressEvent(584)
                        else
                            return quest:event(528)
                        end
                    else
                        local random = math.random(0, 1)
                        if random == 0 then
                            return quest:event(544)
                        else
                            return quest:event(585)
                        end
                    end
                end,
            },

            ['Papo-Hopo'] =
            {
                onTrigger = function(player, npc)
                    return finalEvents(player, 537, 587)
                end,
            },

            ['Pichichi'] =
            {
                onTrigger = function(player, npc)
                    return finalEvents(player, 536, 586)
                end,
            },

            ['Pyo_Nzon'] =
            {
                onTrigger = function(player, npc)
                    return finalEvents(player, 539, 589)
                end,
            },

            ['Shanruru'] =
            {
                onTrigger = function(player, npc)
                    return finalEvents(player, 541, 591)
                end,
            },

            ['Yafa_Yaa'] =
            {
                onTrigger = function(player, npc)
                    return finalEvents(player, 538, 588)
                end,
            },

            onEventFinish =
            {
                [584] = function(player, csid, option, npc)
                    player:setCharVar('SOBfinalEvent', 0)
                end,
            },
        },
    },
}

return quest
