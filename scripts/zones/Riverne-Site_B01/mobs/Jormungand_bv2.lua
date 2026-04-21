-- Area : Riverne - Site B01
-- Mob : Jormungand
-- Battlefield : The Wyrmking Descends
-- Uses Horrid Roar 3 times in a row when under 25% HP. Cannot change phases while Blood Weapon is active. Uses Blood Weapon every 2 1/2 minutes starting at 85% HP. Cannot be used while airborne.
-----------------------------------
---@type TMobEntity
local entity = {}

local function enterFlight(mob)
    mob:setMobSkillAttack(732)
    mob:addStatusEffect(xi.effect.ALL_MISS, { power = 1, origin = mob, icon = 0 })
    mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
    mob:setAnimationSub(1)
end

local function exitFlight(mob)
    mob:setMobSkillAttack(0)
    mob:useMobAbility(xi.mobSkill.TOUCHDOWN_4)
    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setAnimationSub(2)
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobSpawn = function(mob)
    mob:setSpawnAnimation(1)
    mob:setMobSkillAttack(0)
    mob:setAnimationSub(0)
    mob:setMod(xi.mod.ATT, 322)
    mob:setMod(xi.mod.ACC, 358)
    mob:setMod(xi.mod.CURSE_MEVA, 1000)
    mob:setMod(xi.mod.DEF, 384)
    mob:setMod(xi.mod.EVA, 379)
    mob:setMod(xi.mod.MATT, 30)
    mob:setMod(xi.mod.REFRESH, 200)
    mob:setMod(xi.mod.REGEN, 22)
    mob:setMod(xi.mod.UFASTCAST, 60)
    mob:setMod(xi.mod.UDMGMAGIC, -4000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 40)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 146)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)

    mob:setLocalVar('roarCount', 0)
    mob:setLocalVar('bloodWeaponTime', 0)

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

entity.onMobEngage = function(mob)
    local currentTime = GetSystemTime()
    mob:setLocalVar('phaseChangeTime', currentTime + 60)
    mob:setLocalVar('phaseChangeHP', math.max(0, mob:getHP() - 2500))
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local currentTime = GetSystemTime()
    local currentHP = mob:getHP()
    local hpPercent = mob:getHPP()

    -- Can use Blood Weapon every 2 1/2 minutes starting at 85% HP.
    -- Cannot be used while airborne.
    if
        hpPercent <= 85 and
        currentTime >= mob:getLocalVar('bloodWeaponTime') and
        mob:getAnimationSub() ~= 1
    then
        mob:useMobAbility(xi.mobSkill.BLOOD_WEAPON_1)
        mob:setLocalVar('bloodWeaponTime', currentTime + 150)
    end

    if mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) then
        return
    end

    -- Check if it's time to fly or land - Cannot change phases while Blood Weapon is active.
    if
        currentTime >= mob:getLocalVar('phaseChangeTime') or
        currentHP <= mob:getLocalVar('phaseChangeHP')
    then
        if mob:getAnimationSub() == 1 then
            exitFlight(mob)
            mob:setLocalVar('phaseChangeTime', currentTime + 60)
        else
            enterFlight(mob)
            mob:setLocalVar('phaseChangeTime', currentTime + 30)
        end

        mob:setLocalVar('phaseChangeHP', math.max(0, currentHP - 2500))
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    if skillId == xi.mobSkill.SLEET_BLAST_ATTACK then
        return 0
    end

    local skillList = {}

    -- Mid-flight.
    if mob:getAnimationSub() == 1 then
        table.insert(skillList, xi.mobSkill.SLEET_BLAST)
        table.insert(skillList, xi.mobSkill.GREGALE_WING_2)

    -- Ground.
    else
        table.insert(skillList, xi.mobSkill.GREGALE_WING_1)
        table.insert(skillList, xi.mobSkill.SPIKE_FLAIL_4)
        table.insert(skillList, xi.mobSkill.GLACIAL_BREATH_1)
        table.insert(skillList, xi.mobSkill.ABSOLUTE_TERROR_4)
        table.insert(skillList, xi.mobSkill.HORRID_ROAR_4)
    end

    return skillList[math.random(1, #skillList)]
end

-- If under 25% HP, uses Horrid Roar 3 times in a row.
entity.onMobWeaponSkill = function(mob, target, skill, action)
    if mob:getAnimationSub() == 1 then
        return
    end

    if target:isBehind(mob, 96) then
        return
    end

    local roarCount = mob:getLocalVar('roarCount')

    if
        mob:getHPP() <= 25 and
        skill:getID() == xi.mobSkill.HORRID_ROAR_4
    then
        if roarCount < 2 then
            mob:useMobAbility(xi.mobSkill.HORRID_ROAR_4)
            mob:setLocalVar('roarCount', roarCount + 1)
        else
            mob:setLocalVar('roarCount', 0)
        end
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.BLIZZAGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [2] = { xi.magic.spell.PARALYGA,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.PARALYSIS,  0, 100 },
        [3] = { xi.magic.spell.BINDGA,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIND,       0, 100 },
        [4] = { xi.magic.spell.ICE_SPIKES,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ICE_SPIKES, 0, 100 },
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
        mob:setMobSkillAttack(0)
        mob:injectActionPacket(mob:getID(), 11, 974, 0, 0x18, 0, 0, 0)
        mob:delStatusEffect(xi.effect.ALL_MISS)
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    end

    mob:setAnimationSub(0)
end

return entity
