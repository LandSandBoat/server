-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5g5 (Door D)
-- !pos -4.001 -22.4 174.498 196
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
