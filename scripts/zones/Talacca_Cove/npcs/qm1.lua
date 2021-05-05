-----------------------------------
-- Area: Talacca_Cove
--  NPC: ??? (corsair job flag quest)
-----------------------------------
local ID = require("scripts/zones/Talacca_Cove/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    LuckOfTheDraw = player:getCharVar("LuckOfTheDraw")

    if (LuckOfTheDraw ==3) then
        player:startEvent(2)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 2) then
        player:setCharVar("LuckOfTheDraw", 4)
        player:addKeyItem(xi.ki.FORGOTTEN_HEXAGUN)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.FORGOTTEN_HEXAGUN)
    end

end

return entity
