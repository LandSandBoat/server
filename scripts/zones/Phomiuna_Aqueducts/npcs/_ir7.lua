-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _ir7 (Iron Gate)
-- !pos -70.800 -1.500 60.000 27
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getXPos() >= -70 and npc:getAnimation() == 9) then -- only if they're on the locked side and gate is closed.
        if (trade:hasItemQty(1660, 1) and trade:getItemCount() == 1) then -- Bronze Key
            player:tradeComplete()
            npc:openDoor(15)
        elseif ((trade:hasItemQty(1115, 1) or trade:hasItemQty(1023, 1) or trade:hasItemQty(1022, 1)) and trade:getItemCount() == 1 and player:getMainJob() == tpz.job.THF) then
            -- thief's tool/living key/skeleton key as THF main
            player:tradeComplete()
            npc:openDoor(15)
        end
    end
end

function onTrigger(player, npc)
    if (player:getXPos() <= -71) then
        npc:openDoor(15) -- Retail timed
    elseif (npc:getAnimation() == 9) then -- don't want it to say the door is locked when it's wide open!
        player:messageSpecial(ID.text.DOOR_LOCKED, 1660)
    end
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
