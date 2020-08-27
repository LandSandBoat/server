-----------------------------------
-- Area: Port San d'Oria
--  NPC: Curio Vendor Moogle
--  Shop NPC
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if not player:hasKeyItem(tpz.ki.RHAPSODY_IN_WHITE) then
        player:startEvent(9600)
    else
        player:startEvent(9601)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 9601 then
        if option >= 1 and option <= 6 then
            local stock = tpz.shop.curioVendorMoogleStock[option]
            tpz.shop.curioVendorMoogle(player, stock)
        end
    end
end