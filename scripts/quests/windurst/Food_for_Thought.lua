-----------------------------------
-- Food for Thought
-----------------------------------
-- !addquest 2 14
-- Kenapa-Keppa   : !pos 27 -6 -199 238
-- Kerutoto       : !pos 13 -5 -157 238
-- Ohbiru-Dohbiru : !pos 23 -5 -193 238
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FOOD_FOR_THOUGHT)

quest.reward =
{
    fame  = 100,
    fameArea = xi.quest.fame_area.WINDURST,
    title = xi.title.FAST_FOOD_DELIVERER,
}

local kenapaTradeEventFinish = function(player, csid, option, npc)
    player:confirmTrade()
    player:addGil(120)

    if
        quest:getVar(player, 'kerutotoProg') == 2 and
        quest:getVar(player, 'ohbiruProg') == 3
    then
        if quest:complete(player) then
            quest:setMustZone(player)
        end
    else
        quest:setVar(player, 'kenapaProg', 4)
    end
end

local ohbiruTradeEventFinish = function(player, csid, option, npc)
    player:confirmTrade()
    player:addGil(440)

    if
        quest:getVar(player, 'kerutotoProg') == 2 and
        quest:getVar(player, 'kenapaProg') == 4
    then
        if quest:complete(player) then
            quest:setMustZone(player)
        end
    else
        quest:setVar(player, 'ohbiruProg', 3)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kenapa-Keppa'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(310)
                end
            },

            ['Kerutoto'] =
            {
                onTrigger = function(player, npc)
                    local kerutotoProgress = quest:getVar(player, 'kerutotoProg')
                    local ohbiruProgress   = quest:getVar(player, 'ohbiruProg')

                    -- Player knows the researchers are hungry and quest not refused
                    if ohbiruProgress == 1 and kerutotoProgress ~= 256 then
                        return quest:progressEvent(313, 0, 4371)

                    -- Player knows the researchers are hungry and quest refused previously
                    elseif ohbiruProgress == 1 and kerutotoProgress == 256 then
                        return quest:progressEvent(314, 0, 4371)

                    -- Before Quest: Asks you to check on others.
                    else
                        return quest:progressEvent(312)
                    end
                end,
            },

            ['Ohbiru-Dohbiru'] =
            {
                onTrigger = function(player, npc)
                    local ohbiruProgress = quest:getVar(player, 'ohbiruProg')

                    if ohbiruProgress == 0 then
                        return quest:progressEvent(308)
                    elseif ohbiruProgress == 1 then
                        return quest:progressEvent(309)
                    end
                end,
            },

            onEventFinish =
            {
                [308] = function(player, csid, option, npc)
                    quest:setVar(player, 'ohbiruProg', 1)
                end,

                [313] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        quest:setVar(player, 'kerutotoProg', 1)
                    elseif option == 1 then
                        quest:setVar(player, 'kerutotoProg', 256)
                    end
                end,

                [314] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        quest:setVar(player, 'kerutotoProg', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kenapa-Keppa'] =
            {
                onTrade = function(player, npc, trade)
                    local kenapaProg = quest:getVar(player, 'kenapaProg')

                    if npcUtil.tradeHasExactly(trade, xi.items.HARD_BOILED_EGG) then
                        -- Traded item without receiving order
                        if kenapaProg < 3 then
                            if math.random(1, 2) == 1 then
                                return quest:progressEvent(331)
                            else
                                return quest:progressEvent(330, 120)
                            end

                        -- Traded item after receiving order
                        elseif kenapaProg == 3 then
                            return quest:progressEvent(327, 120)
                        end
                    else
                        return quest:progressEvent(329)
                    end
                end,

                onTrigger = function(player, npc)
                    local kenapaProg = quest:getVar(player, 'kenapaProg')

                    if kenapaProg == 0 then
                        return quest:progressEvent(318)
                    elseif kenapaProg == 1 then
                        return quest:progressEvent(319)
                    elseif kenapaProg == 2 then
                        return quest:progressEvent(320, 0, xi.items.HARD_BOILED_EGG)
                    elseif kenapaProg == 3 then
                        local randEvent = math.random(1, 3)

                        if randEvent == 1 then
                            return quest:progressEvent(320, 0, xi.items.HARD_BOILED_EGG) -- Repeats Order
                        elseif randEvent == 2 then
                            return quest:progressEvent(321) -- "Or Whatever"
                        else
                            return quest:progressEvent(328) -- "..<Grin>.."
                        end
                    end
                end
            },

            ['Kerutoto'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.SLICE_OF_GRILLED_HARE) and
                        quest:getVar(player, 'kerutotoProg') == 1
                    then
                        return quest:progressEvent(332, 440)
                    end
                end,

                onTrigger = function(player, npc)
                    local kerutotoProgress = quest:getVar(player, 'kerutotoProg')

                    if kerutotoProgress == 1 then
                        return quest:progressEvent(315, 0, xi.items.SLICE_OF_GRILLED_HARE)
                    elseif kerutotoProgress == 2 then
                        return quest:progressEvent(333)
                    end
                end,
            },

            ['Leepe-Hoppe'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(311)
                end,
            },

            ['Ohbiru-Dohbiru'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.items.CUP_OF_WINDURSTIAN_TEA, xi.items.TORTILLA, xi.items.CLUMP_OF_PAMTAM_KELP }) then
                        local ohbiruProgress = quest:getVar(player, 'ohbiruProg')

                        -- Traded all 3 items & Didn't ask for order
                        if ohbiruProgress < 2 then
                            if math.random(1, 2) == 1 then
                                return quest:progressEvent(325, 440)
                            else
                                return quest:progressEvent(326)
                            end

                        -- Traded all 3 items after receiving order
                        elseif ohbiruProgress == 2 then
                            return quest:progressEvent(322, 440)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    local ohbiruProgress = quest:getVar(player, 'ohbiruProg')

                    if ohbiruProgress < 2 then
                        return quest:progressEvent(316, 0, 4493, 624, 4408)
                    elseif ohbiruProgress == 2 then
                        return quest:progressEvent(317, 0, 4493, 624, 4408)
                    elseif ohbiruProgress == 3 then
                        return quest:progressEvent(324)
                    end
                end,
            },

            onEventFinish =
            {
                [316] = function(player, csid, option, npc)
                    quest:setVar(player, 'ohbiruProg', 2)
                end,

                [318] = function(player, csid, option, npc)
                    quest:setVar(player, 'kenapaProg', 1)
                end,

                [319] = function(player, csid, option, npc)
                    quest:setVar(player, 'kenapaProg', 2)
                end,

                [320] = function(player, csid, option, npc)
                    quest:setVar(player, 'kenapaProg', 3)
                end,

                [322] = ohbiruTradeEventFinish,
                [325] = ohbiruTradeEventFinish,
                [326] = ohbiruTradeEventFinish,

                [327] = kenapaTradeEventFinish,
                [330] = kenapaTradeEventFinish,
                [331] = kenapaTradeEventFinish,

                [332] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:addGil(440)

                    if
                        quest:getVar(player, 'kenapaProg') == 4 and
                        quest:getVar(player, 'ohbiruProg') == 3
                    then
                        if quest:complete(player) then
                            quest:setMustZone(player)
                        end
                    else
                        quest:setVar(player, 'kerutotoProg', 2)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kerutoto']       = quest:event(304):replaceDefault(),
            ['Ohbiru-Dohbiru'] = quest:event(344):replaceDefault(),
        },
    },
}

return quest
