-----------------------------------
-- Area: Balgas Dais
--  Mob: Macan Gadangan
-- BCNM: Wild Wild Whiskers
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------
---@type TMobEntity
local entity = {}

-- Phase table : data = { [1] Times Interrupted, [2] Spell Multiplier, [3] Magic Cooldown { min, max }, [4] Spell List, [5] Message }
local phaseTable =
{
    [1] = {  0,   0, { 40, 50 }, { xi.magic.spell.THUNDER, xi.magic.spell.THUNDAGA, xi.magic.spell.THUNDER_II, xi.magic.spell.THUNDAGA_II }, balgasID.text.WILD_WILD_WHISKERS_OFFSET     }, -- Slightly...
    [2] = {  1,  10, { 35, 45 }, { xi.magic.spell.THUNDAGA, xi.magic.spell.THUNDER_II, xi.magic.spell.THUNDAGA_II },                         balgasID.text.WILD_WILD_WHISKERS_OFFSET + 1 }, -- Rapidly...
    [3] = {  2,  30, { 30, 40 }, { xi.magic.spell.THUNDER_II, xi.magic.spell.THUNDAGA_II },                                                  balgasID.text.WILD_WILD_WHISKERS_OFFSET + 2 }, -- Wildly...
    [4] = {  3,  50, { 25, 35 }, { xi.magic.spell.THUNDAGA_II },                                                                             balgasID.text.WILD_WILD_WHISKERS_OFFSET + 3 }, -- Violently...
    [5] = {  0,  70, { 20, 30 }, { xi.magic.spell.BURST },                                                                                   balgasID.text.WILD_WILD_WHISKERS_OFFSET + 4 }, -- Uncontrollably!
}

local function scheduleSpell(mob, delay)
    local currentPhase  = mob:getLocalVar('phase')
    local spellCooldown = phaseTable[currentPhase][3]
    local castTime      = GetSystemTime() + (delay or math.randomInt(spellCooldown[1], spellCooldown[2]))

    mob:setLocalVar('messageTime', castTime - 3)
    mob:setLocalVar('castTime', castTime)
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMod(xi.mod.REGAIN, 50)
    mob:setMod(xi.mod.REFRESH, 50) -- Seems to be able to cast spells infinitely, either has strong refresh or ludicrous MP pool
    mob:setMod(xi.mod.DOUBLE_ATTACK, 30)
    mob:setMagicCastingEnabled(false) -- Casting is done manually since flavor text always plays 3 seconds before the spell is actually cast.

    -- If silenced during any point in the fight, becomes immune silence and resistant to interrupts. Only uses Burst.
    mob:addListener('EFFECT_GAIN', 'WHISKERS_SILENCED', function(mobArg, effect)
        if
            effect:getEffectType() == xi.effect.SILENCE and
            mobArg:getLocalVar('phase') < 5
        then
            mobArg:setLocalVar('phase', 5)
            mobArg:setLocalVar('messageTime', 0)
            mobArg:setLocalVar('castTime', 0)
            mobArg:setMod(xi.mod.SPELLINTERRUPT, 50)
            mobArg:setMod(xi.mod.SILENCE_RES_RANK, 11)
            mobArg:setMod(xi.mod.POWER_MULTIPLIER_SPELL, phaseTable[5][2])
        end
    end)

    -- Once the silence effect wears off, schedule the next spell cast
    mob:addListener('EFFECT_LOSE', 'WHISKERS_SILENCE_WORE', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.SILENCE then
            scheduleSpell(mobArg)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SPELLINTERRUPT, -50)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 0)
    mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, 0)

    mob:setLocalVar('phase', 1)
    mob:setLocalVar('wasInterrupted', 0)
    mob:setLocalVar('messageTime', 0)
    mob:setLocalVar('castTime', 0)
end

entity.onMobEngage = function(mob, target)
    scheduleSpell(mob, 10)
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar('messageTime', 0)
    mob:setLocalVar('castTime', 0)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local currentTime  = GetSystemTime()
    local currentPhase = mob:getLocalVar('phase')
    local messageTime  = mob:getLocalVar('messageTime')
    local castTime     = mob:getLocalVar('castTime')

    -- If Macan Gadangan was interrupted, retaliate with Charged Whisker or Frenzied rage depending on the phase.
    if mob:getLocalVar('wasInterrupted') == 1 then
        mob:setLocalVar('wasInterrupted', 0)

        if
            currentPhase == 5 and
            mob:checkDistance(target) <= 10
        then
            mob:useMobAbility(xi.mobSkill.CHARGED_WHISKER)
        elseif currentPhase < 5 then
            mob:useMobAbility(xi.mobSkill.FRENZIED_RAGE_1)
        end

        return
    end

    -- If no cast time is scheduled or the mob is silenced, do nothing.
    if
        castTime == 0 or
        mob:hasStatusEffect(xi.effect.SILENCE)
    then
        return
    end

    local phase = phaseTable[currentPhase]

    -- Play the flavor text message 3 seconds before cast begins.
    if
        messageTime > 0 and
        currentTime >= messageTime
    then
        mob:messageText(mob, phase[5], false)
        mob:setLocalVar('messageTime', 0)
        mob:setLocalVar('castTime', currentTime + 3)
    end

    -- If the message has been displayed and it's time to cast the spell, cast it - then schedule the next spell.
    if
        messageTime == 0 and
        currentTime >= castTime
    then
        mob:castSpell(phase[4][math.randomInt(1, #phase[4])])
        scheduleSpell(mob)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local mobskillList =
    {
        xi.mobSkill.CHARGED_WHISKER,
        xi.mobSkill.CHAOTIC_EYE_1,
        xi.mobSkill.POUNCE,
    }

    if mob:getLocalVar('phase') >= 4 then
        table.insert(mobskillList, xi.mobSkill.PETRIFACTIVE_BREATH)
    end

    return mobskillList[math.randomInt(1, #mobskillList)]
end

entity.onSpellInterrupted = function(mob, spell)
    local currentPhase = mob:getLocalVar('phase')

    if currentPhase < 4 then
        currentPhase = currentPhase + 1
        mob:setLocalVar('phase', currentPhase)
        mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, phaseTable[currentPhase][2])
    end

    mob:setLocalVar('wasInterrupted', 1)

    scheduleSpell(mob)
end

return entity
