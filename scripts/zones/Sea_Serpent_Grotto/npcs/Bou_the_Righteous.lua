-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: Bou the Righteous
-- Type: Involved in the "Sahagin Key Quest"
-- !pos -125.029 46.568 -334.778 176
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(108)
    player:setCharVar('SahaginKeyProgress', 2)
end

return entity
