-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Helbort
--  Starts and Finished Quest: A purchase of Arms
-- !pos 71 -1 65 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getFameLevel(xi.fameArea.SANDORIA) >= 2 and
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.FATHER_AND_SON) == xi.questStatus.QUEST_COMPLETED and
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS) == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(594)  -- Start quest A Purchase of Arms
    elseif
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS) == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.WEAPONS_RECEIPT)
    then
        player:startEvent(607) -- Finish A Purchase of Arms quest
    else
        player:startEvent(593)  -- Standard Dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 594 and option == 0 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS)
        npcUtil.giveKeyItem(player, xi.ki.WEAPONS_ORDER)
    elseif csid == 607 then
        if npcUtil.giveItem(player, xi.item.ELM_STAFF) then
            player:addTitle(xi.title.ARMS_TRADER)
            player:delKeyItem(xi.ki.WEAPONS_RECEIPT)
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS)
        end
    end
end

return entity
