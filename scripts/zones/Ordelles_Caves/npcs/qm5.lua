-----------------------------------
-- Area: Ordelles Caves
--  NPC: ??? (qm5)
-- Involved In Quest: Dark Puppet
-- !pos -92 -28 -70 193
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- pop Gerwitz's Sword
    if
        player:getCharVar("darkPuppetCS") >= 3 and
        not player:hasItem(16940) and
        npcUtil.tradeHas(trade, 16681) and
        npcUtil.popFromQM(player, npc, ID.mob.DARK_PUPPET_OFFSET + 1, {hide = 0})
    then
        player:messageSpecial(ID.text.GERWITZS_SWORD_DIALOG)
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
