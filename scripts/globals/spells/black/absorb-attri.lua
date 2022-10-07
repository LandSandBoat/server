-----------------------------------
-- Spell: Absorb-Attri
-- Steals an enemy's beneficial status effects.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- TODO: Get correct animation from retail captures
    -- Get the resist multiplier (1x if no resist)
    local params = {}
        params.attribute = xi.mod.INT
        params.skillType = xi.skill.DARK_MAGIC
    local resist       = applyResistance(caster, target, spell, params)
    local effect       = 0
    local bonusEffect  = 0
    local countEffects = 0

    if resist > 0.0625 then
        spell:setMsg(xi.msg.basic.STATUS_DRAIN)

        effect = caster:stealStatusEffect(target, xi.effectFlag.DISPELABLE)

        if caster:hasStatusEffect(xi.effect.NETHER_VOID) then
            bonusEffect = caster:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
            caster:delStatusEffect(xi.effect.NETHER_VOID)
        end

        if bonusEffect ~= 0 then
            countEffects = 2
        elseif effect ~= 0 then
            countEffects = 1
        end

        if effect == 0 then
            -- Failed to steal effect
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return countEffects
end

return spellObject
