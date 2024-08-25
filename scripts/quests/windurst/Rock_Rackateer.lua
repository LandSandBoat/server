-----------------------------------
-- Rock Racketeer
-----------------------------------
-- Log ID: 2, Quest ID: 26
-- Nanaa Mihgo  : !pos 62 -4 240 241
-- Ardea        : !pos -198 -6 -69 235
-- Varun        : !pos 8 -4 -10 241
-- Mythril Seam : !pos -68 -7 173 143
-----------------------------------
local bastokID  = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER)

quest.reward =
{
    fame = 40,
    fameArea = xi.fameArea.WINDURST,
    -- NOTE: 2100 gil is given out automatically at the end
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 3 and
                player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.MIHGO_S_AMIGO) and
                player:getCurrentMission(xi.mission.log_id.WINDURST) ~= xi.mission.id.windurst.LOST_FOR_WORDS and
                not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] = quest:progressEvent(93),

            onEventFinish =
            {
                [93] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        npcUtil.giveKeyItem(player, xi.ki.SHARP_GRAY_STONE)
                    then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Talk to Ardea in Bastok Markets
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                player:hasKeyItem(xi.ki.SHARP_GRAY_STONE)
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Ardea'] = quest:progressEvent(261),

            onEventFinish =
            {
                [261] = function(player, csid, option, npc)
                    if
                        option ~= 1 and
                        npcUtil.giveCurrency(player, 'gil', 10)
                    then
                        player:delKeyItem(xi.ki.SHARP_GRAY_STONE)
                        player:messageSpecial(bastokID.text.KEYITEM_OBTAINED + 1, xi.ki.SHARP_GRAY_STONE)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] = quest:progressEvent(95),
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                not player:hasKeyItem(xi.ki.SHARP_GRAY_STONE)
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Bopa_Greso'] = {
                onTrigger = function(player, npc)
                    return quest:getVar(player, 'Prog') == 1 and quest:progressEvent(96) or nil
                end,
            },

            ['Cha_Lebagta'] = {
                onTrigger = function(player, npc)
                    return quest:getVar(player, 'Prog') == 1 and quest:progressEvent(97) or nil
                end,
            },

            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(98)
                end
            },

            ['Varun'] = {
                onTrigger = function(player, npc)
                    return quest:getVar(player, 'Prog') == 1 and quest:progressEvent(100) or nil
                end,
            },

            onEventFinish =
            {
                [98] = function(player, csid, option, npc)
                    return quest:setVar(player, 'Prog', 1)
                end,

                [100] = function(player, csid, option, npc)
                    return quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Go to the east half of Palborough Mines and mine up the sharp stone
    -- Trade the sharp stone to complete the quest
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                quest:getVar(player, 'Prog') == 2
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Varun'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(101, { [1] = xi.item.SHARP_STONE })
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.SHARP_STONE) then
                        return quest:progressEvent(102, { [0] = xi.settings.main.GIL_RATE * 2100 })
                    end
                end,
            },

            onEventFinish =
            {
                [102] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:addGil(xi.settings.main.GIL_RATE * 2100) -- Silently, since the quest event will give the message automatically.
                    end
                end,
            },
        },

        [xi.zone.PALBOROUGH_MINES] =
        {
            ['Mythril_Seam'] =
            {
                onTrade = function(player, npc, trade)
                    local lastTrade = player:getCharVar('[HELM]Last_Trade')
                    if os.time() > lastTrade + 4 then
                        if
                            npcUtil.tradeHasExactly(trade, xi.item.PICKAXE) and
                            not player:hasItem(xi.item.SHARP_STONE)
                        then
                            -- Do some mining (Pulling data from helm.lua)
                            player:delStatusEffect(xi.effect.INVISIBLE)

                            local isBreak = (math.random(1, 100) + (player:getMod(xi.mod.MINING_RESULT) / 10) <= xi.settings.main.MINING_BREAK_CHANCE) and 1 or 0
                            local isFull  = (player:getFreeSlotsCount() == 0) and 1 or 0
                            local getItem = (math.random(1, 100) <= xi.settings.main.MINING_RATE) and 1 or 0

                            if getItem == 1 then
                                getItem = xi.item.SHARP_STONE
                            end

                            if isBreak == 1 then
                                player:tradeComplete()
                            end

                            player:startEvent(120, getItem, isBreak, isFull) -- 120 is the csid for mining in Palborough.
                            player:sendEmote(npc, xi.emote.EXCAVATION, xi.emoteMode.MOTION, false)

                            if getItem ~= 0 and isFull == 0 then
                                player:addItem(getItem)
                            end

                            player:setCharVar('[HELM]Last_Trade', os.time() + 2)
                        end
                    else
                        player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0)
                    end
                end,
            },
        },
    },

    -- QUEST COMPLETE
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(99):replaceDefault()
                end
            },
        },
    },
}

return quest
