-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Maloquedil
-- Involved in Quest : Warding Vampires, Riding on the Clouds, Lure of the Wildcat (San d'Oria)
-- !pos 35 0.1 60 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES) ~= xi.questStatus.QUEST_AVAILABLE then
        if
            trade:hasItemQty(xi.item.BULB_OF_SHAMAN_GARLIC, 2) and
            trade:getItemCount() == 2
        then
            player:startEvent(23)
        end
    end
end

entity.onTrigger = function(player, npc)
    local warding = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES)
    local wildcatSandy = player:getCharVar('WildcatSandy')

    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 7)
    then
        player:startEvent(807)
    elseif
        warding == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.SANDORIA) >= 3
    then
        -- Quest available for fame superior or equal to 3
        player:startEvent(24)
    elseif warding == xi.questStatus.QUEST_ACCEPTED then --Quest accepted, and he just tell me where to get item.
        player:startEvent(22)
    elseif warding == xi.questStatus.QUEST_COMPLETED then --Since the quest is repeatable, he tells me where to find (again) the items.
        player:startEvent(22)
    else
        player:startEvent(21)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 24 and option == 1 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES)
    elseif csid == 23 then
        player:tradeComplete()
        player:addTitle(xi.title.VAMPIRE_HUNTER_D_MINUS)
        npcUtil.giveCurrency(player, 'gil', 900)
        if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES) == xi.questStatus.QUEST_ACCEPTED then
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES)
        else
            player:addFame(xi.fameArea.SANDORIA, 5)
        end
    elseif csid == 807 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 7, true))
    end
end

return entity
