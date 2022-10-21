-----------------------------------
-- Blue Ribbon Blues
-----------------------------------
-- !addquest 2 17
-- Kerutoto   : !pos 13 -5 -157 238
-- Roberta    : !pos 21 -4 -157 241
-- Hume Bones : !pos 299 0.1 19 195
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/status')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------
local eldiemeID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLUE_RIBBON_BLUES)

quest.reward =
{
    fame  = 140,
    fameArea = xi.quest.fame_area.WINDURST,
    title = xi.title.GHOSTIE_BUSTER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WATER_WAY_TO_GO) and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 5 and
                not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kerutoto'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.PURPLE_RIBBON) then
                        return quest:progressEvent(358, 3600)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(357):oncePerZone()
                end,
            },

            onEventFinish =
            {
                [357] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [358] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:addGil(3600)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 0)
                    quest:setVar(player, 'Timer', os.time() + 60)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Roberta'] =
            {
                onTrigger = function(player, npc)
                    if not player:findItem(xi.items.PURPLE_RIBBON) then
                        local questProgress = quest:getVar(player, 'Prog')

                        if questProgress == 1 then
                            return quest:progressEvent(376, 0, xi.items.PURPLE_RIBBON)
                        else
                            return quest:progressEvent(377, 0, xi.items.PURPLE_RIBBON)
                        end
                    else
                        return quest:progressEvent(379)
                    end
                end,
            },

            onEventFinish =
            {
                [376] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveItem(player, xi.items.PURPLE_RIBBON)
                    end
                end,

                [377] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveItem(player, xi.items.PURPLE_RIBBON)
                    end
                end,
            },
        },
    },

    -- Player has accepted the quest following Kerutoto trade event.  Due to the amount of interaction prior
    -- to accepting, the Prog variable is reset to 0 when transitioning to this block.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.THE_ELDIEME_NECROPOLIS] =
        {
            ['Hume_Bones'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.PURPLE_RIBBON) and
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.popFromQM(player, npc, eldiemeID.mob.LICH_C_MAGNUS, { hide = 0 })
                    then
                        player:confirmTrade()
                        return quest:messageSpecial(eldiemeID.text.RETURN_RIBBON_TO_HER)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getLocalVar(player, 'Prog') == 2 then
                        -- For onTrigger, there must be a quest function returned to avoid hitting the
                        -- default action.  Handle the item obtained messageSpecials here.

                        if npcUtil.giveItem(player, xi.items.BLUE_RIBBON, { silent = true }) then
                            quest:setVar(player, 'Prog', 3)
                            return quest:messageSpecial(eldiemeID.text.ITEM_OBTAINED, xi.items.BLUE_RIBBON)
                        else
                            return quest:messageSpecial(eldiemeID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.BLUE_RIBBON)
                        end
                    end
                end,
            },

            ['Lich_C_Magnus'] =
            {
                onMobDeath = function(mob, player, optParams)
                    -- player:addTitle(xi.title.LICH_BANISHER)

                    if quest:getVar(player, 'Prog') == 1 then
                        quest:setLocalVar(player, 'Prog', 2)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kerutoto'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.PURPLE_RIBBON) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(365)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        if os.time() < quest:getVar(player, 'Timer') then
                            return quest:progressEvent(359)
                        else
                            return quest:progressEvent(360)
                        end
                    elseif questProgress == 1 then
                        if not player:findItem(xi.items.PURPLE_RIBBON) then
                            return quest:progressEvent(366, 0, xi.items.PURPLE_RIBBON)
                        else
                            return quest:progressEvent(361, 0, xi.items.PURPLE_RIBBON)
                        end
                    elseif questProgress == 3 then
                        return quest:progressEvent(362)
                    end
                end,
            },

            onEventFinish =
            {
                [360] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.PURPLE_RIBBON) then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [365] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 0)
                    quest:setVar(player, 'Timer', os.time() + 60)
                end,

                [362] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setMustZone(player)
                    end
                end
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Roberta'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') < 3 and
                        not player:findItem(xi.items.PURPLE_RIBBON)
                    then
                        return quest:progressEvent(377, 0, xi.items.PURPLE_RIBBON)
                    else
                        return quest:progressEvent(380)
                    end
                end,
            },

            onEventFinish =
            {
                [377] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveItem(player, xi.items.PURPLE_RIBBON)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kerutoto'] = quest:event(363):replaceDefault(),
        },
    },
}

return quest
