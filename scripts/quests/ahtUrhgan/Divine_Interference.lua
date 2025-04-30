-----------------------------------
-- Divine Interference
-----------------------------------
-- Log ID: 6, Quest ID: 75
-- Naja Salaheem, !pos 22.700 -8.804 -45.591 50
-- Imperial Whitegate, !pos 152.8295 -2.2 0.0613 50
-- Acid-Eaten Door, !pos 271.9045 -32 -88 61
-- Blank Lamp, !pos 209.3953 0.05 20.0207 72
-- Runic Seal, !pos 125.4569 0 19.9914 72
-- Naja Salaheem, !pos 22.700 -8.804 -45.591 50
-----------------------------------
local ahtUrhganID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.DIVINE_INTERFERENCE)

quest.reward =
{
    title = xi.title.HEIR_OF_THE_BLESSED_RADIANCE,
    item = { xi.item.IMPERIAL_GOLD_PIECE }
}

local rewardItems =
{
    [0] = xi.item.COLOSSUSS_MANTLE,
    [1] = xi.item.COLOSSUSS_EARRING,
    [2] = xi.item.COLOSSUSS_TORQUE,
}

local function getRewardMask(player)
    local rewardMask = 0

    for bitNum, itemId in pairs(rewardItems) do
        if player:hasItem(itemId) then
            rewardMask = utils.mask.setBit(rewardMask, bitNum, true)
        end
    end

    if player:hasSpell(xi.magic.spell.ALEXANDER) then
        rewardMask = utils.mask.setBit(rewardMask, 4, true)
    end

    return rewardMask
end

local function giveQuestReward(player, eventOption)
    local wasRewarded = true

    if eventOption <= 3 then
        wasRewarded = npcUtil.giveItem(player, rewardItems[eventOption - 1])
    elseif eventOption == 4 then
        npcUtil.giveCurrency(player, 'gil', 10000)
    elseif eventOption == 5 then
        player:addSpell(xi.magic.spell.ALEXANDER)
        player:messageSpecial(ahtUrhganID.text.ALEXANDER_UNLOCKED, 0, 0, 1)
    end

    return wasRewarded
end

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            if
                status == xi.questStatus.QUEST_AVAILABLE and
                player:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.ETERNAL_MERCENARY and
                player:hasCompletedQuest(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.WAKING_THE_COLOSSUS) and
                quest:getVar(player, 'Timer') == 0
            then
                return true
            end

            return false
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(931, xi.besieged.getMercenaryRank(player), 0, 0, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [13] = function(player, triggerArea)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(930, xi.besieged.getMercenaryRank(player), 0, 0, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [930] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [931] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.ALZADAAL_UNDERSEA_RUINS] =
        {
            ['blank_lamp'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        player:hasKeyItem(xi.ki.LIGHTNING_CELL)
                    then
                        return quest:progressEvent(308)
                    end
                end,
            },

            onZoneIn = function(player, prevZone)
                if
                    quest:getVar(player, 'Prog') == 4 and
                    not player:hasKeyItem(xi.ki.WHISPER_OF_RADIANCE)
                then
                    return 309
                end
            end,

            onEventFinish =
            {
                [308] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [309] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.WHISPER_OF_RADIANCE)
                end,
            },
        },

        [xi.zone.MOUNT_ZHAYOLM] =
        {
            ['Acid-eaten_Door'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(157)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') >= 2 and
                        npcUtil.tradeHasExactly(trade, { { xi.item.SLAB_OF_PLUMBAGO, 3 } }) and
                        not player:hasKeyItem(xi.ki.LIGHTNING_CELL)
                    then
                        return quest:progressEvent(158)
                    end
                end,
            },

            onEventFinish =
            {
                [157] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [158] = function(player, csid, option, npc)
                    if npcUtil.giveKeyItem(player, xi.ki.LIGHTNING_CELL) then
                        player:confirmTrade()
                    end
                end,
            },
        }
    },

    -- Section: Complete quest
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and player:hasKeyItem(xi.ki.WHISPER_OF_RADIANCE)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(932, xi.besieged.getMercenaryRank(player), 0, 0, 0, 0, 0, 0, getRewardMask(player), 0)
                end,
            },

            onEventFinish =
            {
                [932] = function(player, csid, option, npc)
                    if giveQuestReward(player, option) then
                        quest:complete(player)
                        player:delKeyItem(xi.ki.WHISPER_OF_RADIANCE)
                        quest:setTimedVar(player, 'Timer', NextJstDay())
                    end
                end,
            },
        },
    },

    -- Section: Repeat quest
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and quest:getVar(player, 'Timer') == 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(931, xi.besieged.getMercenaryRank(player), 0, 0, 0, 0, 0, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [931] = function(player, csid, option, npc)
                    player:delQuest(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.DIVINE_INTERFERENCE)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },
}

return quest
