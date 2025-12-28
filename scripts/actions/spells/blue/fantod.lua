-----------------------------------
-- Spell: Fantod 
-- Enhances attack and magic attack.  
-- Spell cost: 12 MP
-- Monster Type: Birds
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 1
-- Stat Bonus: HP-20 DEX+2 AGI+2
-- Level: 85
-- Casting Time: 0.5 Seconds
-- Recast Time: 10 Seconds
-- 3 minutes or next attack
-----------------------------------
-- Combos: Store TP
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
-----------------------------------
-- Fantod Function
-----------------------------------
xi.job_utils.blue_mage.useFantod = function(player, target, spell)
    local power = 12.5 + (0.10 * player:getMod(xi.mod.BOOST_EFFECT))

    if player:hasStatusEffect(xi.effect.BOOST) then
        local effect = player:getStatusEffect(xi.effect.BOOST)

        effect:setPower(effect:getPower() + power) -- Store updated power in boost for zoning
        effect:addMod(xi.mod.ATTP, power)
    else
        player:addStatusEffect(xi.effect.ATTACK_BOOST, power, 0, 180)
        player:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, power, 0, 180)
    end
    return xi.mod.BOOST_EFFECT
end

return spellObject
