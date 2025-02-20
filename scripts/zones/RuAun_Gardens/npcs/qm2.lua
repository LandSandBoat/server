-----------------------------------
-- Area: Ru'Aun Gardens
--  NPC: ??? (Seiryu's Spawn)
-- Allows players to spawn the HNM Seiryu with a Gem of the East and a Springstone.
-- !pos 569 -70 -80 130
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, { xi.item.GEM_OF_THE_EAST, xi.item.SPRINGSTONE }) and
        npcUtil.popFromQM(player, npc, ID.mob.SEIRYU)
    then -- Gem of the East and Springstone
        player:showText(npc, ID.text.SKY_GOD_OFFSET + 9)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SKY_GOD_OFFSET + 1)
end

return entity
