-----------------------------------
-- Trial by Fire
-----------------------------------
-- Log ID: 5, Quest ID: 12
-- !addquest 5 12
-- Ronta-Onta : !pos 100.370 -13.999 -97.676 250
-- Dodmos     : !pos 102.647 -13.999 -97.664 250
-----------------------------------
-- Event 273 hides the pact option (bit 5) for players who have not unlocked SMN.
-----------------------------------
local kazhamID = zones[xi.zone.KAZHAM]
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_FIRE)

quest.reward =
{
    fame     = 60,
    fameArea = xi.fameArea.WINDURST,
}

local rewardItems =
{
    [0] = xi.item.IFRITS_BLADE,
    [1] = xi.item.FIRE_BELT,
    [2] = xi.item.FIRE_RING,
    [3] = xi.item.EGILS_TORCH,
}

local function getRewardMask(player)
    local rewardMask = 0

    for bitNum, itemId in pairs(rewardItems) do
        if player:hasItem(itemId) then
            rewardMask = utils.mask.setBit(rewardMask, bitNum, true)
        end
    end

    if player:hasSpell(xi.magic.spell.IFRIT) or not player:hasJob(xi.job.SMN) then
        rewardMask = utils.mask.setBit(rewardMask, 5, true)
    end

    return rewardMask
end

local function giveQuestReward(player, eventOption)
    local wasRewarded = true

    if eventOption <= 4 then
        wasRewarded = npcUtil.giveItem(player, rewardItems[eventOption - 1])
    elseif eventOption == 5 then
        npcUtil.giveCurrency(player, 'gil', 10000)
    elseif eventOption == 6 then
        player:addSpell(xi.magic.spell.IFRIT)
        player:messageSpecial(kazhamID.text.IFRIT_UNLOCKED, 0, 0, 0)
    end

    return wasRewarded
end

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 6
        end,

        [xi.zone.KAZHAM] =
        {
            -- Fourth event param plays the injured researcher introduction only seen before the first completion.
            ['Ronta-Onta'] = quest:progressEvent(270, 0, xi.ki.TUNING_FORK_OF_FIRE, 0, 1),

            onEventFinish =
            {
                [270] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_FIRE)
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.KAZHAM] =
        {
            ['Dodmos'] = quest:event(272),

            ['Ronta-Onta'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.WHISPER_OF_FLAMES) then
                        return quest:progressEvent(273, 0, 1, 0, 0, getRewardMask(player))
                    elseif not player:hasKeyItem(xi.ki.TUNING_FORK_OF_FIRE) then
                        -- Player has failed the BCNM and requires a new Tuning Fork.
                        return quest:progressEvent(285, 0, xi.ki.TUNING_FORK_OF_FIRE)
                    else
                        return quest:event(271, 4, xi.ki.TUNING_FORK_OF_FIRE)
                    end
                end,
            },

            onEventFinish =
            {
                [273] = function(player, csid, option, npc)
                    -- Retail does not advance the quest on an escaped cutscene.
                    if option < 1 or option > 6 then
                        return
                    end

                    if giveQuestReward(player, option) then
                        quest:complete(player)
                        player:delKeyItem(xi.ki.WHISPER_OF_FLAMES)
                        quest:setTimedVar(player, 'Timer', NextJstDay())
                    end
                end,

                [285] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_FIRE)
                end,
            },
        },

        [xi.zone.CLOISTER_OF_FLAMES] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.TRIAL_BY_FIRE then
                        npcUtil.giveKeyItem(player, xi.ki.WHISPER_OF_FLAMES)
                        player:addTitle(xi.title.HEIR_OF_THE_GREAT_FIRE)
                    end
                end,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.KAZHAM] =
        {
            ['Ronta-Onta'] =
            {
                onTrigger = function(player, npc)
                    -- Repeatable once per JST day.
                    if quest:getVar(player, 'Timer') == 0 then
                        return quest:progressEvent(270, 0, xi.ki.TUNING_FORK_OF_FIRE)
                    end
                end,
            },

            onEventFinish =
            {
                [270] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_FIRE)

                        npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_FIRE)

                        quest:begin(player)
                    end
                end,
            },
        },
    },
}

return quest
