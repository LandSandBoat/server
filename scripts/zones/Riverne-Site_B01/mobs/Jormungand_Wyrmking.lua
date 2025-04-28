-----------------------------------
-- Area: Riverne Site B01
-- Note: Weaker version of Jormungand summoned by Bahamut during The Wyrmking Descends
-----------------------------------
-- mixins =
-- {
--     require('scripts/mixins/families/flying_wyrm'),
-- }
-----------------------------------
---@type TMobEntity
local entity = {}
-- ['Jormungand_Wyrmking'] = { 732, xi.mobSkill.TOUCHDOWN_JORMUNGAND,      60,  2500, false }, -- BCNM: The Wyrmking Descends.
-- 60 sec ground phase, 30 sec fly phase, 2500 damage force phase change

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.ATT, 322)
    mob:setMod(xi.mod.ACC, 358)
    mob:setMod(xi.mod.CURSE_MEVA, 1000)
    mob:setMod(xi.mod.DEF, 384)
    mob:setMod(xi.mod.EVA, 379)
    mob:setMod(xi.mod.MATT, 30)
    mob:setMod(xi.mod.REFRESH, 200)
    mob:setMod(xi.mod.REGEN, 22)
    mob:setMod(xi.mod.UFASTCAST, 60)
    mob:setMod(xi.mod.UDMGMAGIC, -4000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 40)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 146)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 60)
    mob:setMobMod(xi.mobMod.BUFF_CHANCE, 40)
end

entity.onMobFight = function(mob, target)
    if
        mob:getLocalVar('usedTwoHour') == 0 and
        (mob:getAnimationSub() == 0 or
        mob:getAnimationSub() == 2) and
        mob:getHPP() <= 85 and
        mob:canUseAbilities()
    then
        mob:useMobAbility(xi.jsa.BLOOD_WEAPON)
        mob:setLocalVar('usedTwoHour', 1)
    end

    -- do not use mobskills or magic during 2hr
    if mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) then
        mob:setMobAbilityEnabled(false)
        mob:setMagicCastingEnabled(false)
    else
        mob:setMobAbilityEnabled(true)
        mob:setMagicCastingEnabled(true)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Needs to gain TP from flight auto attacks
    if skill:getID() == 1288 then
        mob:addTP(65)
    end

    -- Below 25% Jorm can Horrid Roar 3x
    local roarCount = mob:getLocalVar('roarCount')

    if
        mob:getHPP() <= 25 and
        -- Check for Horrid Roar
        (skill:getID() == 1296 or skill:getID() == 1286) and
        -- if it flies during horrid roar cancel the remainders
        mob:getAnimationSub() ~= 1
    then
        if roarCount < 2 then
            if not target:isBehind(mob, 96) then
                mob:useMobAbility(1286) -- Use Horrid Roar 3
            else
                mob:useMobAbility(1290) -- Use Spike Flail
            end

            mob:setLocalVar('roarCount', roarCount + 1)
        else
            mob:setLocalVar('roarCount', 0) -- Need to reset once 3x roars are done
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENBLIZZARD, { chance = 20, power = 100 })
end

return entity
