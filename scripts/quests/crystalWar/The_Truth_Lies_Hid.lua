-----------------------------------
-- The Truth Lies Hid
-----------------------------------
-- !addquest 7 58
-- Gentle Tiger    : !pos -203.932 -9.998 2.237 87
-- Rikke           : !pos -90.120 0.601 86.312 155
-- Rakke           : !pos -113.722 0.601 -149.880 155
-- Rokke           : !pos -30.042 0.601 -153.925 155
-- ??? (qm)        : !pos -384.257 -51.999 -95.783 155
-- Displaced Block : !pos -264.139 -52.999 82.333 155
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TRUTH_LIES_HID)

quest.reward =
{
    item = xi.item.SANCTUS_ROSARY,
}

local impScenarios =
{
    -- Scenario A
    {
        honestImp  = 2,
        statements =
        {
            [1] = 1,
            [2] = 1,
            [3] = 1,
        },
    },

    -- Scenario B
    {
        honestImp  = 1,
        statements =
        {
            [1] = 0,
            [2] = 0,
            [3] = 0,
        },
    },

    -- Scenario C
    {
        honestImp  = 3,
        statements =
        {
            [1] = 0,
            [2] = 2,
            [3] = 0,
        },
    },
}

local impData =
{
    [1] =
    {
        dayVar     = 'Imp1Day',
        initial    = 9,
        reminder   = 19,
        trade      = 12,
        selfTrade  = 22,
        otherTrade = 25,
    },

    [2] =
    {
        dayVar     = 'Imp2Day',
        initial    = 10,
        reminder   = 20,
        trade      = 13,
        selfTrade  = 23,
        otherTrade = 26,
    },

    [3] =
    {
        dayVar     = 'Imp3Day',
        initial    = 11,
        reminder   = 21,
        trade      = 14,
        selfTrade  = 24,
        otherTrade = 27,
    },
}

local function getCurrentImpScenario()
    -- The active scenario rotates by Vana'diel day.
    return impScenarios[(VanadielUniqueDay() % #impScenarios) + 1]
end

local function setImpTradeState(player, impNumber, isCorrect)
    quest:setVar(player, 'TradeDay', VanadielUniqueDay())
    quest:setVar(player, 'TradeImp', impNumber)
    quest:setVar(player, 'TradeSuccess', isCorrect and 1 or 0)
end

local function handleImpPuzzleTrigger(player, impNumber)
    local imp = impData[impNumber]

    if quest:getVar(player, 'TradeDay') == VanadielUniqueDay() then
        local tradeSucceeded = quest:getVar(player, 'TradeSuccess')

        if quest:getVar(player, 'TradeImp') == impNumber then
            return quest:event(imp.selfTrade, 155, 0, tradeSucceeded)
        end

        return quest:event(imp.otherTrade, tradeSucceeded)
    end

    local param3 = getCurrentImpScenario().statements[impNumber]

    if quest:getVar(player, imp.dayVar) == VanadielUniqueDay() then
        return quest:event(imp.reminder, 155, 0, param3)
    end

    quest:setVar(player, imp.dayVar, VanadielUniqueDay())
    return quest:event(imp.initial, 155, 0, param3)
end

local function handleImpTrade(player, impNumber, trade)
    local imp = impData[impNumber]

    if
        npcUtil.tradeHasExactly(trade, xi.item.ELIXIR) and
        quest:getVar(player, 'TradeDay') ~= VanadielUniqueDay()
    then
        local isCorrect = getCurrentImpScenario().honestImp == impNumber
        setImpTradeState(player, impNumber, isCorrect)

        if isCorrect then
            return quest:progressEvent(imp.trade, 155, 0, 1)
        end

        return quest:event(imp.trade, 155, 0, 0)
    end
end

local function handleSolvedImpTrigger(impNumber)
    local imp = impData[impNumber]

    if getCurrentImpScenario().honestImp == impNumber then
        return quest:event(imp.selfTrade, 155, 0, 1)
    end

    return quest:event(imp.otherTrade, 1)
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.WHAT_PRICE_LOYALTY) and
                player:getCurrentMission(xi.mission.log_id.WOTG) >= xi.mission.id.wotg.ADIEU_LILISETTE
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:progressEvent(211),

            onEventFinish =
            {
                [211] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] = quest:event(212),
        },

        [xi.zone.CASTLE_ZVAHL_BAILEYS_S] =
        {
            onZoneIn = function(player, prevZone)
                return 12
            end,

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.CASTLE_ZVAHL_KEEP_S] =
        {
            ['Rikke'] =
            {
                onTrade = function(player, npc, trade)
                    return handleImpTrade(player, 1, trade)
                end,

                onTrigger = function(player, npc)
                    return handleImpPuzzleTrigger(player, 1)
                end,
            },

            ['Rakke'] =
            {
                onTrade = function(player, npc, trade)
                    return handleImpTrade(player, 2, trade)
                end,

                onTrigger = function(player, npc)
                    return handleImpPuzzleTrigger(player, 2)
                end,
            },

            ['Rokke'] =
            {
                onTrade = function(player, npc, trade)
                    return handleImpTrade(player, 3, trade)
                end,

                onTrigger = function(player, npc)
                    return handleImpPuzzleTrigger(player, 3)
                end,
            },

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    if quest:getVar(player, 'TradeImp') == 1 and quest:getVar(player, 'TradeSuccess') == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [13] = function(player, csid, option, npc)
                    if quest:getVar(player, 'TradeImp') == 2 and quest:getVar(player, 'TradeSuccess') == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [14] = function(player, csid, option, npc)
                    if quest:getVar(player, 'TradeImp') == 3 and quest:getVar(player, 'TradeSuccess') == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.CASTLE_ZVAHL_KEEP_S] =
        {
            ['Rikke'] =
            {
                onTrigger = function(player, npc)
                    return handleSolvedImpTrigger(1)
                end,
            },

            ['Rakke'] =
            {
                onTrigger = function(player, npc)
                    return handleSolvedImpTrigger(2)
                end,
            },

            ['Rokke'] =
            {
                onTrigger = function(player, npc)
                    return handleSolvedImpTrigger(3)
                end,
            },

            ['qm'] = quest:progressEvent(15),

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 3
        end,

        [xi.zone.CASTLE_ZVAHL_KEEP_S] =
        {
            ['Displaced_Block'] = quest:progressEvent(16),

            onEventFinish =
            {
                [16] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
