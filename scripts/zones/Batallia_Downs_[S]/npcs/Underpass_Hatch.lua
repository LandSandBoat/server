-----------------------------------
-- Area: Batallia Downs (S)
--  NPC: Underpass Gate
-- Type: Entryance to "A Nation on the Brink"
-- !pos  314.083 -1.160 -181.455 84
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs_[S]/IDs")
require("scripts/globals/instance")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not xi.instance.onTrigger(player, npc, xi.zone.EVERBLOOM_HOLLOW) then
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
    xi.instance.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.instance.onEventFinish(player, csid, option)
end

return entity
