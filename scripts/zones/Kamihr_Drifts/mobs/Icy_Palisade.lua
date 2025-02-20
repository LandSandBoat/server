-----------------------------------
-- Area: Kamihr Drifts
-- NPC: Icy Palisade
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.reives.onMobSpawn(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.reives.onMobDeath(mob)
end

return entity
