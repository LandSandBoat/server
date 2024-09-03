-----------------------------------
-- Area: Windurst Woods
--  NPC: Perih Vashai
-- Starts and Finishes Quest: The Fanged One, From Saplings Grow
-- !pos 117 -3 92 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- FIRE AND BRIMSTONE
    if
        player:getCharVar('fireAndBrimstone') == 5 and
        npcUtil.tradeHas(trade, xi.item.OLD_EARRING)
    then
        -- old earring
        player:startEvent(537, 0, 13360)
    end
end

entity.onTrigger = function(player, npc)
    local sinHunting = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.SIN_HUNTING)-- RNG AF1
    local sinHuntingCS = player:getCharVar('sinHunting')
    local fireAndBrimstone = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.FIRE_AND_BRIMSTONE)-- RNG AF2
    local fireAndBrimstoneCS = player:getCharVar('fireAndBrimstone')
    local unbridledPassion = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.UNBRIDLED_PASSION)-- RNG AF3
    local unbridledPassionCS = player:getCharVar('unbridledPassion')
    local lvl = player:getMainLvl()
    local job = player:getMainJob()

    -- SIN HUNTING
    if
        sinHunting == xi.questStatus.QUEST_AVAILABLE and
        job == xi.job.RNG and
        lvl >= xi.settings.main.AF1_QUEST_LEVEL
    then
        player:startEvent(523) -- start RNG AF1
    elseif sinHuntingCS > 0 and sinHuntingCS < 5 then
        player:startEvent(524) -- during quest RNG AF1
    elseif sinHuntingCS == 5 then
        player:startEvent(527) -- complete quest RNG AF1

    -- FIRE AND BRIMSTONE
    elseif
        sinHunting == xi.questStatus.QUEST_COMPLETED and
        job == xi.job.RNG and
        lvl >= xi.settings.main.AF2_QUEST_LEVEL and
        fireAndBrimstone == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(531) -- start RNG AF2
    elseif fireAndBrimstoneCS > 0 and fireAndBrimstoneCS < 4 then
        player:startEvent(532) -- during RNG AF2
    elseif fireAndBrimstoneCS == 4 then
        player:startEvent(535, 0, 13360, xi.item.OLD_EARRING) -- second part RNG AF2
    elseif fireAndBrimstoneCS == 5 then
        player:startEvent(536, 0, 13360, xi.item.OLD_EARRING) -- during second part RNG AF2

    -- UNBRIDLED PASSION
    elseif
        fireAndBrimstone == xi.questStatus.QUEST_COMPLETED and
        job == xi.job.RNG and
        lvl >= xi.settings.main.AF3_QUEST_LEVEL and
        unbridledPassion == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(541, 0, 13360) -- start RNG AF3
    elseif unbridledPassionCS > 0 and unbridledPassionCS < 3 then
        player:startEvent(542)-- during RNG AF3
    elseif unbridledPassionCS < 7 then
        player:startEvent(542)-- during RNG AF3
    elseif unbridledPassionCS == 7 then
        player:startEvent(546, 0, 14099) -- complete RNG AF3
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- SIN HUNTING
    if csid == 523 then -- start quest RNG AF1
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.SIN_HUNTING)
        npcUtil.giveKeyItem(player, xi.ki.CHIEFTAINNESSS_TWINSTONE_EARRING)
        player:setCharVar('sinHunting', 1)
    elseif
        csid == 527 and
        npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.SIN_HUNTING, { item = 17188, var = 'sinHunting' })
    then
        -- complete quest RNG AF1
        player:delKeyItem(xi.ki.CHIEFTAINNESSS_TWINSTONE_EARRING)
        player:delKeyItem(xi.ki.PERCHONDS_ENVELOPE)

    -- FIRE AND BRIMSTONE
    elseif csid == 531 then -- start RNG AF2
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.FIRE_AND_BRIMSTONE)
        player:setCharVar('fireAndBrimstone', 1)
    elseif csid == 535 then -- start second part RNG AF2
        player:setCharVar('fireAndBrimstone', 5)
    elseif
        csid == 537 and
        npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.FIRE_AND_BRIMSTONE, { item = 12518, var = 'fireAndBrimstone' })
    then
        -- complete quest RNG AF2
        player:confirmTrade()

    -- UNBRIDLED PASSION
    elseif csid == 541 then -- start RNG AF3
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.UNBRIDLED_PASSION)
        player:setCharVar('unbridledPassion', 1)
    elseif
        csid == 546 and
        npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.UNBRIDLED_PASSION, { item = 14099, var = 'unbridledPassion' })
    then
        -- complete quest RNG AF3
        player:delKeyItem(xi.ki.KOHS_LETTER)
    end
end

return entity
