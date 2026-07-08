-----------------------------------
-- Area: Castle Oztroja
--  NPC: Brass Door
-- Note: Opened by handles _47f to _47i
-- !pos -182 -15 -19 151
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
