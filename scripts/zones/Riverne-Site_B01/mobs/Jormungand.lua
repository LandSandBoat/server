-----------------------------------
-- Area: Riverne Site B01
-- Note: Weaker version of Jormungand summoned by Bahamut during The Wyrmking Descends
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.land = function(mob)
    -- need to deal with case of stun of touchdown
    mob:useMobAbility(1292)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    mob:setLocalVar("changeTime", mob:getBattleTime() + 60)
    mob:setLocalVar("damageTaken", 0)
end

entity.flight = function(mob)
    mob:setAnimationSub(1)
    mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
    mob:setBehaviour(0)
    mob:setMobSkillAttack(732)
    mob:setLocalVar("changeTime", mob:getBattleTime() + 30)
    mob:setLocalVar("damageTaken", 0)
end

entity.onMobSpawn = function(mob)
    mob:setMobSkillAttack(0) -- resetting so it doesn't respawn in flight mode.
    mob:setAnimationSub(0) -- subanim 0 is only used when it spawns until first flight.

    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 80)
    mob:setMobMod(xi.mobMod.BUFF_CHANCE, 20)
    mob:addMod(xi.mod.SLEEPRES, 100)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.UFASTCAST, 90)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.DEF, 475)
    mob:setMod(xi.mod.EVA, 434)
    mob:setMod(xi.mod.MATT, 0)
    mob:setMod(xi.mod.REGEN, 22)
    mob:setMod(xi.mod.REFRESH, 200)
    mob:setMod(xi.mod.DARK_MEVA, 70)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))

    mob:addListener("TAKE_DAMAGE", "JORM_TAKE_DAMAGE", function(defender, amount, attacker, attackType, damageType)
        local damageTaken = defender:getLocalVar("damageTaken") + amount
        defender:setLocalVar("damageTaken", damageTaken)
        local willKillMob = (defender:getHP() - amount) <= 0
        if damageTaken > 2500 and not willKillMob then
            if
                defender:getAnimationSub() == 1 and
                defender:actionQueueEmpty()
            then
                entity.land(defender)
            elseif
                (defender:getAnimationSub() == 0 or
                defender:getAnimationSub() == 2) and
                not defender:hasStatusEffect(xi.effect.BLOOD_WEAPON) and
                defender:actionQueueEmpty()
            then
                entity.flight(defender)
            end
        end
    end)
end

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar("twohourTime", mob:getBattleTime() + 15)
    mob:setLocalVar("changeTime", mob:getBattleTime() + 60)
end

entity.onMobFight = function(mob, target)
    if
        not mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and
        mob:actionQueueEmpty()
    then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")

        if -- If mob uses its 2hr
            mob:getAnimationSub() == 2 and
            mob:getBattleTime() > twohourTime and
            mob:getHP() <= 85 and
            mob:canUseAbilities()
        then
            mob:useMobAbility(695)
            twohourTime = mob:getBattleTime() + math.random(180, 300)
            mob:setLocalVar("twohourTime", twohourTime)
        elseif -- subanimation 2 is grounded mode, so check if she should take off
            (mob:getAnimationSub() == 0 or mob:getAnimationSub() == 2) and
            mob:getBattleTime() > changeTime
        then
            entity.flight(mob)
        elseif -- subanimation 1 is flight, so check if she should land
            mob:getAnimationSub() == 1 and
            mob:getBattleTime() > changeTime
        then
            entity.land(mob)
        end
    end

    -- Do not use mobskills or magic during 2hr
    if mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) then
        mob:setMobAbilityEnabled(false)
        mob:setMagicCastingEnabled(false)
    else
        mob:setMobAbilityEnabled(true)
        mob:setMagicCastingEnabled(true)
    end

    -- Wyrms automatically wake from sleep in the air
    if
        mob:getAnimationSub() == 1 and
        (target:hasStatusEffect(xi.effect.SLEEP_I) or
        target:hasStatusEffect(xi.effect.SLEEP_II) or
        target:hasStatusEffect(xi.effect.LULLABY))
    then
        mob:wakeUp()
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if mob:getAnimationSub() == 1 then
        mob:setLocalVar("skill_tp", mob:getTP())
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Don't lose TP from autos during flight
    if skill:getID() == 1288 then
        mob:addTP(65) -- Needs to gain TP from flight auto attacks
        mob:setLocalVar("skill_tp", 0)
    elseif skill:getID() == 1292 then
        mob:addTP(mob:getLocalVar("skill_tp"))
        mob:setLocalVar("skill_tp", 0)
    end

    -- Below 25% Jorm can Horrid Roar 3x
    local roarCount = mob:getLocalVar("roarCount")

    if
        mob:getHPP() <= 25 and
        (skill:getID() == 1296 or skill:getID() == 1286) and -- Check for Horrid Roar
        (mob:getAnimationSub() == 0 or mob:getAnimationSub() == 2) -- If it flies during horrid roar cancel the remainders
    then
        if roarCount < 2 then
            if not target:isBehind(mob, 96) then
                mob:useMobAbility(1286) -- Use Horrid Roar 3
            else
                mob:useMobAbility(1290) -- Use Spike Flail
            end

            mob:setLocalVar("roarCount", roarCount + 1)
        else
            mob:setLocalVar("roarCount", 0) -- Need to reset once 3x roars are done
        end
    end
end

entity.onMobDisengage = function(mob)
    -- reset on wipe
    mob:setLocalVar("changeTime", 0)
    mob:setLocalVar("twohourTime", 0)
    mob:setLocalVar("damageTaken", 0)
    if mob:getAnimationSub() == 1 then
        mob:setAnimationSub(0)
        mob:delStatusEffect(xi.effect.ALL_MISS)
        mob:setMobSkillAttack(0)
        mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENBLIZZARD, { chance = 20, power = 100 })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
