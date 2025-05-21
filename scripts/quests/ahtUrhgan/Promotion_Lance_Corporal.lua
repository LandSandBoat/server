-----------------------------------
-- Promotion: Lance Corporal
-- Logid: 6 Quest: 92
-- Abquhbah:                 !pos 35.5 -6.6 -58 50
-- Nafiwaa:                  !pos -74 -6 126 50
-- Mythralline Wellspring 1: !pos -92 -15 -339 51
-- Mythralline Wellspring 2: !pos -218 -15 -388 51
-- Mythralline Wellspring 3: !pos 181 -23 268 51
-- Mythralline Wellspring 4: !pos 259 -23 132 51
-- Mythralline Wellspring 5: !pos 181 -15 373 52
-- Prog: running total of player's test tube contents
-- Option: what mixture was turned in to the guild
-----------------------------------
local ahturhganID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
local bhaflauID    = zones[xi.zone.BHAFLAU_THICKETS]
local wajaomID     = zones[xi.zone.WAJAOM_WOODLANDS]

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_LANCE_CORPORAL)

local stage =
{
    START     = 0,
    FIRST_MIX = 1,
    REMIX     = 2,
    WAIT      = 3,
}

local tube =
{
    ONE   = 1,
    TWO   = 2,
    THREE = 3,
    FOUR  = 4,
    FIVE  = 5,
}

local tubeKeyItems =
{
    [tube.ONE]   = { filledTube = xi.ki.TEST_TUBE_1, emptyTube = xi.ki.EMPTY_TEST_TUBE_1 },
    [tube.TWO]   = { filledTube = xi.ki.TEST_TUBE_2, emptyTube = xi.ki.EMPTY_TEST_TUBE_2 },
    [tube.THREE] = { filledTube = xi.ki.TEST_TUBE_3, emptyTube = xi.ki.EMPTY_TEST_TUBE_3 },
    [tube.FOUR]  = { filledTube = xi.ki.TEST_TUBE_4, emptyTube = xi.ki.EMPTY_TEST_TUBE_4 },
    [tube.FIVE]  = { filledTube = xi.ki.TEST_TUBE_5, emptyTube = xi.ki.EMPTY_TEST_TUBE_5 },
}

local fillLevel =
{
    FULL            = 0,
    ONE_THIRD_USED  = 1,
    TWO_THIRDS_USED = 2,
    EMPTY           = 3,
}

local function getFluidLevel(player, tubeNum, var)
    local allTubes = utils.mask.splitBits(quest:getVar(player, var), 2)

    return allTubes[tubeNum] or 0
end

local function getFilledTubeCount(player)
    local tubeCount = 0

    for _, keyItems in ipairs(tubeKeyItems) do
        if player:hasKeyItem(keyItems.filledTube) then
            tubeCount = tubeCount + 1
        end
    end

    return tubeCount
end

local function canFillTube(player, tubeNum)
    return player:hasKeyItem(tubeKeyItems[tubeNum].emptyTube) or
    (quest:getVar(player, 'Stage') == stage.REMIX and getFluidLevel(player, tubeNum, 'Prog') ~= fillLevel.FULL)
end

local function fillTestTube(player, tubeNum)
    local bitPosOne = (tubeNum * 2) - 1
    local bitPosTwo = bitPosOne - 1

    quest:unsetVarBit(player, 'Prog', bitPosOne)
    quest:unsetVarBit(player, 'Prog', bitPosTwo)

    if player:hasKeyItem(tubeKeyItems[tubeNum].emptyTube) then
        player:delKeyItem(tubeKeyItems[tubeNum].emptyTube)
        player:addKeyItem(tubeKeyItems[tubeNum].filledTube)
    end

    if quest:getVar(player, 'Stage') == stage.FIRST_MIX then
        player:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, tubeKeyItems[tubeNum].filledTube)
    else
        player:messageSpecial(zones[player:getZoneID()].text.WELLSPRING + 1)
    end
end

