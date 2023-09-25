-----------------------------------
-- Spell: Distract
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Pull base stats.
    local dMND = caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)

    -- Base evasion reduction is determend by enfeebling skill
    -- Caps at -25 evasion at 125 skill
    local basePotency = utils.clamp(math.floor(caster:getSkillLevel(xi.skill.ENFEEBLING_MAGIC) / 5), 0, 25)

    -- dMND is tacked on after
    -- Min cap: 0 at 0 dMND
    -- Max cap: 10 at 50 dMND
    basePotency = basePotency + utils.clamp(math.floor(dMND / 5), 0, 10)
    local power = xi.magic.calculatePotency(basePotency, spell:getSkillType(), caster, target)

    -- Duration, including resistance.  Unconfirmed.
    local duration = xi.magic.calculateDuration(120, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local params = {}
    params.diff = dMND
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 150
    params.effect = xi.effect.EVASION_DOWN
    local resist = xi.magic.applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then -- Do it!
        if target:addStatusEffect(params.effect, power, 0, duration * resist) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end

return spellObject
