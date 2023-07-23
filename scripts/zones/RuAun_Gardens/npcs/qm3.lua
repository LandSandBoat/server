-----------------------------------
-- Area: Ru'Aun Gardens
--  NPC: ??? (Byakko's Spawn)
-- Allows players to spawn the HNM Byakko with a Gem of the West and an Autumnstone.
-- !pos -410 -70 394 130
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, { xi.items.GEM_OF_THE_WEST, xi.items.AUTUMNSTONE }) and
        npcUtil.popFromQM(player, npc, ID.mob.BYAKKO)
    then -- Gem of the West and Autumnstone
        player:showText(npc, ID.text.SKY_GOD_OFFSET + 11)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SKY_GOD_OFFSET + 2)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
