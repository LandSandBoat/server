-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Tiamat
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

-- TODO: Draw in should draw in to slightly in front of where Tiamat is facing

entity.onMobInitialize = function(mob)
    mob:setCarefulPathing(true)
end

entity.onMobSpawn = function(mob)
    mob:setMobSkillAttack(0) -- resetting so it doesn't respawn in flight mode.
    mob:setAnimationSub(0) -- subanim 0 is only used when it spawns until first flight.

    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMod(xi.mod.COUNTER, 10)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addMod(xi.mod.SILENCERESBUILD, 200)
    mob:addMod(xi.mod.SILENCERES, 90)
    mob:setMod(xi.mod.DEF, 459)
    mob:setMod(xi.mod.EVA, 422)
    mob:setMod(xi.mod.VIT, 19)
    mob:setMod(xi.mod.STR, 3)
    mob:setMod(xi.mod.MATT, 0)
    mob:setMod(xi.mod.ATT, 436)
    mob:setMod(xi.mod.REFRESH, 200)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))

    mob:addListener("TAKE_DAMAGE", "TIAMAT_TAKE_DAMAGE", function(defender, amount, attacker, attackType, damageType)
        local damageTaken = defender:getLocalVar("damageTaken") + amount
        if damageTaken > 10000 then
            if
                defender:getAnimationSub() == 1 and
                defender:canUseAbilities()
            then
                defender:useMobAbility(1282)
                defender:setLocalVar("damageTaken", 0)
            elseif
                defender:getAnimationSub() == 2 and
                not defender:hasStatusEffect(xi.effect.MIGHTY_STRIKES) and
                defender:canUseAbilities()
            then
                defender:setAnimationSub(1)
                defender:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
                defender:setMobSkillAttack(730)
                defender:setLocalVar("damageTaken", 0)
            end

            defender:setLocalVar("changeHP", defender:getHP() / 1000)
        end
    end)
end

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar("twohourTime", os.time() + 30)
    mob:setLocalVar("changeTime", os.time() + 30)
end

entity.land = function(mob)
    mob:useMobAbility(1282)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    mob:setLocalVar("changeTime", os.time() + 120)
end

entity.flight = function(mob)
    mob:setAnimationSub(1)
    mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
    mob:setBehaviour(0)
    mob:setMobSkillAttack(730)
    mob:setLocalVar("changeTime", os.time() + 120)
end

entity.onMobFight = function(mob, target)
    -- Wyrms automatically wake from sleep in the air
    if
        (mob:hasStatusEffect(xi.effect.SLEEP_I) or
        mob:hasStatusEffect(xi.effect.SLEEP_II) or
        mob:hasStatusEffect(xi.effect.LULLABY)) and
        mob:getAnimationSub() == 1
    then
        mob:wakeUp()
    end

    local hpp = mob:getHPP()

    -- Gains a large attack boost when health is under 25% which cannot be Dispelled.
    if hpp <= 25 and mob:getLocalVar("appliedAttackBoost") == 0 then
        mob:setMod(xi.mod.ATT, 1200)
        mob:setLocalVar("appliedAttackBoost", 1)
    elseif hpp > 25 and mob:getLocalVar("appliedAttackBoost") == 1 then
        mob:setMod(xi.mod.ATT, 436)
        mob:setLocalVar("appliedAttackBoost", 0)
    end

    -- Gains a delay reduction (from 210 to 160) when health is under 10%
    if hpp <= 10 and mob:getLocalVar("appliedDelayReduction") == 0 then
        mob:addMod(xi.mod.DELAY, 833)
        mob:setLocalVar("appliedDelayReduction", 1)
    elseif hpp > 10 and mob:getLocalVar("appliedDelayReduction") == 1 then
        mob:delMod(xi.mod.DELAY, 833)
        mob:setLocalVar("appliedDelayReduction", 0)
    end

    if
        not mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) and
        mob:actionQueueEmpty()
    then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")

        if
            mob:getAnimationSub() == 2 and
            os.time() > twohourTime
        then -- If mob uses its 2hr
            mob:useMobAbility(688)
            twohourTime = os.time() + math.random(180, 300)
            mob:setLocalVar("twohourTime", twohourTime)
        elseif -- subanimation 2 is grounded mode, so check if she should take off
            (mob:getAnimationSub() == 0 or mob:getAnimationSub() == 2) and
            os.time() > changeTime
        then
            entity.flight(mob)
        elseif
            mob:getAnimationSub() == 1 and
            os.time() > changeTime
        then -- subanimation 1 is flight, so check if she should land
            entity.land(mob)
        end
    end

    if mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) then
        mob:setMobAbilityEnabled(false)
        mob:setMagicCastingEnabled(false)
    else
        mob:setMobAbilityEnabled(true)
        mob:setMagicCastingEnabled(true)
    end

    local drawInTableNorth =
    {
        condition1 = target:getXPos() < -515 and target:getZPos() > 8,
        position   = { -530.642, -4.013, 6.262, target:getRotPos() },
    }
    local drawInTableEast =
    {
        condition1 = target:getXPos() > -480 and target:getZPos() > -50,
        position   = { -481.179, -4, -41.92, target:getRotPos() },
    }

    -- Tiamat draws in from set boundaries leaving her spawn area
    utils.arenaDrawIn(mob, target, drawInTableNorth)
    utils.arenaDrawIn(mob, target, drawInTableEast)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if mob:getAnimationSub() == 1 then
        mob:setLocalVar("skill_tp", mob:getTP())
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Don't lose TP from autos during flight
    if skill:getID() == 1278 then
        mob:addTP(65) -- Needs to gain TP from flight auto attacks
        mob:setLocalVar("skill_tp", 0)
    elseif skill:getID() == 1282 then
        mob:addTP(mob:getLocalVar("skill_tp"))
        mob:setLocalVar("skill_tp", 0)
    end
end

entity.onMobDisengage = function(mob)
    -- Reset Tiamat back to the ground on wipe
    if mob:getAnimationSub() == 1 then
        mob:setAnimationSub(0)
        mob:delStatusEffect(xi.effect.ALL_MISS)
        mob:setMobSkillAttack(0)
        mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
        mob:resetLocalVars()
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE, { chance = 20, power = 100 })
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.TIAMAT_TROUNCER)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

return entity
