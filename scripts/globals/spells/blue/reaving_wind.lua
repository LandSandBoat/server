-----------------------------------
-- Spell: Reaving Wind
-- Reduces TP for enemies within range
-- Spell cost: 84 MP
-- Monster Type: Birds
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: STR+2 AGI+2
-- Level: 90
-- Casting Time: 4 seconds
-- Recast Time:90 seconds
-- Combos: Conserve MP
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local resist = applyResistance(caster, target, spell, {
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
    })
    if (resist > 0.0625) then
        -- Base: 1000TP, Amorphs 750TP, Aquans 1250TP
        -- TP Reduction based on monster strength of spell
        local bird = {}
        function bird:getSystem()
            return xi.eco.BIRD
        end

        local reduction = 1000 + (utils.getSystemStrengthBonus(bird, target) * 250)
        target:setTP(math.max(target:getTP() - reduction, 0))
    end

    return 0
end

return spell_object
