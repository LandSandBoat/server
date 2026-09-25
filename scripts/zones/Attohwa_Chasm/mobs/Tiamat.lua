-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Tiamat
-----------------------------------
---@type TMobEntity
local entity = {}

-----------------------------------
-- Enter/Exit Flight Functions
-----------------------------------
local function enterFlight(mob)
    mob:setMobSkillAttack(730)
    mob:addStatusEffect(xi.effect.ALL_MISS, { power = 1, duration = 7200, origin = mob, icon = 0 })
    mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
    mob:setAnimationSub(1)
    mob:setLocalVar('flightTime', GetSystemTime() + 120)
    mob:setLocalVar('changeHP', math.max(0, mob:getHP() - 10000))
end

local function exitFlight(mob)
    mob:useMobAbility(xi.mobSkill.TOUCHDOWN_3)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setLocalVar('flightTime', GetSystemTime() + 120)
    mob:setLocalVar('changeHP', math.max(0, mob:getHP() - 10000))
end

local function checkEnrage(mob)
    local hpp = mob:getHPP()

    if
        hpp <= 25 and
        not mob:hasStatusEffect(xi.effect.ATTACK_BOOST)
    then
        mob:addStatusEffect(xi.effect.ATTACK_BOOST, { power = 75, origin = mob })
        mob:getStatusEffect(xi.effect.ATTACK_BOOST):addEffectFlag(xi.effectFlag.DEATH)
    end

    if hpp <= 10 then
        mob:setDelay(160)
    else
        mob:setDelay(210)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)

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
    mob:setLocalVar('changeHP', math.max(0, mob:getHP() - 10000))
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

    -- Gains a large attack boost under 25% HP and increased attack speed under 10% HP.
    checkEnrage(mob)

    local currentAnimation = mob:getAnimationSub()
    local currentTime      = GetSystemTime()

    if
        currentAnimation == 1 and
        mob:hasStatusEffect(xi.effect.SLEEP_I)
    then
        mob:wakeUp()
    end

    -- No Casting or TP Abilities while Mighty Strikes is active.
    local mightyStrikesActive = mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES)

    mob:setMobAbilityEnabled(not mightyStrikesActive)
    mob:setMagicCastingEnabled(not mightyStrikesActive)

    -- Cannot change phases while Mighty Strikes is active.
    if
        mightyStrikesActive or
        xi.combat.behavior.isEntityBusy(mob)
    then
        return
    end

    if
        currentAnimation == 2 and
        currentTime > mob:getLocalVar('twohourTime')
    then
        mob:useMobAbility(xi.mobSkill.MIGHTY_STRIKES_1)
        mob:setLocalVar('twohourTime', currentTime + 210)
        return
    end

    local flightTime  = mob:getLocalVar('flightTime')
    local changeHP    = mob:getLocalVar('changeHP')
    local currentHP   = mob:getHP()

    if
        currentTime > flightTime or
        currentHP < changeHP
    then
        if currentAnimation == 1 then
            exitFlight(mob)
        else
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

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.FIRAGA_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [2] = { xi.magic.spell.BLAZE_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLAZE_SPIKES, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDisengage = function(mob)
    if mob:getAnimationSub() == 1 then
        local flightTime = math.max(mob:getLocalVar('flightTime') - GetSystemTime(), 1)

        mob:setLocalVar('flightTime', flightTime)
        mob:setAnimationSub(0)
        mob:delStatusEffect(xi.effect.ALL_MISS)
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
        mob:setMobSkillAttack(0)
        mob:setLocalVar('changeHP', 0)
    else
        mob:setLocalVar('flightTime', 0)
    end

    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setAnimationSub(0)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.TIAMAT_TROUNCER)
    end
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

return entity
