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
    if offset >= 4 or offset <= 6 then
        player:messageSpecial(ID.text.SIGN_1)
    elseif offset >= 0 and offset <= 3 then
        player:messageSpecial(ID.text.SIGN_5 - offset)
    end
end

return entity
