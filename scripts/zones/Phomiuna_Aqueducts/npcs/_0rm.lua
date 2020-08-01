-----------------------------------
-- Area: Phomiuna_Aqueducts
-- NPC: Oil Lamp - North (West)
-- Opens Door at F-7 from inside.
-- !pos -63 -26 83
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local DoorOffset = npc:getID() - 1

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        if (player:getZPos() < 84) then
            npc:openDoor(7) -- lamp animation
            GetNPCByID(DoorOffset):openDoor(7) -- _0rf
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
