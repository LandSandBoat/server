-----------------------------------
-- Area: Misareaux Coast
--   NM: Gration
-----------------------------------
mixins = { require('scripts/mixins/fomor_hate') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SILENCE)

    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)

    -- If Gration spawned with a Picaroon's Shield, Tatami Shield is guaranteed drop, otherwise common drop.
    mob:addListener('ITEM_DROPS', 'ITEM_DROPS_GRATION', function(mobArg, loot)
        if mob:getLocalVar('shieldType') == xi.item.PICAROONS_SHIELD then
            loot:addItem(xi.item.TATAMI_SHIELD, xi.drop_rate.GUARANTEED)
        else
            loot:addItem(xi.item.TATAMI_SHIELD, xi.drop_rate.COMMON)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.HUMANOID_KILLER, 40)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 30)
    mob:setMod(xi.mod.REGAIN, 75)
    mob:setMod(xi.mod.ENSPELL_DMG_BONUS, 50)
    mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, 50)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setLocalVar('fomorHateAdj', 2)
    mob:setLocalVar('powerAttackRepeats', 0)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    if skillId == xi.mobSkill.POWER_ATTACK_ARMED_1 then
        return 0
    end

    local skillList =
    {
        xi.mobSkill.POWER_ATTACK_ARMED_1,
        xi.mobSkill.GRAND_SLAM_1,
    }

    return skillList[math.random(1, #skillList)]
end

-- All of Grations TP Moves have 0 Ready Time
entity.onMobSkillReadyTime = function(mob, target, skill)
    return 0
end

-- If Gration was spawned with a Picaroon's Shield, Power Attack repeats 2 additional times, otherwise only 1 additional time.
entity.onMobWeaponSkill = function(mob, target, skill, action)
    local allowedRepeats = 1
    if mob:getLocalVar('shieldType') == xi.item.PICAROONS_SHIELD then
        allowedRepeats = 2
    end

    if skill:getID() == xi.mobSkill.POWER_ATTACK_ARMED_1 then
        local powerAttackRepeats = mob:getLocalVar('powerAttackRepeats')

        if powerAttackRepeats < allowedRepeats then
            mob:useMobAbility(xi.mobSkill.POWER_ATTACK_ARMED_1, nil, 0)
            mob:setLocalVar('powerAttackRepeats', powerAttackRepeats + 1)
        else
            mob:setLocalVar('powerAttackRepeats', 0)
        end
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.THUNDAGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [2] = { xi.magic.spell.THUNDER_IV,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [3] = { xi.magic.spell.BURST,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [4] = { xi.magic.spell.HASTE,        mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.HASTE,        5, 100 },
        [5] = { xi.magic.spell.ENTHUNDER,    mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ENTHUNDER,    0, 100 },
        [6] = { xi.magic.spell.SHOCK_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.SHOCK_SPIKES, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
