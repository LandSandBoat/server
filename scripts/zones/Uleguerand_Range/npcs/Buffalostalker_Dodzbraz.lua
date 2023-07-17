-----------------------------------
-- Area: Uleguerand Range
-- NPC: Buffalostalker Dodzbraz
-- Type: Quest NPC
-- Quest: Bombs Away! (96)
-- !pos -380.171 -24.89 -180.797 5
-- !additem 1667 (Cluster Core)
-- !additem 5267 (Shumeyo Salt)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, { { xi.items.CLUSTER_CORE, 2 } }) then -- Cluster Core x2
        player:startEvent(8, 1667)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(6, 1667)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 8 then
        npcUtil.giveItem(player, xi.items.CHUNK_OF_SHUMEYO_SALT) -- Chunk of Shumeyo Salt
        player:confirmTrade()
    end
end

return entity