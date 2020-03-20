-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _ir5 (Oil Lamp)
-- Notes: Opens north door at J-9 from inside.
-- !pos 103.703 -26.180 37.000 27
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)

    local DoorOffset = npc:getID() - 1;

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        if (player:getZPos() > 34) then
            npc:openDoor(7); -- lamp animation
            GetNPCByID(DoorOffset):openDoor(7); -- _0ri
        end
    end

end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;
