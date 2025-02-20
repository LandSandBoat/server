-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Chalvatot
-- Finish Mission "The Crystal Spring"
-- Start & Finishes Quests: Her Majesty's Garden
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -105 0.1 72 233
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local herMajestysGarden = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.HER_MAJESTYS_GARDEN)

    -- HER MAJESTY'S GARDEN (derfland humus)
    if
        herMajestysGarden == xi.questStatus.QUEST_ACCEPTED and
        trade:hasItemQty(xi.item.CHUNK_OF_DERFLAND_HUMUS, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(83)
    end
end

entity.onTrigger = function(player, npc)
    local circleOfTime = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)
    local circleProgress = player:getCharVar('circleTime')
    local lureOfTheWildcat = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT)
    local wildcatSandy = player:getCharVar('WildcatSandy')
    local herMajestysGarden = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.HER_MAJESTYS_GARDEN)

    -- CIRCLE OF TIME (Bard AF3)
    if circleOfTime == xi.questStatus.QUEST_ACCEPTED then
        if circleProgress == 5 then
            player:startEvent(99)
        elseif circleProgress == 6 then
            player:startEvent(98)
        elseif circleProgress == 7 then
            player:startEvent(97)
        elseif circleProgress == 9 then
            player:startEvent(96)
        end

    -- LURE OF THE WILDCAT
    elseif
        lureOfTheWildcat == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 19)
    then
        player:startEvent(561)

    -- HER MAJESTY'S GARDEN
    elseif
        herMajestysGarden == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.SANDORIA) >= 4
    then
        player:startEvent(84)
    elseif herMajestysGarden == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(82)

    -- DEFAULT DIALOG
    else
        player:startEvent(531)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- CIRCLE OF TIME
    if csid == 99 and option == 0 then
        player:setCharVar('circleTime', 6)
    elseif (csid == 98 or csid == 99) and option == 1 then
        player:setCharVar('circleTime', 7)
        npcUtil.giveKeyItem(player, xi.ki.MOON_RING)
    elseif csid == 96 then
        if npcUtil.giveItem(player, xi.item.CHORAL_JUSTAUCORPS) then
            player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)
            player:addTitle(xi.title.PARAGON_OF_BARD_EXCELLENCE)
            player:setCharVar('circleTime', 0)
        end
    -- LURE OF THE WILDCAT
    elseif csid == 561 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 19, true))
    -- HER MAJESTY'S GARDEN
    elseif csid == 84 and option == 1 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.HER_MAJESTYS_GARDEN)
    elseif csid == 83 then
        player:tradeComplete()
        npcUtil.giveKeyItem(player, xi.ki.MAP_OF_THE_NORTHLANDS_AREA)
        player:addFame(xi.fameArea.SANDORIA, 30)
        player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.HER_MAJESTYS_GARDEN)
    end
end

return entity
