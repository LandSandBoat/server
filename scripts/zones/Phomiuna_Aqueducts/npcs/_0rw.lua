-----------------------------------
-- Area: Phomiuna_Aqueducts
-- NPC: Oil Lamp - North (East)
-- Opens Door at J-7 from inside.
-- !pos 104 -26 83
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local DoorOffset = npc:getID() - 1

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        if (player:getZPos() < 85) then
            npc:openDoor(7) -- torch animation
            GetNPCByID(DoorOffset):openDoor(7) -- _0rh
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
