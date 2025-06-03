-----------------------------------
-- Area: Crawlers' Nest
--  NPC: ??? - Drone Crawler (Spawn area 2)
-- !pos -74.939 -2.606 244.139 197
-----------------------------------
local ID = zones[xi.zone.CRAWLERS_NEST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.ROLANBERRY_881_CE) then -- Rolanberry 881
        player:confirmTrade()
        if
            math.random(1, 100) > 50 or
            not npcUtil.popFromQM(player, npc, ID.mob.AWD_GOGGIE - 3, { claim = true, hide = 0 })
        then
            player:messageSpecial(ID.text.NOTHING_SEEMS_TO_HAPPEN)
        end
    end
end

return entity
