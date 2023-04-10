-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5ga (Lever C)
-- !pos 44 -40.561 -54.199 196
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local lever = npc:getID()

    npc:openDoor(2) -- Lever animation
    if GetNPCByID(lever - 6):getAnimation() == 9 then
        GetNPCByID(lever - 6):setAnimation(8) --open door C (_5g0)
        GetNPCByID(lever - 5):setAnimation(9) --close door B (_5g1)
        GetNPCByID(lever - 4):setAnimation(9) --close door A (_5g2)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
