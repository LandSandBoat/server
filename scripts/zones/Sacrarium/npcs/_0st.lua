-----------------------------------
-- Area: Sacrarium
--  NPC: _0st (Switch)
-- Notes: Opens _0su (Gate)
-- !pos 103.478 -1.563 50.181 28
-----------------------------------
local ID = zones[xi.zone.SACRARIUM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() < 50 then
        npc:openDoor()
    else
        player:messageSpecial(ID.text.CANNOT_OPEN_SIDE)
    end
end

return entity
