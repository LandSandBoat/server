-----------------------------------
-- Area: Phomiuna Aqueducts
--   NPC: qm3 (???)
-- Notes: Opens north door @ J-9
-- !pos 116.743 -24.636 27.518 27
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local DoorOffset = npc:getID() - 2

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        GetNPCByID(DoorOffset):openDoor(7) -- _0ri
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
