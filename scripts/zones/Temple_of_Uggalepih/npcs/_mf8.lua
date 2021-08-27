-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: _mf8 (Granite Door)
-- Note: Opens with Prelate Key
-- !pos -11 -8 -99 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 1137) then -- Prelate Key
        player:confirmTrade()
        player:messageSpecial(ID.text.YOUR_KEY_BREAKS, 0, 1137)
        npc:openDoor(6.5)
    end
end

entity.onTrigger = function(player, npc)
    if player:getXPos() <= -8 then
        player:messageSpecial(ID.text.THE_DOOR_IS_LOCKED, 1137)
    else
        npc:openDoor(11) -- retail timed
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
