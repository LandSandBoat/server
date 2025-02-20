-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  NPC: ??? (Spawn Olla Pequena)
-- !pos 851 0.1 92 178
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:hasItemQty(xi.item.FLASK_OF_ROMAEVE_SPRING_WATER, 1) and
        trade:getItemCount() == 1
    then
        for i = ID.mob.OLLAS_OFFSET, ID.mob.OLLAS_OFFSET + 2 do
            if GetMobByID(i):isSpawned() then
                return
            end
        end

        player:tradeComplete()
        SpawnMob(ID.mob.OLLAS_OFFSET):updateClaim(player)
        npc:setStatus(xi.status.DISAPPEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SMALL_HOLE_HERE)
end

return entity
