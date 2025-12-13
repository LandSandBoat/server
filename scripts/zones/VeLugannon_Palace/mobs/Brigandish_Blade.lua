-----------------------------------
-- Area: VeLugannon Palace
--   NM: Brigandish Blade
-----------------------------------
local ID = zones[xi.zone.VELUGANNON_PALACE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:setLocalVar('killable', 0)
    mob:setLocalVar('defaultAttack', mob:getMod(xi.mod.ATT))
end

entity.onMobFight = function(mob, target)
    local killable = mob:getLocalVar('killable')
    -- Gains significantly increased damage as HP decreases.
    local hp = mob:getHPP()
    local power = (100 - hp) * 5

    if
        mob:getHPP() == 1 and
        mob:getMod(xi.mod.UDMGPHYS) == 0 and
        killable == 0
    then
        mob:setMod(xi.mod.UDMGPHYS, -10000)
        mob:setMod(xi.mod.UDMGRANGE, -10000)
        mob:setMod(xi.mod.UDMGMAGIC, -10000)
        mob:setMod(xi.mod.UDMGBREATH, -10000)
    end

    mob:setMod(xi.mod.ATT, mob:getLocalVar('defaultAttack') + power)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TERROR, { chance = 30 })
end

entity.onMobDeath = function(mob, player, optParams)
    GetNPCByID(ID.npc.QM3):setLocalVar('PillarCharged', 1)
end

return entity
