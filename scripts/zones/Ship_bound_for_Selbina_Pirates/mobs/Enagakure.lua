-----------------------------------
-- Area: Ship bound for Selbina Pirates
--  Mob: Enagakure
-- Involved in Quest: I'll Take the Big Box
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 600)
    mob:addImmunity(xi.immunity.PARALYZE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.BIND_RES_RANK, 4)
    mob:setMod(xi.mod.BLIND_RES_RANK, 4)
    mob:setMod(xi.mod.DARK_RES_RANK, 4)
    mob:setMod(xi.mod.ICE_RES_RANK, 4)
end

entity.onMobDeath = function(mob, player, optParams)
    if
        player:hasKeyItem(xi.ki.SEANCE_STAFF) and
        player:getCharVar('Enagakure_Killed') == 0
    then
        player:setCharVar('Enagakure_Killed', 1)
    end
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('despawnDay', VanadielUniqueDay())
end

return entity
