-----------------------------------
-- Area: Riverne Site B01
-- Note: Weaker version of Ouryu summoned by Bahamut during The Wyrmking Descends
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

local offsets = { 4, 5, 6, 7 }

entity.land = function(mob)
    -- need to deal with case of stun of touchdown
    mob:useMobAbility(1302)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    mob:setLocalVar("changeTime", mob:getBattleTime() + 120)
    mob:setLocalVar("damageTaken", 0)
end

entity.flight = function(mob)
    mob:setAnimationSub(1)
    mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
    mob:setBehaviour(0)
    mob:setMobSkillAttack(731)
    mob:setLocalVar("changeTime", mob:getBattleTime() + 90)
    mob:setLocalVar("damageTaken", 0)
end

entity.onMobSpawn = function(mob)
    mob:setMobSkillAttack(0)
    mob:setAnimationSub(0)
    if mob:hasStatusEffect(xi.effect.ALL_MISS) then
        mob:delStatusEffect(xi.effect.ALL_MISS)
    end

    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addMod(xi.mod.SLEEPRES, 100)
    mob:addMod(xi.mod.LULLABYRES, 100)
    mob:addMod(xi.mod.EARTH_NULL, 1)
    mob:addMod(xi.mod.BLINDRES, 25)
    mob:addMod(xi.mod.PARALYZERES, 25)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 48) -- (level 90 + 2) + 48 = 140
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UFASTCAST, 90)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.DEF, 459)
    mob:setMod(xi.mod.EVA, 422)
    mob:setMod(xi.mod.ATT, 436)
    mob:setMod(xi.mod.MATT, -100)
    mob:setMod(xi.mod.REFRESH, 200)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    for i = 8, 9 do
        SpawnMob(mob:getID() + i)
    end

    mob:setLocalVar("twoHour", 0)

    mob:addListener("TAKE_DAMAGE", "OURYU_TAKE_DAMAGE", function(defender, amount, attacker, attackType, damageType)
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
                defender:actionQueueEmpty()
            then
                entity.flight(defender)
            end
        end
    end)
end

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar("twohourTime", mob:getBattleTime() + 15)
    mob:setLocalVar("changeTime", mob:getBattleTime() + 120)
end

entity.onMobFight = function(mob, target)
    if mob:actionQueueEmpty() then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")

        if
            mob:getBattleTime() > twohourTime and
            mob:canUseAbilities()
        then
            mob:useMobAbility(694)
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

    local delay = mob:getLocalVar("delay")
    if delay > 120 then -- Summon Ziryu every 60s, this is a guess until we get a capture
        mob:setLocalVar("delay", 0)

        local mobId = mob:getID()
        for i, offset in ipairs(offsets) do
            local pet = GetMobByID(mobId + offset)

            if not pet:isSpawned() then
                    pet:spawn(60)
                    local pos = mob:getPos()
                    pet:setPos(pos.x + math.random(2, 6), pos.y, pos.z + math.random(2, 6))
                    pet:updateEnmity(mob:getTarget())
                break
            end
        end
    else
        mob:setLocalVar("delay", delay + 1)
    end

    -- Wakeup from sleep immediately if flying
    if
        mob:getAnimationSub() == 1 and
        (target:hasStatusEffect(xi.effect.SLEEP_I) or
        target:hasStatusEffect(xi.effect.SLEEP_II) or
        target:hasStatusEffect(xi.effect.LULLABY))
    then
        mob:delStatusEffect(xi.effect.SLEEP_I)
        mob:delStatusEffect(xi.effect.SLEEP_II)
        mob:delStatusEffect(xi.effect.LULLABY)
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if mob:getAnimationSub() == 1 then
        mob:setLocalVar("skill_tp", mob:getTP())
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Don't lose TP from autos during flight
    if skill:getID() == 1298 then
        mob:addTP(65) -- Needs to gain TP from flight auto attacks
        mob:setLocalVar("skill_tp", 0)
    elseif skill:getID() == 1302 then
        mob:addTP(mob:getLocalVar("skill_tp"))
        mob:setLocalVar("skill_tp", 0)
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

entity.onMobDeath = function(mob, player, optParams)
    if mob:getLocalVar("deathTrigger") == 0 then
        -- if ouryu dies then kill all pets
        local mobId = mob:getID()
        for i, offset in ipairs(offsets) do
            local pet = GetMobByID(mobId + offset)
            if pet:isAlive() then
                pet:setHP(0)
            end
        end

        mob:setLocalVar("deathTrigger", 1)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE, { power = math.random(45, 90), chance = 10 })
end

return entity
