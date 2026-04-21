-----------------------------------
-- The Wyrmking Descends
-- Vrtra
-- !pos -612.800 1.750 693.190 29
-- Charms 10 times starting at 85% HP (It is not time based, holding Vrtra at the same HP results in no charm being used.
-- Pushing their HP down quickly will result in multiple charms being used in quick succession. This is intended behavior.
-- Summons 6 pets, 2 each of type. Pey, Iruci, and Airi - once every minute, in a random order.
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
---@type TMobEntity
local entity = {}

local charmThresholds =
{
    [ 1] = { 85 },
    [ 2] = { 77 },
    [ 3] = { 69 },
    [ 4] = { 61 },
    [ 5] = { 53 },
    [ 6] = { 45 },
    [ 7] = { 37 },
    [ 8] = { 29 },
    [ 9] = { 21 },
    [10] = { 13 },
}

local pets =
{
    ID.mob.BAHAMUT_V2 + 11, -- Pey
    ID.mob.BAHAMUT_V2 + 12, -- Pey
    ID.mob.BAHAMUT_V2 + 13, -- Iruci
    ID.mob.BAHAMUT_V2 + 14, -- Iruci
    ID.mob.BAHAMUT_V2 + 15, -- Airi
    ID.mob.BAHAMUT_V2 + 16, -- Airi
}

local callPetParams =
{
    inactiveTime = 3000,
    maxSpawns = 1,
    dieWithOwner = true,
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setSpawnAnimation(1)
    mob:setMobSkillAttack(0)
    mob:setAnimationSub(0)
    mob:setMod(xi.mod.DEF, 436)
    mob:setMod(xi.mod.ATT, 281)
    mob:setMod(xi.mod.EVA, 371)
    mob:setMod(xi.mod.ACC, 359)
    mob:setMod(xi.mod.UFASTCAST, 40)
    mob:setMod(xi.mod.DARK_MEVA, 100)
    mob:setMod(xi.mod.REGEN, 22)
    mob:setMod(xi.mod.REFRESH, 100)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -4000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 137)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 40)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)

    mob:setLocalVar('charmsUsed', 0)

    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    local players = battlefield:getPlayers()
    for _, player in pairs(players) do
        if player:isAlive() then
            mob:updateEnmity(player)
            break
        end
    end
end

entity.onMobEngage = function(mob, target)
    local currentTime = GetSystemTime()
    mob:setLocalVar('addTime', currentTime + math.random(25, 30))
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local currentTime = GetSystemTime()
    local addTime = mob:getLocalVar('addTime')

    if currentTime > addTime then
        mob:setLocalVar('addTime', currentTime + math.random(55, 60))
        xi.mob.callPets(mob, utils.shuffle(pets), callPetParams)
    end

    local charmIndex = mob:getLocalVar('charmsUsed') + 1
    local charmData = charmThresholds[charmIndex]

    if not charmData then
        return
    end

    if
        mob:getHPP() <= charmData[1] and
        mob:checkDistance(target) <= 15
    then
        mob:useMobAbility(xi.mobSkill.CHARM)
        mob:setLocalVar('charmsUsed', charmIndex)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.CYCLONE_WING_1,
        xi.mobSkill.SPIKE_FLAIL_6,
        xi.mobSkill.SABLE_BREATH_1,
        xi.mobSkill.ABSOLUTE_TERROR_6,
        xi.mobSkill.HORRID_ROAR_6,
    }

    return skillList[math.random(1, #skillList)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.BIO_III,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,       4, 100 },
        [2] = { xi.magic.spell.BLINDGA,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BLINDNESS, 0, 100 },
        [3] = { xi.magic.spell.SLEEPGA_II, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,   0, 100 },
    }

    if target:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) then
        table.insert(spellList, #spellList + 1, { xi.magic.spell.DISPELGA, target, false, xi.action.type.NONE, nil, 0, 100 })
    end

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
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

return entity
