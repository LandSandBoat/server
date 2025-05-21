-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Morjean
-- Involved in Quest: A Squire's Test II (Optional), The Holy Crest
-- !pos 99 0 116 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local theHolyCrest = player:getCharVar('TheHolyCrest_Event')

    if theHolyCrest == 2 then
        player:startEvent(65)
    elseif
        (theHolyCrest == 3 and player:hasItem(xi.item.WYVERN_EGG)) or
        theHolyCrest == 4
    then -- Wyvern Egg
        player:startEvent(62)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 65 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST)
        player:setCharVar('TheHolyCrest_Event', 3)
    elseif csid == 62 and option == 0 then
        player:setCharVar('TheHolyCrest_Event', 4)
    end
end

return entity
