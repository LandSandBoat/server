-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5gd (Lever F)
-- !pos 44 -20.56 143.802 196
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    --local nID = npc:getID()
    -- printf("id: %u", nID)

    local Lever = npc:getID()

    npc:openDoor(2) -- Lever animation
    if (GetNPCByID(Lever-6):getAnimation() == 9) then
        GetNPCByID(Lever-6):setAnimation(8)--open door F
        GetNPCByID(Lever-5):setAnimation(9)--close door E
        GetNPCByID(Lever-4):setAnimation(9)--close door D
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
