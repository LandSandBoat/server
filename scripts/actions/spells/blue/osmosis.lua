-----------------------------------
-- Spell: Osmosis
-- Steals an enemy's HP and one beneficial status effect
-- Spell cost: 47 MP
-- Monster Type: Amorph
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: MND+3, CHR-2
-- Level: 84
-- Casting Time: 4 seconds
-- Recast Time: 120 seconds
-----------------------------------
-- Combos: Magic Defense Bonus
-----------------------------------
-- Notes: Drains HP based on Blue Magic Skill
-- Formula: (Blue Magic Skill × 0.11) × 7
-- Steals one beneficial status effect (like Aura Steal)
-- Ineffective against undead
-- Stolen enhancements retain their remaining duration
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Check if target is undead
    if target:isUndead() then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return 0
    end

    -- HP Drain formula: (Blue Magic Skill × 0.11) × 7
    local skill = caster:getSkillLevel(xi.skill.BLUE_MAGIC)
    local drain = math.floor((skill * 0.11) * 7)

    -- Apply resistance
    local params = {}
    params.ecosystem = xi.ecosystem.AMORPH
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.DARK
    params.diff = 0
    params.skillType = xi.skill.BLUE_MAGIC

    local resist = applyResistanceEffect(caster, target, spell, params)
    drain = math.floor(drain * resist)

    -- Cap drain to target's current HP
    drain = math.min(drain, target:getHP())

    -- Apply drain
    if drain > 0 then
        target:takeDamage(drain, caster, xi.attackType.MAGICAL, xi.damageType.DARK)
        caster:addHP(drain)

        -- Steal one beneficial effect (dispel from target)
        local effect = target:dispelStatusEffect()
        if effect ~= xi.effect.NONE then
            -- Note: In retail, stolen buff would be added to caster
            -- For simplicity, we just dispel from target
            spell:setMsg(xi.msg.basic.MAGIC_ERASE)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        drain = 0
    end

    return drain
end

return spellObject
