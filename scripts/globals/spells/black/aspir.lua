-----------------------------------
-- Spell: Aspir
-- Aspir functions only on Dark Magic skill level!
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    -- Calculate base drain amount and potency
    -- https://www.bg-wiki.com/ffxi/Aspir
    local base    = (caster:getSkillLevel(xi.skill.DARK_MAGIC) / 3) + 20
    local potency = math.random(50, 100) / 100

    if caster:getSkillLevel(xi.skill.DARK_MAGIC) > 300 then
        base = caster:getSkillLevel(xi.skill.DARK_MAGIC) * 0.4
    end

    local dmg = base * potency
    -- Get the resist multiplier (1x if no resist)
    local params = {}
        params.diff      = caster:getStat(xi.mod.INT)-target:getStat(xi.mod.INT)
        params.attribute = xi.mod.INT
        params.skillType = xi.skill.DARK_MAGIC
        params.bonus     = 1.0
    local resist = applyResistance(caster, target, spell, params)
    -- Get the resisted damage
    dmg = dmg * resist
    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)
    -- Add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())

    -- Make final adjustments
    if dmg < 0 then
        dmg = 0
    end

    dmg = dmg * xi.settings.main.DARK_POWER

    if target:isUndead() then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect

        return dmg
    end

    if (target:getMP() > dmg) then
        caster:addMP(dmg)
        target:delMP(dmg)
    else
        dmg = target:getMP()

        caster:addMP(dmg)
        target:delMP(dmg)
    end

    return dmg
end

return spell_object