local function getQuestReward(player)
    local tubeAmounts = {} -- calculate how many thirds of each tube were used, multiply by the tube's density and add them all together.

    for tubeNum = tube.ONE, tube.FIVE do
        table.insert(tubeAmounts, getFluidLevel(player, tubeNum, 'Option'))
    end

    local mythrallineQuality = 0
    local densities = -- densities are constant based on the hints and consistent results.
    {
        [tube.ONE]   = 0.5, -- "...appears to be very light."
        [tube.TWO]   = 1.5, -- "...is at the same level as tube #4."
        [tube.THREE] = 2.0, -- "...appears to be very dense."
        [tube.FOUR]  = 1.5, -- "...caused a reaction three times faster than the sample in tube #1."
        [tube.FIVE]  = 1.0, -- "...has a density is equal to half that of the sample with the highest concentration.."
    }

    for tubeNum, contents in ipairs(tubeAmounts) do
        mythrallineQuality = mythrallineQuality + (contents * densities[tubeNum])
    end

    -- Final Mythralline Quality
    -- 1.0 - 1.5 = Silver
    -- 2.0 - 3.5 = Mythril
    -- 4.0 - 5.5 = Gold
    -- 6.0 - 9.5 = Platinum
    -- 10.0      = Luminium
    -- 10.5      = Smoke

    local reward
    local rewardTiers =
    {
        luminium = { item = xi.item.IMPERIAL_GOLD_PIECE, amount = 2 },
        platinum =
        {
            { item = xi.item.IMPERIAL_MYTHRIL_PIECE, amount = math.random(3, 4) },
            { item = xi.item.IMPERIAL_GOLD_PIECE, amount = 1 },
        },
    }

    if mythrallineQuality == 10 then
        reward = rewardTiers.luminium
    elseif mythrallineQuality >= 6 and mythrallineQuality <= 9.5 then
        reward = rewardTiers.platinum[math.random(#rewardTiers.platinum)]
    end

    return reward
end

quest.reward =
{
    keyItem = xi.ki.LC_WILDCAT_BADGE,
    title   = xi.title.LANCE_CORPORAL,
}

quest.sections =
{
    { -- Start: Trigger Abquhbah
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getCharVar('AssaultPromotion') >= 25 and
            player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_SUPERIOR_PRIVATE) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] = quest:progressEvent(5030, { text_table = 0 }),

            onEventFinish =
            {
                [5030] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },
    { -- 1st Stage: Trigger Nafiwaa and recieve 5 KI empty test tubes
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Stage == stage.START
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] = quest:event(5032):importantOnce(),

            ['Nafiwaa'] = quest:progressEvent(5035, { text_table = 0 }),

            onEventFinish =
            {
                [5035] = function(player, csid, option, npc)
                    quest:setVar(player, 'Stage', stage.FIRST_MIX)
                    npcUtil.giveKeyItem(player, { xi.ki.EMPTY_TEST_TUBE_1, xi.ki.EMPTY_TEST_TUBE_2,
                        xi.ki.EMPTY_TEST_TUBE_3, xi.ki.EMPTY_TEST_TUBE_4, xi.ki.EMPTY_TEST_TUBE_5 })
                end,
            },
        },
    },
    { -- 2nd (and optional 3rd) Stage: Go to Mythralline Wellsprings and fill tubes; Trigger Nafiwaa to do mini game and mix mythralline
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            (vars.Stage == stage.FIRST_MIX or vars.Stage == stage.REMIX)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] = quest:event(5033):importantOnce(),

            ['Nafiwaa'] =
            {
                onTrigger = function(player, npc)
                    local currentStage = quest:getVar(player, 'Stage')
                    local tubeContents = quest:getVar(player, 'Prog')
                    local isRemix = currentStage == stage.REMIX and 1 or 0
                    local emptyTubes = 0

                    if currentStage == stage.FIRST_MIX then
                        local filledTubeCount = getFilledTubeCount(player)

                        if filledTubeCount == 0 then
                            return quest:event(5036)
                        elseif filledTubeCount < 5 then -- must gather all 5 tubes on first mix
                            return quest:event(5037, { [1] = filledTubeCount })
                        end
                    elseif currentStage == stage.REMIX then
                        local totalThirds = 15

                        for tubeNum = tube.ONE, tube.FIVE do
                            totalThirds = totalThirds - getFluidLevel(player, tubeNum, 'Prog')
                        end

                        if totalThirds < 2 then -- not enough liquid to mix anything
                            return quest:event(5036)
                        end
                    end

                    for tubeNum, keyItems in ipairs(tubeKeyItems) do
                        if player:hasKeyItem(keyItems.emptyTube) then
                            emptyTubes = utils.mask.setBit(emptyTubes, tubeNum - 1, 1)
                        end
                    end

                    return quest:progressEvent(5038, { [2] = tubeContents, [5] = emptyTubes, [7] = isRemix, text_table = 0 })
                end,
            },

            onEventFinish =
            {
                [5038] = function(player, csid, option, npc)
                    local remainingTubeContents, mask = utils.mask.varSplit(option, 16)

                    local result = bit.rshift(mask, 14)

                    if result == 2 then -- accept the results, turn in to guild
                        local startingContents = quest:getVar(player, 'Prog')

                        quest:setVar(player, 'Stage', stage.WAIT)
                        quest:setVar(player, 'Wait', VanadielUniqueDay() + 1)
                        quest:setVar(player, 'Option', remainingTubeContents - startingContents)

                        for keyItem = xi.ki.EMPTY_TEST_TUBE_1, xi.ki.TEST_TUBE_5 do
                            if player:hasKeyItem(keyItem) then
                                player:delKeyItem(keyItem)
                            end
                        end

                    elseif result == 1 then -- threw it out
                        quest:setVar(player, 'Stage', stage.REMIX)
                        quest:setVar(player, 'Prog', remainingTubeContents)

                        for tubeNum, tubeKeyItem in ipairs(tubeKeyItems) do
                            if
                                getFluidLevel(player, tubeNum, 'Prog') == fillLevel.EMPTY and
                                player:hasKeyItem(tubeKeyItem.filledTube)
                            then
                                player:delKeyItem(tubeKeyItem.filledTube)
                                player:addKeyItem(tubeKeyItem.emptyTube)
                            end
                        end
                    end
                end,
            },
        },
        [xi.zone.WAJAOM_WOODLANDS] =
        {
            ['Mythralline_Wellspring'] =
            {
                onTrigger = function(player, npc)
                    local offset = npc:getID() - wajaomID.npc.WELLSPRING
                    if canFillTube(player, tube.ONE + offset) then
                        return quest:progressEvent(4 + offset)
                    end

                    return quest:messageSpecial(wajaomID.text.WELLSPRING + 3)
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    fillTestTube(player, tube.ONE)
                end,

                [5] = function(player, csid, option, npc)
                    fillTestTube(player, tube.TWO)
                end,

                [6] = function(player, csid, option, npc)
                    fillTestTube(player, tube.THREE)
                end,

                [7] = function(player, csid, option, npc)
                    fillTestTube(player, tube.FOUR)
                end,
            },
        },
        [xi.zone.BHAFLAU_THICKETS] =
        {
            ['Mythralline_Wellspring'] =
            {
                onTrigger = function(player, npc)
                    if canFillTube(player, tube.FIVE) then
                        return quest:progressEvent(10)
                    end

                    return quest:messageSpecial(bhaflauID.text.WELLSPRING + 3)
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    fillTestTube(player, tube.FIVE)
                end,
            },
        },
    },
    { -- Complete: after game day wait, enter region
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Stage == stage.WAIT and
            vars.Option > 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Nafiwaa'] = quest:event(5039),

            ['Abquhbah'] = quest:event(5034):importantOnce(),

            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    if quest:getVar(player, 'Wait') <= VanadielUniqueDay() then
                        return quest:progressEvent(5031, { text_table = 0 })
                    end
                end,
            },

            onEventFinish =
            {
                [5031] = function(player, csid, option, npc)
                    local reward = getQuestReward(player)

                    if reward then
                        if not npcUtil.giveItem(player, { { reward.item, reward.amount } }) then
                            return
                        end
                    end

                    quest:complete(player)
                    quest:messageSpecial(ahturhganID.text.LANCE_CORPORAL)
                    player:setCharVar('AssaultPromotion', 0)
                    player:delKeyItem(xi.ki.SP_WILDCAT_BADGE)
                end,
            },
        },
        [xi.zone.WAJAOM_WOODLANDS] =
        {
            ['Mythralline_Wellspring'] =
            {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(wajaomID.text.WELLSPRING + 2)
                end,
            },
        },
        [xi.zone.BHAFLAU_THICKETS] =
        {
            ['Mythralline_Wellspring'] =
            {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(bhaflauID.text.WELLSPRING + 2)
                end,
            },
        },
    },
}

return quest
