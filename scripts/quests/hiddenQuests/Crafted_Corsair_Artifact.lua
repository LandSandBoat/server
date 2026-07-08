-----------------------------------
-- Crafted Corsair Artifact
-----------------------------------
-- Leleroon                                 : !pos -14.687 0.000 25.114 53
-- Raqtibahl  (San d'Oria - Corsair's Frac) : !pos -59.000 -4.000 -39.000 232
-- Door_House (Bastok - Corsair's Bottes)   : !pos 10.000 0.000 -16.000 234
-- Door_House (Windurst - Corsair's Gants)  : !pos -200.000 -4.000 -111.000 238
-----------------------------------
local windurstWatersID = zones[xi.zone.WINDURST_WATERS]
local bastokMinesID = zones[xi.zone.BASTOK_MINES]
-----------------------------------

local quest = HiddenQuest:new('CorArtifact')

local function canStartCommission(player)
    return player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS) >= xi.questStatus.QUEST_ACCEPTED
end

local function getExcludedCommissionMask(player)
    local completedCommissions = quest:getVar(player, 'Completed')
    local excludedCommissions = 0

    if utils.mask.getBit(completedCommissions, 0) then
        excludedCommissions = excludedCommissions + 2
    end

    if utils.mask.getBit(completedCommissions, 1) then
        excludedCommissions = excludedCommissions + 4
    end

    if utils.mask.getBit(completedCommissions, 2) then
        excludedCommissions = excludedCommissions + 8
    end

    return excludedCommissions
end

local function hasCompletedCommission(player, option)
    return utils.mask.getBit(quest:getVar(player, 'Completed'), option - 1)
end

local function hasCompletedRedCommission(player)
    return hasCompletedCommission(player, 3)
end

local function hasCompletedAllCommissions(player)
    return
        hasCompletedCommission(player, 1) and
        hasCompletedCommission(player, 2) and
        hasCompletedCommission(player, 3)
end

local function finishCommission(player)
    quest:setVarBit(player, 'Completed', quest:getVar(player, 'Option') - 1)
    quest:setVar(player, 'Prog', 0)
    quest:setVar(player, 'Option', 0)
    quest:setVar(player, 'Timer', 0)
end

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return canStartCommission(player)
        end,

        [xi.zone.NASHMAU] =
        {
            ['Leleroon'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')
                    local questOption = quest:getVar(player, 'Option')

                    if questProgress >= 1 and questProgress <= 4 then
                        if questOption == 1 then
                            return quest:progressEvent(285)
                        elseif questOption == 2 then
                            return quest:progressEvent(286)
                        elseif questOption == 3 then
                            return quest:progressEvent(287)
                        end
                    elseif
                        questProgress == 0 and
                        not hasCompletedAllCommissions(player)
                    then
                        return quest:progressEvent(282, { [7] = getExcludedCommissionMask(player) })
                    end
                end,
            },

            onEventFinish =
            {
                [282] = function(player, csid, option, npc)
                    if
                        option >= 1 and
                        option <= 3 and
                        not hasCompletedCommission(player, option)
                    then
                        if option == 1 then
                            npcUtil.giveKeyItem(player, xi.ki.LELEROONS_LETTER_GREEN)
                        elseif option == 2 then
                            npcUtil.giveKeyItem(player, xi.ki.LELEROONS_LETTER_BLUE)
                        elseif option == 3 then
                            npcUtil.giveKeyItem(player, xi.ki.LELEROONS_LETTER_RED)
                        end

                        quest:setVar(player, 'Option', option)
                        quest:setVar(player, 'Prog', 1)
                        quest:setVar(player, 'Timer', 0)
                    end
                end,
            },
        },
    },

    {
        check = function(player, questVars, vars)
            return canStartCommission(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Door_House'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npc:getID() == windurstWatersID.npc.LELEROON_GREEN_DOOR and
                        quest:getVar(player, 'Option') == 1
                    then
                        local questProgress = quest:getVar(player, 'Prog')

                        if
                            questProgress == 2 and
                            npcUtil.tradeHasExactly(
                                trade,
                                {
                                    xi.item.SPOOL_OF_GOLD_THREAD,
                                    xi.item.SQUARE_OF_KARAKUL_LEATHER,
                                    xi.item.SQUARE_OF_RED_GRASS_CLOTH,
                                    xi.item.SPOOL_OF_WAMOURA_SILK,
                                }
                            )
                        then
                            return quest:progressEvent(943)
                        elseif
                            questProgress == 3 and
                            npcUtil.tradeHasExactly(trade, { { xi.item.IMPERIAL_MYTHRIL_PIECE, 4 } })
                        then
                            return quest:progressEvent(946)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    if
                        npc:getID() == windurstWatersID.npc.LELEROON_GREEN_DOOR and
                        quest:getVar(player, 'Option') == 1
                    then
                        local questProgress = quest:getVar(player, 'Prog')

                        if player:hasKeyItem(xi.ki.LELEROONS_LETTER_GREEN) then
                            return quest:progressEvent(941)
                        elseif questProgress == 2 then
                            return quest:progressEvent(942)
                        elseif questProgress == 3 then
                            return quest:progressEvent(954)
                        elseif questProgress == 4 then
                            if quest:getVar(player, 'Timer') <= VanadielUniqueDay() then
                                return quest:progressEvent(944)
                            else
                                return quest:progressEvent(945)
                            end
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [941] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:delKeyItem(xi.ki.LELEROONS_LETTER_GREEN)
                end,

                [943] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 3)
                end,

                [944] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.CORSAIRS_GANTS) then
                        finishCommission(player)
                    end
                end,

                [946] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 4)
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                end,
            },
        },
    },

    {
        check = function(player, questVars, vars)
            return canStartCommission(player)
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Door_House'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npc:getID() == bastokMinesID.npc.LELEROON_BLUE_DOOR and
                        quest:getVar(player, 'Option') == 2
                    then
                        local questProgress = quest:getVar(player, 'Prog')

                        if
                            questProgress == 2 and
                            npcUtil.tradeHasExactly(
                                trade,
                                {
                                    xi.item.MYTHRIL_SHEET,
                                    xi.item.SQUARE_OF_KARAKUL_LEATHER,
                                    xi.item.SQUARE_OF_LM_BUFFALO_LEATHER,
                                    xi.item.SQUARE_OF_WOLF_FELT,
                                }
                            )
                        then
                            return quest:progressEvent(521)
                        elseif
                            questProgress == 3 and
                            npcUtil.tradeHasExactly(trade, { { xi.item.IMPERIAL_MYTHRIL_PIECE, 4 } })
                        then
                            return quest:progressEvent(524)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    if
                        npc:getID() == bastokMinesID.npc.LELEROON_BLUE_DOOR and
                        quest:getVar(player, 'Option') == 2
                    then
                        local questProgress = quest:getVar(player, 'Prog')

                        if player:hasKeyItem(xi.ki.LELEROONS_LETTER_BLUE) then
                            return quest:progressEvent(519)
                        elseif questProgress == 2 then
                            return quest:progressEvent(520)
                        elseif questProgress == 3 then
                            return quest:progressEvent(535)
                        elseif questProgress == 4 then
                            if quest:getVar(player, 'Timer') <= VanadielUniqueDay() then
                                return quest:progressEvent(522)
                            else
                                return quest:progressEvent(523)
                            end
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [519] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:delKeyItem(xi.ki.LELEROONS_LETTER_BLUE)
                end,

                [521] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 3)
                end,

                [522] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.CORSAIRS_BOTTES) then
                        finishCommission(player)
                    end
                end,

                [524] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 4)
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                end,
            },
        },
    },

    {
        check = function(player, questVars, vars)
            return canStartCommission(player)
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Raqtibahl'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'Option') == 3 then
                        local questProgress = quest:getVar(player, 'Prog')

                        if
                            questProgress == 2 and
                            npcUtil.tradeHasExactly(
                                trade,
                                {
                                    xi.item.GOLD_CHAIN,
                                    xi.item.SQUARE_OF_VELVET_CLOTH,
                                    xi.item.SQUARE_OF_RED_GRASS_CLOTH,
                                    xi.item.SQUARE_OF_SAILCLOTH,
                                }
                            )
                        then
                            return quest:progressEvent(755)
                        elseif
                            questProgress == 3 and
                            npcUtil.tradeHasExactly(trade, xi.item.IMPERIAL_GOLD_PIECE)
                        then
                            return quest:progressEvent(760)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if quest:getVar(player, 'Option') == 3 then
                        if player:hasKeyItem(xi.ki.LELEROONS_LETTER_RED) then
                            return quest:progressEvent(753)
                        elseif questProgress == 2 then
                            return quest:progressEvent(754)
                        elseif questProgress == 3 then
                            return quest:progressEvent(761)
                        elseif questProgress == 4 then
                            if quest:getVar(player, 'Timer') <= VanadielUniqueDay() then
                                return quest:progressEvent(756)
                            else
                                return quest:progressEvent(757)
                            end
                        end
                    elseif hasCompletedRedCommission(player) then
                        return quest:progressEvent(758)
                    end
                end,
            },

            onEventFinish =
            {
                [753] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:delKeyItem(xi.ki.LELEROONS_LETTER_RED)
                end,

                [755] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 3)
                end,

                [756] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.CORSAIRS_FRAC) then
                        finishCommission(player)
                    end
                end,

                [760] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 4)
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                end,
            },
        },
    },
}

return quest
