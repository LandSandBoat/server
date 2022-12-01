-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Cahaurme
-- Involved in Quest: A Knight's Test, Lost Chick
-- !pos 55.749 -8.601 -29.354 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:hasKeyItem(xi.ki.BOOK_OF_TASKS) and
        not player:hasKeyItem(xi.ki.BOOK_OF_THE_EAST)
    then
        player:startEvent(633)
    else
        player:showText(npc, 7817) -- nothing to report
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 633 then
        player:addKeyItem(xi.ki.BOOK_OF_THE_EAST)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BOOK_OF_THE_EAST)
    end
end

--- for future use
    -- player:startEvent(847) --are you the chicks owner

return entity
