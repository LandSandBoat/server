-----------------------------------
-- Area: Windurst Waters
--  NPC: Leepe-Hoppe
-- Involved in Mission 1-3, Mission 7-2
-- !pos 13 -9 -197 238
-----------------------------------
---@type TNpcEntity
local entity = {}

local avatarKeyItems =
{
    xi.ki.WHISPER_OF_FLAMES,
    xi.ki.WHISPER_OF_TREMORS,
    xi.ki.WHISPER_OF_TIDES,
    xi.ki.WHISPER_OF_GALES,
    xi.ki.WHISPER_OF_FROST,
    xi.ki.WHISPER_OF_STORMS,
}

local function hasAvatarWhispers(player)
    for _, v in ipairs(avatarKeyItems) do
        if not player:hasKeyItem(v) then
            return false
        end
    end

    return true
end

local function getFenrirRewardMask(player)
    local rewardMask = 0

    if player:findItem(18165) then
        rewardMask = rewardMask + 1
    end -- Fenrir's Stone

    if player:findItem(13572) then
        rewardMask = rewardMask + 2
    end -- Fenrir's Cape

    if player:findItem(13138) then
        rewardMask = rewardMask + 4
    end -- Fenrir's Torque

    if player:findItem(13399) then
        rewardMask = rewardMask + 8
    end -- Fenrir's Earring

    if player:findItem(1208) then
        rewardMask = rewardMask + 16
    end -- Ancient's Key

    if player:hasSpell(xi.magic.spell.FENRIR) then
        rewardMask = rewardMask + 64
    end  -- Pact

    if
        not player:hasKeyItem(xi.ki.TRAINERS_WHISTLE) or
        player:hasKeyItem(xi.ki.FENRIR_WHISTLE)
    then
        rewardMask = rewardMask + 128
    end -- Mount Pact

    return rewardMask
end

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, { 1696, 1697, 1698 }) and -- Magicked Steel Ingot, Spruce Lumber, Extra-fine File
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TUNING_IN) == xi.questStatus.QUEST_ACCEPTED
    then
        player:startEvent(886)
    end
end

