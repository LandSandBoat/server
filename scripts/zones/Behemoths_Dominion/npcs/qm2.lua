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

function onSpawn(npc)
    if LandKingSystem_NQ < 1 and LandKingSystem_HQ < 1 then
        npc:setStatus(tpz.status.DISAPPEAR)
    end
end

function onTrade(player, npc, trade)
    if not GetMobByID(ID.mob.BEHEMOTH):isSpawned() and not GetMobByID(ID.mob.KING_BEHEMOTH):isSpawned() then
        if LandKingSystem_NQ ~= 0 and npcUtil.tradeHas(trade, 3341) and npcUtil.popFromQM(player, npc, ID.mob.BEHEMOTH) then
            player:confirmTrade()
        elseif LandKingSystem_HQ ~= 0 and npcUtil.tradeHas(trade, 3342) and npcUtil.popFromQM(player, npc, ID.mob.KING_BEHEMOTH) then
            player:confirmTrade()
        end
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.IRREPRESSIBLE_MIGHT)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
