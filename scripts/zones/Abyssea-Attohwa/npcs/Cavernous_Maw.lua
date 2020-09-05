-----------------------------------
-- Area: Abyssea - Attohwa
--  NPC: Cavernous Maw
-- !pos -133.197 20.242 -181.658 215
-- Notes: Teleports Players to Buburimu Peninsula
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(200)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 200 and option == 1 then
        player:setPos(-338, -23, 47, 167, 118)
    end
end
