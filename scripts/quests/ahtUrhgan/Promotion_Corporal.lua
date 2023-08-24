-----------------------------------
-- Promotion: Corporal
-- Log ID: 6, Quest ID: 93
-- Naja Salaheem !pos 26 -8 -45.5 50
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/quest')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_CORPORAL)
-----------------------------------
local ahtUrhganID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
local bhaflauID = require("scripts/zones/Bhaflau_Thickets/IDs")
local mireID = require("scripts/zones/Caedarva_Mire/IDs")
local mountzID = require("scripts/zones/Mount_Zhayolm/IDs")
local waojoamID = require("scripts/zones/Wajaom_Woodlands/IDs")

quest.reward =
{
    keyItem = xi.ki.C_WILDCAT_BADGE,
    title   = xi.title.CORPORAL,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getCharVar("AssaultPromotion") >= 25 and
            player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_LANCE_CORPORAL) == QUEST_COMPLETED
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
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(5047):importantOnce()
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(5046, { text_table = 0 })
                    end
                end,
            },

            onEventFinish =
            {
                [5046] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setCharVar("AssaultPromotion", 0)
                        player:delKeyItem(xi.ki.LC_WILDCAT_BADGE)
                        player:messageSpecial(ahtUrhganID.text.C_PROMOTION)
                    end
                end,
            },
        },

        [xi.zone.BHAFLAU_THICKETS] =
        {
            ['Warhorse_Hoofprint'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.QUARTZ_TRANSMITTER) then
                        player:delKeyItem(xi.ki.QUARTZ_TRANSMITTER)
                        quest:setVar(player, 'Prog', 1)
                        return quest:messageSpecial(bhaflauID.text.PLACE_QUARTZ, xi.ki.QUARTZ_TRANSMITTER):replaceDefault()
                    end
                end,
            }
        },
        [xi.zone.CAEDARVA_MIRE] =
        {
            ['Warhorse_Hoofprint'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.item.QUARTZ_TRANSMITTER) then
                        player:delKeyItem(xi.ki.QUARTZ_TRANSMITTER)
                        quest:setVar(player, 'Prog', 1)
                        return player:messageSpecial(mireID.text.PLACE_QUARTZ, xi.ki.QUARTZ_TRANSMITTER):replaceDefault()
                    end
                end,
            }        },
        [xi.zone.MOUNT_ZHAYOLM] =
        {
            ['Warhorse_Hoofprint'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.item.QUARTZ_TRANSMITTER) then
                        player:delKeyItem(xi.ki.QUARTZ_TRANSMITTER)
                        quest:setVar(player, 'Prog', 1)
                        return player:messageSpecial(mountzID.text.PLACE_QUARTZ, xi.ki.QUARTZ_TRANSMITTER):replaceDefault()
                    end
                end,
            }        },
        [xi.zone.WAJAOM_WOODLANDS] =
        {
            ['Warhorse_Hoofprint'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.item.QUARTZ_TRANSMITTER) then
                        player:delKeyItem(xi.ki.QUARTZ_TRANSMITTER)
                        quest:setVar(player, 'Prog', 1)
                        return player:messageSpecial(waojoamID.text.PLACE_QUARTZ, xi.ki.QUARTZ_TRANSMITTER):replaceDefault()
                    end
                end,
            }
        },
    },
}

return quest
