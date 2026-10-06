-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Reinwald
-- !pos -266.373 3.999 -536.712 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageText(npc, zones[xi.zone.CHOCOBO_CIRCUIT].text.WELCOME_ADVENTURER, true, 2)
end

return entity
