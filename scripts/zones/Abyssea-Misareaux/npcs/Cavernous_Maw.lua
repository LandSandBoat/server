-----------------------------------
-- Area: Abyssea - Misareaux
--  NPC: Cavernous Maw
-- !pos 676.070, -16.063, 318.999 216
-- Teleports Players to Valkrum Dunes
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(200)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 200 and option ==1 then
        player:setPos(362, 0.001, -119, 4, 103)
    end
end
