-----------------------------------
-- Promotion: Sergeant
-- Log ID: 6, Quest ID: 94
-- Naja Salaheem      : !pos 26 -8 -45.5 50
-- Region 10 Whitegate: !pos -80 0 0 50
-- Region 1 Nashmau   : !pos 0 0 -40 53
-- Totoroon           : !pos -13 0 -24 53
-- qm11               : !pos 195 2 -616 79
-----------------------------------
local whitegateID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_SERGEANT)

quest.reward =
{
    keyItem = xi.ki.S_WILDCAT_BADGE,
    title   = xi.title.SERGEANT,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and player:getCharVar('AssaultPromotion') >= 25 and
            player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_CORPORAL) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5055),

            onEventFinish =
            {
                [5055] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5058):oncePerZone(),

            onTriggerAreaEnter =
            {
                [10] = function(player, triggerArea)
                    return quest:progressEvent(5056)
                end,
            },

            onEventFinish =
            {
                [5056] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5058):oncePerZone(),
        },

        [xi.zone.NASHMAU] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if VanadielUniqueDay() > quest:getVar(player, 'Stage') then
                        return quest:progressEvent(303)
                    end
                end,
            },

            onEventFinish =
            {
                [303] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:setVar(player, 'Prog', 2)
                    else
                        quest:setVar(player, 'Stage', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5058):oncePerZone(),
        },

        [xi.zone.NASHMAU] =
        {
            ['Totoroon'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.BOWL_OF_SUTLAC) then
                        return quest:progressEvent(304)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(252)
                end,
            },

            onEventFinish =
            {
                [304] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 3
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5058):oncePerZone(),
        },

        [xi.zone.CAEDARVA_MIRE] =
        {
            ['qm11'] = quest:progressEvent(20),

            onEventFinish =
            {
                [20] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 4
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5057),

            onEventFinish =
            {
                [5057] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setCharVar('AssaultPromotion', 0)
                        player:messageSpecial(whitegateID.text.PROMOTION_SERGEANT)
                        player:delKeyItem(xi.ki.C_WILDCAT_BADGE)
                    end
                end,
            },
        },
    },
}

return quest
