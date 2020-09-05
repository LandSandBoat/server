-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm10 (???)
-- Notes: Opens south door @ J-7
-- !pos 113.474 -26.000 91.610 27
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local DoorOffset = npc:getID() - 63

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        GetNPCByID(DoorOffset):openDoor(7) -- _0rh
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
