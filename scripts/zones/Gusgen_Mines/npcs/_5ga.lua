-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5ga (Lever C)
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

            GetNPCByID(lever - 6):setAnimation(8) --open door C (_5g0)
            GetNPCByID(lever - 5):setAnimation(9) --close door B (_5g1)
            GetNPCByID(lever - 4):setAnimation(9) --close door A (_5g2)
        end
    end)
end

return entity
