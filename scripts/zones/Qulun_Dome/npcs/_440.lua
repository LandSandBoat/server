-----------------------------------
-- Area: Qulun Dome
--  NPC: Door
-- Involved in Mission: Magicite
-- !pos 60 24 -2 148
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Qulun_Dome/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:hasKeyItem(tpz.ki.SILVER_BELL) and player:hasKeyItem(tpz.ki.CORUSCANT_ROSARY) and player:hasKeyItem(tpz.ki.BLACK_MATINEE_NECKLACE)) then
        if (player:getZPos() < -7.2) then
            player:startEvent(51)
        else
            player:startEvent(50)
        end
    else
        player:messageSpecial(ID.text.IT_SEEMS_TO_BE_LOCKED_BY_POWERFUL_MAGIC)
    end

    return 1

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if ((csid == 50 or csid == 51) and option == 1) then
        player:messageSpecial(ID.text.THE_3_ITEMS_GLOW_FAINTLY, tpz.ki.SILVER_BELL, tpz.ki.CORUSCANT_ROSARY, tpz.ki.BLACK_MATINEE_NECKLACE)
    end

end
