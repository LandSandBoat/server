-----------------------------------
-- Area: Ranguemont Pass
--  NPC: Myffore
-- Type: NPC
-- !pos -179.951 4 -172.234 166
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(1)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    if (csid == 1 and option == 0) then
        local DoorID = npc:getID()+1
        GetNPCByID(DoorID):openDoor(10)
    end
end
