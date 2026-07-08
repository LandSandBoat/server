-----------------------------------
-- Promotion: Corporal
-- Naja Salaheem !pos 26 -8 -45.5 50
-- LogID: 6 QuestID: 93
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_CORPORAL)

quest.reward =
{
    keyItem = xi.ki.C_WILDCAT_BADGE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getCharVar('AssaultPromotion') >= 25 and
            player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_LANCE_CORPORAL) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5045, { text_table = 0 }),

            onEventFinish =
            {
                [5045] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.QUARTZ_TRANSMITTER)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            player:hasKeyItem(xi.ki.QUARTZ_TRANSMITTER)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5047, { text_table = 0 }):oncePerZone(),
        },

        [xi.zone.BHAFLAU_THICKETS] =
        {
            ['Warhorse_Hoofprint'] =
            {
                onTrigger = function(player, npc)
                    player:delKeyItem(xi.ki.QUARTZ_TRANSMITTER)
                    quest:setVar(player, 'Prog', 2)
                    return quest:messageSpecial(zones[player:getZoneID()].text.WARHORSE_HOOFPRINT + 1, xi.ki.QUARTZ_TRANSMITTER)
                end,
            },
        },
        [xi.zone.CAEDARVA_MIRE] =
        {
            ['Warhorse_Hoofprint'] =
            {
                onTrigger = function(player, npc)
                    player:delKeyItem(xi.ki.QUARTZ_TRANSMITTER)
                    quest:setVar(player, 'Prog', 4)
                    return quest:messageSpecial(zones[player:getZoneID()].text.WARHORSE_HOOFPRINT + 1, xi.ki.QUARTZ_TRANSMITTER)
                end,
            },
        },
        [xi.zone.MOUNT_ZHAYOLM] =
        {
            ['Warhorse_Hoofprint'] =
            {
                onTrigger = function(player, npc)
                    player:delKeyItem(xi.ki.QUARTZ_TRANSMITTER)
                    quest:setVar(player, 'Prog', 3)
                    return quest:messageSpecial(zones[player:getZoneID()].text.WARHORSE_HOOFPRINT + 1, xi.ki.QUARTZ_TRANSMITTER)
                end,
            },
        },
        [xi.zone.WAJAOM_WOODLANDS] =
        {
            ['Warhorse_Hoofprint'] =
            {
                onTrigger = function(player, npc)
                    player:delKeyItem(xi.ki.QUARTZ_TRANSMITTER)
                    quest:setVar(player, 'Prog', 1)
                    return quest:messageSpecial(zones[player:getZoneID()].text.WARHORSE_HOOFPRINT + 1, xi.ki.QUARTZ_TRANSMITTER)
                end,
            },
        },

    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            not player:hasKeyItem(xi.ki.QUARTZ_TRANSMITTER)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    local hoofprintZone = quest:getVar(player, 'Prog')
                    return quest:progressEvent(5046, { [0] = hoofprintZone, text_table = 0 })
                end,
            },

            onEventFinish =
            {
                [5046] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setVar('AssaultPromotion', 0)
                        player:delKeyItem(xi.ki.LC_WILDCAT_BADGE)
                    end
                end,
            },
        },
    },
}

return quest
