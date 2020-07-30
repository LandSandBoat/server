-----------------------------------
-- Area: Lower Jeuno
--  NPC: Muckvix
-- Involved in Mission: Magicite
-- !pos -26.824 3.601 -137.082 245
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.SILVER_BELL) and not player:hasKeyItem(tpz.ki.YAGUDO_TORCH) then
        if player:getCharVar("YagudoTorchCS") == 1 then
            player:startEvent(184)
        else
            player:startEvent(80)
        end
    else
        player:startEvent(15)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 184 then
        player:addKeyItem(tpz.ki.YAGUDO_TORCH)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.YAGUDO_TORCH)
        player:setCharVar("YagudoTorchCS", 0)
        player:setCharVar("FickblixCS", 1)
    end
end
