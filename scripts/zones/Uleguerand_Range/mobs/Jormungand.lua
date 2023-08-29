-----------------------------------
-- Area: Uleguerand Range
--  Mob: Jormungand
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
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.UFASTCAST, 90)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.ATT, 398)
    mob:setMod(xi.mod.DEF, 475)
    mob:setMod(xi.mod.EVA, 434)
    mob:setMod(xi.mod.MATT, 30) -- Jorm has 30 MAB
    mob:setMod(xi.mod.REGEN, 22)
    mob:setMod(xi.mod.REFRESH, 200)
    mob:setMod(xi.mod.DARK_MEVA, 70)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))

    mob:addListener("TAKE_DAMAGE", "JORM_TAKE_DAMAGE", function(defender, amount, attacker, attackType, damageType)
        local damageTaken = defender:getLocalVar("damageTaken") + amount
        if damageTaken > 10000 then
            if defender:getAnimationSub() == 1 and defender:canUseAbilities() then
                defender:useMobAbility(1292)
                defender:setLocalVar("damageTaken", 0)
            elseif
                defender:getAnimationSub() == 2 and
                not defender:hasStatusEffect(xi.effect.BLOOD_WEAPON) and
                defender:canUseAbilities()
            then
                defender:setAnimationSub(1)
                defender:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
                defender:setMobSkillAttack(732)
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
    mob:setLocalVar("changeTime", os.time() + 60)
end

entity.flight = function(mob)
    mob:setAnimationSub(1)
    mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
    mob:setBehaviour(0)
    mob:setMobSkillAttack(732)
    mob:setLocalVar("changeTime", os.time() + 30)
end

entity.onMobFight = function(mob, target)
    -- Wyrms automatically wake from sleep in the air
    if
        mob:getAnimationSub() == 1 and
        (target:hasStatusEffect(xi.effect.SLEEP_I) or
        target:hasStatusEffect(xi.effect.SLEEP_II) or
        target:hasStatusEffect(xi.effect.LULLABY))
    then
        mob:wakeUp()
    end

    -- Handle flight and ground timer
    if
        not mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and
        mob:actionQueueEmpty()
    then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")

        if -- If mob uses its 2hr
            mob:getAnimationSub() == 2 and
            os.time() > twohourTime and
            mob:getHP() <= 85
        then
            mob:useMobAbility(695)
            twohourTime = os.time() + 300
            mob:setLocalVar("twohourTime", twohourTime)
        elseif -- subanimation 2 is grounded mode, so check if she should take off
            (mob:getAnimationSub() == 0 or mob:getAnimationSub() == 2) and
            os.time() > changeTime
        then
            entity.flight(mob)
        -- subanimation 1 is flight, so check if she should land
        elseif mob:getAnimationSub() == 1 and os.time() > changeTime then
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

    local drawInTableNorth =
    {
        condition1 = target:getXPos() < -105 and target:getXPos() > -215 and target:getZPos() > 195,
        position   = { -201.86, -175.66, 189.32, target:getRotPos() },
    }
    local drawInTableSouth =
    {
        condition1 = target:getXPos() > -250 and target:getXPos() < -212 and target:getZPos() < 55,
        position   = { -235.62, -175.17, 62.67, target:getRotPos() },
    }
    local drawInTableEast =
    {
        condition1 = target:getXPos() > -160 and target:getZPos() > 105 and target:getZPos() < 130,
        position   = { -166.02, -175.89, 119.38, target:getRotPos() },
    }

    -- Jorm draws in from set boundaries leaving her spawn area
    utils.arenaDrawIn(mob, target, drawInTableNorth)
    utils.arenaDrawIn(mob, target, drawInTableSouth)
    utils.arenaDrawIn(mob, target, drawInTableEast)
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
    -- Reset Jorm back to the ground on wipe
    if mob:getAnimationSub() == 1 then
        mob:setAnimationSub(0)
        mob:delStatusEffect(xi.effect.ALL_MISS)
        mob:setMobSkillAttack(0)
        mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
        mob:resetLocalVars()
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENBLIZZARD, { chance = 20, power = 100 })
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.WORLD_SERPENT_SLAYER)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

return entity
