-----------------------------------
-- Area: Crawlers' Nest
--  NPC: ??? - Guardian Crawler (Spawn area 1)
-- !pos 124.335 -34.609 -75.373 197
-----------------------------------
local ID = zones[xi.zone.CRAWLERS_NEST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.ROLANBERRY) then -- Rolanberry
        player:confirmTrade()
        if
            math.random(1, 100) > 38 or
            not npcUtil.popFromQM(player, npc, ID.mob.AWD_GOGGIE - 6, { claim = true, hide = 0 })
        then
            player:messageSpecial(ID.text.NOTHING_SEEMS_TO_HAPPEN)
        end
    end
end

return entity
