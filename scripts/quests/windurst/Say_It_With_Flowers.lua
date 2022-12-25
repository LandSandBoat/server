-----------------------------------
-- Say It With Flowers
-----------------------------------
-- Area: Windurst Waters
-- !addquest 2 50
-- Moari-Kaaori   : !pos -253 -5 -227 238
-- Kenapa-Keppa   : !pos 27 -6 -199 238
-- Ohbiru-Dohbiru : !pos 23 -5 -193 238
-- Kenapa-Keppa   : !pos 27 -6 -199 238
-- Tahrongi Cacti : !pos -308 7 264 117
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------
local windurstWatersIDs = require('scripts/zones/Windurst_Waters/IDs')
local tahrongiID = require("scripts/zones/Tahrongi_Canyon/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)

local flowerList =
{
    [0] = { itemid = xi.items.CARNATION,  gil = 300 },
    [1] = { itemid = xi.items.RED_ROSE,   gil = 200 },
    [2] = { itemid = xi.items.RAIN_LILY,  gil = 250 },
    [3] = { itemid = xi.items.LILAC,      gil = 150 },
    [4] = { itemid = xi.items.AMARYLLIS,  gil = 200 },
    [5] = { itemid = xi.items.MARGUERITE, gil = 100 },
}

quest.reward =
{
}

quest.sections =
{
    -- Quest Available
    {
        check = function(player, status, vars)
            return player:getFameLevel(xi.quest.log_id.WINDURST) >= 2 and
                (status == QUEST_AVAILABLE or
                    (
                        status == QUEST_COMPLETED and
                        vars.Prog == 0 and
                        not quest:getMustZone(player)
                    )
                )
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Moari-Kaaori'] = quest:progressEvent(514),

            onEventFinish =
            {
                [514] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, "Prog", 1)
                    end
                end,
            },
        },
    },

    -- Quest in Progress - Stage 1
    {
        check = function(player, status, vars)
            return status >= QUEST_ACCEPTED and
            vars.Prog == 1
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(516, { [4] = xi.items.TAHRONGI_CACTUS })
                end,
            },

            ['Moari-Kaaori'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(515)
                end,
            },

            onEventFinish =
            {
                [516] = function(player, csid, option, npc)
                    if option < 7 then
                        local choice = flowerList[option]
                        if choice and player:getGil() >= choice.gil then
                            if npcUtil.giveItem(player, choice.itemId) then
                                player:delGil(choice.gil)
                                quest:setMustZone(player)
                            else
                                player:messageSpecial(windurstWatersIDs.text.ITEM_CANNOT_BE_OBTAINED, choice.itemid)
                            end
                        else
                            player:messageSpecial(windurstWatersIDs.text.NOT_HAVE_ENOUGH_GIL)
                        end
                    elseif option == 7 then
                        quest:setVar(player, "Prog", 2)
                    end
                end,
            },
        },
    },

    -- Quest in Progress - Stage 2
    {
        check = function(player, status, vars)
            return status >= QUEST_ACCEPTED and
            vars.Prog == 2
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(517, { [4] = xi.items.TAHRONGI_CACTUS })
                end,
            },

            ['Moari-Kaaori'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(515)
                end,
            },

            ['Kenapa-Keppa'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(519)
                end,
            },

            onEventFinish =
            {
                [519] = function(player, csid, option, npc)
                    quest:setVar(player, "Prog", 3)
                end,
            }
        },
    },

    -- Quest in Progress - Stage 3
    {
        check = function(player, status, vars)
            return status >= QUEST_ACCEPTED and
            vars.Prog >= 3
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Moari-Kaaori'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(515)
                end,

                onTrade = function(player, npc, trade)
                    local flowers =
                    {
                        xi.items.CARNATION,
                        xi.items.RED_ROSE,
                        xi.items.RAIN_LILY,
                        xi.items.LILAC,
                        xi.items.AMARYLLIS,
                        xi.items.MARGUERITE,
                    }
                    if npcUtil.tradeHasExactly(trade, { xi.items.TAHRONGI_CACTUS }) then
                        if player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS) then
                            return quest:progressEvent(525, 400)
                        else
                            return quest:progressEvent(520)
                        end
                    elseif
                        trade:getItemCount() == 1 and
                        npcUtil.tradeSetInList(trade, flowers)
                    then
                        player:startEvent(522) -- Brought wrong flowers.
                    end
                end,
            },

            ['Kenapa-Keppa'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(519)
                end,
            },

            onEventFinish =
            {
                [519] = function(player, csid, option, npc)
                    quest:setVar(player, "CactusAvailable", 1)
                end,

                [520] = function(player, csid, option, npc) -- Right flower, full reward
                    if npcUtil.giveItem(player, xi.items.IRON_SWORD) then
                        player:tradeComplete()
                        quest.reward =
                        {
                            fame     = 30,
                            fameArea = xi.quest.fame_area.WINDURST,
                            title    = xi.title.CUPIDS_FLORIST,
                            gil      = 400,
                        }
                        quest:complete(player)
                        quest:setMustZone(player)
                    end
                end,

                [522] = function(player, csid, option, npc) -- Wrong flower, smaller reward
                    player:tradeComplete()
                    quest.reward =
                    {
                        fame     = 10,
                        fameArea = xi.quest.fame_area.WINDURST,
                        gil      = 100,
                    }
                    quest:complete(player)
                    quest:setMustZone(player)
                end,

                [525] = function(player, csid, option, npc) -- Repeatable rewards
                    player:tradeComplete()
                    quest.reward =
                    {
                        fame     = 30,
                        fameArea = xi.quest.fame_area.WINDURST,
                        title    = xi.title.CUPIDS_FLORIST,
                        gil      = 400,
                    }
                    quest:complete(player)
                    quest:setMustZone(player)
                end,
            },
        },
    },

    -- Quest in Progress - Able to Collect Cactus
    {
        check = function(player, status, vars)
            return status >= QUEST_ACCEPTED and
            vars.CactusAvailable
        end,

        [xi.zone.TAHRONGI_CANYON] =
        {
            ['Tahrongi_Cacti'] =
            {
                onTrigger = function(player, npc)
                    if npcUtil.giveItem(player, xi.items.TAHRONGI_CACTUS, { silent = true }) then
                        player:messageSpecial(tahrongiID.text.BUD_BREAKS_OFF, 0, 950)
                        quest:setVar(player, "CactusAvailable", 0)
                    else
                        player:messageSpecial(tahrongiID.text.CANT_TAKE_ANY_MORE)
                    end
                end,
            },
        },
    },
}

return quest
