-----------------------------------
-- Area: Throne Room
--  Mob: Shadow Lord
-- Mission 5-2 BCNM Fight
-----------------------------------
---@type TMobEntity
local entity = {}

local function changeStance(mob, stance)
    -- Set behavior.
    mob:setAnimationSub(stance)
    mob:setAutoAttackEnabled(stance == 2 and true or false)
    mob:setMagicCastingEnabled(stance == 1 and true or false)

    -- Set effects.
    if stance == 2 then
        mob:addStatusEffect(xi.effect.PHYSICAL_SHIELD, { power = 1, origin = mob, icon = 0 })
        mob:addStatusEffect(xi.effect.ARROW_SHIELD, { power = 1, origin = mob, icon = 0 })
        mob:delStatusEffectSilent(xi.effect.MAGIC_SHIELD)
    else
        mob:delStatusEffectSilent(xi.effect.PHYSICAL_SHIELD)
        mob:delStatusEffectSilent(xi.effect.ARROW_SHIELD)
        mob:addStatusEffect(xi.effect.MAGIC_SHIELD, { power = 1, origin = mob, icon = 0 })
    end

    -- Set special modifiers for action delays.
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 8)

    -- Save data.
    mob:setLocalVar('changeTime', GetSystemTime())
    mob:setLocalVar('changeHP', mob:getHP())
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)

    -- Counter-attack with "Blind" spell when in magical stance.
    mob:addListener('TAKE_DAMAGE', 'COUNTER_WITH_BLIND', function(mobArg, amount, attacker, attackType, damageType)
        if not attacker then
            return
        end

        if mobArg:getAnimationSub() ~= 1 then
            return
        end

        if xi.combat.behavior.isEntityBusy(mobArg) then
            return
        end

        if attacker:hasStatusEffect(xi.effect.BLINDNESS) then
            return
        end

        mobArg:castSpell(xi.magic.spell.BLIND, attacker) -- Spell is casted on whoever attacked him. Ignores hate.
    end)
end

entity.onMobSpawn = function(mob)
    -- Ensure default state.
    mob:setAnimationSub(0)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:delStatusEffectSilent(xi.effect.PHYSICAL_SHIELD)
    mob:delStatusEffectSilent(xi.effect.ARROW_SHIELD)
    mob:delStatusEffectSilent(xi.effect.MAGIC_SHIELD)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.NO_SPELL_COST, 1)
    mob:setMod(xi.mod.DESPAWN_TIME_REDUCTION, 14)
end

entity.onMobFight = function(mob, target)
    -- Once he's under 50% HP, start changing immunities and attack patterns
    local currentTime = GetSystemTime()
    local changeTime  = mob:getLocalVar('changeTime')
    local changeHP    = mob:getLocalVar('changeHP')

    switch (mob:getAnimationSub()): caseof
    {
        -- Initial phase.
        [0] = function()
            if mob:getHPP() <= 50 then
                changeStance(mob, 1) -- Change to magical stance.
            end
        end,

        -- Magical stance.
        [1] = function()
            if
                mob:getHP() <= changeHP - 1000 or
                currentTime - changeTime > 300
            then
                changeStance(mob, 2) -- Change to physical stance.
            end
        end,

        -- Physical stance.
        [2] = function()
            if
                mob:getHP() <= changeHP - 1000 or
                currentTime - changeTime > 300
            then
                mob:useMobAbility(xi.mobSkill.DARK_NOVA)
                changeStance(mob, 1) -- Change to magical stance.
            end
        end,
    }
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local mobskillTable =
    {
        [1] = { xi.mobSkill.KICK_BACK,   25 },
        [2] = { xi.mobSkill.UMBRA_SMASH, 35 },
        [3] = { xi.mobSkill.GIGA_SLASH,  25 },
        [4] = { xi.mobSkill.DARK_NOVA,   15 },
    }

    local randomRoll = math.randomInt(1, 100)
    local weightSum  = 0
    for i = 1, #mobskillTable do
        weightSum = weightSum + mobskillTable[i][2]
        if randomRoll <= weightSum then
            return mobskillTable[i][1]
        end
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1]  = { xi.magic.spell.AEROGA_II,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [2]  = { xi.magic.spell.BLIZZAGA_II, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [3]  = { xi.magic.spell.FIRAGA_II,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [4]  = { xi.magic.spell.STONEGA_II,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [5]  = { xi.magic.spell.WATERGA_II,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [6]  = { xi.magic.spell.DRAIN,       target, false, xi.action.type.DRAIN_HP,             nil,                  0, 100 },
        [7]  = { xi.magic.spell.BLIND,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS,  0, 100 },
        [8]  = { xi.magic.spell.DROWN,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DROWN,      0, 100 },
        [9]  = { xi.magic.spell.FROST,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.FROST,      0, 100 },
        [10] = { xi.magic.spell.RASP,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.RASP,       0, 100 },
        [11] = { xi.magic.spell.ICE_SPIKES,  mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ICE_SPIKES, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
