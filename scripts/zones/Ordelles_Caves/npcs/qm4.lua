-----------------------------------
-- Area: Ordelles Caves
--  NPC: ??? (qm4)
-- Involved In Quest: Dark Puppet
-- !pos -52 27 -85 193
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- pop Gerwitz's Axe
    if
        player:getCharVar("darkPuppetCS") >= 2 and
        not player:hasItem(16681) and
        npcUtil.tradeHas(trade, 654) and
        npcUtil.popFromQM(player, npc, ID.mob.DARK_PUPPET_OFFSET, {hide = 0})
    then
        player:messageSpecial(ID.text.GERWITZS_AXE_DIALOG)
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
