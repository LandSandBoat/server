-----------------------------------
-- Area: Tahrongi Canyon
--  NPC: Signpost
-----------------------------------
local ID = zones[xi.zone.TAHRONGI_CANYON]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local offset = math.floor((npc:getID() - ID.npc.SIGNPOST_OFFSET) / 2)
    player:messageSpecial(ID.text.SIGN_1 + offset)
end

return entity
