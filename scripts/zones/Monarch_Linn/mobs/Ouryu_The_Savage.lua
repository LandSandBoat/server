-----------------------------------
-- Area: Monarch Linn
--  Mob: Ouryu
-----------------------------------
mixins =
{
    require('scripts/mixins/families/flying_wyrm'),
    require('scripts/mixins/job_special')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGRANGE, -3500)
    mob:setMod(xi.mod.UDMGMAGIC, -3500)
    mob:setMod(xi.mod.UFASTCAST, 50)

    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 14) -- 54 + 2 + 14 = 70 total damage (the 14 dmg accounts for a 25% boost)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)

    -- can use invincible on ground or air
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.INVINCIBLE, hpp = math.random(50, 85) },
        },
    })
end

entity.onMobFight = function(mob, target)
    local battlefield = mob:getBattlefield()
    if
        battlefield and
        battlefield:getID() == xi.battlefield.id.SAVAGE and
        mob:getHPP() < 30
    then
        battlefield:win()
        return
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE, { chance = 15 })
end

return entity
