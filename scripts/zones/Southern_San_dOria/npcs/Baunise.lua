-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Baunise
-- Involved in Quest: A Knight's Test
-- !pos -55 -8 -32 230
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:hasKeyItem(xi.ki.BOOK_OF_TASKS) and player:hasKeyItem(xi.ki.BOOK_OF_THE_WEST) == false) then
        player:startEvent(634)
    else
        player:showText(npc, 7817)-- nothing to report
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 634) then
        player:addKeyItem(xi.ki.BOOK_OF_THE_WEST)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BOOK_OF_THE_WEST)
    end

end

return entity
