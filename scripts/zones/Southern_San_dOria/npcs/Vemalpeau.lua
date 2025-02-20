-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Vemalpeau
-- Involved in Quests: Under Oath
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.UNDER_OATH) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('UnderOathCS') == 0
    then   -- Quest: Under Oath - PLD AF3
        player:startEvent(7) --Under Oath - mentions the boy missing
    elseif
        player:getCharVar('UnderOathCS') == 3 and
        player:hasKeyItem(xi.ki.MIQUES_PAINTBRUSH)
    then
        player:startEvent(5) --Under Oath - upset about the paintbrush
    elseif
        player:getCharVar('UnderOathCS') == 4 and
        player:hasKeyItem(xi.ki.STRANGE_SHEET_OF_PAPER)
    then
        player:startEvent(3) -- Under Oath - mentions commanding officer
    elseif
        player:getCharVar('UnderOathCS') == 9 and
        player:hasKeyItem(xi.ki.KNIGHTS_CONFESSION)
    then
        player:startEvent(2) -- Under Oath - Thanks you and concludes quest
    else
        player:startEvent(1)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 7 then
        player:setCharVar('UnderOathCS', 1)
    elseif csid == 5 then
        player:setCharVar('UnderOathCS', 4)
        player:delKeyItem(xi.ki.MIQUES_PAINTBRUSH)
    elseif csid == 2 then
        player:setCharVar('UnderOathCS', 0)
        player:delKeyItem(xi.ki.KNIGHTS_CONFESSION)
    end
end

return entity
