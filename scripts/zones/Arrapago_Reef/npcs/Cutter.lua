-----------------------------------
-- Area: Arrapago Reef
--  NPC: Cutter
-- The ship for The Black Coffin Battle (TOAU-15)
-- !pos -462 -2 -394 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/instance")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not xi.instance.onTrigger(player, npc, xi.zone.THE_ASHU_TALIF) then
        player:messageSpecial(ID.text.YOU_NO_REQS)
    end
end

entity.onEventUpdate = function(player, csid, option, target)
    xi.instance.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.instance.onEventFinish(player, csid, option)
end

return entity
