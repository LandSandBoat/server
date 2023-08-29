-----------------------------------
-- Area: Southern San d'Oria
-- NPC : Amaura
-- Involved in Quest: The Medicine Woman, To Cure a Cough
-- !pos -85 -6 89 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local toCureaCough = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TO_CURE_A_COUGH)

    if player:getCharVar('DiaryPage') == 3 or toCureaCough == QUEST_ACCEPTED then
        if
            not player:hasKeyItem(xi.ki.THYME_MOSS) and
            not player:hasKeyItem(xi.ki.COUGH_MEDICINE)
        then
            player:startEvent(645) -- need thyme moss for cough med
        elseif player:hasKeyItem(xi.ki.THYME_MOSS) then
            player:startEvent(646) -- receive cough med for Nenne
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 645 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TO_CURE_A_COUGH)
    elseif csid == 646 then
        player:delKeyItem(xi.ki.THYME_MOSS)
        player:addKeyItem(xi.ki.COUGH_MEDICINE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.COUGH_MEDICINE)
    end
end

return entity
