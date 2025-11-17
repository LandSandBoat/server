-----------------------------------
-- Spell: Absolute Terror
-- Freezes target in fear (Terror status)
-- Spell cost: 29 MP
-- Monster Type: Dragon (Wyrm)
-- Spell Type: Enfeebling (Dark)
-- Blue Magic Points: 3
-- Stat Bonus: INT+2
-- Level: 96
-- Casting Time: 0.5 seconds
-- Recast Time: 30 seconds
-----------------------------------
-- Combos: None
-----------------------------------
-- Notes: Requires Unbridled Learning
-- Inflicts Terror status (prevents all actions)
-- Duration depends on Blue Magic Skill, Magic Accuracy, and resist
-- Can be resisted by NMs and some enemies
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    -- Requires Unbridled Learning
    if not caster:hasStatusEffect(xi.effect.UNBRIDLED_LEARNING) then
        return xi.msg.basic.STATUS_PREVENTS
    end

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local duration = 30  -- Base 30 seconds
    local params = {}
    params.diff = 0
    params.skillType = xi.skill.BLUE_MAGIC
    params.attribute = xi.mod.INT
    params.effect = xi.effect.TERROR

    local resist = applyResistanceEffect(caster, target, spell, { xi.element.DARK }, params.skillType)

    if resist > 0.125 then
        duration = duration * resist

        if target:addStatusEffect(xi.effect.TERROR, 1, 0, duration) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return xi.effect.TERROR
end

return spellObject
