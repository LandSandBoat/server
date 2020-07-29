-----------------------------------
-- Area: Phomiuna Aqueducts
--   NPC: qm6 (???)
-- Notes: Opens door @ J-8 from behind
-- !pos 105.502 -25.262 57.138 27
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local xPos = player:getXPos()
    local DoorOffset = npc:getID() - 1

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        if (xPos > 105) then
            GetNPCByID(DoorOffset):openDoor(7) -- _0rl
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
