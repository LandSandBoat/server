-----------------------------------
-- Area: Korroloka Tunnel
--  NPC: ??? (qm1) - Morion Worm spawn
-- !pos 254.652 -6.039 20.878 173
-----------------------------------
local ID = zones[xi.zone.KORROLOKA_TUNNEL]
local korrolokaGlobal = require('scripts/zones/Korroloka_Tunnel/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
    korrolokaGlobal.moveMorionWormQM()
end

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.CHUNK_OF_IRON_ORE) and
        npcUtil.popFromQM(player, npc, ID.mob.MORION_WORM, { radius = 1, hide = 0 }) -- set hide to zero, we are manually despawning this
    then
        npc:clearTimerQueue() -- Clear previous 15 minute timer, timer will be reinstated by Morion Worm's script
        player:confirmTrade()
        npc:setStatus(xi.status.DISAPPEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.MORION_WORM_1)
end

return entity
