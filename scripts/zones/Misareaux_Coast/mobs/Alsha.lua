-----------------------------------
--  Area: Misareaux Coast
--    NM: Alsha
-- Quest: Knocking on Forbidden Doors
-----------------------------------
local ID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SKIP_ALLEGIANCE_CHECK, 1)
    mob:setMod(xi.mod.STORETP, 125)
    mob:setMod(xi.mod.SPELLINTERRUPT, 100)
    mob:setMobMod(xi.mobMod.NO_SPELL_COST, 0)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:setMobAbilityEnabled(true)

    mob:setLocalVar('FinalPhase', 0)
    mob:setLocalVar('CuresCasted', 0)
    mob:setLocalVar('CureTime', GetSystemTime() + math.random(45, 90))
end

entity.onMobFight = function(mob, target)
    -- Early return: Mob is busy.
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Final phase behavior: Cast Fire II on itself.
    local finalPhase = mob:getLocalVar('FinalPhase')
    if finalPhase == 1 then
        mob:castSpell(xi.magic.spell.FIRE_II, mob)
        return
    end

    -- Evaluate battle phase and change if applicable.
    local currentTime = GetSystemTime()
    local isCureTime  = mob:getLocalVar('CureTime') <= currentTime
    local curesCasted = mob:getLocalVar('CuresCasted')
    if
        mob:getHPP() < 25 or
        (curesCasted >= 3 and isCureTime)
    then
        mob:setLocalVar('FinalPhase', 1)
        mob:messageText(mob, ID.text.LARGE_DROPS_OF_OIL, false)
        mob:setMobMod(xi.mobMod.NO_SPELL_COST, 1)
        mob:setAutoAttackEnabled(false)
        mob:setMagicCastingEnabled(false)
        mob:setMobAbilityEnabled(false)
        return
    end

    -- Regular behavior: Occasionally cast Cure III on oponent.
    if isCureTime then
        mob:messageText(mob, ID.text.DROP_OF_OIL, false)
        mob:setLocalVar('CureTime', GetSystemTime() + math.random(30, 90))
        mob:setLocalVar('CuresCasted', curesCasted + 1)
        mob:castSpell(xi.magic.spell.CURE_III, target)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local tpTable =
    {
        xi.mobSkill.SHINING_STRIKE_1,
        xi.mobSkill.SERAPH_STRIKE_1,
        xi.mobSkill.BRAINSHAKER_1,
        xi.mobSkill.SKULLBREAKER_1,
        xi.mobSkill.TRUE_STRIKE_1,
    }

    return tpTable[math.random(1, #tpTable)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.AERO_II,      target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 2] = { xi.magic.spell.AEROGA_II,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 3] = { xi.magic.spell.BLIZZARD_II,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 4] = { xi.magic.spell.BLIZZAGA,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 5] = { xi.magic.spell.FIRE_II,      target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 6] = { xi.magic.spell.FIRAGA_II,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 7] = { xi.magic.spell.FREEZE,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 8] = { xi.magic.spell.PARALYZE,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.PARALYSIS,    0, 100 },
        [ 9] = { xi.magic.spell.QUAKE,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [10] = { xi.magic.spell.SHOCK_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.SHOCK_SPIKES, 0, 100 },
        [11] = { xi.magic.spell.SILENCE,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SILENCE,      0, 100 },
        [12] = { xi.magic.spell.SLEEPGA_II,   target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_II,     2, 100 },
        [13] = { xi.magic.spell.STONE_III,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [14] = { xi.magic.spell.STONEGA_II,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [15] = { xi.magic.spell.THUNDER_II,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [16] = { xi.magic.spell.THUNDAGA,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [17] = { xi.magic.spell.WATER_III,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [18] = { xi.magic.spell.WATERGA_II,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
