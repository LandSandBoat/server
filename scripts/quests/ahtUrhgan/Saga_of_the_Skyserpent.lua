-----------------------------------
-- Saga of the Skyserpent
-- Log: 6, Quest: 43
-- Fari-Wari: !pos 80 -6 -137 50
-- qm7:       !pos -11 8 -185 62
-- Biyaada:   !pos -65.802 -6.999 69.273 48
-----------------------------------
require('scripts/globals/common')
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.SAGA_OF_THE_SKYSERPENT)

quest.reward =
{
    item = xi.items.IMPERIAL_GOLD_PIECE,
    title = xi.title.SKYSERPENT_AGGRANDIZER
}

quest.sections =
{

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Fari-Wari'] = quest:progressEvent(823, { text_table = 0 }),

            onEventFinish =
            {
                [823] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.AL_ZAHBI] =
        {
            ['Biyaada'] = quest:event(278),
        },

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Fari-Wari'] = quest:event(829),
        },

        [xi.zone.HALVUNG] =
        {
            ['qm7'] =
            {
                onTrigger = function(player, npc)
                    quest:setVar(player, 'Prog', 1)
                    return quest:keyItem(xi.ki.LILAC_RIBBON)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.AL_ZAHBI] =
        {
            ['Biyaada'] = quest:event(278),
        },

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Fari-Wari'] = quest:progressEvent(953, { text_table = 0 }),

            onEventFinish =
            {
                [953] = function(player, csid, option, npc)
                    player:setPos(0, 0, 0, 0, xi.zone.WAJAOM_WOODLANDS)
                end,
            },
        },

        [xi.zone.WAJAOM_WOODLANDS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 1 then
                        return 12
                    end
                end
            },

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    player:startEvent(13)
                end,

                [13] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    quest:setVar(player, 'Stage', VanadielUniqueDay())
                    player:delKeyItem(xi.keyItem.LILAC_RIBBON)
                    player:setPos(80, -6, -123, 65, xi.zone.AHT_URHGAN_WHITEGATE)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.AL_ZAHBI] =
        {
            ['Biyaada'] = quest:event(279),
        },

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Fari-Wari'] = quest:progressEvent(825, { text_table = 0 }),
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Stage') < VanadielUniqueDay() then
                        return quest:progressEvent(825, { text_table = 0 })
                    else
                        return quest:event(833)
                    end
                end,
            },

            onEventFinish =
            {
                [825] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addCurrency("imperial_standing", 1000)
                        player:messageSpecial(zones[player:getZoneID()].text.BESIEGED_OFFSET)
                    end
                end,
            },
        },
    },
}

return quest
