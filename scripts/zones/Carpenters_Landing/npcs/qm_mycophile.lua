-----------------------------------
-- Area: Carpenters' Landing (2)
--  NPC: ???
-- Note: Used to spawn Mycophile NM
-- !pos 145.500 -9.000 -699.000 2
-----------------------------------
local ID = zones[xi.zone.CARPENTERS_LANDING]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Sleepshroom, Woozyshroom, Danceshroom
    if
        npcUtil.tradeHas(trade, { 4373, 4374, 4375 }) and
        npcUtil.popFromQM(player, npc, ID.mob.MYCOPHILE)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.MYCOPHILE_MUSHROOM)
end

return entity
