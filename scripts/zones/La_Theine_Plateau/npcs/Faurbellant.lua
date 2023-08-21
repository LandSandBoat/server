-----------------------------------
-- Area: La Theine Plateau
--  NPC: Faurbellant
-- Type: Quest NPC
-- Involved in Quest: Gates of Paradise
-- !pos 484 24 -89 102
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local gates = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GATES_TO_PARADISE)
    if gates == QUEST_COMPLETED then
        player:showText(npc, ID.text.FAURBELLANT_4)
    elseif gates == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.SCRIPTURE_OF_WIND) then
            player:showText(npc, ID.text.FAURBELLANT_2, 0, xi.ki.SCRIPTURE_OF_WIND)
            player:delKeyItem(xi.ki.SCRIPTURE_OF_WIND)
            player:addKeyItem(xi.ki.SCRIPTURE_OF_WATER)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SCRIPTURE_OF_WATER)
        else
            player:showText(npc, ID.text.FAURBELLANT_3, xi.ki.SCRIPTURE_OF_WATER)
        end
    else
        player:showText(npc, ID.text.FAURBELLANT_1)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
