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
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.STUN)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 78) -- 175 total weapon damage
    mob:addMod(xi.mod.EVA, 30)
    mob:addMod(xi.mod.DEFP, 50)
    mob:addMod(xi.mod.ATTP, 50)

    mob:setSpellList(0) -- If it dies with the ability to cast spells, the next spawn would be able to cast from the start.
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20) -- This gives around 6 - 15 seconds between casts. Doesn't seem to work anywhere except in this function.

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MIGHTY_STRIKES, cooldown = 90, hpp = math.random(85, 95) }, -- 'May use Mighty Strikes multiple times.'
        },
    })

    -- Handle spawn animation
    -- Spawns underwater and surfaces after 3 seconds
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:hideName(true)
    mob:setUntargetable(true)
    mob:setAutoAttackEnabled(false)
    mob:setAnimationSub(5)
    mob:timer(3000, function(mobArg)
        mob:setAnimationSub(6)
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        mob:hideName(false)
        mob:setUntargetable(false)
        mobArg:setAutoAttackEnabled(true)
    end)
end

entity.onMobFight = function(mob, target)
    if
        mob:getLocalVar('SpellTime') < GetSystemTime() and
        mob:getLocalVar('SpellTime') ~= 0
    then
        -- Checks for it being 0 because it gets set to 0 to avoid setting the spell list repeatedly
        mob:setSpellList(0)
        mob:setLocalVar('SpellTime', 0)
    end

    -- Occasionally Uses Aerial Collision or Spine Lash twice in a row with no ready time
    local repeatMove = mob:getLocalVar('repeatMove')
    if
        repeatMove ~= 0 and
        not xi.combat.behavior.isEntityBusy(mob) and
        math.random(100) <= 75 -- High chance to use it again
    then
        mob:useMobAbility(repeatMove, nil, 0)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId = skill:getID()
    if skillId == xi.mobSkill.PLASMA_CHARGE then -- Set spell list for Burst2/Thundaga3 upon using Plasma Charge. Allow for 60 seconds.
        mob:setSpellList(140)
        mob:setLocalVar('SpellTime', GetSystemTime() + 60)
    elseif
        skillId == xi.mobSkill.AERIAL_COLLISION or
        skillId == xi.mobSkill.SPINE_LASH or
        skillId == xi.mobSkill.TIDAL_DIVE
    then
        local repeatMove = mob:getLocalVar('repeatMove')
        if
            repeatMove ~= 0 and
            skillId == repeatMove
        then
            mob:setLocalVar('repeatMove', 0)
        else
            mob:setLocalVar('repeatMove', skillId)
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, { chance = 65, duration = math.random(4, 8) })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
