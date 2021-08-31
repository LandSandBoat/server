-----------------------------------
-- Area: Palborough Mines
--  NPC: ???
-- Involved In Quest: The Talekeeper's Truth
-- !pos 15 -31 -94 143
-----------------------------------
local ID = require("scripts/zones/Palborough_Mines/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("theTalekeeperTruthCS") == 3 and npcUtil.popFromQM(player, npc, ID.mob.NI_GHU_NESTFENDER, {hide = 0}) then
        player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
