-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5gb (Lever B)
-- !pos 19.999 -40.561 -54.198 196
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    --local nID = npc:getID()
    -- printf("id: %u", nID)

    local Lever = npc:getID()

    npc:openDoor(2) -- Lever animation
    if (GetNPCByID(Lever-6):getAnimation() == 9) then
        GetNPCByID(Lever-7):setAnimation(9)--close door C
        GetNPCByID(Lever-6):setAnimation(8)--open door B
        GetNPCByID(Lever-5):setAnimation(9)--close door A
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
