-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Palson
-- !pos -372.807 3.999 -536.904 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageText(npc, zones[xi.zone.CHOCOBO_CIRCUIT].text.WELCOME_ADVENTURER, true, 2)
end

return entity
