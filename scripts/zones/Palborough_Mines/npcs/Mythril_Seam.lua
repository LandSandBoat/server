-----------------------------------
-- Area: Palborough Mines
--  NPC: Mythril Seam
-- Involved In Mission: Journey Abroad
-- Involved in quest: Rock Racketeer
-- !pos -68 -7 173 143
-- Rock Racketeer !pos 210 -32 -63 143
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.items.PICKAXE) then -- pickaxe
        if player:getFreeSlotsCount() > 0 then
            if math.random() < 0.47 then
                if player:getCharVar("rockracketeer_sold") == 5 then
                    player:startEvent(51, 12, xi.items.SHARP_STONE) -- Sharp Stone
                else
                    player:startEvent(43, 12, 0, xi.items.CHUNK_OF_MINE_GRAVEL) -- Mine Gravel
                end
            else
                player:startEvent(47, 8, xi.items.SHARP_STONE) -- pickaxe breaks
            end
        else
            player:startEvent(53) -- cannot carry any more
        end
    else
        player:startEvent(32) -- need a pickaxe
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(30, 12, 0, xi.items.CHUNK_OF_MINE_GRAVEL)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 51 and npcUtil.giveItem(player, xi.items.SHARP_STONE) then
        player:confirmTrade()
    elseif csid == 43 and npcUtil.giveItem(player, xi.items.CHUNK_OF_MINE_GRAVEL) then
        player:confirmTrade()
    elseif csid == 47 then
        player:confirmTrade()
    end
end

return entity
