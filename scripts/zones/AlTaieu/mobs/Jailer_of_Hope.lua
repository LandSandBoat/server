-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Hope
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    mob:setSpellList(0) -- If it dies with the ability to cast spells, the next spawn would be able to cast from the start.
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20) -- This gives around 6 - 15 seconds between casts. Doesn't seem to work anywhere except in this function.

    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 90, hpp = math.random(85, 95)}, -- "May use Mighty Strikes multiple times."
        },
    })
end

function onMobFight(mob, target)
    if (mob:getLocalVar("SpellTime") < os.time() and mob:getLocalVar("SpellTime") ~= 0) then -- Checks for it being 0 because it gets set to 0 to avoid setting the spell list repeatedly
        mob:setSpellList(0)
        mob:setLocalVar("SpellTime", 0)
    end
end

function onMobWeaponSkill(target, mob, skill)
    if (skill:getID() == 1102) then -- Set spell list for Burst2/Thundaga3 upon using Plasma Charge. Allow for 60 seconds.
        mob:setSpellList(140)
        mob:setLocalVar("SpellTime", os.time() + 60)
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN, {chance = 65, duration = math.random(4, 8)})
end

function onMobDeath(mob, player, isKiller)
end
