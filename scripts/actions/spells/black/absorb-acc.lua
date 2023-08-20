-----------------------------------
-- Spell: Absorb-ACC
-- Steals an enemy's accuracy.
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if caster:hasStatusEffect(xi.effect.ACCURACY_BOOST) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
    else
        -- local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
        local params = {}
        params.diff = nil
        params.attribute = xi.mod.INT
        params.skillType = xi.skill.DARK_MAGIC
        params.bonus = 0
        params.effect = nil
        local resist = applyResistance(caster, target, spell, params)
        if resist <= 0.125 then
            spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        else
            spell:setMsg(xi.msg.basic.MAGIC_ABSORB_ACC)
            caster:addStatusEffect(xi.effect.ACCURACY_BOOST, xi.settings.main.ABSORB_SPELL_AMOUNT * resist * ((100 + (caster:getMod(xi.mod.AUGMENTS_ABSORB))) / 100), xi.settings.main.ABSORB_SPELL_TICK, xi.settings.main.ABSORB_SPELL_AMOUNT * xi.settings.main.ABSORB_SPELL_TICK) -- caster gains ACC
            target:addStatusEffect(xi.effect.ACCURACY_DOWN, xi.settings.main.ABSORB_SPELL_AMOUNT * resist * ((100 + (caster:getMod(xi.mod.AUGMENTS_ABSORB))) / 100), xi.settings.main.ABSORB_SPELL_TICK, xi.settings.main.ABSORB_SPELL_AMOUNT * xi.settings.main.ABSORB_SPELL_TICK)    -- target loses ACC
        end
    end

    return xi.effect.ACCURACY_BOOST
end

return spellObject
