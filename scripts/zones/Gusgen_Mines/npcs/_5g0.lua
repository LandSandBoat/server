-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5g0 (Door C)
-- !pos 44 -42.4 -25.5 196
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
