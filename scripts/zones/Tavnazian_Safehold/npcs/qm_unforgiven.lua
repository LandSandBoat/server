-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: ???
-- Involved in Quest: Unforgiven
-- !pos 110.714 -40.856 -53.154 26
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local unforgiven = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.UNFORGIVEN)

    if
        unforgiven == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.ALABASTER_HAIRPIN)
    then
        npcUtil.giveKeyItem(player, xi.ki.ALABASTER_HAIRPIN) -- ALABASTER HAIRPIN for Unforgiven Quest
    end
end

return entity
