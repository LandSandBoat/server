-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5gf (Lever C)
-- !pos 44 -40.561 -54.199 196
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    npc:openDoor(2) -- Lever animation

    npc:timer(750, function(npcArg)
        local lever = npcArg:getID()

        if GetNPCByID(lever - 6):getAnimation() == 9 then
            -- send dustcloud animation
            SendEntityVisualPacket(GetNPCByID(lever - 6):getID(), 'kem1')

            GetNPCByID(lever - 8):setAnimation(9) -- close door F
            GetNPCByID(lever - 7):setAnimation(9) -- close door E
            GetNPCByID(lever - 6):setAnimation(8) -- open door D
        end
    end)
end

return entity
