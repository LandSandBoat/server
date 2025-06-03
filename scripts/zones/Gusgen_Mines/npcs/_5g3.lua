-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5g3 (Door F)
-- !pos 44 -22.399 174.494 196
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
