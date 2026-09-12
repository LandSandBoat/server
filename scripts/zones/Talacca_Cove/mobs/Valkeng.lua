-----------------------------------
-- Area: Talacca Cove
--  Mob: Valkeng
-----------------------------------
local ID = zones[xi.zone.TALACCA_COVE]
-----------------------------------
---@type TMobEntity
local entity = {}

local harlequinModel  = 1977
local valoredgeModel  = 1983
local sharpshotModel  = 1990
local stormwakerModel = 1994

local frames =
{
    [harlequinModel] =
    {
        skillList =
        {
            xi.mobSkill.SLAPSTICK_AUTOMATON,
        },
    },
    [valoredgeModel] =
    {
        skillList    =
        {
            xi.mobSkill.CHIMERA_RIPPER_AUTOMATON,
            xi.mobSkill.STRING_CLIPPER_AUTOMATON,
            xi.mobSkill.SHIELD_BASH_AUTOMATON,
        },
        textOffset   = 0,
        delay        = 240,
        casting      = false,
        specialSkill = 0,
        specialCool  = 0,
        regain       = 20,
        fastCast     = 0,
        onManeuver   = function(mob, maneuvers)
            mob:setMod(xi.mod.REGAIN, math.max(mob:getMod(xi.mod.REGAIN), 20 + maneuvers * 20))
            if maneuvers == 4 then
                mob:setDelay(120)
            end
        end,
    },
    [sharpshotModel] =
    {
        skillList    =
        {
            xi.mobSkill.ARCUBALLISTA_AUTOMATON,
            xi.mobSkill.SLAPSTICK_AUTOMATON,
        },
        textOffset   = 1,
        delay        = 240,
        casting      = false,
        specialSkill = xi.mobSkill.RANGED_ATTACK_1,
        specialCool  = 12,
        regain       = 0,
        fastCast     = 0,
        onManeuver   = function(mob, maneuvers)
            mob:setMobMod(xi.mobMod.SPECIAL_COOL, 12 - maneuvers * 2)
        end,
    },
    [stormwakerModel] =
    {
        skillList    =
        {
            xi.mobSkill.SLAPSTICK_AUTOMATON,
        },
        textOffset   = 2,
        delay        = 240,
        casting      = true,
        specialSkill = 0,
        specialCool  = 0,
        regain       = 0,
        fastCast     = 20,
        onManeuver   = function(mob, maneuvers)
            mob:setMod(xi.mod.UFASTCAST, 20 + maneuvers * 20)
        end,
    },
}

local function handleAutomatonManeuver(mob, model, share)
    local frame = frames[model]

    if mob:getModelId() ~= model then
        mob:showText(mob, ID.text.VALKENG_STATUS + frame.textOffset, share, 0, 0, 0, true)
        mob:setMagicCastingEnabled(false)
        mob:setMod(xi.mod.REGAIN, math.max(mob:getMod(xi.mod.REGAIN), frame.regain)) -- Regain accrued while in Valoredge never resets.
        mob:setMod(xi.mod.UFASTCAST, frame.fastCast)
        mob:setDelay(frame.delay)
        mob:setMobMod(xi.mobMod.SPECIAL_SKILL, frame.specialSkill)
        mob:setMobMod(xi.mobMod.SPECIAL_COOL, frame.specialCool)
        mob:setLocalVar('maneuvers', 0)
        mob:setLocalVar('nextManeuverTime', GetSystemTime() + 50)
        mob:useMobAbility(xi.mobSkill.FRAME_CHANGE_AUTOMATON)
        mob:timer(3300, function(mobArg)
            if mobArg:isAlive() then
                mobArg:setModelId(model)
                mobArg:setMagicCastingEnabled(frame.casting)
                mobArg:setMobAbilityEnabled(true)
            end
        end)

        return
    end

    if mob:getLocalVar('maneuvers') < 4 then
        mob:showText(mob, ID.text.VALKENG_STATUS + 3 + frame.textOffset, share, 0, 0, 0, true)
        local maneuvers = mob:getLocalVar('maneuvers') + 1
        mob:setLocalVar('maneuvers', maneuvers)
        mob:setLocalVar('nextManeuverTime', GetSystemTime() + 25)
        frame.onManeuver(mob, maneuvers)
    end
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)

    mob:addListener('TAKE_DAMAGE', 'VALKENG_TAKE_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        if attackType == xi.attackType.PHYSICAL then
            mobArg:setLocalVar('meleeDamage', mobArg:getLocalVar('meleeDamage') + damage)
        elseif attackType == xi.attackType.RANGED then
            mobArg:setLocalVar('rangedDamage', mobArg:getLocalVar('rangedDamage') + damage)
        else
            mobArg:setLocalVar('magicDamage', mobArg:getLocalVar('magicDamage') + damage)
        end
    end)

    mob:addListener('DISENGAGE', 'VALKENG_DISENGAGE', function(mobArg)
        mobArg:setLocalVar('meleeDamage', 0)
        mobArg:setLocalVar('rangedDamage', 0)
        mobArg:setLocalVar('magicDamage', 0)
        mobArg:setLocalVar('maneuvers', 0)
        mobArg:setLocalVar('nextManeuverTime', 0)
    end)
