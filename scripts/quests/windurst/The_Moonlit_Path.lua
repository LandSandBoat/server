-----------------------------------
-- The Moonlit Path
-----------------------------------
-- Log ID: 2, Quest ID: 9
-- !addquest 2 9
-- Leepe-Hoppe : !pos 11.432 -9.749 -197.475 238
-----------------------------------
-- Events 846 and 850 hide the pact (bit 6) without SMN and the mount (bit 7) without the trainer's whistle.
-- A repeat puts the quest back in the log.
-- Leepe-Hoppe plays 850 and 851 in place of 846 and 847 from then on.
-----------------------------------
local windurstWatersID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.THE_MOONLIT_PATH)

quest.reward =
{
    fame     = 60,
    fameArea = xi.fameArea.WINDURST,
    title    = xi.title.HEIR_OF_THE_NEW_MOON,
}

local avatarWhispers =
{
    xi.keyItem.WHISPER_OF_FLAMES,
    xi.keyItem.WHISPER_OF_TREMORS,
    xi.keyItem.WHISPER_OF_TIDES,
    xi.keyItem.WHISPER_OF_GALES,
    xi.keyItem.WHISPER_OF_FROST,
    xi.keyItem.WHISPER_OF_STORMS,
}

local rewardItems =
{
    [1] = xi.item.FENRIRS_STONE,
    [2] = xi.item.FENRIRS_CAPE,
    [3] = xi.item.FENRIRS_TORQUE,
    [4] = xi.item.FENRIRS_EARRING,
    [5] = xi.item.ANCIENTS_KEY,
}

local function turnInOnEventFinish(player, csid, option, npc)
    -- Retail does not advance the quest on an escaped cutscene.
    if option < 1 or option > 8 then
        return
    end

    if option <= 5 then
        if not npcUtil.giveItem(player, rewardItems[option]) then
            return
        end
    elseif option == 6 then
        npcUtil.giveCurrency(player, 'gil', 15000)
    elseif option == 7 then
        player:addSpell(xi.magic.spell.FENRIR, { silentLog = true })
        player:messageText(npc, windurstWatersID.text.FENRIR_UNLOCKED, false, 6)
    elseif option == 8 then
        npcUtil.giveKeyItem(player, xi.keyItem.FENRIR_WHISTLE)
    end

    quest:complete(player)
    player:delKeyItem(xi.keyItem.WHISPER_OF_THE_MOON)
    quest:setTimedVar(player, 'Timer', NextJstDay())

    -- quest:complete() wipes the vars. Set again so Leepe-Hoppe plays 851 in place of 847.
    if csid == 850 then
        quest:setVar(player, 'Repeat', 1)
    end

    if
        player:getNation() == xi.nation.WINDURST and
        player:getRank(xi.nation.WINDURST) == 10 and
        player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.THE_PROMISE)
    then
        npcUtil.giveKeyItem(player, xi.keyItem.DARK_MANA_ORB)
    end
end

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 6
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Leepe-Hoppe'] = quest:progressEvent(842, 0, xi.item.CARBUNCLES_RUBY),

            onEventFinish =
            {
                [842] = function(player, csid, option, npc)
                    if option == 2 then
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

        [xi.zone.FULL_MOON_FOUNTAIN] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.MOONLIT_PATH then
                        player:delKeyItem(xi.keyItem.MOON_BAUBLE)
                        npcUtil.giveKeyItem(player, xi.keyItem.WHISPER_OF_THE_MOON)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Leepe-Hoppe'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.keyItem.MOON_BAUBLE) then
                        return quest:event(845, 0, xi.item.CARBUNCLES_RUBY, xi.keyItem.MOON_BAUBLE) -- Reminder: take the moon bauble to the Full Moon Fountain.
                    end

                    if not player:hasKeyItem(xi.keyItem.WHISPER_OF_THE_MOON) then
                        for _, whisper in ipairs(avatarWhispers) do
                            if not player:hasKeyItem(whisper) then
                                return quest:event(843, 0, xi.item.CARBUNCLES_RUBY) -- Reminder: gather the six whispers.
                            end
                        end

                        return quest:progressEvent(844, 0, xi.item.CARBUNCLES_RUBY, xi.keyItem.MOON_BAUBLE)
                    end

                    -- Set bits hide reward menu options.
                    local rewardMask = 0

                    for option, itemId in pairs(rewardItems) do
                        if player:hasItem(itemId) then
                            rewardMask = utils.mask.setBit(rewardMask, option - 1, true)
                        end
                    end

                    if player:hasSpell(xi.magic.spell.FENRIR) or not player:hasJob(xi.job.SMN) then
                        rewardMask = utils.mask.setBit(rewardMask, 6, true)
                    end

                    if
                        player:hasKeyItem(xi.keyItem.FENRIR_WHISTLE) or
                        not player:hasKeyItem(xi.keyItem.TRAINERS_WHISTLE)
                    then
                        rewardMask = utils.mask.setBit(rewardMask, 7, true)
                    end

                    if quest:getVar(player, 'Repeat') == 1 then
                        return quest:progressEvent(850, 0, xi.item.FENRIRS_EARRING, xi.item.ANCIENTS_KEY, xi.item.CARBUNCLES_RUBY, rewardMask, xi.item.FENRIRS_STONE, xi.item.FENRIRS_CAPE)
                    else
                        return quest:progressEvent(846, 0, xi.item.FENRIRS_EARRING, xi.item.ANCIENTS_KEY, xi.item.CARBUNCLES_RUBY, rewardMask, xi.item.FENRIRS_STONE, xi.item.FENRIRS_CAPE)
                    end
                end,
            },

            onEventFinish =
            {
                [844] = function(player, csid, option, npc)
                    -- Retail does not advance the quest on an escaped cutscene.
                    if option ~= 0 then
                        return
                    end

                    npcUtil.giveKeyItem(player, xi.keyItem.MOON_BAUBLE)

                    for _, whisper in ipairs(avatarWhispers) do
                        player:delKeyItem(whisper)
                    end
                end,

                [846] = turnInOnEventFinish,
                [850] = turnInOnEventFinish,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Leepe-Hoppe'] =
            {
                onTrigger = function(player, npc)
                    -- Repeatable once per JST day.
                    if quest:getVar(player, 'Timer') == 0 then
                        return quest:progressEvent(848, 0, xi.item.CARBUNCLES_RUBY, xi.keyItem.MOON_BAUBLE)
                    elseif quest:getVar(player, 'Repeat') == 1 then
                        return quest:event(851, 0, xi.item.CARBUNCLES_RUBY, xi.item.ANCIENTS_KEY, xi.item.CARBUNCLES_RUBY, 0, xi.item.FENRIRS_STONE, xi.item.FENRIRS_CAPE)
                    else
                        return quest:event(847, 0, xi.item.CARBUNCLES_RUBY)
                    end
                end,
            },

            onEventFinish =
            {
                [848] = function(player, csid, option, npc)
                    if option == 2 then
                        player:delQuest(xi.questLog.WINDURST, xi.quest.id.windurst.THE_MOONLIT_PATH)
                        npcUtil.giveKeyItem(player, xi.keyItem.MOON_BAUBLE)
                        quest:begin(player)
                        quest:setVar(player, 'Repeat', 1)
                    end
                end,
            },
        },
    },
}

return quest
