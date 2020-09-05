-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm1 (???)
-- Notes: Opens east door @ F-7
-- !pos -44.550 -24.601 106.495 27
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local DoorOffset = npc:getID() - 1

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        GetNPCByID(DoorOffset):openDoor(7) -- _0re
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
