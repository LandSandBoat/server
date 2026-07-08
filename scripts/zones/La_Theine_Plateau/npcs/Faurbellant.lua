-----------------------------------
-- Area: La Theine Plateau
--  NPC: Faurbellant
-- Involved in Quest: Gates of Paradise
-- !pos 484 24 -89 102
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local gates = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.GATES_TO_PARADISE)
    if gates == xi.questStatus.QUEST_COMPLETED then
        player:showText(npc, ID.text.FAURBELLANT_4)
    elseif gates == xi.questStatus.QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.SCRIPTURE_OF_WIND) then
            player:showText(npc, ID.text.FAURBELLANT_2, 0, xi.ki.SCRIPTURE_OF_WIND)
            player:delKeyItem(xi.ki.SCRIPTURE_OF_WIND)
            npcUtil.giveKeyItem(player, xi.ki.SCRIPTURE_OF_WATER)
        else
            player:showText(npc, ID.text.FAURBELLANT_3, xi.ki.SCRIPTURE_OF_WATER)
        end
    else
        player:showText(npc, ID.text.FAURBELLANT_1)
    end
end

return entity
