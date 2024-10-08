-----------------------------------
-- Area: Aydeewa Subterrane
--  NPC: ??? (Spawn Pandemonium Warden)
-- !pos 200 33 -140 68
-----------------------------------
local ID = zones[xi.zone.AYDEEWA_SUBTERRANE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.PANDEMONIUM_KEY) and
        npcUtil.popFromQM(player, npc, ID.mob.PANDEMONIUM_WARDEN + 1)
    then
        -- Trade Pandemonium Key
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SENSE_OMINOUS_PRESENCE)
end

return entity
