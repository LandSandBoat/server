-----------------------------------
-- Area: Ifrit's Cauldron
--  NPC: qm1 (???)
-- Notes: Used to spawn Tarasque
-- !pos 126 18 166 205
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.RATTLING_EGG) and
        npcUtil.popFromQM(player, npc, ID.mob.TARASQUE, { claim = false, look = true })
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.EGGSHELLS_LIE_SCATTERED)
end

return entity
