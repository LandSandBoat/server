-----------------------------------
-- Area: Riverne - Site B01 (BCNM)
-- NM: Bahamut
-- !pos -612.800 1.750 693.190 29
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
---@type TMobEntity
local entity = {}

local flareTable =
{
    [1] = { 89, xi.mobSkill.MEGAFLARE },
    [2] = { 79, xi.mobSkill.MEGAFLARE },
    [3] = { 69, xi.mobSkill.MEGAFLARE },
    [4] = { 59, xi.mobSkill.MEGAFLARE },
    [5] = { 49, xi.mobSkill.MEGAFLARE },
    [6] = { 39, xi.mobSkill.MEGAFLARE },
    [7] = { 29, xi.mobSkill.MEGAFLARE },
    [8] = { 19, xi.mobSkill.MEGAFLARE },
    [9] = {  9, xi.mobSkill.GIGAFLARE },
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 20)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 50)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 51)
    mob:setMod(xi.mod.UFASTCAST, 60)
    mob:setMod(xi.mod.ATT, 425)
    mob:addMod(xi.mod.REGAIN, 50)
    mob:addMod(xi.mod.REGEN, 50)
    mob:setMod(xi.mod.MDEF, 55)
    mob:addStatusEffect(xi.effect.PHALANX, { power = 35, duration = 180, origin = mob })
    mob:addStatusEffect(xi.effect.STONESKIN, { power = 350, duration = 300, origin = mob })
    mob:addStatusEffect(xi.effect.PROTECT, { power = 175, duration = 1800, origin = mob })
    mob:addStatusEffect(xi.effect.SHELL, { power = 24, duration = 1800, origin = mob })
    mob:setBehavior(xi.behavior.NO_TURN)
    mob:setMobAbilityEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:setAutoAttackEnabled(true)
    mob:setLocalVar('phase', 1)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local hpPercent       = mob:getHPP()
    local phase           = mob:getLocalVar('phase')
    local messagePlayed   = mob:getLocalVar('messagePlayed')

    local phaseData = flareTable[phase]
    if not phaseData then
        return
    end

    local threshold = phaseData[1]
    local flare     = phaseData[2]

    -- If were above the HP threshold, and haven't played the message, do nothing.(We check messagePlayed as well because Bahamut has a very strong Regen)
    if
        hpPercent > threshold and
        messagePlayed == 0
    then
        return
    end

    -- Play message Sequence, if it's phase 9 play the Gigaflare message instead.
    if
        messagePlayed == 0 and
        phase < 9
    then
        mob:messageText(mob, ID.text.BAHAMUT_TAUNT)
        mob:setLocalVar('messagePlayed', 1)
        mob:setMobAbilityEnabled(false)
        mob:setMagicCastingEnabled(false)
        mob:setAutoAttackEnabled(false)

        mob:timer(2000, function(mobArg)
            mobArg:messageText(mobArg, ID.text.BAHAMUT_TAUNT + 1)
            mobArg:setLocalVar('messagePlayed', 2)
        end)
    elseif
        messagePlayed == 0 and
        phase == 9
    then
        mob:messageText(mob, ID.text.BAHAMUT_TAUNT + 2)
        mob:setLocalVar('messagePlayed', 2)
        mob:setMobAbilityEnabled(false)
        mob:setMagicCastingEnabled(false)
        mob:setAutoAttackEnabled(false)
        return
    end

    -- Use Megaflare / Gigaflare
    if
        messagePlayed == 2 and
        mob:checkDistance(target) <= 8
    then
        mob:useMobAbility(flare)

        mob:setLocalVar('phase', phase + 1)
        mob:setLocalVar('messagePlayed', 0)

        mob:setMobAbilityEnabled(true)
        mob:setMagicCastingEnabled(true)
        mob:setAutoAttackEnabled(true)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skills =
    {
        xi.mobSkill.TRAMPLE_BAHAMUT,
        xi.mobSkill.TEMPEST_WING,
        xi.mobSkill.TOUCHDOWN_BAHAMUT,
        xi.mobSkill.SWEEPING_FLAIL,
        xi.mobSkill.PRODIGIOUS_SPIKE,
        xi.mobSkill.IMPULSION,
        xi.mobSkill.ABSOLUTE_TERROR_BAHAMUT,
        xi.mobSkill.HORRIBLE_ROAR_BAHAMUT
    }

    return skills[math.random(1, #skills)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.FIRE_V,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 2] = { xi.magic.spell.FIRAGA_IV, target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 3] = { xi.magic.spell.FLARE_II,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 4] = { xi.magic.spell.CURE_V,    mob,    false, xi.action.type.HEALING_TARGET,       50,                  0, 100 },
        [ 5] = { xi.magic.spell.SILENCEGA, target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SILENCE,   0, 100 },
        [ 6] = { xi.magic.spell.GRAVIGA,   target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.WEIGHT,    0, 100 },
        [ 7] = { xi.magic.spell.PROTECT_V, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.PROTECT,   0, 100 },
        [ 8] = { xi.magic.spell.SHELL_V,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.SHELL,     0, 100 },
        [ 9] = { xi.magic.spell.STONESKIN, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN, 0, 100 },
        [10] = { xi.magic.spell.PHALANX,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.PHALANX,   0, 100 },
    }

    if target:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) then
        table.insert(spellList, #spellList + 1, { xi.magic.spell.DISPELGA, target, false, xi.action.type.NONE, nil, 0, 100 })
    end

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
