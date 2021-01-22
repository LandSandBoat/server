-----------------------------------
-- Area: Ifrit's Cauldron
--  NPC: ???
-- Involved in Mission: Bastok 6-2
-- !pos 171 0 -25 205
-----------------------------------
local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Adaman Ore: spawn Salamander and Magma for The Pirate's Cove
    if (
        player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_PIRATE_S_COVE and
        player:getCharVar("MissionStatus") == 2 and
        npcUtil.tradeHas(trade, 646) and
        npcUtil.popFromQM(player, npc, {ID.mob.PIRATES_COVE_NMS, ID.mob.PIRATES_COVE_NMS + 1}, {claim = false})
    ) then
        player:confirmTrade()
        GetMobByID(ID.mob.PIRATES_COVE_NMS):lookAt(player:getPos()) -- Salamander
        GetMobByID(ID.mob.PIRATES_COVE_NMS + 1):updateClaim(player) -- Magma
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
