-----------------------------------
-- Area: Talacca_Cove
--  NPC: ??? (corsair job flag quest)
--
-----------------------------------
local ID = require("scripts/zones/Talacca_Cove/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    LuckOfTheDraw = player:getCharVar("LuckOfTheDraw")

    if (LuckOfTheDraw ==3) then
        player:startEvent(2)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 2) then
        player:setCharVar("LuckOfTheDraw", 4)
        player:addKeyItem(tpz.ki.FORGOTTEN_HEXAGUN)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.FORGOTTEN_HEXAGUN)
    end

end
