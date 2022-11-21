-----------------------------------
-- Led Astry
-- Log: 6, Quest: 65
-- Mhasbaf:         !pos 54.701 -6.999 11.387 50
-- Whitegate Region !pos 71 0 9.299 50
-- Tohka Telposkha: !pos 22.1 0 22.759 50
-- Rubahah:         !pos -96.746 0 -14.701 50
-- Cacaroon:        !pos -72.026 0.000 -82.337 50
-- Whitegate Region !pos 12.5 -94 2 50
-- Tataroon:        !pos -25.189 0 -39.022 53
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/quest')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.LED_ASTRAY)

quest.reward =
{
    item = xi.items.IMPERIAL_SILVER_PIECE,
}

quest.sections =
{

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Mhasbaf'] = quest:progressEvent(808),

            onEventFinish =
            {
                [808] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Mhasbaf'] = quest:event(834):oncePerZone(),

            onTriggerAreaEnter =
            {
                [7] = function(player, triggerArea)
                    return quest:progressEvent(809)
                end,
            },

            onEventFinish =
            {
                [809] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Mhasbaf'] = quest:event(834):oncePerZone(),

            ['Tohka_Telposkha'] = quest:progressEvent(810),

            onEventFinish =
            {
                [810] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Mhasbaf'] = quest:event(834):oncePerZone(),

            ['Rubahah'] =
            {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Stage', 1) then
                        return quest:progressEvent(811)
                    end
                end,
            },

            ['Cacaroon'] =
            {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Stage', 2) then
                        return quest:progressEvent(812)
                    end
                end,
            },

            onEventFinish =
            {
                [811] = function(player, csid, option, npc)
                    if quest:isVarBitsSet(player, 'Stage', 2) then
                        quest:setVar(player, 'Prog', 3)
                        quest:setVar(player, 'Stage', 0)
                    else
                        quest:setVarBit(player, 'Stage', 1)
                    end
                end,

                [812] = function(player, csid, option, npc)
                    if quest:isVarBitsSet(player, 'Stage', 1) then
                        quest:setVar(player, 'Prog', 3)
                        quest:setVar(player, 'Stage', 0)
                    else
                        quest:setVarBit(player, 'Stage', 2)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 3
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Mhasbaf'] = quest:event(834),

            onTriggerAreaEnter =
            {
                [8] = function(player, triggerArea)
                    return quest:progressEvent(813)
                end,
            },

            onEventFinish =
            {
                [813] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_BERNAHN)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 4
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Mhasbaf'] = quest:event(834):oncePerZone(),
        },

        [xi.zone.NASHMAU] =
        {
            ['Tataroon'] = quest:progressEvent(305),

            onEventFinish =
            {
                [305] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.LETTER_FROM_BERNAHN)
                    end
                end,
            },
        },
    },
}

return quest
