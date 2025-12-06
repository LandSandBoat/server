-----------------------------------
-- Area: Throne Room
--  Mob: Shadow Lord
-- Mission 5-2 BCNM Fight
-----------------------------------
---@type TMobEntity
local entity = {}

local stanceTable =
{
-- [Stance] = { animationSub, canAutoAttack, canCastSpells, effectToApply, effectToDelete }
    [1] = { 1, false, true,  xi.effect.MAGIC_SHIELD,    xi.effect.PHYSICAL_SHIELD }, -- Magical Stance
    [2] = { 2, true,  false, xi.effect.PHYSICAL_SHIELD, xi.effect.MAGIC_SHIELD    }, -- Physical Stance
}

local function changeStance(mob, stance)
    -- Set behavior.
    mob:setAnimationSub(stanceTable[stance][1])
    mob:setAutoAttackEnabled(stanceTable[stance][2])
    mob:setMagicCastingEnabled(stanceTable[stance][3])
    mob:addStatusEffectEx(stanceTable[stance][4], 0, 1, 0, 0)
    mob:delStatusEffectSilent(stanceTable[stance][5])

    -- Set special modifiers for action delays.
    mob:setMod(xi.mod.HASTE_GEAR, 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 8)

    -- Save data.
    mob:setLocalVar('changeTime', mob:getBattleTime())
    mob:setLocalVar('changeHP', mob:getHP())
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    -- Ensure default state.
    mob:setAnimationSub(0)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:delStatusEffectSilent(xi.effect.PHYSICAL_SHIELD)
    mob:delStatusEffectSilent(xi.effect.MAGIC_SHIELD)
    mob:setMod(xi.mod.HASTE_GEAR, 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMod(xi.mod.DESPAWN_TIME_REDUCTION, 14)

    -- Ensure counter-attack.
    mob:addListener('TAKE_DAMAGE', 'COUNTER_WITH_BLIND', function(mobArg, amount, attacker, attackType, damageType)
        local animationSub = mobArg:getAnimationSub()

        if
            animationSub == 1 and                             -- Shadow Lord in magical stance.
            not xi.combat.behavior.isEntityBusy(mobArg) and   -- Shadow lord ain't busy.
            not attacker:hasStatusEffect(xi.effect.BLINDNESS) -- Target not blind.
        then
            mobArg:castSpell(xi.magic.spell.BLIND, attacker) -- Spell is casted on whoever attacked him. Ignores hate.
        end
    end)
end

entity.onMobFight = function(mob, target)
    -- Once he's under 50% HP, start changing immunities and attack patterns
    local animationSub = mob:getAnimationSub()
    local changeTime   = mob:getLocalVar('changeTime')
    local changeHP     = mob:getLocalVar('changeHP')

    switch (animationSub): caseof
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

entity.onMobMobskillChoose = function(mob, target)
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

entity.onMobDespawn = function(mob)
    mob:removeListener('COUNTER_WITH_BLIND')
end

return entity
