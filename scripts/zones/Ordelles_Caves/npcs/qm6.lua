-----------------------------------
-- Area: Ordelles Caves
--  NPC: ??? (qm6)
-- Involved In Quest: Dark Puppet
-- !pos -132 -27 -245 193
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- pop Gerwitz's Soul
    if
        player:getCharVar("darkPuppetCS") >= 4 and
        npcUtil.tradeHas(trade, 16940) and
        npcUtil.popFromQM(player, npc, ID.mob.DARK_PUPPET_OFFSET + 2, {hide = 0})
    then
        player:messageSpecial(ID.text.GERWITZS_SOUL_DIALOG)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
