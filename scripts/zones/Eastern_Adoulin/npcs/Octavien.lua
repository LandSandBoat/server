-----------------------------------
-- Area: Eastern Adoulin (257)
--  NPC: Octavien
-- Type: Palace Guard
-- Starts Children of the Rune
-- !pos 100.580 -40.150 -63.830
-----------------------------------
local ID = zones[xi.zone.EASTERN_ADOULIN]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Various quest states for Children Of The Rune (COTR).
-- Corresponds to possible values for the char var 'RUN_COTR'.
local cotrStates =
{
    -- Player triggered the quest but declined to accept the quest in the
    -- dialog options. On next trigger jump to the quest continuation cutscene.
    TRIGGERED = 1,
    -- Player has not yet finished the rune enhacement phase of the quest.
    -- On next trigger, jump straight to the rune enhancement cutscene.
    RUNE_ENHANCEMENT = 2,
    -- Player would have completed the quest, but had a full inventory. On
    -- next interaction, jump to the final cutscene and try to issue the reward.
    REWARD_PENDING = 3
}

entity.onTrigger = function(player, npc)
    -- CHILDREN OF THE RUNE
    local cotrQuestStatus = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.CHILDREN_OF_THE_RUNE)
    -- NOTE: The if-statements are ordered in reverse order from when they occur
    -- for natural fallthrough, to avoid needing `not` statements in them.
    if cotrQuestStatus == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(28)
    elseif player:getCharVar('RUN_COTR') == cotrStates.REWARD_PENDING then
        player:startEvent(29)
    elseif player:getCharVar('RUN_COTR') == cotrStates.RUNE_ENHANCEMENT then
        player:startEvent(26, 1)
    elseif
        cotrQuestStatus == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.YAHSE_WILDFLOWER_PETAL)
    then
        player:startEvent(26)
    elseif cotrQuestStatus == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(25)
    elseif player:getCharVar('RUN_COTR') == cotrStates.TRIGGERED then
        player:startEvent(24)
    elseif
        cotrQuestStatus == xi.questStatus.QUEST_AVAILABLE and
        player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
    then
        player:startEvent(23)
    else
        player:startEvent(27) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 26 then
        if option == 1 then
            -- Half the players MP and HP unless the HP is really low, to avoid
            -- killing the player.
            local hp = player:getHP()
            if hp > 5 then
                player:setHP(math.ceil(hp / 2))
            end

            local mp = player:getMP()
            if mp > 5 then
                player:setMP(math.ceil(mp / 2))
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- CHILDREN OF THE RUNE
    if csid == 23 or csid == 24 then
        if option == 0 then
            player:setCharVar('RUN_COTR', cotrStates.TRIGGERED)
        elseif option == 1 then
            player:addQuest(xi.questLog.ADOULIN, xi.quest.id.adoulin.CHILDREN_OF_THE_RUNE)
        end
    elseif csid == 26 then
        if option == 0 then
            player:setCharVar('RUN_COTR', cotrStates.RUNE_ENHANCEMENT)
        elseif option == 1 then
            player:setCharVar('RUN_COTR', cotrStates.REWARD_PENDING)
        end
    end

    -- Attempt to issue the Children of the Rune reward if the player has space.
    if player:getCharVar('RUN_COTR') == cotrStates.REWARD_PENDING then
        if npcUtil.giveItem(player, xi.item.SOWILO_CLAYMORE) then  -- Sowilo Claymore
            player:unlockJob(xi.job.RUN)
            player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME, 1)  -- You can now become a rune fencer!
            npcUtil.giveKeyItem(player, xi.ki.JOB_GESTURE_RUNE_FENCER)
            player:setCharVar('RUN_COTR', 0)
            player:delKeyItem(xi.ki.YAHSE_WILDFLOWER_PETAL)
            player:completeQuest(xi.questLog.ADOULIN, xi.quest.id.adoulin.CHILDREN_OF_THE_RUNE)
        end
    end
end

return entity
