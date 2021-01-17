-----------------------------------
-- Spell: Distract
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    -- Pull base stats.
    local dMND = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)

    -- Base evasion reduction is determend by enfeebling skill
    -- Caps at -25 evasion at 125 skill
    local basePotency = utils.clamp(math.floor(caster:getSkillLevel(tpz.skill.ENFEEBLING_MAGIC) / 5), 0, 25)

    -- dMND is tacked on after
    -- Min cap: 0 at 0 dMND
    -- Max cap: 10 at 50 dMND
    basePotency = basePotency + utils.clamp(math.floor(dMND / 5), 0, 10)
    local power = calculatePotency(basePotency, spell:getSkillType(), caster, target)

    -- Duration, including resistance.  Unconfirmed.
    local duration = calculateDuration(120, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local params = {}
    params.diff = dMND
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.EVASION_DOWN
    local resist = applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then -- Do it!
        if target:addStatusEffect(params.effect, power, 0, duration * resist) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end

return spell_object
