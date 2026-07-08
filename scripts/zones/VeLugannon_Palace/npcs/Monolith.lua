-----------------------------------
-- Area: VeLugannon Palace
--  NPC: Monolith
-----------------------------------
local ID = zones[xi.zone.VELUGANNON_PALACE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.Y_LITH_OFFSET
    if offset >= 0 and offset <= 20 then
        local y = (offset <= 8) and xi.anim.OPEN_DOOR or xi.anim.CLOSE_DOOR
        local b = (offset <= 8) and xi.anim.CLOSE_DOOR or xi.anim.OPEN_DOOR

        for i = ID.npc.Y_DOOR_OFFSET, ID.npc.Y_DOOR_OFFSET + 7, 1 do
            GetNPCByID(i):setAnimation(y)
        end  -- yellow doors

        for i = ID.npc.B_DOOR_OFFSET, ID.npc.B_DOOR_OFFSET + 6, 1 do
            GetNPCByID(i):setAnimation(b)
        end  -- blue doors

        for i = ID.npc.Y_LITH_OFFSET -1, ID.npc.Y_LITH_OFFSET + 9, 2 do
            GetNPCByID(i):setAnimation(y)
        end  -- yellow monoliths

        for i = ID.npc.B_LITH_OFFSET -1, ID.npc.B_LITH_OFFSET + 9, 2 do
            GetNPCByID(i):setAnimation(b)
        end  -- blue monoliths
    end
end

return entity
