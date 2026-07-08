-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Daggao
-- Involved in Quest: Peace for the Spirit, Lure of the Wildcat (San d'Oria)
-- !pos 89 0 119 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatSandy = player:getCharVar('WildcatSandy')

    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 0)
    then
        player:startEvent(810)
    elseif player:getCharVar('peaceForTheSpiritCS') == 3 then
        player:startEvent(72)
    elseif player:getCharVar('peaceForTheSpiritCS') == 5 then
        player:startEvent(73)
    else
        player:startEvent(60)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 810 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 0, true))
    elseif csid == 72 then
        player:setCharVar('peaceForTheSpiritCS', 4)
    end
end

return entity
