-----------------------------------
-- Out of the Depths
-----------------------------------
-- Log ID: 1, Quest ID: 75
-- Ayame     !pos 132.904 -18.983 34.106
-- Ravorara  !pos -150.614 -6.000 -8.320
-- Brakobrik !pos 165.573 12.000 -89.774
-- Pavvke    !pos 15.820 6.985 -14.324
-----------------------------------
local oldtonID = zones[xi.zone.OLDTON_MOVALPOLOS]
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.OUT_OF_THE_DEPTHS)

quest.reward =
{
    fame     = 80,
    fameArea = xi.fameArea.BASTOK,
    gil      = 1200,
    title    = xi.title.TAVNAZIAN_SQUIRE,
}

local kiCheck = function(player)
    if
        player:hasKeyItem(xi.ki.DUSTY_TOME) or
        player:hasKeyItem(xi.ki.POINTED_JUG) or
        player:hasKeyItem(xi.ki.CRACKED_CLUB) or
        player:hasKeyItem(xi.ki.PEELING_HAIRPIN)
    then
        return true
    else
        return false
    end
end

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
            ['Ayame'] = quest:event(860):setPriority(101) -- Reminder
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Ravorara'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:progressEvent(307)
                    elseif
                        progress <= 3 and
                        kiCheck(player)
                    then -- Always checks the KIs in this order
                        if player:hasKeyItem(xi.ki.DUSTY_TOME) then
                            return quest:progressEvent(309, 0, 1, 0, xi.ki.DUSTY_TOME)
                        elseif player:hasKeyItem(xi.ki.POINTED_JUG) then
                            return quest:progressEvent(309, 0, 2, 0, xi.ki.POINTED_JUG)
                        elseif player:hasKeyItem(xi.ki.CRACKED_CLUB) then
                            return quest:progressEvent(309, 0, 3, 0, xi.ki.CRACKED_CLUB)
                        elseif player:hasKeyItem(xi.ki.PEELING_HAIRPIN) then
                            return quest:progressEvent(309, 0, 4, 0, xi.ki.PEELING_HAIRPIN)
                        end
                    elseif
                        progress == 3 and
                        not kiCheck(player) and
                        player:hasKeyItem(xi.ki.OLD_NAMETAG)
                    then
                        return quest:progressEvent(309, 0, 5, 0, xi.ki.OLD_NAMETAG)
                    elseif progress == 4 then
                        return quest:event(311)
                    else
                        return quest:event(308)
                    end
                end,
            },

            onEventFinish =
            {
                [307] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [309] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.DUSTY_TOME)
                        quest:setVarBit(player, 'Option', 0)
                        npcUtil.giveCurrency(player, 'gil', 100)
                    elseif option == 2 then
                        player:delKeyItem(xi.ki.POINTED_JUG)
                        quest:setVarBit(player, 'Option', 1)
                        npcUtil.giveCurrency(player, 'gil', 200)
                    elseif option == 3 then
                        player:delKeyItem(xi.ki.CRACKED_CLUB)
                        quest:setVarBit(player, 'Option', 2)
                        npcUtil.giveCurrency(player, 'gil', 300)
                    elseif option == 4 then
                        player:delKeyItem(xi.ki.PEELING_HAIRPIN)
                        quest:setVarBit(player, 'Option', 3)
                        npcUtil.giveCurrency(player, 'gil', 400)
                    elseif option == 5 then
                        player:delKeyItem(xi.ki.OLD_NAMETAG)
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Pavvke'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(238):setPriority(1005) -- Ensures this plays before the start of the quest "Fallen Comrades" as observed in captures.
                    end
                end,
            },

            onEventFinish =
            {
                [238] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Brakobrik'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 1 then
                        return quest:progressCutscene(2, 0, xi.item.PINCH_OF_HOARY_BOMB_ASH)
                    elseif progress == 2 then
                        return quest:messageSpecial(oldtonID.text.KILLING_BOMBS, 0, xi.item.PINCH_OF_HOARY_BOMB_ASH)
                    end
                end,

                onTrade = function(player, npc, trade)
                    local bombAshCount = utils.clamp(trade:getItemQty(xi.item.PINCH_OF_HOARY_BOMB_ASH), 0, 4)
                    local option       = quest:getVar(player, 'Option')
                    local dustyTome    = player:hasKeyItem(xi.ki.DUSTY_TOME) and 1 or 0

                    if
                        quest:getVar(player, 'Prog') == 2 and
                        bombAshCount > 0
                    then
                        if npcUtil.tradeHas(trade, { { xi.item.PINCH_OF_HOARY_BOMB_ASH, bombAshCount } }) then
                            -- Player has traded 1, 2, 3 or 4 ash and does not have associated KI.
                            if
                                (bombAshCount == 4 and not player:hasKeyItem(xi.ki.PEELING_HAIRPIN)) or
                                (bombAshCount == 3 and not player:hasKeyItem(xi.ki.CRACKED_CLUB)) or
                                (bombAshCount == 2 and not player:hasKeyItem(xi.ki.POINTED_JUG)) or
                                (bombAshCount == 1 and not player:hasKeyItem(xi.ki.DUSTY_TOME) and option < 15)
                            then
                                return quest:progressCutscene(4, 0, 0, bombAshCount) -- Both selections return option = #bombAsh

                        -- Depending on where the player is in the quest this interaction changes
                        elseif bombAshCount == 1 and option == 15 then
                            return quest:progressCutscene(4, 5, 4, 1, 1, dustyTome) -- Selection 1 returns 1 selection 2 returns 5

                            -- Player has the key item for the number of ash traded
                            else
                                return quest:progressCutscene(4, 0, 0, 0, 0, 1) -- Both selections return option 6
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
                        player:confirmTrade()
                        npcUtil.giveKeyItem(player, xi.ki.DUSTY_TOME)
                    elseif option == 2 then
                        player:confirmTrade()
                        npcUtil.giveKeyItem(player, xi.ki.POINTED_JUG)
                    elseif option == 3 then
                        player:confirmTrade()
                        npcUtil.giveKeyItem(player, xi.ki.CRACKED_CLUB)
                    elseif option == 4 then
                        player:confirmTrade()
                        npcUtil.giveKeyItem(player, xi.ki.PEELING_HAIRPIN)
                    elseif option == 5 and quest:getVar(player, 'Option') == 15 then
                        player:confirmTrade()
                        npcUtil.giveKeyItem(player, xi.ki.OLD_NAMETAG)
                        quest:setVar(player, 'Prog', 3)
                    elseif option == 6 then
                        player:confirmTrade()
                        player:messageSpecial(oldtonID.text.REFUSES_TO_GIVE_ANOTHER)
                    end
                end,
            },
        },
    },
}

return quest
