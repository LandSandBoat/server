-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5ge (Lever E)
-- !pos 20 -20.561 143.801 196
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local lever = npc:getID()

    npc:openDoor(2) -- Lever animation
    if GetNPCByID(lever - 6):getAnimation() == 9 then
        GetNPCByID(lever - 7):setAnimation(9) -- close door F
        GetNPCByID(lever - 6):setAnimation(8) -- open door E
        GetNPCByID(lever - 5):setAnimation(9) -- close door D
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
