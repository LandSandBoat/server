-----------------------------------
-- Area: Phomiuna Aqueducts
--   NPC: qm4 (???)
-- Notes: Opens west door @ J-9
-- !pos 92.542 -25.907 26.548 27
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local DoorOffset = npc:getID() - 1

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        GetNPCByID(DoorOffset):openDoor(7) -- _0rj
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
