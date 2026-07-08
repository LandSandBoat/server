-----------------------------------
-- Area: Ifrit's Cauldron
--  NPC: qm2 (???)
-- Notes: Used to spawn Bomb Queen
-- !pos 18 20 -104 205
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, { 1186, { 1187, 3 } }) and
        npcUtil.popFromQM(player, npc, ID.mob.BOMB_QUEEN)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

return entity
