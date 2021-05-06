-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm6 (???)
-- Notes: Opens door @ J-8 from behind
-- !pos 105.502 -25.262 57.138 27
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local xPos = player:getXPos()
    local DoorOffset = npc:getID() - 1

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        if (xPos > 105) then
            GetNPCByID(DoorOffset):openDoor(7) -- _0rl
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
