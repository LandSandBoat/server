-----------------------------------
-- Area: Promyvion Dem
--  NPC: ??? (map acquisition)
-- TODO: QM moves every 20-30 minutes. need retail cap of all possible positions
-- known positions include:
-- !pos 319.996 -2.330 -80.000 18
-- !pos 159.998 -2.327 0.000 18
-----------------------------------
local ID = require("scripts/zones/Promyvion-Dem/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    -- TODO: The sphere is emitting an erie green glow. occurred when in posession of item, but not
    -- with map, with map received nothing out of the ordinary.  Assumption: Glow is present until obtaining.
end

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 1721) and
        not player:hasKeyItem(xi.ki.MAP_OF_PROMYVION_DEM)
    then
        player:startEvent(49)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 49 then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, xi.ki.MAP_OF_PROMYVION_DEM)
    end
end

return entity
