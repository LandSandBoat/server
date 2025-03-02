-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Olbergieut
-- !pos 91 0 121 231
-- Starts and Finishes Quest: Gates of Paradise
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local gates = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.GATES_TO_PARADISE)

    if player:hasKeyItem(xi.ki.SCRIPTURE_OF_WATER) then
        player:startEvent(620)
    elseif gates == xi.questStatus.QUEST_ACCEPTED then
        player:showText(npc, ID.text.OLBERGIEUT_DIALOG, xi.ki.SCRIPTURE_OF_WIND)
    elseif
        player:getFameLevel(xi.fameArea.SANDORIA) >= 2 and
        gates == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(619)
    else
        player:startEvent(612)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 619 and option == 0 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.GATES_TO_PARADISE)
        npcUtil.giveKeyItem(player, xi.ki.SCRIPTURE_OF_WIND)
    elseif csid == 620 then
        if npcUtil.giveItem(player, xi.item.COTTON_CAPE) then
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.GATES_TO_PARADISE)
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:addTitle(xi.title.THE_PIOUS_ONE)
            player:delKeyItem(xi.ki.SCRIPTURE_OF_WATER)
        end
    end
end

return entity
