-----------------------------------
-- Area: Pso'Xja
--  NPC: _090 (Stone Gate)
-- Notes: Spawns Gargoyle when triggered
-- !pos 341.600 -1.925 -50.000 9
-----------------------------------
local psoXjaGlobal = require("scripts/zones/PsoXja/globals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getMainJob() == xi.job.THF and
        trade:getItemCount() == 1 and
        (trade:hasItemQty(1115, 1) or trade:hasItemQty(1023, 1) or trade:hasItemQty(1022, 1))
    then
        psoXjaGlobal.attemptPickLock(player, npc, player:getXPos() <= 341)
    end
end

entity.onTrigger = function(player, npc)
    psoXjaGlobal.attemptOpenDoor(player, npc, player:getXPos() <= 341)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 26 and option == 1 then
        player:setPos(260, -0.25, -20, 254, 111)
    end
end

return entity
