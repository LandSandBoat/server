-----------------------------------
-- Area: Uleguerand Range
--  Mob: Jormungand
-----------------------------------
---@type TMobEntity
local entity = {}

local function enterFlight(mob)
    mob:setMobSkillAttack(732)
    mob:addStatusEffect(xi.effect.ALL_MISS, { power = 1, duration = 7200, origin = mob, icon = 0 })
    mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
    mob:setLocalVar('flightTime', GetSystemTime() + 30)
    mob:setLocalVar('changeHP', math.max(0, mob:getHP() - 6000))
    mob:setAnimationSub(1)
end

local function exitFlight(mob)
    mob:setMobSkillAttack(0)
    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setLocalVar('flightTime', GetSystemTime() + 60)
    mob:setLocalVar('changeHP', math.max(0, mob:getHP() - 6000))
    mob:useMobAbility(xi.mobSkill.TOUCHDOWN_4)
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.TERROR)

    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)

    mob:setRespawnTime(math.randomInt(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

entity.onMobSpawn = function(mob)
    -- Ensure Jorm spawns with correct ground status
    mob:setAnimationSub(0)
    mob:setMobSkillAttack(0)
    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)

    mob:setMod(xi.mod.ATT, 348)
    mob:setMod(xi.mod.ACC, 442)
    mob:setMod(xi.mod.CURSE_MEVA, 1000) -- TODO: Needs curse immunity verification
    mob:setMod(xi.mod.DEF, 460)
    mob:setMod(xi.mod.EVA, 410)
    mob:setMod(xi.mod.MATT, 30)
    mob:setMod(xi.mod.REFRESH, 200)
    mob:setMod(xi.mod.REGEN, 22)
    mob:setMod(xi.mod.UFASTCAST, 90)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 55)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 5)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MODIFIER, 158) -- 255 total weapon damage
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
end

entity.onMobEngage = function(mob, target)
    local currentTime = GetSystemTime()
    local flightTime  = mob:getLocalVar('flightTime')

    if flightTime == 0 then
        mob:setLocalVar('flightTime', currentTime + 30)
    else
        mob:setLocalVar('flightTime', currentTime + flightTime)
    end

    mob:setLocalVar('twohourTime', currentTime + 210)
    mob:setLocalVar('changeHP', math.max(0, mob:getHP() - 6000))
end

entity.onMobFight = function(mob, target)
    -- Draw in, prevents Jormungand from leaving the spawn area.
    local drawInTable =
    {
        conditions =
        {
            target:getXPos() < -105 and target:getXPos() > -215 and target:getZPos() > 195,
            target:getXPos() > -250 and target:getXPos() < -212 and target:getZPos() < 55,
            target:getXPos() > -160 and target:getZPos() > 105 and target:getZPos() < 130,
        },
        position = mob:getPos(),
        wait = 3,
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

    local currentAnimation = mob:getAnimationSub()

    -- Wakes up if slept during air phase.
    if
        currentAnimation == 1 and
        mob:hasStatusEffect(xi.effect.SLEEP_I)
    then
        mob:wakeUp()
    end

    -- No Casting or TP Abilities during Blood Weapon.
    local bloodWeaponActive = mob:hasStatusEffect(xi.effect.BLOOD_WEAPON)

    mob:setMobAbilityEnabled(not bloodWeaponActive)
    mob:setMagicCastingEnabled(not bloodWeaponActive)

    -- Cannot change phases while Blood Weapon is active.
    if
        bloodWeaponActive or
        xi.combat.behavior.isEntityBusy(mob)
    then
        return
    end

    local currentTime      = GetSystemTime()
    local currentHP        = mob:getHP()

    if
        currentAnimation == 2 and
        currentTime > mob:getLocalVar('twohourTime')
    then
        mob:useMobAbility(xi.mobSkill.BLOOD_WEAPON_1)
        mob:setLocalVar('twohourTime', currentTime + 300)
        return
    end

    if
        currentTime > mob:getLocalVar('flightTime') or
        currentHP < mob:getLocalVar('changeHP')
    then
        if currentAnimation == 1 then
            exitFlight(mob)
        else
            enterFlight(mob)
        end
    end
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    if
        mob:getHPP() > 25 or
        mob:getAnimationSub() == 1 or
        skill:getID() ~= xi.mobSkill.HORRID_ROAR_4
    then
        return
    end

    mob:setMagicCastingEnabled(false)
    mob:setLocalVar('isBusy', 1)
    local roarCount = mob:getLocalVar('roarCount')

    if roarCount < 2 then
        if not target:isBehind(mob, 96) then
            mob:useMobAbility(xi.mobSkill.HORRID_ROAR_4)
        else
            mob:useMobAbility(xi.mobSkill.SPIKE_FLAIL_4)
        end

        mob:setLocalVar('roarCount', roarCount + 1)
    else
        mob:setMagicCastingEnabled(true)
        mob:setLocalVar('isBusy', 0)
        mob:setLocalVar('roarCount', 0)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.BLIZZAGA_III,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [2] = { xi.magic.spell.PARALYGA,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [3] = { xi.magic.spell.BINDGA,          target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [4] = { xi.magic.spell.ICE_SPIKES,      mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ICE_SPIKES, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 20,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.ICE,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
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
    end

    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setAnimationSub(0)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.WORLD_SERPENT_SLAYER)
    end
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

return entity
