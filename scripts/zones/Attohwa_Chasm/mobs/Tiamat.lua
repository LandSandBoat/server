-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Tiamat
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
    mob:SetMobSkillAttack(0) -- resetting so it doesn't respawn in flight mode.
    mob:setAnimationSub(0) -- subanim 0 is only used when it spawns until first flight.

    mob:setMod(xi.mod.COUNTER, 10)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.DEF, 575)
    mob:setMod(xi.mod.EVA, 450)
    mob:setMod(xi.mod.VIT, 19)
    mob:setMod(xi.mod.STR, 3)
    mob:setMod(xi.mod.MATT, 0)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))

    mob:addListener("TAKE_DAMAGE", "TIAMAT_TAKE_DAMAGE", function(defender, amount, attacker, attackType, damageType)
        local damageTaken = defender:getLocalVar("damageTaken") + amount
        if damageTaken > 10000 then
            if defender:getAnimationSub() == 1 and defender:canUseAbilities() then
                defender:useMobAbility(1282)
                defender:setLocalVar("damageTaken", 0)
            elseif defender:getAnimationSub() == 2 and not defender:hasStatusEffect(xi.effect.MIGHTY_STRIKES) and defender:canUseAbilities() then
                defender:setAnimationSub(1)
                defender:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
                defender:SetMobSkillAttack(730)
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

entity.onMobFight = function(mob, target)
    -- Gains a large attack boost when health is under 25% which cannot be Dispelled.
    if mob:getHPP() < 25 and mob:getMod(xi.mod.ATT) <= 800 then
        mob:setMod(xi.mod.ATT, 1200)
    end

    if not mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) and mob:canUseAbilities() then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")

        if mob:getAnimationSub() == 2 and os.time() > twohourTime then
            mob:useMobAbility(688)
            twohourTime = os.time() + math.random(180, 300)
            mob:setLocalVar("twohourTime", twohourTime)
        elseif mob:getAnimationSub() == 0 and os.time() > changeTime then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:setBehaviour(0)
            mob:SetMobSkillAttack(730)
            mob:setLocalVar("changeTime", os.time() + 120)
        -- subanimation 1 is flight, so check if she should land
        elseif mob:getAnimationSub() == 1 and os.time() > changeTime then
            mob:useMobAbility(1282)
            mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
            mob:setLocalVar("changeTime", os.time() + 120)
        -- subanimation 2 is grounded mode, so check if she should take off
        elseif mob:getAnimationSub() == 2 and os.time() > changeTime then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:setBehaviour(0)
            mob:SetMobSkillAttack(730)
            mob:setLocalVar("changeTime", os.time() + 120)
        end
    end

    -- Wyrms automatically wake from sleep in the air
    if hasSleepEffects(mob) and mob:getAnimationSub() == 1 then
        removeSleepEffects(mob)
    end

    -- Tiamat draws in from set boundaries leaving her spawn area
    local drawInWait = mob:getLocalVar("DrawInWait")

    if (target:getXPos() < -515 and target:getZPos() > 8) and os.time() > drawInWait then -- North Draw In
        local rot = target:getRotPos()
        target:setPos(-530.642, -4.013, 6.262, rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif (target:getXPos() > -480 and target:getZPos() > -50) and os.time() > drawInWait then  -- East Draw In
        local rot = target:getRotPos()
        target:setPos(-481.179, -4, -41.92, rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if mob:getAnimationSub() == 1 then
        mob:setLocalVar("skill_tp", mob:getTP())
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Don't lose TP from autos during flight
    if skill:getID() == 1278 then
        mob:addTP(mob:getLocalVar("skill_tp") + 65)
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
        mob:SetMobSkillAttack(0)
        mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE, { chance = 20, power = 100 })
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.TIAMAT_TROUNCER)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

return entity
