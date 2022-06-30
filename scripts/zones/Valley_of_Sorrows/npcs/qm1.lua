-----------------------------------
-- Area: Valley of Sorrows
--  NPC: qm1 (???)
-- Spawns Adamantoise or Aspidochelone
-- !pos 0 0 -37 59
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
require("scripts/globals/npc_util")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    if xi.settings.LandKingSystem_NQ < 1 and xi.settings.LandKingSystem_HQ < 1 then
        npc:setStatus(xi.status.DISAPPEAR)
    end
end

entity.onTrade = function(player, npc, trade)
    if not GetMobByID(ID.mob.ADAMANTOISE):isSpawned() and not GetMobByID(ID.mob.ASPIDOCHELONE):isSpawned() then
        if xi.settings.LandKingSystem_NQ ~= 0 and npcUtil.tradeHas(trade, 3343) and npcUtil.popFromQM(player, npc, ID.mob.ADAMANTOISE) then
            player:confirmTrade()
        elseif xi.settings.LandKingSystem_HQ ~= 0 and npcUtil.tradeHas(trade, 3344) and npcUtil.popFromQM(player, npc, ID.mob.ASPIDOCHELONE) then
            player:confirmTrade()
        end
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
