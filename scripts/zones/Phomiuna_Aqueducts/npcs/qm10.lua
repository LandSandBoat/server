-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm10 (???)
-- Notes: Opens south door @ J-7
-- !pos 113.474 -26.000 91.610 27
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local DoorOffset = npc:getID() - 63

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        GetNPCByID(DoorOffset):openDoor(7) -- _0rh
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
