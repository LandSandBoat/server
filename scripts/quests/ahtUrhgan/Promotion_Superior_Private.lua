-----------------------------------
-- Promotion: Superior Private
-- Log ID: 6, Quest ID: 91
-- Naja Salaheem !pos 26 -8 -45.5 50
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_SUPERIOR_PRIVATE)

quest.reward =
{
    keyItem = xi.ki.SP_WILDCAT_BADGE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getCharVar('AssaultPromotion') >= 25
            and player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_PRIVATE_FIRST_CLASS) == QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5020, { text_table = 0 }),

            onEventFinish =
            {
                [5020] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and not player:hasKeyItem(xi.ki.DARK_RIDER_HOOFPRINT)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:event(5021, { text_table = 0 }),
        },

        [xi.zone.BHAFLAU_THICKETS] =
        {
            ['Warhorse_Hoofprint'] = quest:keyItem(xi.ki.DARK_RIDER_HOOFPRINT)
        },
        [xi.zone.CAEDARVA_MIRE] =
        {
            ['Warhorse_Hoofprint'] = quest:keyItem(xi.ki.DARK_RIDER_HOOFPRINT)
        },
        [xi.zone.MOUNT_ZHAYOLM] =
        {
            ['Warhorse_Hoofprint'] = quest:keyItem(xi.ki.DARK_RIDER_HOOFPRINT)
        },
        [xi.zone.WAJAOM_WOODLANDS] =
        {
            ['Warhorse_Hoofprint'] = quest:keyItem(xi.ki.DARK_RIDER_HOOFPRINT)
        },

    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.DARK_RIDER_HOOFPRINT)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5022, { text_table = 0 }),

            onEventFinish =
            {
                [5022] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setCharVar('AssaultPromotion', 0)
                        player:delKeyItem(xi.ki.PFC_WILDCAT_BADGE)
                        player:delKeyItem(xi.ki.DARK_RIDER_HOOFPRINT)
                    end
                end,
            },
        },
    },
}

return quest
