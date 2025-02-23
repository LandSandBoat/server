-----------------------------------
-- Area: Bhaflau Remnants
--  MOB: Chigoe
--  Reactionary Rampart Pet
-----------------------------------
-----------------------------------

---@type TMobEntity
local entity = {}

-- mob takes double dmg
entity.onMobSpawn = function(mob)
    mob:hideName(false)
    mob:setUntargetable(false)
    mob:setMod(xi.mod.UDMGMAGIC, 1000)
    mob:setMod(xi.mod.UDMGPHYS, 100)
    mob:setMod(xi.mod.UDMGRANGE, 100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.DISEASE)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
