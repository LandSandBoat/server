-----------------------------------
-- Area: Mamook
--  NPC: _1t1 (Mahogany Door)
-- Notes:
--      Red Bell Key Item Door - North Mamook
--      Does not open on retail
--      Instead teleports players to Mamook Incursion Map - https://youtu.be/ndCzoPayc_E?t=3198
-- !pos -60.000, 3.942, 0.000
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageText(npc, ID.text.RED_BELL_LOCKED, false, 6)
end

return entity
