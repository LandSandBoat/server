-----------------------------------
-- Area: Castle Oztroja
--  NPC: _473 (Brass Door)
-- Notes: Opened by Torch Stands near Password #3
-- !pos -43.455 -20.161 20.014 151
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
