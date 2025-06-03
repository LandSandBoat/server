-----------------------------------
-- Area: Windurst Waters
--  NPC: Moari-Kaaori
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local sayFlowers = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)
    local flowerProgress = player:getCharVar('FLOWER_PROGRESS')
    local offer = trade:getItemId()

    if flowerProgress == 3 then
        if
            trade:hasItemQty(xi.item.TAHRONGI_CACTUS, 1) and
            trade:getItemCount() == 1
        then
            if sayFlowers == xi.questStatus.QUEST_COMPLETED then
                player:startEvent(525, xi.settings.main.GIL_RATE * 400)
            else
                player:startEvent(520)
            end
        elseif
            offer == 941 or
            offer == 948 or
            offer == 949 or
            offer == 956 or
            offer == 957 or
            offer == 958
        then
            player:startEvent(522) -- Brought wrong flowers.
        end
    end
end

entity.onTrigger = function(player, npc)
    local sayFlowers = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)
    local flowerProgress = player:getCharVar('FLOWER_PROGRESS')
    local needToZone = player:needToZone()

    if
        sayFlowers == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.WINDURST) >= 2
    then
        player:startEvent(514) -- Begin Say It with Flowers.
    elseif flowerProgress == 3 or flowerProgress == 1 then
        player:startEvent(515) -- Waiting for trade.
    elseif
        sayFlowers == xi.questStatus.QUEST_COMPLETED and
        needToZone and
        flowerProgress == 0
    then -- Must zone to retry quest.
        player:startEvent(521)
    elseif sayFlowers == xi.questStatus.QUEST_COMPLETED and flowerProgress == 0 then
        player:startEvent(523) -- Repeat Say It with Flowers.
    else
        player:startEvent(512)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 514 and option == 1 then
        player:setCharVar('FLOWER_PROGRESS', 1)
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)
    elseif csid == 520 then -- First completion, Iron Sword awarded.
        if player:getFreeSlotsCount() > 0 then
            player:tradeComplete()
            player:addItem(xi.item.IRON_SWORD)
            player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)
            player:addFame(xi.fameArea.WINDURST, 30)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.IRON_SWORD)
            player:setCharVar('FLOWER_PROGRESS', 0)
            player:needToZone(true)
            player:setTitle(xi.title.CUPIDS_FLORIST)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.IRON_SWORD)
        end
    elseif csid == 522 then -- Wrong flowers so complete quest, but smaller reward/fame and no title.
        player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 100)
        player:addFame(xi.fameArea.WINDURST, 10)
        player:needToZone(true)
        player:setCharVar('FLOWER_PROGRESS', 0)
    elseif csid == 523 then
        player:setCharVar('FLOWER_PROGRESS', 1)
    elseif csid == 525 then -- Repeatable quest rewards.
        player:tradeComplete()
        player:addFame(xi.fameArea.WINDURST, 30)
        player:addGil(xi.settings.main.GIL_RATE * 400)
        player:setCharVar('FLOWER_PROGRESS', 0)
        player:needToZone(true)
        player:setTitle(xi.title.CUPIDS_FLORIST)
    end
end

return entity
