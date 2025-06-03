-----------------------------------
-- Area: Castle Oztroja
--  NPC: _m75 (Torch Stand)
-- Notes: Opens door _477 when _m72 to _m75 are lit
-- !pos -139.643 -72.113 -62.682 151
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local brassDoor = GetNPCByID(npc:getID() - 5)

    if
        npc:getAnimation() == xi.anim.CLOSE_DOOR and
        brassDoor and
        brassDoor:getAnimation() == xi.anim.CLOSE_DOOR
    then
        player:startEvent(10)
    else
        player:messageSpecial(ID.text.TORCH_LIT)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if option == 1 then
        local brassDoor = GetNPCByID(ID.npc.BRASS_DOOR_FLOOR_4_H7)
        if
            brassDoor and
            brassDoor:getAnimation() == xi.anim.CLOSE_DOOR
        then
            brassDoor:openDoor(35)

            for i = 2, 5 do
                local torch = GetNPCByID(ID.npc.BRASS_DOOR_FLOOR_4_H7 + i)

                if torch then
                    torch:setAnimation(xi.anim.CLOSE_DOOR)
                    torch:openDoor(39)
                end
            end
        else
            GetNPCByID(ID.npc.BRASS_DOOR_FLOOR_4_H7 + 5):openDoor()
        end
    end
end

return entity
