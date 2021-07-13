-----------------------------------
-- Area: Behemoth's Dominion
--  NPC: qm2 (???)
-- Spawns Behemoth or King Behemoth
-- !pos -267 -19 74 127
-----------------------------------
local ID = require("scripts/zones/Behemoths_Dominion/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    if xi.settings.LandKingSystem_NQ < 1 and xi.settings.LandKingSystem_HQ < 1 then
        npc:setStatus(xi.status.DISAPPEAR)
    end
end

entity.onTrade = function(player, npc, trade)
    if not GetMobByID(ID.mob.BEHEMOTH):isSpawned() and not GetMobByID(ID.mob.KING_BEHEMOTH):isSpawned() then
        if xi.settings.LandKingSystem_NQ ~= 0 and npcUtil.tradeHas(trade, 3341) and npcUtil.popFromQM(player, npc, ID.mob.BEHEMOTH) then
            player:confirmTrade()
        elseif xi.settings.LandKingSystem_HQ ~= 0 and npcUtil.tradeHas(trade, 3342) and npcUtil.popFromQM(player, npc, ID.mob.KING_BEHEMOTH) then
            player:confirmTrade()
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.IRREPRESSIBLE_MIGHT)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
