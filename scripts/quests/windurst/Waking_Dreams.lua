-----------------------------------
-- Waking Dreams
-----------------------------------
-- Log ID: 2, Quest ID: 93
-- Kerutoto : !pos 13 -5 -157 238
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

    local diabolosCheck = not player:hasJob(xi.job.SMN) or player:hasSpell(xi.magic.spell.DIABOLOS)

    rewardMask = utils.mask.setBit(rewardMask, diabolosCheck and 5 or 4, true)

    return rewardMask
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
                    npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_DREAM_INCENSE)
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
                    if player:hasKeyItem(xi.ki.WHISPER_OF_DREAMS) then
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
                    if option >= 1 and option <= 4 and not player:hasItem(rewardItems[option]) then
                        npcUtil.giveItem(player, rewardItems[option])
                    elseif option == 5 then
                        npcUtil.giveCurrency(player, 'gil', 15000)
                    elseif option == 6 and not player:hasSpell(xi.magic.spell.DIABOLOS) then
                        player:addSpell(xi.magic.spell.DIABOLOS)
                        player:messageSpecial(windurstWatersID.text.DIABOLOS_UNLOCKED, 0, 0, 0)
                    end

                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.WHISPER_OF_DREAMS)
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
                    -- Time lockout.
                    if GetSystemTime() < player:getCharVar('Darkness_Named_date') then
                        return quest:event(306)

                    -- "Re-start" quest
                    elseif not player:hasKeyItem(xi.ki.VIAL_OF_DREAM_INCENSE) then
                        return quest:progressEvent(918)

                    -- Quest complete.
                    elseif player:hasKeyItem(xi.ki.WHISPER_OF_DREAMS) then
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
                [918] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_DREAM_INCENSE)
                end,

                [919] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,

                [920] = function(player, csid, option, npc)
                    if option >= 1 and option <= 4 and not player:hasItem(rewardItems[option]) then
                        npcUtil.giveItem(player, rewardItems[option])
                    elseif option == 5 then
                        npcUtil.giveCurrency(player, 'gil', 15000)
                    elseif option == 6 and not player:hasSpell(xi.magic.spell.DIABOLOS) then
                        player:addSpell(xi.magic.spell.DIABOLOS)
                        player:messageSpecial(windurstWatersID.text.DIABOLOS_UNLOCKED, 0, 0, 0)
                    end

                    player:delKeyItem(xi.ki.WHISPER_OF_DREAMS)
                    player:setCharVar('Darkness_Named_date', JstMidnight())
                end,
            },
        },
    },
}

return quest
