-----------------------------------
-- Area: Crawlers' Nest
--  NPC: ??? - Awd Goggie spawn
-- !pos -253.026 -1.867 253.055 197
-----------------------------------
local ID = zones[xi.zone.CRAWLERS_NEST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.ROLANBERRY_864_CE) then -- Rolanberry 864
        player:confirmTrade()
        if
            math.random(1, 100) > 73 or
            not npcUtil.popFromQM(player, npc, ID.mob.AWD_GOGGIE, { claim = true, hide = 0 })
        then
            player:messageSpecial(ID.text.NOTHING_SEEMS_TO_HAPPEN)
        end
    end
end

return entity
