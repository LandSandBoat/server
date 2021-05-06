-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm4 (???)
-- Notes: Opens west door @ J-9
-- !pos 92.542 -25.907 26.548 27
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local DoorOffset = npc:getID() - 1

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        GetNPCByID(DoorOffset):openDoor(7) -- _0rj
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
