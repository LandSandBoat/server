-- Area : Riverne - Site B01
-- Mob : Tiamat
-- Battlefield : The Wyrmking Descends
-- Gains a 75% attack boost at 25% HP, and a 25% delay reduction at 10% HP.
-----------------------------------
---@type TMobEntity
local entity = {}

local function enterFlight(mob)
    mob:setMobSkillAttack(730)
    mob:addStatusEffect(xi.effect.ALL_MISS, { power = 1, origin = mob, icon = 0 })
    mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
    mob:setAnimationSub(1)
end

local function exitFlight(mob)
    mob:setMobSkillAttack(0)
    mob:useMobAbility(xi.mobSkill.TOUCHDOWN_1)
    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setAnimationSub(2)
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
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
    mob:setMod(xi.mod.ACC, 361)
    mob:setMod(xi.mod.ATT, 359)
    mob:setMod(xi.mod.COUNTER, 10)
    mob:setMod(xi.mod.DEF, 424)
    mob:setMod(xi.mod.EVA, 367)
    mob:setMod(xi.mod.MATT, 0)
    mob:setMod(xi.mod.REFRESH, 200)
    mob:setMod(xi.mod.REGEN, 22)
    mob:setMod(xi.mod.UDMGMAGIC, -4000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UFASTCAST, 25)
    mob:setMod(xi.mod.VIT, 12)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 139)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 45)

    mob:setLocalVar('mightyStrikesTime', 0)
    mob:setLocalVar('delayReductionApplied', 0)

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
    mob:setLocalVar('phaseChangeTime', currentTime + 120)
    mob:setLocalVar('phaseChangeHP', math.max(0, mob:getHP() - 2500))
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local currentTime = GetSystemTime()
    local currentHP = mob:getHP()
    local hpPercent = mob:getHPP()

    -- Can use Mighty Strikes every 3 1/2 minutes starting at 85% HP.
    -- Cannot be used while airborne.
    if
        hpPercent <= 85 and
        currentTime >= mob:getLocalVar('mightyStrikesTime') and
        mob:getAnimationSub() ~= 1
    then
        mob:useMobAbility(xi.mobSkill.MIGHTY_STRIKES_1)
        mob:setLocalVar('mightyStrikesTime', currentTime + 210)
    end

    -- Gain a 75% attack boost at 25% HP, and a 25% delay reduction at 10% HP.
    if
        hpPercent <= 25 and
        not mob:hasStatusEffect(xi.effect.ATTACK_BOOST)
    then
        mob:addStatusEffect(xi.effect.ATTACK_BOOST, { power = 75, origin = mob })
        mob:getStatusEffect(xi.effect.ATTACK_BOOST):addEffectFlag(xi.effectFlag.DEATH)
    end

    if
        hpPercent <= 10 and
        mob:getLocalVar('delayReductionApplied') == 0
    then
        mob:setMod(xi.mod.DELAYP, -25)
        mob:setLocalVar('delayReductionApplied', 1)
    end

    if mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) then
        return
    end

    -- Check if it's time to fly or land - Cannot change phases while Mighty Strikes is active.
    if
        currentTime >= mob:getLocalVar('phaseChangeTime') or
        currentHP <= mob:getLocalVar('phaseChangeHP')
    then
        if mob:getAnimationSub() == 1 then
            exitFlight(mob)
        else
            enterFlight(mob)
        end

        mob:setLocalVar('phaseChangeTime', currentTime + 120)
        mob:setLocalVar('phaseChangeHP', math.max(0, currentHP - 2500))
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    if skillId == xi.mobSkill.INFERNO_BLAST_ATTACK then
        return 0
    end

    local skillList = {}

    -- Mid-flight.
    if mob:getAnimationSub() == 1 then
        table.insert(skillList, xi.mobSkill.INFERNO_BLAST)
        table.insert(skillList, xi.mobSkill.TEBBAD_WING_2)

    -- Ground.
    else
        table.insert(skillList, xi.mobSkill.TEBBAD_WING_1)
        table.insert(skillList, xi.mobSkill.SPIKE_FLAIL_3)
        table.insert(skillList, xi.mobSkill.FIERY_BREATH_1)
        table.insert(skillList, xi.mobSkill.ABSOLUTE_TERROR_3)
        table.insert(skillList, xi.mobSkill.HORRID_ROAR_3)
    end

    return skillList[math.random(1, #skillList)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.FIRAGA_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [2] = { xi.magic.spell.BLAZE_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLAZE_SPIKES, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
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
    if mob:getAnimationSub() == 1 then
        mob:setMobSkillAttack(0)
        mob:injectActionPacket(mob:getID(), 11, 974, 0, 0x18, 0, 0, 0)
        mob:delStatusEffect(xi.effect.ALL_MISS)
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    end

    if mob:hasStatusEffect(xi.effect.ATTACK_BOOST) then
        mob:delStatusEffect(xi.effect.ATTACK_BOOST)
    end

    mob:setMod(xi.mod.DELAYP, 0)
    mob:setLocalVar('delayReductionApplied', 0)

    mob:setAnimationSub(0)
end

return entity
