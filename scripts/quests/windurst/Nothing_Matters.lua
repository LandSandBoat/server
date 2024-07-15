-----------------------------------
-- Nothing Matters
-----------------------------------
-- Log ID: 2, Quest ID: 79
-- Koru-Moru      : !pos -120 -6 124 239
-- Bonchacha      : !gotoid 17756196
-- Maan-Pokuun    : !gotoid 17756195
-- Yoran-Oran     : !pos -110 -14 203 239
-- Shantotto      : !pos 122 -2 112 239
-- Fuepepe        : !pos 161 -2 161 238
-- Acolyte Hostel : !gotoid 17752275
-----------------------------------
-- !addquest 2 79
-- !additem 4602
-- !additem 907
-----------------------------------
local windurstWatersID  = zones[xi.zone.WINDURST_WATERS]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.NOTHING_MATTERS)

quest.reward =
{
    title = xi.title.SEEKER_OF_TRUTH,
    gil = 10000
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.BLAST_FROM_THE_PAST) and
                not xi.quest.getMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.NOTHING_MATTERS) and
                player:getFameLevel(xi.questLog.WINDURST) >= 8
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(227):importantOnce() -- start quest non-blocking
                end,
            },

            onEventFinish =
            {
                [227] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')
                    if prog <= 1 then
                        return quest:event(228):importantOnce() -- reminder to find an alchemist
                    elseif
                        prog == 2 and
                        player:hasKeyItem(xi.ki.THESIS_ON_ALCHEMY)
                    then
                        return quest:progressEvent(237) -- turn in paper, Koru-Moru asks adventurer to find lifeforce and power of death
                    elseif prog == 3 then
                        return quest:event(238):importantOnce() -- reminder to find lifeforce and power of death
                    elseif prog == 4 then
                        if os.time() > quest:getVar(player, 'Wait') then
                            return quest:progressEvent(242) -- complete quest
                        else
                            return quest:event(241):importantOnce() -- impatient adventurer check before time gate
                        end
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHas(trade, { xi.item.WARM_EGG, xi.item.COLD_BONE }) and
                        quest:getVar(player, 'Prog') == 3
                    then
                        return quest:progressEvent(239, 0, xi.item.WARM_EGG, xi.item.COLD_BONE)
                    end
                end,
            },

            ['Bonchacha'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') <= 3 then
                        return quest:event(229):importantOnce() -- optional dialogue pre item turnin
                    end
                end
            },

            ['Maan-Pokuun'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') <= 3 then
                        return quest:event(230):importantOnce() -- optional dialogue pre item turnin
                    end
                end
            },

            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(231):importantOnce() -- optional dialogue School of Magic student hint until quest finish
                end,
            },

            ['Yoran-Oran'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(232):importantOnce() -- optional dialogue until quest finish
                end
            },

            onEventFinish =
            {
                [237] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.THESIS_ON_ALCHEMY)
                    quest:setVar(player, 'Prog', 3)
                end,

                [239] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                    player:confirmTrade()
                    quest:setVar(player, 'Wait', getMidnight())
                end,

                [242] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        xi.quest.setMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.NOTHING_MATTERS)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Fuepepe'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')
                    if prog == 0 then
                        return quest:progressEvent(545) -- tells player to find Katzun-Nattzun at the Acolyte Hostel
                    elseif prog == 1 then
                        return quest:event(546):importantOnce() -- reminds player to find Katzun-Nattzun at the Acolyte Hostel
                    end
                end
            },

            ['Moreno-Toeno'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') <= 3 then
                        return quest:event(544):importantOnce() -- optional dialogue pre item turnin
                    end
                end
            },

            ['Pechiru-Mashiru'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') <= 3 then
                        return quest:event(541):importantOnce() -- optional dialogue pre item turnin
                    end
                end
            },

            ['Door_Acolyte_Hostel'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        if npc:getID() == windurstWatersID.npc.ACOLYTE_HOSTEL_DOOR_OFFSET then
                            if not quest:isVarBitsSet(player, 'Doors', 1) then -- question set 1
                                return quest:progressEvent(804, 0, xi.ki.AIRSHIP_PASS, 500000, 0, 0, 0, 0, xi.ki.THESIS_ON_ALCHEMY) -- airship cost based on Derrick.lua for airship
                            end
                        elseif npc:getID() == windurstWatersID.npc.ACOLYTE_HOSTEL_DOOR_OFFSET + 1 then
                            if not quest:isVarBitsSet(player, 'Doors', 2) then -- question set 2
                                return quest:progressEvent(805, 0, 0, xi.item.TARUTARU_FISHING_ROD, xi.item.WILLOW_FISHING_ROD, xi.item.LU_SHANGS_FISHING_ROD, 0, 0, xi.ki.THESIS_ON_ALCHEMY)
                            end
                        elseif npc:getID() == windurstWatersID.npc.ACOLYTE_HOSTEL_DOOR_OFFSET + 2 then
                            if not quest:isVarBitsSet(player, 'Doors', 3) then -- question set 3
                                return quest:progressEvent(806, 0, 0, 0, 0, 0, 0, 0, xi.ki.THESIS_ON_ALCHEMY)
                            end
                        elseif npc:getID() == windurstWatersID.npc.ACOLYTE_HOSTEL_DOOR_OFFSET + 7 then
                            if not quest:isVarBitsSet(player, 'Doors', 4) then -- question set 4
                                return quest:progressEvent(811, 0, 0, 0, 0, 0, 0, 0, xi.ki.THESIS_ON_ALCHEMY)
                            end
                        elseif npc:getID() == windurstWatersID.npc.ACOLYTE_HOSTEL_DOOR_OFFSET + 8 then
                            if not quest:isVarBitsSet(player, 'Doors', 5) then -- question set 5
                                return quest:progressEvent(812, 0, 0, 0, 0, xi.item.CRYSTAL_BASS, 0, 0, xi.ki.THESIS_ON_ALCHEMY)
                            end
                        elseif npc:getID() == windurstWatersID.npc.ACOLYTE_HOSTEL_DOOR_OFFSET + 9 then
                            if not quest:isVarBitsSet(player, 'Doors', 6) then -- question set 6
                                return quest:progressEvent(813, 0, xi.item.BAG_OF_HERB_SEEDS, xi.item.CARNATION, xi.item.DEATHBALL, xi.item.MARGUERITE, xi.item.BISMUTH_SHEET, 0, xi.ki.THESIS_ON_ALCHEMY)
                            end
                        end
                    end
                end
            },

            ['Door_Acolyte_Hostel_F'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        quest:isVarBitsSet(player, 'Doors', 1) and
                        quest:isVarBitsSet(player, 'Doors', 2) and
                        quest:isVarBitsSet(player, 'Doors', 3) and
                        quest:isVarBitsSet(player, 'Doors', 4) and
                        quest:isVarBitsSet(player, 'Doors', 5) and
                        quest:isVarBitsSet(player, 'Doors', 6) -- check all questions have been answered
                    then
                        if quest:getVar(player, 'correctProg') >= 4 then -- check at least 4 correct answers to progress
                            if quest:getVar(player, 'correctProg') == 6 then -- if player has 6 correct they get additional reward
                                return quest:progressCutscene(814, 0, 0, 1, 0, 0, 0, 0, xi.ki.THESIS_ON_ALCHEMY) -- additional reward
                            else -- regular cs for 6 > correctProg >= 4
                                return quest:progressCutscene(814, 0, 0, 0, 0, 0, 0, 0, xi.ki.THESIS_ON_ALCHEMY)
                            end
                        else -- all questions have been answered but < 4 were correct
                            for i = 1, 6 do
                                quest:unsetVarBit(player, 'Doors', i)
                            end

                            quest:setVar(player, 'correctProg', 0)
                        end
                    end
                end
            },

            onEventFinish =
            {
                [545] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [804] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Doors', 1)
                    if option == 100 then
                        quest:setVar(player, 'correctProg', quest:getVar(player, 'correctProg') + 1)
                    end
                end,

                [805] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Doors', 2)
                    if option == 100 then
                        quest:setVar(player, 'correctProg', quest:getVar(player, 'correctProg') + 1)
                    end
                end,

                [806] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Doors', 3)
                    if option == 100 then
                        quest:setVar(player, 'correctProg', quest:getVar(player, 'correctProg') + 1)
                    end
                end,

                [811] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Doors', 4)
                    if option == 100 then
                        quest:setVar(player, 'correctProg', quest:getVar(player, 'correctProg') + 1)
                    end
                end,

                [812] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Doors', 5)
                    if option == 100 then
                        quest:setVar(player, 'correctProg', quest:getVar(player, 'correctProg') + 1)
                    end
                end,

                [813] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Doors', 6)
                    if option == 100 then
                        quest:setVar(player, 'correctProg', quest:getVar(player, 'correctProg') + 1)
                    end
                end,

                [814] = function(player, csid, option, npc)
                    if quest:getVar(player, 'correctProg') == 6 then -- if player answered 6 correctly reward with vile elixir
                        if npcUtil.giveItem(player, xi.item.VILE_ELIXIR) then
                            quest:setVar(player, 'Prog', 2)
                            npcUtil.giveKeyItem(player, xi.ki.THESIS_ON_ALCHEMY)
                        end
                    else
                        quest:setVar(player, 'Prog', 2)
                        npcUtil.giveKeyItem(player, xi.ki.THESIS_ON_ALCHEMY)
                    end
                end,
            },
        }
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                xi.quest.getMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.NOTHING_MATTERS)
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru']  = quest:event(244):importantEvent(),
        },
    },
}

return quest
