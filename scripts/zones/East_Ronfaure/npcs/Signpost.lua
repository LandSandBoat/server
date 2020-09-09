-----------------------------------
-- Area: East Ronfaure
--  NPC: Signpost
-- Involved in Quest: To Cure a Cough
-- !pos 257 -45 212 101
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/East_Ronfaure/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local X = player:getXPos()
    local Z = player:getZPos()

    if ((X > 251.6 and X < 263.6) and (Z < 219.7 and Z > 207.7)) then
        if (player:hasKeyItem(tpz.ki.SCROLL_OF_TREASURE) == true) then
            player:startEvent(20)
            player:delKeyItem(tpz.ki.SCROLL_OF_TREASURE)
            player:addGil(GIL_RATE*3000)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*3000)
        else
            player:startEvent(5)
        end
    elseif ((X > 434.9 and X < 446.9) and (Z < 148.4 and Z > 136.4)) then
        player:startEvent(3)
    elseif ((X > 652.2 and X < 664.2) and (Z < 311.5 and Z > 299.5)) then
        player:startEvent(7)
    elseif ((X > 459.2 and X < 471.2) and (Z < -167.4 and Z > -179.4)) then
        player:startEvent(9)
    elseif ((X > 532 and X < 544) and (Z < -378.2 and Z > -390.2)) then
        player:startEvent(11)
    elseif ((X > 273.1 and X < 285.1) and (Z < -251.6 and Z > -263.6)) then
        player:startEvent(13)
    elseif ((X > 290.5 and X < 302.5) and (Z < -451.1 and Z > -463.1)) then
        player:startEvent(15)
    elseif ((X > 225.1 and X < 237.1) and (Z < 68.6 and Z > 56.6)) then
        player:startEvent(17)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
