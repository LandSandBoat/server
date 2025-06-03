-----------------------------------
-- Waking the Colossus
-----------------------------------
-- Log ID: 6, Quest ID: 74
-- Naja Salaheem, !pos 22.700 -8.804 -45.591 50
-- Imperial Whitegate, !pos 152.8295 -2.2 0.0613 50
-- Audience Chamber, !pos 0 -5 66 243
-- Halver !pos 2.4 0 0 233
-- Iron Eater !pos 91 -19 1 237
-- Kupipi !pos 2 0 30 242
-- Audience Chamber, !pos 0 -5 66 243
-- Imperial Whitegate, !pos 152.8295 -2.2 0.0613 50
-- Acid-Eaten Door, !pos 271.9045 -32 -88 61
-- Blank Lamp, !pos 209.3953 0.05 20.0207 72
-- Runic Seal, !pos 125.4569 0 19.9914 72
-- Imperial Whitegate, !pos 152.8295 -2.2 0.0613 50
-- Naja Salaheem, !pos 22.700 -8.804 -45.591 50
-----------------------------------
local ahtUrhganID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.WAKING_THE_COLOSSUS)

quest.reward =
{
    title = xi.title.HEIR_OF_THE_BLESSED_RADIANCE,
    item  = { xi.item.IMPERIAL_GOLD_PIECE }
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
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.ETERNAL_MERCENARY
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        not player:hasKeyItem(xi.ki.IMPERIAL_MISSIVE)
                    then
                        return quest:progressEvent(926, { text_table = 0, [0] = 50, [1] = 1, [2] = 4, [5] = 1 })
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [13] = function(player, triggerArea)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(925, { text_table = 0, [0] = 50, [1] = 1, [2] = 4, [5] = 1 })
                    end
                end,
            },

            onEventFinish =
            {
                [925] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [926] = function(player, csid, option, npc)
                    if option == 0 then
                        npcUtil.giveKeyItem(player, xi.ki.IMPERIAL_MISSIVE)
                        quest:begin(player)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                player:hasKeyItem(xi.ki.IMPERIAL_MISSIVE)
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['_6r9'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(10115)
                    end

                    if
                        not player:hasKeyItem(xi.ki.JEUNOAN_APPROVAL_LETTER) and
                        player:hasKeyItem(xi.ki.SAN_DORIAN_APPROVAL_LETTER) and
                        player:hasKeyItem(xi.ki.BASTOKAN_APPROVAL_LETTER) and
                        player:hasKeyItem(xi.ki.WINDURSTIAN_APPROVAL_LETTER)
                    then
                        return quest:progressEvent(10116)
                    end
                end
            },

            onEventFinish =
            {
                [10115] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [10116] = function(player, csid, option, npc)
                    if option == 0 then
                        npcUtil.giveKeyItem(player, xi.ki.JEUNOAN_APPROVAL_LETTER)
                    end
                end,
            }
        },

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        not player:hasKeyItem(xi.ki.SAN_DORIAN_APPROVAL_LETTER)
                    then
                        return quest:progressEvent(567, { [0] = 4, [1] = 4, [2] = 2964, [6] = 1 })
                    end
                end
            },

            onEventFinish =
            {
                [567] = function(player, csid, option, npc)
                    if option == 0 then
                        npcUtil.giveKeyItem(player, xi.ki.SAN_DORIAN_APPROVAL_LETTER)
                    end
                end,
            }
        },

        [xi.zone.METALWORKS] =
        {
            ['Iron_Eater'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        not player:hasKeyItem(xi.ki.BASTOKAN_APPROVAL_LETTER)
                    then
                        return quest:progressEvent(968, { [1] = 4, [2] = 2964, [4] = 58195967, [5] = 212046073, [7] = 4095 })
                    end
                end
            },

            onEventFinish =
            {
                [968] = function(player, csid, option, npc)
                    if option == 0 then
                        npcUtil.giveKeyItem(player, xi.ki.BASTOKAN_APPROVAL_LETTER)
                    end
                end,
            }
        },

        [xi.zone.HEAVENS_TOWER] =
        {
            ['Kupipi'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        not player:hasKeyItem(xi.ki.WINDURSTIAN_APPROVAL_LETTER)
                    then
                        return quest:progressEvent(429, { [0] = 74, [1] = 4, [2] = 2964, [4] = 582, [7] = 1 })
                    end
                end
            },

            onEventFinish =
            {
                [429] = function(player, csid, option, npc)
                    if option == 0 then
                        npcUtil.giveKeyItem(player, xi.ki.WINDURSTIAN_APPROVAL_LETTER)
                    end
                end,
            }
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                player:hasKeyItem(xi.ki.JEUNOAN_APPROVAL_LETTER)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.PRESENT_FOR_MEGOMAK) then
                        return quest:progressEvent(927, { text_table = 0, [2] = 3, [4] = 66420735, [5] = 66497777 })
                    end
                end
            },

            onEventFinish =
            {
                [927] = function(player, csid, option, npc)
                    if option == 0 then
                        player:delKeyItem(xi.ki.IMPERIAL_MISSIVE)
                        player:delKeyItem(xi.ki.SAN_DORIAN_APPROVAL_LETTER)
                        player:delKeyItem(xi.ki.BASTOKAN_APPROVAL_LETTER)
                        player:delKeyItem(xi.ki.WINDURSTIAN_APPROVAL_LETTER)
                        player:delKeyItem(xi.ki.JEUNOAN_APPROVAL_LETTER)
                        npcUtil.giveKeyItem(player, xi.ki.PRESENT_FOR_MEGOMAK)
                    end
                end,
            }
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                (player:hasKeyItem(xi.ki.PRESENT_FOR_MEGOMAK) or player:hasKeyItem(xi.ki.MEGOMAKS_SHOPPING_LIST))
        end,

        [xi.zone.MOUNT_ZHAYOLM] =
        {
            ['Acid-eaten_Door'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.PRESENT_FOR_MEGOMAK) and
                        not player:hasKeyItem(xi.ki.MEGOMAKS_SHOPPING_LIST)
                    then
                        return quest:progressEvent(154)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        player:hasKeyItem(xi.ki.MEGOMAKS_SHOPPING_LIST) and
                        npcUtil.tradeHasExactly(trade, { { xi.item.SLAB_OF_PLUMBAGO, 3 } }) and
                        not player:hasKeyItem(xi.ki.LIGHTNING_CELL)
                    then
                        return quest:progressEvent(155)
                    end
                end,
            },

            onEventFinish =
            {
                [154] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.PRESENT_FOR_MEGOMAK)
                        npcUtil.giveKeyItem(player, xi.ki.MEGOMAKS_SHOPPING_LIST)
                    end
                end,

                [155] = function(player, csid, option, npc)
                    if npcUtil.giveKeyItem(player, xi.ki.LIGHTNING_CELL) then
                        player:confirmTrade()
                    end
                end,
            },
        }
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                (player:hasKeyItem(xi.ki.LIGHTNING_CELL) or vars.Prog == 4)
        end,

        [xi.zone.ALZADAAL_UNDERSEA_RUINS] =
        {
            ['blank_lamp'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.LIGHTNING_CELL) and
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(306)
                    end
                end,
            },

            onZoneIn = function(player, prevZone)
                if
                    quest:getVar(player, 'Prog') == 4 and
                    not player:hasKeyItem(xi.ki.WHISPER_OF_RADIANCE)
                then
                    return 307
                end
            end,

            onEventFinish =
            {
                [306] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [307] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.WHISPER_OF_RADIANCE)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                player:hasKeyItem(xi.ki.WHISPER_OF_RADIANCE)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(928, { text_table = 0, [2] = 255, [4] = 67108863, [5] = 47467207 })
                    end
                end,
            },
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(929, { text_table = 0, [0] = xi.besieged.getMercenaryRank(player), [7] = getRewardMask(player) })
                    end
                end,
            },

            onEventFinish =
            {
                [928] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 5)
                    end
                end,

                [929] = function(player, csid, option, npc)
                    if giveQuestReward(player, option) then
                        quest:complete(player)
                        player:delKeyItem(xi.ki.WHISPER_OF_RADIANCE)
                        -- Divine Interference cannot start until next JP midnight
                        xi.quest.setVar(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.DIVINE_INTERFERENCE, 'Timer', 1, NextJstDay())
                    end
                end,
            },
        },
    },
}

return quest
