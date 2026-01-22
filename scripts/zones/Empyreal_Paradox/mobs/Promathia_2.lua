-----------------------------------
-- Area: Empyreal Paradox
--  Mob: Promathia
-- Note: Phase 2
-----------------------------------
local ID = zones[xi.zone.EMPYREAL_PARADOX]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.STUN)
    mob:setMod(xi.mod.REGAIN, 75)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 15)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('nextBreakpoint', 90)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 350)
    mob:setMod(xi.mod.DEF, 250)
    mob:setMod(xi.mod.MDEF, 30)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)

    mob:addListener('WEAPONSKILL_STATE_ENTER', 'PROMY_SKILL_MSG', function(mobArg, skillID)
        if
            skillID == xi.mobSkill.WHEEL_OF_IMPREGNABILITY or
            skillID == xi.mobSkill.BASTION_OF_TWILIGHT
        then
            mob:messageText(mob, ID.text.PROMATHIA_TEXT + 5)
        elseif
            skillID == xi.mobSkill.WINDS_OF_OBLIVION or
            skillID == xi.mobSkill.SEAL_OF_QUIESCENCE
        then
            mob:messageText(mob, ID.text.PROMATHIA_TEXT + 6)
        end
    end)
end

entity.onMobFight = function(mob, target)
    local battlefield = mob:getBattlefield()
    if xi.combat.behavior.isEntityBusy(mob) or not battlefield then
        return
    end

    -- Trigger Prishe reaction on first instance of damage done to Promathia
    if mob:getLocalVar('damageTaken') == 0 and mob:getHPP() < 100 then
        battlefield:setLocalVar('prisheReact', 2)
        mob:setLocalVar('damageTaken', 1)
    end

    -- Reset animation after lance wears off
    if
        mob:getAnimationSub() == 3 and
        not mob:hasStatusEffect(xi.effect.TERROR)
    then
        mob:setAnimationSub(0)
        mob:stun(1500)
    end

    -- HP breakpoints: Go physical or magic immune every 10% HP
    local nextBreakpoint = mob:getLocalVar('nextBreakpoint')
    if
        mob:getAnimationSub() == 0 and
        mob:getHPP() < nextBreakpoint
    then
        local pickImmune = math.random(1, 100) <= 50 and xi.mobSkill.WHEEL_OF_IMPREGNABILITY or xi.mobSkill.BASTION_OF_TWILIGHT
        mob:useMobAbility(pickImmune)
        mob:setLocalVar('nextBreakpoint', nextBreakpoint - 10)
    end
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == xi.magic.spell.METEOR then
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setRadius(25)
        spell:setAnimation(280)
        spell:setMPCost(1)
    elseif spell:getID() == xi.magic.spell.COMET then
        spell:setMPCost(1)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    if math.random(1, 100) <= 25 then
        return xi.magic.spell.COMET
    else
        return xi.magic.spell.METEOR
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local tpList = {}
    if
        mob:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) or
        mob:hasStatusEffect(xi.effect.MAGIC_SHIELD)
    then
        table.insert(tpList, xi.mobSkill.WINDS_OF_OBLIVION)
        table.insert(tpList, xi.mobSkill.SEAL_OF_QUIESCENCE)
    else
        table.insert(tpList, xi.mobSkill.MALEVOLENT_BLESSING_2)
        table.insert(tpList, xi.mobSkill.PESTILENT_PENANCE_2)
        table.insert(tpList, xi.mobSkill.EMPTY_SALVATION_2)
        table.insert(tpList, xi.mobSkill.INFERNAL_DELIVERANCE_2)
    end

    return tpList[math.random(#tpList)]
end

entity.onMobDespawn = function(mob)
    mob:removeListener('PROMY_SKILL_MSG')
end

return entity
