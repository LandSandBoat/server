-----------------------------------
-- Area: Uleguerand Range
--  Mob: Jormungand
-----------------------------------
require("scripts/globals/status")
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

    mob:setMod(xi.mod.UFASTCAST, 99)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.ATT, 398)
    mob:setMod(xi.mod.DEF, 475)
    mob:setMod(xi.mod.EVA, 434)
    mob:setMod(xi.mod.DARK_MEVA, 70)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 60)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))

    mob:addListener("TAKE_DAMAGE", "JORM_TAKE_DAMAGE", function(defender, amount, attacker, attackType, damageType)
        local damageTaken = defender:getLocalVar("damageTaken") + amount
        if damageTaken > 10000 then
            if defender:getAnimationSub() == 1 and defender:canUseAbilities() then
                defender:useMobAbility(1292)
                defender:setLocalVar("damageTaken", 0)
            elseif defender:getAnimationSub() == 2 and not defender:hasStatusEffect(xi.effect.BLOOD_WEAPON) and defender:canUseAbilities() then
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
    mob:setLocalVar("changeTime", os.time() + 30)
end

entity.onMobFight = function(mob, target)
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

    -- Gains a large magic attack boost when health is under 25%
    if mob:getHPP() < 30 and mob:getMod(xi.mod.MATT) <= 69 then
        mob:setMod(xi.mod.MATT, 70)
    end

    -- Handle flight and ground timer
    if not mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and mob:canUseAbilities() then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")

        if mob:getAnimationSub() == 2 and os.time() > twohourTime and mob:getHP() <= 85 then
            mob:useMobAbility(695)
            twohourTime = os.time() + 300
            mob:setLocalVar("twohourTime", twohourTime)
        elseif mob:getAnimationSub() == 0 and os.time() > changeTime then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:setBehaviour(0)
            mob:setMobSkillAttack(732)
            mob:setLocalVar("changeTime", os.time() + 30)
        -- subanimation 1 is flight, so check if she should land
        elseif mob:getAnimationSub() == 1 and os.time() > changeTime then
            mob:useMobAbility(1282)
            mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
            mob:setLocalVar("changeTime", os.time() + 60)
        -- subanimation 2 is grounded mode, so check if she should take off
        elseif mob:getAnimationSub() == 2 and os.time() > changeTime then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:setBehaviour(0)
            mob:setMobSkillAttack(732)
            mob:setLocalVar("changeTime", os.time() + 30)
        end
    end

    -- Jorm draws in from set boundaries leaving her spawn area
    utils.arenaDrawIn(mob, target, drawInTableNorth)
    utils.arenaDrawIn(mob, target, drawInTableSouth)
    utils.arenaDrawIn(mob, target, drawInTableEast)

    -- Jorm uses Horrid Roar 3x or Spike Flails if target is behind her
    local roarCount = mob:getLocalVar("roarCount")
    if roarCount > 0 and mob:canUseAbilities() then
        if not target:isBehind(mob, 96) then
            mob:useMobAbility(1286)
        else
            mob:useMobAbility(1290)
        end
        mob:setLocalVar("roarCount", roarCount - 1)
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
        mob:addTP(mob:getLocalVar("skill_tp") + 65) -- Needs to gain TP from flight auto attacks
        mob:setLocalVar("skill_tp", 0)
    elseif skill:getID() == 1292 then
        mob:addTP(mob:getLocalVar("skill_tp"))
        mob:setLocalVar("skill_tp", 0)
    end

    -- Below 25% Jorm can Horrid Roar 3x
    local roarCount = mob:getLocalVar("roarCount")
    if
        mob:getHPP() < 30 and
        skill:getID() == 1296 and
        roarCount == 0
    then
        mob:setLocalVar("roarCount", 2)
    end
end

entity.onMobDisengage = function(mob)
    -- Reset Jorm back to the ground on wipe
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
    player:addTitle(xi.title.WORLD_SERPENT_SLAYER)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

return entity
