-----------------------------------
-- Area: Port San d'Oria
--  NPC: Nogelle
-- Starts Lufet's Lake Salt
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LUFETS_LAKE_SALT) == xi.questStatus.QUEST_ACCEPTED then
        if
            trade:hasItemQty(xi.item.CHUNK_OF_LUFET_SALT, 3) and
            trade:getItemCount() == 3
        then
            player:startEvent(11)
        end
    end
end

entity.onTrigger = function(player, npc)
    local lufetsLakeSalt = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LUFETS_LAKE_SALT)

    if lufetsLakeSalt == 0 then
        player:startEvent(12)
    elseif lufetsLakeSalt == 1 then
        player:startEvent(10)
    elseif lufetsLakeSalt == 2 then
        player:startEvent(522)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 12 and option == 1 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.LUFETS_LAKE_SALT)
    elseif csid == 11 then
        player:tradeComplete()
        player:addFame(xi.fameArea.SANDORIA, 30)
        player:addTitle(xi.title.BEAN_CUISINE_SALTER)
        npcUtil.giveCurrency(player, 'gil', 600)
        player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.LUFETS_LAKE_SALT)
    end
end

return entity
