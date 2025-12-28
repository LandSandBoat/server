-----------------------------------
-- Rock Racketeer
-----------------------------------
-- Log ID: 2, Quest ID: 26
-- Nanaa Mihgo  !pos 62 -4 240 241
-- Ardea        !pos -198.231 -6 -71.379
-- Varun        !pos 9.989 -2.5 -7.597
-- Mythril Seam !pos 210 -32 -63 143
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER)

quest.reward =
{
    fame  = 40,
    fameArea = xi.fameArea.WINDURST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.MIHGOS_AMIGO) and
                player:getFameLevel(xi.fameArea.WINDURST) >= 3 and
                not xi.quest.getMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.MIHGOS_AMIGO)
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] = quest:progressEvent(93),

            onEventFinish =
            {
                [93] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.SHARP_GRAY_STONE)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Bopa_Greso'] =
            {
                onTrigger = function(player, npc)
                    -- Once the player gets the Sharp Stone, NPC goes back to default action until after the quest is complete
                    if quest:getVar(player, 'Prog') <= 2 then
                        return quest:event(96)
                    end
                end,
            },

            ['Cha_Lebagta'] =
            {
                onTrigger = function(player, npc)
                    -- Once the player gets the Sharp Stone, NPC goes back to default action until after the quest is complete
                    if quest:getVar(player, 'Prog') <= 2 then
                        return quest:event(97)
                    end
                end,
            },

            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        if quest:getVar(player, 'Option') == 0 then
                            return quest:event(94)
                        else
                            return quest:event(95)
                        end
                    elseif progress == 1 then
                        return quest:progressEvent(98)
                    elseif progress == 2 then
                        return quest:event(99)
                    end
                end,
            },

            ['Varun'] =
            {
                -- It was found in captures that the dialogue for Varun is not required to progress the quest
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 3 then
                        if quest:getVar(player, 'Option') < 2 then
                            return quest:progressEvent(100) -- Optional Dialogue that only places once
                        else
                            return quest:event(101, 0, xi.item.SHARP_STONE)
                        end
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { { xi.item.SHARP_STONE } }) then
                        return quest:progressEvent(102, 2100)
                    end
                end,
            },

            onEventFinish =
            {
                [98] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [100] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 2)
                end,

                [102] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:addGil(2100) -- "Obtained X gil." Text is baked into the CS, so gil needs to be given outside of the quest rewards.
                        quest:setMustZone(player)
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Ardea'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:progressEvent(261)
                    elseif progress == 1 then
                        return quest:event(262)
                    else
                        return quest:event(263)
                    end
                end,
            },

            onEventFinish =
            {
                [261] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 1)
                        player:delKeyItem(xi.ki.SHARP_GRAY_STONE) -- Silent
                        npcUtil.giveCurrency(player, 'gil', 10)
                    elseif option == 1 then
                        quest:setVar(player, 'Option', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Bopa_Greso'] =
            {
                onTrigger = function(player, npc)
                    if quest:getMustZone(player) then
                        return quest:event(96)
                    end
                end,
            },

            ['Cha_Lebagta'] =
            {
                onTrigger = function(player, npc)
                    if quest:getMustZone(player) then
                        return quest:event(97)
                    end
                end,
            },

            ['Varun'] =
            {
                onTrigger = function(player, npc)
                    if quest:getMustZone(player) then
                        return quest:event(103)
                    else
                        return quest:event(104):replaceDefault()
                    end
                end,
            },
        },
    },
}

return quest
