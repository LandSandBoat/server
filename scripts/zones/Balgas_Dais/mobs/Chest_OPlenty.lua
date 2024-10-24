-----------------------------------
-- Area: Balga's Dais
--  Mob: Chest O'Plenty
-- BCNM: A.M.A.N. Trove (Mars)
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onTrigger = function(player, npc)
    xi.amanTrove.chestOPlentyOnTrigger(player, npc)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