end

entity.onMobSpawn = function(mob)
    mob:setModelId(harlequinModel)
    mob:setMobAbilityEnabled(false)
    mob:setMagicCastingEnabled(true)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 23)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGMAGIC, 0)
    mob:setMod(xi.mod.REGAIN, 0)
    mob:setMod(xi.mod.UFASTCAST, 0)
    mob:setDelay(240)
    mob:setLocalVar('maneuvers', 0)
    mob:setLocalVar('meleeDamage', 0)
    mob:setLocalVar('rangedDamage', 0)
    mob:setLocalVar('magicDamage', 0)

    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobEngage = function(mob)
    mob:setLocalVar('nextManeuverTime', GetSystemTime() + 25)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Check if it's time for a manuever, if not, return.
    if mob:getLocalVar('nextManeuverTime') > GetSystemTime() then
        return
    end

    local meleeDamageTaken   = mob:getLocalVar('meleeDamage')
    local rangedDamageTaken  = mob:getLocalVar('rangedDamage')
    local magicDamageTaken   = mob:getLocalVar('magicDamage')
    local totalDamageTaken   = meleeDamageTaken + rangedDamageTaken + magicDamageTaken
    local highestDamageTaken = math.max(meleeDamageTaken, rangedDamageTaken, magicDamageTaken)
    local damageShare        = math.floor(100 * highestDamageTaken / totalDamageTaken)

    -- Update damage taken modifiers, only changes on status updates. Tested to confirm that one damage type will raise DT to 90%, even if its only a few damage.
    mob:setMod(xi.mod.UDMGPHYS, -math.floor(9000 * meleeDamageTaken / totalDamageTaken))
    mob:setMod(xi.mod.UDMGRANGE, -math.floor(9000 * rangedDamageTaken / totalDamageTaken))
    mob:setMod(xi.mod.UDMGMAGIC, -math.floor(9000 * magicDamageTaken / totalDamageTaken))

    -- Switch forms or execute maneuvers. Form/maneuver used based off of dominant damage type.
    if highestDamageTaken == meleeDamageTaken then
        handleAutomatonManeuver(mob, valoredgeModel, damageShare)
    elseif highestDamageTaken == rangedDamageTaken then
        handleAutomatonManeuver(mob, sharpshotModel, damageShare)
    else
        handleAutomatonManeuver(mob, stormwakerModel, damageShare)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    if
        mob:getModelId() == harlequinModel and
        mob:isEngaged()
    then
        return xi.magic.spell.DIA
    end

    local spellList =
    {
        [ 1] = { xi.magic.spell.BLAZE_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLAZE_SPIKES, 0, 100 },
        [ 2] = { xi.magic.spell.SLEEPGA_II,   target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,      2, 100 },
        [ 3] = { xi.magic.spell.SLEEPGA,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,      1, 100 },
        [ 4] = { xi.magic.spell.SLEEP,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,      1, 100 },
        [ 5] = { xi.magic.spell.STUN,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.STUN,         1, 100 },
        [ 6] = { xi.magic.spell.BLIND,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS,    1, 100 },
        [ 7] = { xi.magic.spell.BIND,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIND,         1, 100 },
        [ 8] = { xi.magic.spell.POISONGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,       1, 100 },
        [ 9] = { xi.magic.spell.BIO_II,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIO,          4, 100 },
        [10] = { xi.magic.spell.BURN,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BURN,         1, 100 },
        [11] = { xi.magic.spell.FROST,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.FROST,        1, 100 },
        [12] = { xi.magic.spell.CHOKE,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.CHOKE,        1, 100 },
        [13] = { xi.magic.spell.RASP,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.RASP,         1, 100 },
        [14] = { xi.magic.spell.DROWN,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DROWN,        1, 100 },
        [15] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DRAIN_HP,             nil,                    0, 100 },
        [16] = { xi.magic.spell.ASPIR,        target, false, xi.action.type.DRAIN_MP,             nil,                    0, 100 },
        [17] = { xi.magic.spell.FIRE_III,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [18] = { xi.magic.spell.BLIZZARD_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [19] = { xi.magic.spell.FIRAGA_II,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [20] = { xi.magic.spell.BLIZZAGA_II,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [21] = { xi.magic.spell.STONEGA_III,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [22] = { xi.magic.spell.THUNDAGA_II,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [23] = { xi.magic.spell.WATERGA_III,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [24] = { xi.magic.spell.FLARE,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [25] = { xi.magic.spell.QUAKE,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [26] = { xi.magic.spell.BURST,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [27] = { xi.magic.spell.FLOOD,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList = frames[mob:getModelId()].skillList

    return skillList[math.randomInt(1, #skillList)]
end

return entity
