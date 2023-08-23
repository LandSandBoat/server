-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Granite Door
-- !pos 340 0.1 329 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require('scripts/globals/items')
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.items.CURSED_KEY) and
        player:getZPos() < 332
    then
        -- Cursed Key
        player:confirmTrade()
        player:messageSpecial(ID.text.YOUR_KEY_BREAKS, 0, xi.items.CURSED_KEY)
        player:startEvent(25)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() < 332 then
        player:messageSpecial(ID.text.DOOR_LOCKED)
    else
        player:startEvent(26)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
