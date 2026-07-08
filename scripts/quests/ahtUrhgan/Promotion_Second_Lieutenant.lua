-----------------------------------
-- Promotion Second Lieutenant
-- Abquhbah: !pos 35.5 -6.6 -58 50
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_SECOND_LIEUTENANT)

quest.reward =
{
    keyItem = xi.ki.SL_WILDCAT_BADGE,
    title   = xi.title.SECOND_LIEUTENANT,
}

quest.sections =
{
    -- Trigger to start quest
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getCharVar('AssaultPromotion') >= 25 and
            player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_CHIEF_SERGEANT) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] = quest:progressEvent(5071),

            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    return quest:progressEvent(5071)
                end,
            },

            onEventFinish =
            {
                [5071] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },
    -- Trigger to give reminder, trade coins to give academy tuition
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.IMPERIAL_GOLD_PIECE, 3 } }) then
                        return quest:progressEvent(5073)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:progressEvent(5072):oncePerZone()
                end,
            },

            onEventFinish =
            {
                [5073] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 1)
                    npcUtil.giveKeyItem(player, xi.ki.OFFICER_ACADEMY_MANUAL)
                end,
            },
        },
    },
    -- Begin 1st game, Trigger for reminder, trade coins to start
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 1
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.IMPERIAL_MYTHRIL_PIECE, 2 } }) then
                        return quest:progressEvent(5075)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getLocalVar(player, 'Prog') == 0 then
                        return quest:progressEvent(5074)
                    end
                end,
            },

            onEventFinish =
            {
                [5074] = function(player, csid, option, npc)
                    quest:setLocalVar(player, 'Prog', 1)
                end,

                [5075] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setLocalVar(player, 'Prog', 0)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        },
    },
    -- starts 2nd game: trigger for reminder, trade coins to progress
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 2
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.IMPERIAL_MYTHRIL_PIECE, 2 } }) then
                        return quest:progressEvent(5076)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getLocalVar(player, 'Prog') == 0 then
                        return quest:progressEvent(5074)
                    end
                end,
            },

            onEventFinish =
            {
                [5074] = function(player, csid, option, npc)
                    quest:setLocalVar(player, 'Prog', 1)
                end,

                [5076] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },
    -- completes 2nd game: trigger for reminder, trade item to progress
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 3
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] =
            {
                onTrade = function(player, npc, trade)
                    local beastmenItems =
                    {
                        xi.item.MACUAHUITL_M1, xi.item.MAMOOL_JA_COLLAR, xi.item.MAMOOL_JA_HELM,
                        xi.item.JADAGNA_M1, xi.item.JANUWIYAH_M1, xi.item.TARIQAH_M1,
                        xi.item.TROLL_PAULDRON, xi.item.TROLL_VAMBRACE, xi.item.LAMIAN_ARMLET,
                        xi.item.LAMIAN_KAMAN_M1, xi.item.QUTRUB_GORGET
                    }

                    for _, requiredTrade in pairs(beastmenItems) do
                        if npcUtil.tradeHasExactly(trade, { requiredTrade }) then
                            return quest:progressEvent(5077)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:progressEvent(5079):oncePerZone()
                end,
            },

            onEventFinish =
            {
                [5077] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setLocalVar(player, 'Prog', 0)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },
    -- 3rd game: trigger for reminder, trade coins to play
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 4
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.IMPERIAL_MYTHRIL_PIECE, 2 } }) then
                        return quest:progressEvent(5078)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getLocalVar(player, 'Prog') == 0 then
                        return quest:progressEvent(5074)
                    end
                end,
            },

            onEventFinish =
            {
                [5074] = function(player, csid, option, npc)
                    quest:setLocalVar(player, 'Prog', 1)
                end,

                [5078] = function(player, csid, option, npc)
                    quest:setLocalVar(player, 'Prog', 0)
                    player:confirmTrade()
                    if option == 1 then
                        if quest:complete(player) then
                            player:setCharVar('AssaultPromotion', 0)
                            player:delKeyItem(xi.ki.CS_WILDCAT_BADGE)
                            quest:messageSpecial(ID.text.SECOND_LIEUTENANT)
                        end
                    end
                end,
            },
        },
    },
}

return quest
