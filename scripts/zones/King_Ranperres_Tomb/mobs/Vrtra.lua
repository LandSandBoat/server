-----------------------------------
-- Area: King Ranperre's Tomb
--   NM: Vrtra
-----------------------------------
---@type TMobEntity
local entity = {}

local ID = zones[xi.zone.KING_RANPERRES_TOMB]

local charmThresholds =
{
    [ 1] = 90,
    [ 2] = 85,
    [ 3] = 80,
    [ 4] = 75,
    [ 5] = 70,
    [ 6] = 65,
    [ 7] = 60,
    [ 8] = 55,
    [ 9] = 50,
    [10] = 45,
    [11] = 40,
    [12] = 35,
    [13] = 30,
    [14] = 25,
    [15] = 20,
    [16] = 15,
    [17] = 10,
    [18] =  5,
}

local pets =
{
    ID.mob.VRTRA + 1,
    ID.mob.VRTRA + 2,
    ID.mob.VRTRA + 3,
    ID.mob.VRTRA + 4,
    ID.mob.VRTRA + 5,
    ID.mob.VRTRA + 6,
}

local callPetParams =
{
    inactiveTime = 3000,
    ignoreInactive = true,
    maxSpawns = 1,
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)

    mob:setRespawnTime(math.randomInt(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.ACC, 442)
    mob:setMod(xi.mod.ATT, 305)
    mob:setMod(xi.mod.CURSE_MEVA, 1000)
    mob:setMod(xi.mod.DEF, 466)
    mob:setMod(xi.mod.EVA, 401)
    mob:setMod(xi.mod.REGEN, 50)
    mob:setMod(xi.mod.REFRESH, 100)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 55)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 5)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MODIFIER, 148) -- 245 total weapon damage
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobEngage = function(mob, target)
    local currentTime = GetSystemTime()
    local hpPercent   = mob:getHPP()
    local charmsLeft  = 0

    -- Amount of charms remaining set on engage, to reset properly on wipe.
    for _, threshold in ipairs(charmThresholds) do
        if hpPercent >= threshold then
            charmsLeft = charmsLeft + 1
        end
    end

    mob:setLocalVar('charmsLeft', charmsLeft)
    mob:setLocalVar('petTime', currentTime + math.randomInt(3, 5) * 15)
end

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            target:getXPos() < 180 and target:getZPos() > -305 and target:getZPos() < -290,
        },
        position = mob:getPos(),
        wait = 3,
    }

    if drawInTable.conditions[1] then
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        utils.drawIn(target, drawInTable)
    else
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    end

    local currentTime = GetSystemTime()

    if
        currentTime > mob:getLocalVar('petTime') and
        xi.mob.callPets(mob, utils.shuffle(pets), callPetParams)
    then
        mob:setLocalVar('petTime', currentTime + math.randomInt(3, 5) * 15)
    end

    local charmsLeft  = mob:getLocalVar('charmsLeft')
    local charmIndex  = #charmThresholds - charmsLeft + 1

    if
        charmsLeft > 0 and
        mob:getHPP() <= charmThresholds[charmIndex] and
        not xi.combat.behavior.isEntityBusy(mob)
    then
        mob:useMobAbility(xi.mobSkill.CHARM)
        mob:setLocalVar('charmsLeft', charmsLeft - 1)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 25,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.DARK,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobDisengage = function(mob)
    -- Despawn undead on disgengage
    for _, petId in ipairs(pets) do
        DespawnMob(petId)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.VRTRA_VANQUISHER)
    end
end

entity.onMobDespawn = function(mob)
    -- Set Vrtra's spawnpoint and respawn time (3-5 days)
    mob:setRespawnTime(math.randomInt(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

return entity
