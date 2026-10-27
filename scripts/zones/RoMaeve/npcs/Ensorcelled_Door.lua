-----------------------------------
-- Area: Ro'Maeve (122)
--  NPC: Ensorcelled Door
-- Type: A Shantotto Ascension door
-- !pos -223.03 -7.8 -104 122
-----------------------------------
local ID = zones[xi.zone.ROMAEVE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageText(npc, ID.text.DOOR_IS_LOCKED)
end

return entity
