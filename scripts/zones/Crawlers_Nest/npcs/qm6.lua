-----------------------------------
-- Area: Crawlers Nest
--  NPC: ??? - Matron Crawler spawn
-- !pos -141.158 -33.689 20.944 197
-----------------------------------
local ID = zones[xi.zone.CRAWLERS_NEST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.ROLANBERRY_874_CE) then -- Rolanberry 874
        player:confirmTrade()
        if
            math.random(1, 100) > 34 or
            not npcUtil.popFromQM(player, npc, ID.mob.AWD_GOGGIE - 1, { claim = true, hide = 0 })
        then
            player:messageSpecial(ID.text.NOTHING_SEEMS_TO_HAPPEN)
        end
    end
end

return entity
