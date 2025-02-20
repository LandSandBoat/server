-----------------------------------
-- Area: Gusgen Mines
--  NPC: qm3 (???)
-- Involved In Quest: Healing the Land
-- !pos -168 1 311 196
-----------------------------------
local ID = zones[xi.zone.GUSGEN_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local healingTheLand = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND)

    if
        healingTheLand == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.SEAL_OF_BANISHING)
    then
        player:delKeyItem(xi.ki.SEAL_OF_BANISHING)
        player:messageSpecial(ID.text.FOUND_LOCATION_SEAL, xi.ki.SEAL_OF_BANISHING)
    elseif
        healingTheLand == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.SEAL_OF_BANISHING)
    then
        player:messageSpecial(ID.text.IS_ON_THIS_SEAL, xi.ki.SEAL_OF_BANISHING)
    else
        player:messageSpecial(ID.text.LETTERS_IS_WRITTEN_HERE)
    end
end

return entity
