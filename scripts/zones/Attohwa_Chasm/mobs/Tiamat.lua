-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Tiamat
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -509.612, y = -7.883,  z = -57.162 },
    { x = -511.114, y = -8.854,  z = -61.300 },
    { x = -513.979, y = -9.972,  z = -66.404 },
    { x = -516.567, y = -11.228, z = -71.118 },
    { x = -516.019, y = -12.018, z = -77.012 },
    { x = -516.266, y = -12.074, z = -82.299 },
    { x = -520.644, y = -12.033, z = -84.040 },
    { x = -525.511, y = -11.937, z = -79.784 },
    { x = -531.459, y = -12.028, z = -75.823 },
    { x = -537.182, y = -11.317, z = -79.414 },
    { x = -541.642, y = -11.083, z = -80.879 },
    { x = -546.247, y = -11.653, z = -78.959 },
    { x = -550.252, y = -11.713, z = -81.462 },
    { x = -553.738, y = -12.191, z = -83.898 },
    { x = -558.361, y = -12.178, z = -84.656 },
    { x = -562.449, y = -12.202, z = -84.500 },
    { x = -565.689, y = -12.420, z = -79.477 },
    { x = -559.911, y = -11.622, z = -67.839 },
    { x = -556.672, y = -11.939, z = -66.284 },
    { x = -551.187, y = -12.342, z = -67.364 },
    { x = -545.686, y = -11.851, z = -64.526 },
    { x = -540.688, y = -12.420, z = -61.299 },
    { x = -547.407, y = -11.494, z = -56.208 },
    { x = -545.911, y = -11.480, z = -53.302 },
    { x = -543.347, y = -11.080, z = -49.358 },
    { x = -547.281, y = -11.188, z = -46.117 },
    { x = -551.477, y = -11.580, z = -48.592 },
    { x = -555.466, y = -11.945, z = -50.986 },
    { x = -560.512, y = -12.042, z = -51.924 },
    { x = -563.436, y = -12.140, z = -48.995 },
    { x = -563.185, y = -12.002, z = -46.441 },
    { x = -563.587, y = -12.005, z = -43.905 },
    { x = -566.766, y = -12.674, z = -41.782 },
    { x = -563.552, y = -12.000, z = -39.131 },
    { x = -560.329, y = -12.000, z = -37.608 },
    { x = -553.611, y = -11.488, z = -36.440 },
    { x = -547.924, y = -9.652,  z = -32.699 },
    { x = -545.229, y = -9.139,  z = -26.835 },
    { x = -539.781, y = -6.688,  z = -24.802 },
    { x = -537.228, y = -6.278,  z = -21.546 },
    { x = -536.608, y = -4.329,  z = -16.014 },
    { x = -540.775, y = -4.301,  z = -13.786 },
    { x = -547.040, y = -4.759,  z = -13.895 },
    { x = -552.430, y = -5.316,  z = -11.979 },
    { x = -556.140, y = -4.988,  z = -8.711  },
    { x = -560.106, y = -4.234,  z = -5.819  },
    { x = -559.868, y = -4.000,  z = -1.305  },
    { x = -557.823, y = -4.000,  z = 3.232   },
    { x = -553.009, y = -3.918,  z = 4.200   },
    { x = -549.802, y = -8.944,  z = -24.848 },
}

-----------------------------------
-- Enter/Exit Flight Functions
-----------------------------------
local function enterFlight(mob)
    mob:setMobSkillAttack(730)
    mob:addStatusEffect(xi.effect.ALL_MISS, { power = 1, origin = mob, icon = 0 })
    mob:setAnimationSub(1)
    mob:setLocalVar('flightTime', GetSystemTime() + 120)
    mob:setLocalVar('changeHP', mob:getHP() - 10000)
end

local function exitFlight(mob)
    mob:useMobAbility(xi.mobSkill.TOUCHDOWN_3)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setLocalVar('flightTime', GetSystemTime() + 120)
    mob:setLocalVar('changeHP', mob:getHP() - 10000)
end

entity.onMobInitialize = function(mob)
    mob:setCarefulPathing(true) -- Used for drawin
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)

    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

