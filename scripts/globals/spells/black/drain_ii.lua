-----------------------------------
-- Spell: Drain II
-- Drain functions only on Dark Magic skill level!
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Calculate base drain amount and potency
    -- https://www.bg-wiki.com/ffxi/Drain_II
    -- https://ffxiclopedia.fandom.com/wiki/Drain_II
    local base    = caster:getSkillLevel(xi.skill.DARK_MAGIC) + 20
    local potency = math.random(50, 100) / 100

    if caster:getSkillLevel(xi.skill.DARK_MAGIC) > 300 then
        base = caster:getSkillLevel(xi.skill.DARK_MAGIC) * 1.35
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
    -- Add in final adjustments

    if dmg < 0 then
        dmg = 0
    end

    if target:getHP() < dmg then
        dmg = target:getHP()
    end

    if target:isUndead() then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect

        return dmg
    end

    dmg = finalMagicAdjustments(caster, target, spell, dmg)

    local leftOver = (caster:getHP() + dmg) - caster:getMaxHP()

    if leftOver > 0 then
        caster:addStatusEffect(xi.effect.MAX_HP_BOOST, (leftOver / caster:getMaxHP()) * 100, 0, 180)
    end

    caster:addHP(dmg)
    spell:setMsg(xi.msg.basic.MAGIC_DRAIN_HP) -- Change message to '<amount> HP drained from the <target>.'

    return dmg
end

return spellObject
