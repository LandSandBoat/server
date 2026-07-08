-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Ailbeche
-- Starts and Finishes Quest: Father and Son, Sharpening the Sword, A Boy's Dream (start)
-- !pos 4 -1 24 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getCharVar('aBoysDreamCS') >= 3 then
        if
            npcUtil.tradeHasExactly(trade, xi.item.GIANT_SHELL_BUG) and
            player:getCharVar('aBoysDreamCS') == 3
        then
            player:startEvent(15) -- During Quest "A Boy's Dream" (trading bug) madame ?
        elseif
            npcUtil.tradeHasExactly(trade, xi.item.ODONTOTYRANNUS) and
            player:getCharVar('aBoysDreamCS') == 4
        then
            player:startEvent(47) -- During Quest "A Boy's Dream" (trading odontotyrannus)
        end
    end
end

entity.onTrigger = function(player, npc)
    local aBoysDream   = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_BOYS_DREAM)
    local sharpenStone = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.SHARPENING_THE_SWORD)

    -- Checking levels and jobs for af quest
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()
    local aBoysDreamCS = player:getCharVar('aBoysDreamCS')

    if
        aBoysDream == xi.questStatus.QUEST_AVAILABLE and
        sharpenStone == xi.questStatus.QUEST_COMPLETED and
        mJob == xi.job.PLD and
        mLvl >= 50
    then
        if aBoysDreamCS == 0 then
            player:startEvent(41) -- Start Quest 'A Boy's Dream' (long cs)
        else
            player:startEvent(40) -- Start Quest 'A Boy's Dream' (shot cs)
        end
    elseif aBoysDreamCS == 2 then
        player:startEvent(46) -- During Quest 'A Boy's Dream'
    elseif aBoysDreamCS == 3 then
        player:startEvent(39) -- During Quest 'A Boy's Dream' (after exoroche cs)
    elseif aBoysDreamCS == 4 then
        player:startEvent(60) -- During Quest 'A Boy's Dream' (after trading bug) madame ?
    elseif aBoysDreamCS == 5 then
        player:startEvent(47) -- During Quest 'A Boy's Dream' (after trading odontotyrannus)
    elseif aBoysDreamCS >= 6 then
        player:startEvent(25) -- During Quest 'A Boy's Dream' (after Zaldon CS)
    elseif
        player:hasKeyItem(xi.ki.KNIGHTS_CONFESSION) and
        player:getCharVar('UnderOathCS') == 6
    then
        player:startEvent(59) -- During Quest 'Under Oath' (he's going fishing in Jugner)
    elseif player:getCharVar('UnderOathCS') == 8 then
        player:startEvent(13) -- During Quest 'Under Oath' (After jugner CS)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- "A Boy's Dream"
    if (csid == 41 or csid == 40) and option == 1 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_BOYS_DREAM)
        player:setCharVar('aBoysDreamCS', 2)
    elseif csid == 41 and option == 0 then
        player:setCharVar('aBoysDreamCS', 1)
    elseif csid == 15 and player:getCharVar('aBoysDreamCS') == 3 then
        player:setCharVar('aBoysDreamCS', 4)
    elseif csid == 47 and player:getCharVar('aBoysDreamCS') == 4 then
        player:setCharVar('aBoysDreamCS', 5)
    elseif csid == 25 and player:getCharVar('aBoysDreamCS') == 6 then
        player:setCharVar('aBoysDreamCS', 7)
    elseif csid == 59 then
        player:setCharVar('UnderOathCS', 7)
    end
end

return entity
