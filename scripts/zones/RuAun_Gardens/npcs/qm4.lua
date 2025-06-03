-----------------------------------
-- Area: Ru'Aun Gardens
--  NPC: ??? (Suzaku's Spawn)
-- Allows players to spawn the HNM Suzaku with a Gem of the South and a Summerstone.
-- !pos -514 -70 -264 130
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, { xi.item.GEM_OF_THE_SOUTH, xi.item.SUMMERSTONE }) and
        npcUtil.popFromQM(player, npc, ID.mob.SUZAKU)
    then -- Gem of the South and Summerstone
        player:showText(npc, ID.text.SKY_GOD_OFFSET + 7)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SKY_GOD_OFFSET + 3)
end

return entity
