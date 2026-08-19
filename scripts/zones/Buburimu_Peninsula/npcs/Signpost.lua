-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Signpost
-----------------------------------
local ID = zones[xi.zone.BUBURIMU_PENINSULA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.SIGNPOST_OFFSET

    -- First 3 Signpost all say SIGN_1. The next 4 Signposts increment the ID.
    if offset <= 2 then
        player:messageText(npc, ID.text.SIGN_1)
    else
        player:messageText(npc, ID.text.SIGN_1 + offset - 2)
    end
end

return entity
