-----------------------------------
-- Area: Valley of Sorrows
--  NPC: qm1 (???)
-- Spawns Adamantoise or Aspidochelone
-- !pos 0 0 -37 59
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onSpawn(npc)
    if LandKingSystem_NQ < 1 and LandKingSystem_HQ < 1 then
        npc:setStatus(tpz.status.DISAPPEAR)
    end
end

function onTrade(player, npc, trade)
    if not GetMobByID(ID.mob.ADAMANTOISE):isSpawned() and not GetMobByID(ID.mob.ASPIDOCHELONE):isSpawned() then
        if LandKingSystem_NQ ~= 0 and npcUtil.tradeHas(trade, 3343) and npcUtil.popFromQM(player, npc, ID.mob.ADAMANTOISE) then
            player:confirmTrade()
        elseif LandKingSystem_HQ ~= 0 and npcUtil.tradeHas(trade, 3344) and npcUtil.popFromQM(player, npc, ID.mob.ASPIDOCHELONE) then
            player:confirmTrade()
        end
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
