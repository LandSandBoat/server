-----------------------------------
-- Area: Pso'Xja
--  NPC: _099 (Stone Gate)
-- Notes: Spawns Gargoyle when triggered
-- !pos 250.000 -1.925 -58.399 9
-----------------------------------
require("scripts/zones/PsoXja/globals")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    if ( player:getMainJob() == tpz.job.THF and trade:getItemCount() == 1 and (trade:hasItemQty(1115, 1) or trade:hasItemQty(1023, 1) or trade:hasItemQty(1022, 1)) ) then
        attemptPickLock(player, npc, player:getZPos() <= -59)
    end
end

function onTrigger(player, npc)
    attemptOpenDoor(player, npc, player:getZPos() <= -59)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 26 and option == 1) then
        player:setPos(260, -0.25, -20, 254, 111)
    end
end
