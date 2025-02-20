-----------------------------------
-- Promotion First Lieutenant
-----------------------------------
-- LogID: 6 QuestID: 98
-- Abquhbah: !pos 35.5 -6.6 -58 50
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_FIRST_LIEUTENANT)

quest.reward =
{
    keyItem = xi.ki.FL_WILDCAT_BADGE,
    title   = xi.title.FIRST_LIEUTENANT,
}

quest.sections =
{
    -- Trigger to start quest
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getCharVar('AssaultPromotion') >= 25 and
            player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_SECOND_LIEUTENANT) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onTriggerAreaEnter =
            {
                [12] = function(player, triggerArea)
                    return quest:progressEvent(5080, { text_table = 0 })
                end,
            },

            onEventFinish =
            {
                [5080] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },
    -- Trigger to give reminder, trade coins to give academy tuition
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 0 and
            vars.Wait == 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { { xi.item.IMPERIAL_GOLD_PIECE, 5 } }) then
                        return quest:progressEvent(5081, { text_table = 0 })
                    end
                end,

                onTrigger = quest:event(5087, { text_table = 0 }):oncePerZone(),
            },

            onEventFinish =
            {
                [5081] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Wait', VanadielUniqueDay())
                end,
            },
        },
    },
    -- Minigame Counterespionage
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 0 and
            vars.Wait > 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] =
            {
                onTrigger = function(player, npc)
                    local wait = quest:getVar(player, 'Wait')
                    local redo = quest:getVar(player, 'Stage') == 0 and 0 or 1

                    if wait < VanadielUniqueDay() then
                        return quest:progressEvent(5082, { [0] = redo, text_table = 0 })
                    else
                        return quest:event(5088, { text_table = 0 })
                    end
                end,
            },

            onEventFinish =
            {
                [5082] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 1)
                        quest:setVar(player, 'Stage', 0)
                    else
                        quest:setVar(player, 'Stage', 1)
                    end

                    quest:setVar(player, 'Wait', VanadielUniqueDay())
                end,
            },
        },
    },
    -- Minigame Cipher
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 1
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] =
            {
                onTrigger = function(player, npc)
                    local wait = quest:getVar(player, 'Wait')
                    local redo = quest:getVar(player, 'Stage') == 0 and 0 or 1

                    if wait <= VanadielUniqueDay() then
                        return quest:progressEvent(5083, { [0] = redo, text_table = 0 })
                    else
                        return quest:event(5088, { [0] = 1, text_table = 0 })
                    end
                end,
            },

            onEventFinish =
            {
                [5083] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 2)
                        quest:setVar(player, 'Stage', 0)
                    else
                        quest:setVar(player, 'Stage', 1)
                    end

                    quest:setVar(player, 'Wait', VanadielUniqueDay())
                end,
            },
        },
    },
    -- Minigame rock, paper, scissors
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 2
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] =
            {
                onTrigger = function(player, npc)
                    local wait = quest:getVar(player, 'Wait')
                    local redo = quest:getVar(player, 'Stage') == 0 and 0 or 1

                    if wait <= VanadielUniqueDay() then
                        return quest:progressEvent(5084, { [0] = redo, text_table = 0 })
                    else
                        return quest:event(5088, { text_table = 0 })
                    end
                end,
            },

            onEventFinish =
            {
                [5084] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 3)
                        quest:setVar(player, 'Stage', 0)
                    else
                        quest:setVar(player, 'Stage', 1)
                    end

                    quest:setVar(player, 'Wait', VanadielUniqueDay())
                end,
            },
        },
    },
    -- Graduation setup
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 3
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] =
            {
                onTrigger = function(player, npc)
                    local wait = quest:getVar(player, 'Wait') < VanadielUniqueDay() and 1 or 0

                    return quest:event(5089, { [0] = wait, text_table = 0 }):importantOnce()
                end,
            },

            onEventFinish =
            {
                [5089] = function(player, csid, option, npc)
                    local gameHour = VanadielHour()
                    if gameHour >= 15 and gameHour < 17 then
                        quest:setVar(player, 'Prog', 4)
                        player:needToZone(true)
                    end
                end,
            },
        },
    },
    -- Graduation setup after zone
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 4
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] =
            {
                onTrigger = function(player, npc)
                    local gameHour = VanadielHour()

                    if gameHour >= 15 and gameHour < 17 and not player:needToZone() then
                        return quest:progressEvent(5085, { text_table = 0 })
                    else
                        return quest:event(5089, { [0] = 1, text_table = 0 })
                    end
                end,
            },

            onEventFinish =
            {
                [5085] = function(player, csid, option, npc)
                    quest:complete(player)
                    player:delKeyItem(xi.ki.SL_WILDCAT_BADGE)
                    quest:messageSpecial(ID.text.FIRST_LIEUTENANT)
                    player:setCharVar('AssaultPromotion', 0)
                end,
            },
        },
    },
}
return quest
