-----------------------------------
-- Return to the Depths
-----------------------------------
-- Log ID: 1, Quest ID: 78
-- Ayame     : !pos 133 -19 34 237
-- Muckvix   : !gotoid 17780761
-- Magriffon : !gotoid 17801262
-- Tarnotik  : !pos 161 11 -56 11
-----------------------------------
local portBastokID = zones[xi.zone.PORT_BASTOK]
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.RETURN_TO_THE_DEPTHS)

quest.reward =
{
    fame     = 60,
    fameArea = xi.fameArea.BASTOK,
    item     = xi.item.BOWYER_RING,
    title    = xi.title.GOBLIN_IN_DISGUISE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.BASTOK) >= 5 and
                player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.A_QUESTION_OF_FAITH)
        end,

        [xi.zone.METALWORKS] =
        {
            ['Ayame'] = quest:progressEvent(879),

            onEventFinish =
            {
                [879] = function(player, csid, option, npc)
                        quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Ayame'] =
            {
                onTrigger = function(player, csid, option, npc)
                    if quest:getVar(player, 'prog') == 10 then
                        return quest:progressEvent(881)
                    else
                        return quest:event(880)
                    end
                end,
            },

            onEventFinish =
            {
                [881] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Tarnotik'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'prog') == 6 then
                        return quest:progressEvent(42, 0, 0, 0, 0, xi.item.BULB_OF_MISAREAUX_GARLIC)
                    elseif quest:getVar(player, 'prog') == 7 then
                        return quest:event(43):importantOnce()
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.BOTTLE_OF_AHRIMAN_TEARS) and
                        quest:getVar(player, 'prog') == 7
                    then
                        return quest:progressEvent(44)
                    end
                end,
            },

            afterZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'prog') == 0 then
                        return quest:progressEvent(40, 0, xi.item.SPRIG_OF_FRESH_MUGWORT, xi.item.MOORISH_IDOL, xi.item.PIECE_OF_ANGEL_SKIN, xi.item.BULB_OF_MISAREAUX_GARLIC)
                    elseif quest:getVar(player, 'prog') == 5 then
                        return quest:progressEvent(41)
                    end
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    quest:setVar(player, 'prog', 1)
                end,

                [41] = function(player, csid, option, npc)
                    quest:setVar(player, 'prog', 6)
                end,

                [42] = function(player, csid, option, npc)
                    quest:setVar(player, 'prog', 7)
                end,

                [44] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'prog', 8)
                    xi.teleport.to(player, xi.teleport.id.MINESHAFT)
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Muckvix'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.BULB_OF_MISAREAUX_GARLIC) and
                        quest:getVar(player, 'prog') == 1
                    then
                        return quest:progressEvent(99, 0, 0, 0, 0, xi.item.BULB_OF_MISAREAUX_GARLIC)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'prog')
                    if questProgress == 2 then
                        return quest:event(46):importantOnce()
                    elseif questProgress == 4 then
                        return quest:progressEvent(100)
                    elseif questProgress >= 5 then
                        return quest:event(47):importantOnce()
                    end
                end,
            },

            onEventFinish =
            {
                [99] = function(player, csid, option, npc)
                    player:tradeComplete()
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_MUCKVIX)
                    npcUtil.giveCurrency(player, 'gil', 2000)
                    quest:setVar(player, 'prog', 2)
                end,

                [100] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.PROVIDENCE_POT)
                    player:delKeyItem(xi.ki.LETTER_FROM_MAGRIFFON)
                    player:delKeyItem(xi.ki.LETTER_FROM_MUCKVIX)
                    npcUtil.giveKeyItem(player, xi.ki.PUNGENT_PROVIDENCE_POT)
                    quest:setVar(player, 'prog', 5)
                end,
            },
        },

        [xi.zone.KAZHAM] =
        {
            ['Magriffon'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'prog')
                    if questProgress == 2 then
                        return quest:progressEvent(299, 0, xi.ki.PROVIDENCE_POT, 10000)
                    elseif questProgress == 3 then
                        return quest:progressEvent(300, 0, xi.ki.PROVIDENCE_POT, 10000)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { { 'gil', 10000 } }) and
                        quest:getVar(player, 'prog') == 3
                    then
                        return quest:progressEvent(301, 0, xi.ki.PROVIDENCE_POT, 10000)
                    end
                end,
            },

            onEventFinish =
            {
                [299] = function(player, csid, option, npc)
                    quest:setVar(player, 'prog', 3)
                end,

                [301] = function(player, csid, option, npc)
                    player:tradeComplete()
                    npcUtil.giveKeyItem(player, { xi.ki.PROVIDENCE_POT, xi.ki.LETTER_FROM_MAGRIFFON })
                    quest:setVar(player, 'prog', 4)
                end,
            },
        },

        [xi.zone.MINE_SHAFT_2716] =
        {
            ['_0d0'] = -- Mine Shaft BCNM Entrance
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'prog') == 8 then
                        return quest:progressEvent(5, 0, 0, 0, 0, xi.item.BULB_OF_MISAREAUX_GARLIC)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    quest:setVar(player, 'prog', 9)
                end,

                [32001] = function(player, csid, option, npc)
                    if quest:getVar(player, 'prog') == 9 then
                        quest:setVar(player, 'prog', 10)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Ravorara'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.PUNGENT_PROVIDENCE_POT) then
                        return quest:progressEvent(313, 0, 0, 0, xi.ki.PUNGENT_PROVIDENCE_POT)
                    else
                        return quest:event(314)
                    end
                end,
            },

            onEventFinish =
            {
                [313] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.PUNGENT_PROVIDENCE_POT)
                        player:messageSpecial(portBastokID.text.KEYITEM_LOST, xi.ki.PUNGENT_PROVIDENCE_POT)
                        npcUtil.giveCurrency(player, 'gil', 1000)
                    end
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Tarnotik'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(43)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.BOTTLE_OF_AHRIMAN_TEARS) then
                        return quest:progressEvent(44)
                    end
                end,
            },

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    player:tradeComplete()
                    xi.teleport.to(player, xi.teleport.id.MINESHAFT)
                end,
            },
        },
    },
}

return quest
