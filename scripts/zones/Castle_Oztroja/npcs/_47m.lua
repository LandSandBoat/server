-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47m (Torch Stand)
-- Notes: Opens door _471 near password #2
-- !pos -45.230 -17.832 17.668 151
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local brassDoor = GetNPCByID(npc:getID() - 3)

    if not brassDoor then -- Nil check
        return
    end

    if brassDoor:getAnimation() == xi.anim.OPEN_DOOR then -- Door is already open
        return
    end

    if npc:getAnimation() == xi.anim.OPEN_DOOR then -- Torch is already lit
        return
    end

    if player:hasKeyItem(xi.ki.YAGUDO_TORCH) then
        player:startEvent(10)
    else
        player:messageSpecial(ID.text.UNLIT_TORCH)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local brassDoor = GetNPCByID(ID.npc.THIRD_PASSWORD_STATUE - 2)
    local torch1 = GetNPCByID(ID.npc.THIRD_PASSWORD_STATUE + 1)
    local torch2 = GetNPCByID(ID.npc.THIRD_PASSWORD_STATUE + 2)

    if
        torch1 and
        torch2 and
        brassDoor and
        option == 1
    then
        torch1:openDoor(10)
        torch2:openDoor(10)
        brassDoor:openDoor(6)
    end
end

return entity
