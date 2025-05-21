-----------------------------------
-- Area: Selbina
--  NPC: Vuntar
-- Starts and Finishes Quest: Cargo (R)
-- !pos 7 -2 -15 248
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.CARGO) ~= xi.questStatus.QUEST_AVAILABLE then
        if os.time() > player:getCharVar('VuntarCanBuyItem_date') then
            if npcUtil.tradeHas(trade, xi.item.ROLANBERRY_881_CE) then
                player:startEvent(52, 1) -- Can Buy rolanberry (881 ce)
            elseif npcUtil.tradeHas(trade, xi.item.ROLANBERRY_874_CE) then
                player:startEvent(52, 2) -- Can Buy rolanberry (874 ce)
            elseif npcUtil.tradeHas(trade, xi.item.ROLANBERRY_864_CE) then
                player:startEvent(52, 3) -- Can Buy rolanberry (864 ce)
            end
        else
            player:startEvent(1134, 4365) -- Can't buy rolanberrys
        end
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getMainLvl() >= 20 and
        player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.CARGO) == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(50, 4365) -- Start quest "Cargo"
    elseif player:getMainLvl() < 20 then
        player:startEvent(53) -- Dialog for low level or low fame
    else
        player:startEvent(51, 4365) -- During & after completed quest "Cargo"
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 50 then
        player:addQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.CARGO)
    elseif csid == 52 then
        player:setCharVar('VuntarCanBuyItem_date', getMidnight())

        if player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.CARGO) == xi.questStatus.QUEST_ACCEPTED then
            player:completeQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.CARGO)
            player:addFame(xi.fameArea.SELBINA_RABAO, 30)
        end

        if option == 1 then
            npcUtil.giveCurrency(player, 'gil', 800)
            player:confirmTrade()
        elseif option == 2 then
            npcUtil.giveCurrency(player, 'gil', 2000)
            player:confirmTrade()
        elseif option == 3 then
            npcUtil.giveCurrency(player, 'gil', 3000)
            player:confirmTrade()
        end
    end
end

return entity