entity.onMobSpawn = function(mob)
    mob:setMobSkillAttack(0)
    mob:setAnimationSub(0)
    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)

    mob:setMod(xi.mod.ACC, 444)
    mob:setMod(xi.mod.ATT, 388)
    mob:setMod(xi.mod.COUNTER, 10)
    mob:setMod(xi.mod.CURSE_MEVA, 1000) -- TODO: Needs curse immunity verification
    mob:setMod(xi.mod.DEF, 463)
    mob:setMod(xi.mod.EVA, 397)
    mob:setMod(xi.mod.MATT, 0)
    mob:setMod(xi.mod.REFRESH, 200)
    mob:setMod(xi.mod.REGEN, 22)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMod(xi.mod.VIT, 19)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 55)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 5)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MODIFIER, 150) -- 247 total weapon damage
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobEngage = function(mob, target)
    local currentTime = GetSystemTime()
    local flightTime  = mob:getLocalVar('flightTime')

    if flightTime == 0 then
        mob:setLocalVar('flightTime', currentTime + 120)
    else
        mob:setLocalVar('flightTime', currentTime + flightTime)
    end

    mob:setLocalVar('twohourTime', currentTime + 210)
    mob:setLocalVar('changeHP', mob:getHP() - 10000)
end

entity.onMobFight = function(mob, target)
    -- Tiamat draws in from set boundaries leaving her spawn area
    local drawInTable =
    {
        conditions =
        {
            target:getZPos() > 28,
            target:getZPos() > -31 and target:getXPos() > -515,
            target:getZPos() <= -31 and target:getXPos() > -500,
        },
        position = mob:getPos(),
        wait = 5,
    }

    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end

    -- Gains a large attack boost when health is under 25% which cannot be Dispelled.
    local hpp = mob:getHPP()
    if
        hpp <= 25 and
        not mob:hasStatusEffect(xi.effect.ATTACK_BOOST)
    then
        mob:addStatusEffect(xi.effect.ATTACK_BOOST, { power = 75, origin = mob })
        mob:getStatusEffect(xi.effect.ATTACK_BOOST):addEffectFlag(xi.effectFlag.DEATH)
    end

    -- Gains a delay reduction (from 210 to 160) when health is under 10%
    if hpp <= 10 then
        mob:setDelay(160)
    else
        mob:setDelay(210)
    end

    local animationSub = mob:getAnimationSub()

    -- Tiamat wakes from sleep in air
    if
        animationSub == 1 and
        mob:hasStatusEffect(xi.effect.SLEEP_I)
    then
        mob:wakeUp()
    end

    -- If Mighty Strikes is active, cannot fly until it ends.
    if
        mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) or
        xi.combat.behavior.isEntityBusy(mob)
    then
        return
    end

    -- Landing / Flying logic
    local currentTime = GetSystemTime()
    local flightTime  = mob:getLocalVar('flightTime')
    local twohourTime = mob:getLocalVar('twohourTime')
    local changeHP    = mob:getLocalVar('changeHP')
    local currentHP   = mob:getHP()

    if
        animationSub == 0 and
        currentTime > flightTime or
        currentHP < changeHP
    then
        enterFlight(mob)

    elseif
        animationSub == 1 and
        currentTime > flightTime or
        currentHP < changeHP
    then
        exitFlight(mob)

    elseif animationSub == 2 then
        -- 2-Hour logic.
        if currentTime > twohourTime then
            mob:useMobAbility(xi.mobSkill.MIGHTY_STRIKES_1)
            mob:setLocalVar('twohourTime', currentTime + 210)

        elseif
            currentTime > flightTime or
            currentHP < changeHP
        then
            enterFlight(mob)
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 20,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.FIRE,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobDisengage = function(mob)
    -- Reset Tiamat back to the ground on wipe
    if mob:getAnimationSub() == 1 then
        local flightTime = mob:getLocalVar('flightTime')
        mob:setLocalVar('flightTime', math.max(flightTime - GetSystemTime(), 1)) -- Get seconds left to fly for next pull
        mob:setAnimationSub(0)
        mob:delStatusEffect(xi.effect.ALL_MISS)
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
        mob:setMobSkillAttack(0)
        mob:setLocalVar('changeHP', 0)
    else
        mob:setLocalVar('flightTime', 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.TIAMAT_TROUNCER)
    end
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

return entity
