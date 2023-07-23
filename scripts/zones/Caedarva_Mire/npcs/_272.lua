-----------------------------------
-- Area: Caedarva Mire
-- Door: Runic Seal
-- !pos 486 -23 -500 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/assault")
require("scripts/globals/instance")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not xi.instance.onTrigger(player, npc, xi.zone.LEUJAOAM_SANCTUM) then
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.assault.onAssaultUpdate(player, csid, option, npc)
    xi.instance.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.instance.onEventFinish(player, csid, option, npc)
end

return entity
