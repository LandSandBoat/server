-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Hope
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 60)
    mob:setMod(xi.mod.UFASTCAST, 150)
end

entity.onMobSpawn = function(mob)
    mob:setSpellList(0) -- If it dies with the ability to cast spells, the next spawn would be able to cast from the start.
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20) -- This gives around 6 - 15 seconds between casts. Doesn't seem to work anywhere except in this function.

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MIGHTY_STRIKES, cooldown = 90, hpp = math.random(85, 95) }, -- "May use Mighty Strikes multiple times."
        },
    })
end

entity.onMobFight = function(mob, target)
    if
        mob:getLocalVar('SpellTime') < os.time() and
        mob:getLocalVar('SpellTime') ~= 0
    then
        -- Checks for it being 0 because it gets set to 0 to avoid setting the spell list repeatedly
        mob:setSpellList(0)
        mob:setLocalVar('SpellTime', 0)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1102 then -- Set spell list for Burst2/Thundaga3 upon using Plasma Charge. Allow for 60 seconds.
        mob:setSpellList(140)
        mob:setLocalVar('SpellTime', os.time() + 60)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, { chance = 65, duration = math.random(4, 8) })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
