-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5g2 (Door A)
-- !pos -4.001 -42.4 -25.5 196
-----------------------------------
local ID = zones[xi.zone.GUSGEN_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        player:messageSpecial(ID.text.LOCK_OTHER_DEVICE)
    end
end

return entity
