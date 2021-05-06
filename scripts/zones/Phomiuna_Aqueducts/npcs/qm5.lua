-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm5 (???)
-- Notes: Opens door @ F-8 from behind
-- !pos -65.512 -25.262 62.918 27
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local xPos = player:getXPos()
    local DoorOffset = npc:getID() - 1

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        if (xPos <= -65) then
            GetNPCByID(DoorOffset):openDoor(15) -- _0rk
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
