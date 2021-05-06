-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm3 (???)
-- Notes: Opens north door @ J-9
-- !pos 116.743 -24.636 27.518 27
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local DoorOffset = npc:getID() - 2

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        GetNPCByID(DoorOffset):openDoor(7) -- _0ri
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
