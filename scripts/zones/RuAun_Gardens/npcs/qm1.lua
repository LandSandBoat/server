-----------------------------------
-- Area: Ru'Aun Gardens
--  NPC: ??? (Genbu's Spawn)
-- Allows players to spawn the HNM Genbu with a Gem of the North and a Winterstone.
-- !pos 257 -70 517 130
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, { xi.item.GEM_OF_THE_NORTH, xi.item.WINTERSTONE }) and
        npcUtil.popFromQM(player, npc, ID.mob.GENBU)
    then -- Gem of the North and Winterstone
        player:showText(npc, ID.text.SKY_GOD_OFFSET + 5)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SKY_GOD_OFFSET)
end

return entity
