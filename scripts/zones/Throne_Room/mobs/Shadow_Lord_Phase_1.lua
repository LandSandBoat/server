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
    mob:setLocalVar('changeTime', mob:getBattleTime())
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
    mob:setMod(xi.mod.DESPAWN_TIME_REDUCTION, 14)
end

entity.onMobFight = function(mob, target)
    -- Once he's under 50% HP, start changing immunities and attack patterns
    local changeTime = mob:getLocalVar('changeTime')
    local changeHP   = mob:getLocalVar('changeHP')

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
                mob:getBattleTime() - changeTime > 300
            then
                changeStance(mob, 2) -- Change to physical stance.
            end
        end,

        -- Physical stance.
        [2] = function()
            if
                mob:getHP() <= changeHP - 1000 or
                mob:getBattleTime() - changeTime > 300
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

    local randomRoll = math.random(1, 100)
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
        xi.magic.spell.AEROGA_II,
        xi.magic.spell.BLIZZAGA_II,
        xi.magic.spell.DRAIN,
        xi.magic.spell.FIRAGA_II,
        xi.magic.spell.STONEGA_II,
        xi.magic.spell.WATERGA_II,
    }

    if not mob:hasStatusEffect(xi.effect.ICE_SPIKES) then
        table.insert(spellList, xi.magic.spell.ICE_SPIKES)
    end

    if not target:hasStatusEffect(xi.effect.BLINDNESS) then
        table.insert(spellList, xi.magic.spell.BLIND)
    end

    if not target:hasStatusEffect(xi.effect.DROWN) then
        table.insert(spellList, xi.magic.spell.DROWN)
    end

    if not target:hasStatusEffect(xi.effect.FROST) then
        table.insert(spellList, xi.magic.spell.FROST)
    end

    if not target:hasStatusEffect(xi.effect.RASP) then
        table.insert(spellList, xi.magic.spell.RASP)
    end

    return spellList[math.random(1, #spellList)]
end

return entity
