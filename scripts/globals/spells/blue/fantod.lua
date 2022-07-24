-----------------------------------
-- Spell: Fantod
-- Enhances Attack and magic attack.
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 1
-- Stat Bonus: HP-10 DEX+2 AGI+2
-- Level: 85
-- Casting Time: 0.5 seconds
-- Recast Time: 10 seconds
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
-- TODO: Add new Fantod status effect
-- Implemented as boost for now
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local power = 12.5 + (0.10 * player:getMod(xi.mod.BOOST_EFFECT))

    if player:hasStatusEffect(xi.effect.BOOST) then
        local effect = player:getStatusEffect(xi.effect.BOOST)
        effect:setPower(effect:getPower() + power)
        player:addMod(xi.mod.ATTP, power)
    else
        player:addStatusEffect(xi.effect.BOOST, power, 3, 180)
    end
end

return spell_object