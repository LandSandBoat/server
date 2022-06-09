-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5gd (Lever F)
-- !pos 44 -20.56 143.802 196
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local lever = npc:getID()

    npc:openDoor(2) -- Lever animation
    if GetNPCByID(lever - 6):getAnimation() == 9 then
        GetNPCByID(lever - 6):setAnimation(8) -- open door F
        GetNPCByID(lever - 5):setAnimation(9) -- close door E
        GetNPCByID(lever - 4):setAnimation(9) -- close door D
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
