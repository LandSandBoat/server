-----------------------------------
-- Area: Pashhow_Marshlands(S)
--  NPC: ??? (Kinepikwa)
-- Allow player to spawn Kinepikwa with Peiste pellets
-----------------------------------
local ID = zones[xi.zone.PASHHOW_MARSHLANDS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.JAR_OF_PEISTE_PELLETS) and
        npcUtil.popFromQM(player, npc, ID.mob.KINEPIKWA, { hide = 0 })
    then
        player:confirmTrade()
    end
end

return entity
