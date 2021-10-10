-----------------------------------
-- Area: Pashhow Marshlands [S] (90)
--  NPC: Corroded Door
-- !pos -385.602 21.970 456.359 90
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands_[S]/IDs")
require("scripts/globals/instance")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not xi.instance.onTrigger(player, npc, xi.zone.RUHOTZ_SILVERMINES) then
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY) -- TODO: confirm this
    end
end

entity.onEventUpdate = function(player, csid, option)
    xi.instance.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.instance.onEventFinish(player, csid, option)
end

return entity
