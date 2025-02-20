-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Belgidiveau
-- Starts and Finishes Quest: Trouble at the Sluice
-- !pos -98 0 69 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local troubleAtTheSluice = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.TROUBLE_AT_THE_SLUICE)
    local hasNeutralizerKI = player:hasKeyItem(xi.ki.NEUTRALIZER)

    if
        troubleAtTheSluice == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.SANDORIA) >= 3
    then
        player:startEvent(57)
    elseif
        troubleAtTheSluice == xi.questStatus.QUEST_ACCEPTED and
        not hasNeutralizerKI
    then
        player:startEvent(55)
    elseif hasNeutralizerKI then
        player:startEvent(56)
    else
        player:startEvent(585)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 57 and option == 0 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.TROUBLE_AT_THE_SLUICE)
        player:setCharVar('troubleAtTheSluiceVar', 1)
    elseif csid == 56 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.HEAVY_AXE) -- Heavy Axe
        else
            player:tradeComplete()
            player:delKeyItem(xi.ki.NEUTRALIZER)
            player:addItem(xi.item.HEAVY_AXE)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.HEAVY_AXE) -- Heavy Axe
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.TROUBLE_AT_THE_SLUICE)
        end
    end
end

return entity
