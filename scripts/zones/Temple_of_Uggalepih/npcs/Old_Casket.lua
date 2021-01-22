-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Old casket
-- Obtaining 'Paintbrush of Souls'
-- !pos 61 0 17 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(tpz.ki.OLD_RUSTY_KEY) then
        player:startEvent(64, tpz.ki.OLD_RUSTY_KEY)
    elseif player:hasKeyItem(tpz.ki.PAINTBRUSH_OF_SOULS) then
        player:messageSpecial(ID.text.NO_REASON_TO_INVESTIGATE)
    else
        player:messageSpecial(ID.text.THE_BOX_IS_LOCKED)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 64 and option == 1 then
        player:delKeyItem(tpz.ki.OLD_RUSTY_KEY)
        player:addKeyItem(tpz.ki.PAINTBRUSH_OF_SOULS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PAINTBRUSH_OF_SOULS)
    end
end

return entity
