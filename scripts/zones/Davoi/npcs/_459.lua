-----------------------------------
-- Area: Davoi
--  NPC: Wall of Dark Arts
-- Involved in Mission: Magicite
-- !pos -22 1 -66 149
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.CREST_OF_DAVOI) then
        player:startEvent(54) -- TODO: Check if this should be a cutscene that can be Event Skipped
    end
end

return entity
