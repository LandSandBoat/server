-----------------------------------
-- Waking Dreams
-----------------------------------
-- Log ID: 2, Quest ID: 93
-- Kerutoto : !pos 13 -5 -157 238
-----------------------------------
-- Event 920 hides the pact option (bit 5) for players who have not unlocked SMN or already know it.
-- A seventh event param of 1 plays Kerutoto's repeat lines in 918 and 920.
-----------------------------------
local windurstWatersID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.WAKING_DREAMS)

local rewardItems =
{
    [1] = xi.item.DIABOLOSS_POLE,
    [2] = xi.item.DIABOLOSS_EARRING,
    [3] = xi.item.DIABOLOSS_RING,
    [4] = xi.item.DIABOLOSS_TORQUE,
}

-- Setup reward table to display available awards in event properly
local function getAvailableRewards(player)
    local rewardMask = 0

    for bit, itemId in pairs(rewardItems) do
        if player:hasItem(itemId) then
            rewardMask = utils.mask.setBit(rewardMask, bit - 1, true)
        end
    end

    if
        player:hasSpell(xi.magic.spell.DIABOLOS) or
        not player:hasJob(xi.job.SMN)
    then
        rewardMask = utils.mask.setBit(rewardMask, 5, true)
    end

    return rewardMask
end

local function giveQuestReward(player, npc, option)
    if option <= 4 then
        return npcUtil.giveItem(player, rewardItems[option])
    elseif option == 5 then
        npcUtil.giveCurrency(player, 'gil', 15000)
    elseif option == 6 then
        player:addSpell(xi.magic.spell.DIABOLOS, { silentLog = true })
        player:messageText(npc, windurstWatersID.text.DIABOLOS_UNLOCKED, false, 6)
    end

    return true
end

quest.sections =
{
    -- Section 1: Quest available (first time)
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kerutoto'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(918)
                end,
            },

            onEventFinish =
            {
                [918] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.keyItem.VIAL_OF_DREAM_INCENSE)
                end,
            },
        },
    },

    -- Section 2: Quest accepted (First time)
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kerutoto'] =
            {
                onTrigger = function(player, npc)
                    -- Quest complete.
                    if player:hasKeyItem(xi.keyItem.WHISPER_OF_DREAMS) then
                        return quest:progressEvent(920, xi.item.DIABOLOSS_POLE, xi.item.DIABOLOSS_EARRING, xi.item.DIABOLOSS_RING, xi.item.DIABOLOSS_TORQUE, 0, 0, 0, getAvailableRewards(player))

                    -- 1-time optional dialog.
                    elseif quest:getVar(player, 'Option') == 0 then
                        return quest:progressEvent(919)

                    -- In-quest default.
                    else
                        return quest:event(789)
                    end
                end,
            },

            onEventFinish =
            {
                [919] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,

                [920] = function(player, csid, option, npc)
                    -- Retail does not advance the quest on an escaped cutscene.
                    if option < 1 or option > 6 then
                        return
                    end

                    if not giveQuestReward(player, npc, option) then
                        return
                    end

                    if quest:complete(player) then
                        player:addFame(xi.fameArea.WINDURST, 60)
                        player:delKeyItem(xi.keyItem.WHISPER_OF_DREAMS)
                        player:setCharVar('Darkness_Named_date', JstMidnight())
                        quest:setMustZone(player)
                    end
                end,
            },
        },
    },

    -- Section 3: Quest completed (repeats)
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kerutoto'] =
            {
                onTrigger = function(player, npc)
                    -- Time lockout. Retail keeps the in-quest lines until the next offer.
                    if GetSystemTime() < player:getCharVar('Darkness_Named_date') then
                        return quest:event(789):replaceDefault()

                    -- Quest complete.
                    elseif player:hasKeyItem(xi.keyItem.WHISPER_OF_DREAMS) then
                        return quest:progressEvent(920, xi.item.DIABOLOSS_POLE, xi.item.DIABOLOSS_EARRING, xi.item.DIABOLOSS_RING, xi.item.DIABOLOSS_TORQUE, 0, 0, 1, getAvailableRewards(player))

                    -- "Re-start" quest
                    elseif not player:hasKeyItem(xi.keyItem.VIAL_OF_DREAM_INCENSE) then
                        return quest:progressEvent(918, 0, 0, 0, 0, 0, 0, 1)

                    -- 1-time optional dialog.
                    elseif quest:getVar(player, 'Option') == 0 then
                        return quest:progressEvent(919)

                    -- In-quest default.
                    else
                        return quest:event(789)
                    end
                end,
            },

            onEventFinish =
            {
                [918] = function(player, csid, option, npc)
                    -- "Not yet." returns the escape value.
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.keyItem.VIAL_OF_DREAM_INCENSE)
                    end
                end,

                [919] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,

                [920] = function(player, csid, option, npc)
                    -- Retail does not advance the quest on an escaped cutscene.
                    if option < 1 or option > 6 then
                        return
                    end

                    if not giveQuestReward(player, npc, option) then
                        return
                    end

                    player:delKeyItem(xi.keyItem.WHISPER_OF_DREAMS)
                    player:setCharVar('Darkness_Named_date', JstMidnight())
                end,
            },
        },
    },
}

return quest
