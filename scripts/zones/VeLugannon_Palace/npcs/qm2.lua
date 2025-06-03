-----------------------------------
-- Area: VeLugannon Palace
--  NPC: qm2 (???)
-- Note: Used to spawn Brigandish Blade
-- !pos 0.1 0.1 -286 177
-----------------------------------
local ID = zones[xi.zone.VELUGANNON_PALACE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.CURTANA) and
        npcUtil.popFromQM(player, npc, ID.mob.BRIGANDISH_BLADE)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.EVIL_PRESENCE)
end

return entity
