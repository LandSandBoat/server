-----------------------------------
-- Area: Phomiuna Aqueducts
--   NPCqm2 (???)
-- Notes: Open south door @ F-7
-- !pos -75.329 -24.636 92.512 27
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local DoorOffset = npc:getID() - 2

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        GetNPCByID(DoorOffset):openDoor(7) -- _0rf
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
