-----------------------------------
-- Area: Davoi
--  NPC: Bernal
-- !pos 177 -3 -127 149
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Davoi/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(30)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 42 and option == 0) then
        player:messageSpecial(ID.text.POWER_OF_THE_ORB_ALLOW_PASS)
    end

end

return entity
