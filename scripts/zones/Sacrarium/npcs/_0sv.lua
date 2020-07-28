-----------------------------------
-- Area: Sacrarium
--  NPC: _0sv (Switch)
-- Notes: Opens _0sw (Reliquiarium Gate)
-- !pos 23.447 -1.563 50.941 28
-----------------------------------

function onTrigger(player, npc)

    local DoorID = npc:getID() + 1
    local DoorA = GetNPCByID(DoorID):getAnimation()

    if (player:getZPos() < 52) then
        if (DoorA == 8) then
            npc:openDoor(15) -- Retail tested
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
