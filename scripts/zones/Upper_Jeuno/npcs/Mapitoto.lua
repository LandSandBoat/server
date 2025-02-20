-----------------------------------
-- Area: Upper Jeuno
--  NPC: Mapitoto
-- Type: Full Speed Ahead Mount NPC
-- !pos -54.310 8.200 85.940 244
-----------------------------------
local ID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:hasKeyItem(xi.ki.TRAINERS_WHISTLE) and
        trade:getSlotCount() == 1 and
        -- The Fenrir (10057) and Omega (10067) items and mounts have their own questlines, so they aren't valid trades here
        not (npcUtil.tradeHasExactly(trade, xi.item.MOUNT_FENRIR) or npcUtil.tradeHasExactly(trade, xi.item.MOUNT_OMEGA))
    then
        local item = trade:getItemId(0)
        local mount = item - xi.item.MOUNT_TIGER
        if item == xi.item.CHOCOBO_WHISTLE then
            player:startEvent(10227, xi.item.CHOCOBO_WHISTLE, xi.ki.TRAINERS_WHISTLE, xi.mount.CHOCOBO)
            player:setLocalVar('FullSpeedAheadReward', xi.ki.CHOCOBO_COMPANION)
        elseif item == xi.item.RED_RAPTOR_NOTEBOOK then -- Key Items, Items, and Mount IDs don't line up for 4 mounts starting with Red Raptor
            player:setLocalVar('FullSpeedAheadReward', xi.ki.TIGER_COMPANION + mount + 3)
            player:startEvent(10227, item, xi.ki.TRAINERS_WHISTLE, xi.mount.TIGER + mount + 2)
        elseif
            item >= xi.item.GOLDEN_BOMB_NOTEBOOK and
            item <= xi.item.WIVRE_NOTEBOOK
        then
            -- These are all offset by one due to Red Raptor
            player:setLocalVar('FullSpeedAheadReward', xi.ki.TIGER_COMPANION + mount - 1)
            player:startEvent(10227, item, xi.ki.TRAINERS_WHISTLE, xi.mount.TIGER + mount - 2)
        elseif mount >= xi.mount.CHOCOBO and mount <= xi.mount.MOUNT_MAX then
            player:setLocalVar('FullSpeedAheadReward', xi.ki.TIGER_COMPANION + mount)
            player:startEvent(10227, item, xi.ki.TRAINERS_WHISTLE, xi.mount.TIGER + mount - 1)
        end
    end
end

entity.onTrigger = function(player, npc)
    local fsaQuest = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.FULL_SPEED_AHEAD)
    local fullSpeedAheadStatus = player:getCharVar('[QUEST]FullSpeedAhead')

    if fsaQuest == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(10226)
    elseif fullSpeedAheadStatus == 4 then -- Complete
        player:startEvent(10225, xi.ki.TRAINERS_WHISTLE, 15533, ID.npc.MAPITOTO)
    elseif fsaQuest == xi.questStatus.QUEST_ACCEPTED then -- Retry
        player:startEvent(10224, 1)
    elseif
        player:hasKeyItem(xi.ki.CHOCOBO_LICENSE) and
        player:getMainLvl() >= 20 and
        player:hasKeyItem(xi.ki.MAP_OF_THE_JEUNO_AREA)
    then
        player:startEvent(10223, 0, 0, 4)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if (csid == 10223 or csid == 10224) and option == 1 then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.FULL_SPEED_AHEAD)
        player:setCharVar('[QUEST]FullSpeedAhead', 1) -- Flag to start minigame
        player:setPos(475, 8.8, -159, 128, 105)
    elseif csid == 10223 and option == 2 then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.FULL_SPEED_AHEAD)
    elseif csid == 10225 then
        -- Complete quest
        player:setCharVar('[QUEST]FullSpeedAhead', 0)
        player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.FULL_SPEED_AHEAD)
        npcUtil.giveKeyItem(player, xi.ki.TRAINERS_WHISTLE)
        npcUtil.giveKeyItem(player, xi.ki.RAPTOR_COMPANION)
    elseif csid == 10227 then
        local rewardKI = player:getLocalVar('FullSpeedAheadReward')
        player:setLocalVar('FullSpeedAheadReward', 0)
        if rewardKI == xi.ki.CHOCOBO_COMPANION then
            -- NOTE: This does not consume the whistle, do not take it!
            -- TODO: Get chocobo visual information from whistle
            -- TODO: player:registerChocobo(info)
        else
            player:tradeComplete()
        end

        npcUtil.giveKeyItem(player, rewardKI)
    end
end

return entity
