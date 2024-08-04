-----------------------------------
-- Out of the Depths
-----------------------------------
-- Log ID    : 1, Quest ID: 75
-- Ayame     : !pos 133 -19 34 237
-- Ravorara  : !pos -151 -7 -7 236
-- Brakobrik : !pos 164 11 -91 11
-- Pavvke    : !pos 7.5 7 -13.5 234
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.OUT_OF_THE_DEPTHS)

quest.reward =
{
    fame     = 80,
    fameArea = xi.fameArea.BASTOK,
    title    = xi.title.TRASH_COLLECTOR,
    gil      = 1200,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.BASTOK) >= 3
        end,

        [xi.zone.METALWORKS] =
        {
            ['Ayame'] = quest:progressEvent(859),

            onEventFinish =
            {
                [859] = function(player, csid, option, npc)
                    if option == 3 then
                        quest:begin(player)
                    end
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
            ['Ayame'] = quest:event(860)
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Ravorara'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 1 then
                        if player:hasKeyItem(xi.ki.DUSTY_TOME) then
                            return quest:progressEvent(309, 0, 1, 0, 597)
                        elseif player:hasKeyItem(xi.ki.POINTED_JUG) then
                            return quest:progressEvent(309, 0, 2, 0, 598)
                        elseif player:hasKeyItem(xi.ki.CRACKED_CLUB) then
                            return quest:progressEvent(309, 0, 3, 0, 599)
                        elseif player:hasKeyItem(xi.ki.PEELING_HAIRPIN) then
                            return quest:progressEvent(309, 0, 4, 0, 600)
                        elseif player:hasKeyItem(xi.ki.OLD_NAMETAG) then
                            return quest:progressEvent(309, 0, 5, 0, 601)
                        else
                            return quest:event(308)
                        end
                    else
                        return quest:progressEvent(307)
                    end
                end,
            },

            onEventFinish =
            {
                [307] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [309] = function(player, csid, option, npc)
                    local increment = (quest:getVar(player, 'Prog') < 6 and 1 or 0) -- don't increment if prog is already 6
                    if option == 1 then
                        npcUtil.giveCurrency(player, 'gil', 100)
                        player:delKeyItem(xi.ki.DUSTY_TOME)
                        quest:incrementVar(player, 'Prog', increment)
                    elseif option == 2 then
                        npcUtil.giveCurrency(player, 'gil', 200)
                        player:delKeyItem(xi.ki.POINTED_JUG)
                        quest:incrementVar(player, 'Prog', increment)
                    elseif option == 3 then
                        npcUtil.giveCurrency(player, 'gil', 300)
                        player:delKeyItem(xi.ki.CRACKED_CLUB)
                        quest:incrementVar(player, 'Prog', increment)
                    elseif option == 4 then
                        npcUtil.giveCurrency(player, 'gil', 400)
                        player:delKeyItem(xi.ki.PEELING_HAIRPIN)
                        quest:incrementVar(player, 'Prog', increment)
                    elseif option == 5 then
                        player:delKeyItem(xi.ki.OLD_NAMETAG)
                        quest:setVar(player, 'Prog', 8)
                    end
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Brakobrik'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')
                    if questProgress >= 7 then
                        player:showText(npc, ID.text.STUPID_PEOPLE)
                    elseif questProgress == 1 then
                        return quest:progressEvent(2, 0, xi.item.PINCH_OF_HOARY_BOMB_ASH)
                    else
                        return quest:progressEvent(3, 0, xi.item.PINCH_OF_HOARY_BOMB_ASH)
                    end
                end,

                onTrade = function(player, npc, trade)
                    local questProgress = quest:getVar(player, 'Prog')
                    if
                        questProgress >= 2 and
                        questProgress < 7
                    then
                        if npcUtil.tradeHasExactly(trade, { { xi.item.PINCH_OF_HOARY_BOMB_ASH, 1 } }) then
                            if player:hasKeyItem(xi.ki.DUSTY_TOME) then
                                return quest:progressEvent(4, 8, 23, 0)
                            else
                                return quest:progressEvent(4, 0, 0, 1)
                            end
                        elseif npcUtil.tradeHasExactly(trade, { { xi.item.PINCH_OF_HOARY_BOMB_ASH, 2 } }) then
                            if player:hasKeyItem(xi.ki.POINTED_JUG) then
                                return quest:progressEvent(4, 0, 0, 0)
                            else
                                return quest:progressEvent(4, 0, 0, 2)
                            end
                        elseif npcUtil.tradeHasExactly(trade, { { xi.item.PINCH_OF_HOARY_BOMB_ASH, 3 } }) then
                            if player:hasKeyItem(xi.ki.CRACKED_CLUB) then
                                return quest:progressEvent(4, 0, 0, 0)
                            else
                                return quest:progressEvent(4, 0, 0, 3)
                            end
                        elseif npcUtil.tradeHasExactly(trade, { { xi.item.PINCH_OF_HOARY_BOMB_ASH, 4 } }) then
                            if player:hasKeyItem(xi.ki.PEELING_HAIRPIN) then
                                return quest:progressEvent(4, 0, 0, 0)
                            else
                                return quest:progressEvent(4, 0, 0, 4)
                            end
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [4] = function(player, csid, option, npc)
                    if option == 1 then
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, xi.ki.DUSTY_TOME)
                    elseif option == 2 then
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, xi.ki.POINTED_JUG)
                    elseif option == 3 then
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, xi.ki.CRACKED_CLUB)
                    elseif option == 4 then
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, xi.ki.PEELING_HAIRPIN)
                    elseif
                        option == 0 and
                        quest:getVar(player, 'Prog') >= 6
                    then
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, xi.ki.OLD_NAMETAG)
                        player:showText(npc, ID.text.FIGURING_OUT)
                        player:showText(npc, ID.text.DONT_BEING_MAD)
                        quest:setVar(player, 'Prog', 7)
                    elseif option == 0 then
                        player:tradeComplete()
                        player:showText(npc, ID.text.ALREADY_HAVE)
                        player:messageSpecial(ID.text.REFUSE_TO_GIVE)
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Pavvke'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 8 then
                        return quest:progressEvent(238)
                    end
                end,
            },

            onEventFinish =
            {
                [238] = function(player, csid, option, npc)
                    player:addFame(xi.fameArea.BASTOK, 80)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
