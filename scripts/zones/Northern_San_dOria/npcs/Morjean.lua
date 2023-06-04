-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Morjean
-- Involved in Quest: A Squire's Test II (Optional), The Holy Crest
-- !pos 99 0 116 231
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local theHolyCrest = player:getCharVar("TheHolyCrest_Event")

    if theHolyCrest == 2 then
        player:startEvent(65)
    elseif (theHolyCrest == 3 and player:hasItem(1159)) or theHolyCrest == 4 then -- Wyvern Egg
        player:startEvent(62)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 65 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST)
        player:setCharVar("TheHolyCrest_Event", 3)
    elseif csid == 62 and option == 0 then
        player:setCharVar("TheHolyCrest_Event", 4)
    end
end

return entity