entity.onTrigger = function(player, npc)
    local moonlitPath = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_MOONLIT_PATH)
    local tuningIn = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TUNING_IN)
    local tuningOut = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TUNING_OUT)

    -- Tuning In
    if
        tuningIn == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.WINDURST) >= 4 and
        (player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.DISTANT_BELIEFS or player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE))
    then
        player:startEvent(884, 0, 1696, 1697, 1698) -- Magicked Steel Ingot, Spruce Lumber, Extra-fine File

    -- Tuning Out
    elseif
        tuningIn == xi.questStatus.QUEST_COMPLETED and
        tuningOut == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(888) -- Starting dialogue

    elseif
        tuningOut == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('TuningOut_Progress') == 8
    then
        player:startEvent(897) -- Finishing dialogue

    -- The Moonlit Path and Other Fenrir Stuff!
    elseif
        moonlitPath == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.WINDURST) >= 6 and
        player:getFameLevel(xi.fameArea.SANDORIA) >= 6 and
        player:getFameLevel(xi.fameArea.BASTOK) >= 6 and
        player:getFameLevel(xi.fameArea.NORG) >= 4
    then -- Fenrir flag event

        player:startEvent(842, 0, 1125)
    elseif moonlitPath == xi.questStatus.QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.MOON_BAUBLE) then -- Default text after acquiring moon bauble and before fighting Fenrir
            player:startEvent(845, 0, 1125, 334)
        elseif player:hasKeyItem(xi.ki.WHISPER_OF_THE_MOON) then -- First turn-in
            local availRewards = 0
            if
                not player:hasKeyItem(xi.ki.TRAINERS_WHISTLE) or
                player:hasKeyItem(xi.ki.FENRIR_WHISTLE)
            then
                availRewards = availRewards + 128
            end -- Mount Pact

            player:startEvent(846, 0, 13399, 1208, 1125, availRewards, 18165, 13572)
        elseif hasAvatarWhispers(player) then
            -- Collected the whispers
            player:startEvent(844, 0, 1125, 334)
        else -- Talked to after flag without the whispers
            player:startEvent(843, 0, 1125)
        end
    elseif moonlitPath == xi.questStatus.QUEST_COMPLETED then
        if player:hasKeyItem(xi.ki.MOON_BAUBLE) then -- Default text after acquiring moon bauble and before fighting Fenrir
            player:startEvent(845, 0, 1125, 334)
        elseif player:hasKeyItem(xi.ki.WHISPER_OF_THE_MOON) then -- Repeat turn-in
            local availRewards = getFenrirRewardMask(player)

            player:startEvent(850, 0, 13399, 1208, 1125, availRewards, 18165, 13572)
        elseif os.time() > player:getCharVar('MoonlitPath_date') then --24 hours have passed, flag a new fight
            player:startEvent(848, 0, 1125, 334)
        end
    elseif tuningIn == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(885, 0, 1696, 1697, 1698) -- Reminder to bring Magicked Steel Ingot, Spruce Lumber, Extra-fine File
    elseif tuningOut == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(889) -- Reminder to go help Ildy in Kazham
    elseif moonlitPath == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(847, 0, 1125) -- Having completed Moonlit Path, this will indefinitely replace his standard dialogue!
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- Moonlit Path and Other Fenrir Stuff
    if csid == 842 and option == 2 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.THE_MOONLIT_PATH)
    elseif csid == 844 then
        npcUtil.giveKeyItem(player, xi.ki.MOON_BAUBLE)
        player:delKeyItem(xi.ki.WHISPER_OF_FLAMES)
        player:delKeyItem(xi.ki.WHISPER_OF_TREMORS)
        player:delKeyItem(xi.ki.WHISPER_OF_TIDES)
        player:delKeyItem(xi.ki.WHISPER_OF_GALES)
        player:delKeyItem(xi.ki.WHISPER_OF_FROST)
        player:delKeyItem(xi.ki.WHISPER_OF_STORMS)
        player:delQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_FIRE)
        player:delQuest(xi.questLog.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH)
        player:delQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WATER)
        player:delQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WIND)
        player:delQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE)
        player:delQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_BY_LIGHTNING)
    elseif csid == 846 or csid == 850 then -- Turn-in event
        local reward = xi.item.NONE
        if option == 1 then
            reward = xi.item.FENRIRS_STONE -- Fenrir's Stone
        elseif option == 2 then
            reward = xi.item.FENRIRS_CAPE -- Fenrir's Cape
        elseif option == 3 then
            reward = xi.item.FENRIRS_TORQUE -- Fenrir's Torque
        elseif option == 4 then
            reward = xi.item.FENRIRS_EARRING -- Fenrir's Earring
        elseif option == 5 then
            reward = xi.item.ANCIENTS_KEY -- Ancient's Key
        elseif option == 6 then
            npcUtil.giveCurrency(player, 'gil', 15000)
        elseif option == 7 then
            player:addSpell(xi.magic.spell.FENRIR) -- Pact
        elseif option == 8 then
            npcUtil.giveKeyItem(player, xi.ki.FENRIR_WHISTLE)
            -- Pact as Mount
        end

        -- TODO: Reward is never nil since it is initialized; however, we should't run this block
        -- if the player chooses an item, and they don't have space in their inventory.
        player:addTitle(xi.title.HEIR_OF_THE_NEW_MOON)
        player:delKeyItem(xi.ki.WHISPER_OF_THE_MOON)
        player:setCharVar('MoonlitPath_date', getMidnight())
        player:addFame(xi.fameArea.WINDURST, 30)

        if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_MOONLIT_PATH) == xi.questStatus.QUEST_ACCEPTED then
            player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.THE_MOONLIT_PATH)
        end

        if reward ~= 0 then
            npcUtil.giveItem(player, reward)
        end

        if
            player:getNation() == xi.nation.WINDURST and
            player:getRank(player:getNation()) == 10 and
            player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_PROMISE) == xi.questStatus.QUEST_COMPLETED
        then
            npcUtil.giveKeyItem(player, xi.ki.DARK_MANA_ORB)
        end
    elseif csid == 848 then
        npcUtil.giveKeyItem(player, xi.ki.MOON_BAUBLE)

    -- Tuning In
    elseif csid == 884 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.TUNING_IN)

    elseif
        csid == 886 and
        npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.TUNING_IN, {
            gil = 4000,
            title = xi.title.FINE_TUNER,
        })
    then
        player:tradeComplete()

    -- Tuning Out
    elseif csid == 888 then
        player:setCharVar('TuningOut_Progress', 1)
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.TUNING_OUT)

    elseif
        csid == 897 and
        npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.TUNING_OUT, {
            item = xi.item.CACHE_NEZ, -- Cache-Nez
            title = xi.title.FRIEND_OF_THE_HELMED,
        })
    then
        player:setCharVar('TuningOut_Progress', 0) -- zero when quest is done
    end
end

return entity
