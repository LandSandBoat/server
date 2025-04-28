-----------------------------------
-- Area: Riverne Site B01
-- Note: Weaker version of Tiamat summoned by Bahamut during The Wyrmking Descends
-----------------------------------
-- mixins =
-- {
--     require('scripts/mixins/families/flying_wyrm'),
-- }
-----------------------------------
---@type TMobEntity
local entity = {}
-- ['Tiamat_Wyrmking'] = { 730, xi.mobSkill.TOUCHDOWN_TIAMAT,      60,  2500, false }, -- BCNM: The Wyrmking Descends.
-- 60 sec ground phase, 30 sec fly phase, 2500 damage force phase change

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.ACC, 361)
    mob:setMod(xi.mod.ATT, 359)
    mob:setMod(xi.mod.COUNTER, 10)
    mob:setMod(xi.mod.DEF, 424)
    mob:setMod(xi.mod.EVA, 367)
    mob:setMod(xi.mod.MATT, 0)
    mob:setMod(xi.mod.REFRESH, 200)
    mob:setMod(xi.mod.REGEN, 22)
    mob:setMod(xi.mod.UDMGMAGIC, -4000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)

    mob:setMod(xi.mod.UFASTCAST, 25)
    mob:setMod(xi.mod.VIT, 12)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 139)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)

    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 45)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 70)
    mob:setMobMod(xi.mobMod.BUFF_CHANCE, 30)
    --mob:addMod(xi.mod.SILENCERESBUILD, 200)
    mob:addMod(xi.mod.SILENCERES, 90)
end

entity.onMobFight = function(mob, target)
    -- Gains a large attack boost when health is under 25% which cannot be dispelled
    if mob:getHPP() < 25 then
        if not mob:hasStatusEffect(xi.effect.ATTACK_BOOST) then
            mob:addStatusEffect(xi.effect.ATTACK_BOOST, 75, 0, 0)
            mob:getStatusEffect(xi.effect.ATTACK_BOOST):setEffectFlags(xi.effectFlag.DEATH)
        end
    -- Deletes effect if regens back up due to a wipe
    else
        if mob:hasStatusEffect(xi.effect.ATTACK_BOOST) then
            mob:delStatusEffect(xi.effect.ATTACK_BOOST)
        end
    end

    if
        mob:getLocalVar('usedTwoHour') == 0 and
        (mob:getAnimationSub() == 0 or
        mob:getAnimationSub() == 2) and
        mob:getHPP() <= 85 and
        mob:canUseAbilities()
    then
        mob:useMobAbility(xi.jsa.MIGHTY_STRIKES)
        mob:setLocalVar('usedTwoHour', 1)
    end

    -- do not use mobskills or magic during 2hr
    if mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) then
        mob:setMobAbilityEnabled(false)
        mob:setMagicCastingEnabled(false)
    else
        mob:setMobAbilityEnabled(true)
        mob:setMagicCastingEnabled(true)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Needs to gain TP from flight auto attacks
    if skill:getID() == 1278 then
        mob:addTP(65)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE, { chance = 20, power = 100 })
end

return entity
