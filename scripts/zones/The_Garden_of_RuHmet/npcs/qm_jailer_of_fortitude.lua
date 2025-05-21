-----------------------------------
-- Area: The_Garden_of_RuHmet
--  NPC: qm_jailer_of_fortitude (???)
-- Note: Spawn Jailer of Fortitude by trading 12 Ghrah M Chips
-- North / Hume tower  !pos -420 0 755 35
-- NE / Elvaan tower   !pos -43 0 460 35
-- SE / Galka tower    !pos -260 0 44 35
-- SW / Tarutaru tower !pos -580 0 43 35
-- NW / Mithra tower   !pos -796 0 460 35
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, { { 1872, 12 } }) and -- 12x Ghrah M Chips
        npcUtil.popFromQM(player, npc, { ID.mob.JAILER_OF_FORTITUDE, ID.mob.KFGHRAH_WHM, ID.mob.KFGHRAH_BLM }, { radius = 1 })
    then
        player:confirmTrade()
    end
end

return entity
