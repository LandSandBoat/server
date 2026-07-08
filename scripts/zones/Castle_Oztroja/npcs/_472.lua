-----------------------------------
-- Area: Castle Oztroja
--  NPC: Brass Door
-- Notes: Opened by handle near password 1
-- !pos -59 0.5 -28 151
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == xi.anim.CLOSE_DOOR then
        player:messageSpecial(ID.text.ITS_LOCKED)
    end
end

return entity
