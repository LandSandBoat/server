-----------------------------------
-- Area: Mount Zhayolm
-- Door: Runic Seal
-- !pos 703 -18 382 61
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/assault")
require("scripts/globals/instance")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not xi.instance.onTrigger(player, npc, xi.zone.LEBROS_CAVERN) then
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventUpdate = function(player, csid, option, target)
    xi.assaultUtil.onAssaultUpdate(player, csid, option)
    xi.instance.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, target)
    xi.instance.onEventFinish(player, csid, option)
end

return entity
