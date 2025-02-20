-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Thierride
-- !pos -124 -2 14 80
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Item 1019 = Lufet Salt
-- Had to use setCharVar because you have to trade Salts one at a time according to the wiki.
-- Lufet Salt can be obtained by killing Crabs in normal West Ronfaure.

entity.onTrade = function(player, npc, trade)
    local lufetSalt = trade:hasItemQty(xi.item.CHUNK_OF_LUFET_SALT, 1)
    local cnt = trade:getItemCount()
    local beansAhoy = player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BEANS_AHOY)

    if lufetSalt and cnt == 1 and beansAhoy == xi.questStatus.QUEST_ACCEPTED then
        if player:getCharVar('BeansAhoy') == 0 then
            player:startEvent(337) -- Traded the Correct Item Dialogue (NOTE: You have to trade the Salts one at according to wiki)
        elseif not player:needToZone() then
            player:startEvent(340) -- Quest Complete Dialogue
        end
    else
        player:startEvent(339) -- Wrong Item Traded
    end
end

entity.onTrigger = function(player, npc)
    local beansAhoy = player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BEANS_AHOY)

    if beansAhoy == xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(334) -- Quest Start
    elseif beansAhoy == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(335) -- Quest Active, NPC Repeats what he says but as normal 'text' instead of cutscene.
    elseif
        beansAhoy == xi.questStatus.QUEST_COMPLETED and
        player:getCharVar('BeansAhoy_ConquestWeek') == 0
    then
        player:startEvent(342)
    elseif beansAhoy == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(341)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 334 then
        player:addQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BEANS_AHOY)
    elseif csid == 337 then
        player:tradeComplete()
        player:setCharVar('BeansAhoy', 1)
        player:needToZone(true)
    elseif csid == 340 or csid == 342 then
        if
            player:hasItem(xi.item.ANGLERS_CASSOULET, 1) or
            player:getFreeSlotsCount() < 1
        then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ANGLERS_CASSOULET)
        else
            player:addItem(xi.item.ANGLERS_CASSOULET, 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.ANGLERS_CASSOULET)
            player:setCharVar('BeansAhoy_ConquestWeek', 1, NextConquestTally())
            if csid == 340 then
                player:completeQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BEANS_AHOY)
                player:setCharVar('BeansAhoy', 0)
                player:tradeComplete()
            end
        end
    end
end

return entity
