-----------------------------------
-- Area: Jugner Forest [S]
--  NPC: ???
-- !pos 8.54 -11.18 -511 82
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasOnly(trade, xi.item.JAR_OF_GNOLE_PELLETS) and
        npcUtil.popFromQM(player, npc, ID.mob.VULKODLAC, { hide = 0 })
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

return entity
