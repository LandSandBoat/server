-----------------------------------
-- Area: Other Areas
--  Quest: Records of Eminence
-----------------------------------
--   Log ID: 4, Quest ID: 110
--   Isakoth        - Bastok Markets        !pos -343.396 -10.002 -171.542
--   Rolandienne    - Southern San d'Oria   !pos -85.278 1 -50.708
--   Fhelm Jobeizat - Windurst Woods        !pos 89.049 -4.108 -46.195
--   Eternal Flame  - Western Adoulin       !pos 13.103 -0.148 -119.403
-----------------------------------
local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.RECORDS_OF_EMINENCE)

local function tutorialStartedVariant(player)
    return player:getVar('HQuest[Tutorial]Prog') > 0 and 0 or 1
end

quest.sections =
{
    -- Available -> "First Step Forward" (Record 1) either still active, or not yet assigned.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Isakoth'] =
            {
                onTrigger = function(player, npc)
                    if player:getEminenceProgress(1) then
                        return quest:progressEvent(24, tutorialStartedVariant(player))
                    else
                        return quest:event(25)
                    end
                end,
            },

            onEventFinish =
            {
                [24] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        xi.roe.onRecordTrigger(player, 1)
                        quest:complete(player)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Rolandienne'] =
            {
                onTrigger = function(player, npc)
                    if player:getEminenceProgress(1) then
                        return quest:progressEvent(993, tutorialStartedVariant(player))
                    else
                        return quest:event(994)
                    end
                end,
            },

            onEventFinish =
            {
                [993] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        xi.roe.onRecordTrigger(player, 1)
                        quest:complete(player)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Fhelm_Jobeizat'] =
            {
                onTrigger = function(player, npc)
                    if player:getEminenceProgress(1) then
                        return quest:progressEvent(848, tutorialStartedVariant(player), player:getGil())
                    else
                        return quest:event(849)
                    end
                end,
            },

            onEventFinish =
            {
                [848] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        xi.roe.onRecordTrigger(player, 1)
                        quest:complete(player)
                    end
                end,
            },
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Eternal_Flame'] =
            {
                onTrigger = function(player, npc)
                    if player:getEminenceProgress(1) then
                        return quest:progressEvent(5079)
                    else
                        return quest:event(5080)
                    end
                end,
            },

            onEventFinish =
            {
                [5079] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        xi.roe.onRecordTrigger(player, 1)
                        quest:complete(player)
                    end
                end,
            },
        },
    },

    -- Completed -> indefinite Sparks of Eminence shop / trade.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Isakoth'] =
            {
                onTrade = function(player, npc, trade)
                    xi.sparkshop.onTrade(player, npc, trade, 27)
                end,

                onTrigger = function(player, npc)
                    player:triggerRoeEvent(xi.roeTrigger.TRIGGER_NPC)
                    player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.TURNING_IN_SPARKS)
                    xi.sparkshop.onTrigger(player, npc, 26)
                end,

                onEventUpdate = function(player, csid, option, npc)
                    xi.sparkshop.onEventUpdate(player, csid, option, npc)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Rolandienne'] =
            {
                onTrade = function(player, npc, trade)
                    xi.sparkshop.onTrade(player, npc, trade, 4601)
                end,

                onTrigger = function(player, npc)
                    player:triggerRoeEvent(xi.roeTrigger.TRIGGER_NPC)
                    player:messageSpecial(zones[xi.zone.SOUTHERN_SAN_DORIA].text.YOU_WISH_TO_EXCHANGE_SPARKS)
                    xi.sparkshop.onTrigger(player, npc, 995)
                end,

                onEventUpdate = function(player, csid, option, npc)
                    xi.sparkshop.onEventUpdate(player, csid, option, npc)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Fhelm_Jobeizat'] =
            {
                onTrade = function(player, npc, trade)
                    xi.sparkshop.onTrade(player, npc, trade, 860)
                end,

                onTrigger = function(player, npc)
                    player:triggerRoeEvent(xi.roeTrigger.TRIGGER_NPC)
                    player:messageSpecial(zones[xi.zone.WINDURST_WOODS].text.TRRRADE_IN_SPARKS)
                    xi.sparkshop.onTrigger(player, npc, 850)
                end,

                onEventUpdate = function(player, csid, option, npc)
                    xi.sparkshop.onEventUpdate(player, csid, option, npc)
                end,
            },
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Eternal_Flame'] =
            {
                onTrade = function(player, npc, trade)
                    xi.sparkshop.onTrade(player, npc, trade, 5086)
                end,

                onTrigger = function(player, npc)
                    player:triggerRoeEvent(xi.roeTrigger.TRIGGER_NPC)
                    player:messageSpecial(zones[xi.zone.WESTERN_ADOULIN].text.SPARK_EXCHANGE)
                    xi.sparkshop.onTrigger(player, npc, 5081)
                end,

                onEventUpdate = function(player, csid, option, npc)
                    xi.sparkshop.onEventUpdate(player, csid, option, npc)
                end,
            },
        },
    },
}

return quest
