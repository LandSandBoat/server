-----------------------------------
-- Return to the Depths
-----------------------------------
-- Log ID: 1, Quest ID: 78
-----------------------------------
-- Area: Metalworks
-- NPC: Ayame !pos 132 -18 33 237
-- NPC: Rakorok !pos 158 13 -42 11
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.RETURN_TO_THE_DEPTHS)

quest.reward =
{
    fame     = 50,
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
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:event(880)
                    elseif progress == 10 then
                        return quest:progressEvent(881)
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
            onZoneIn = function(player)
                local progress = quest:getVar(player, 'Prog')

                if progress == 0 then
                    return 40
                elseif progress == 5 then
                    return 41
                end
            end,

            ['Tarnotik'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') >= 7 and
                        npcUtil.tradeHas(trade, { xi.item.BOTTLE_OF_AHRIMAN_TEARS })
                    then
                        return quest:progressEvent(44)
                    end
                end,

                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 6 then
                        return quest:progressEvent(42, 11, 131456, 384, 0, xi.item.MISAREAUX_GARLIC)
                    elseif progress >= 7 then
                        return quest:event(43):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [41] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,

                [42] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 7)
                end,

                [44] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 8)
                    player:tradeComplete()
                    player:setPos(-93.657, -120.000, -583.561, 232, xi.zone.MINE_SHAFT_2716)
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Muckvix'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeHas(trade, { xi.item.MISAREAUX_GARLIC })
                    then
                        return quest:progressEvent(99, 1, 1, 3, 0, xi.item.MISAREAUX_GARLIC)
                    end
                end,

                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 2 then
                        return quest:event(46):oncePerZone()
                    elseif
                        progress == 4 and
                        player:hasKeyItem(xi.ki.LETTER_FROM_MAGRIFFON) and
                        player:hasKeyItem(xi.ki.PROVIDENCE_POT)
                    then
                        return quest:progressEvent(100)
                    elseif progress == 5 then
                        return quest:event(47):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [99] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:tradeComplete()
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_MUCKVIX)
                    npcUtil.giveCurrency(player, 'gil', 2000)
                end,

                [100] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    npcUtil.giveKeyItem(player, xi.ki.PUNGENT_PROVIDENCE_POT)
                    player:delKeyItem(xi.ki.PROVIDENCE_POT)
                    player:delKeyItem(xi.ki.LETTER_FROM_MAGRIFFON)
                end,
            },
        },

        [xi.zone.KAZHAM] =
        {
            ['Magriffon'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 3 and
                        trade:getGil() == 10000
                    then
                        return quest:progressEvent(301, 1, xi.ki.PROVIDENCE_POT)
                    end
                end,

                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        player:hasKeyItem(xi.ki.LETTER_FROM_MUCKVIX)
                    then
                        return quest:progressEvent(299, 75, xi.ki.PROVIDENCE_POT, 10000)
                    end
                end,
            },

            onEventFinish =
            {
                [299] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    player:delKeyItem(xi.ki.LETTER_FROM_MUCKVIX)
                end,

                [301] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                    player:tradeComplete()
                    npcUtil.giveKeyItem(player, xi.ki.PROVIDENCE_POT)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_MAGRIFFON)
                end,
            },
        },

        [xi.zone.MINE_SHAFT_2716] =
        {
            ['_0d0'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 8 then
                        return quest:progressEvent(5, 1, 131456, 384, 0, xi.item.MISAREAUX_GARLIC)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 9)
                end,

                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.RETURN_TO_THE_DEPTHS then
                        quest:setVar(player, 'Prog', 10)
                        npcUtil.giveCurrency(player, 'gil', 10000)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Ayame'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(882)
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Tarnotik'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { xi.item.BOTTLE_OF_AHRIMAN_TEARS }) then
                        return quest:event(44)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(45):oncePerZone()
                end,
            },

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    player:tradeComplete()
                    player:setPos(-93.657, -120.000, -583.561, 232, xi.zone.MINE_SHAFT_2716)
                end,
            },
        },

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
                        npcUtil.giveCurrency(player, 'gil', 1000)
                        player:delKeyItem(xi.ki.PUNGENT_PROVIDENCE_POT)
                    end
                end,
            },
        },
    },
}

return quest
