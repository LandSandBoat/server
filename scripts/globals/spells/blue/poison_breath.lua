-----------------------------------
-- Spell: Poison Breath
-- Deals water damage to enemies within a fan-shaped area originating from the caster. Additional effect: Poison
-- Spell cost: 22 MP
-- Monster Type: Undead
-- Spell Type: Magical (Water)
-- Blue Magic Points: 1
-- Stat Bonus: MND+1
-- Level: 22
-- Casting Time: 3 seconds
-- Recast Time: 19.5 seconds
-- Magic Bursts on: Reverberation, Distortion, and Darkness
-- Combos: Clear Mind
-- Damage formula is (Current HP)/10 + (Blue Mage level)/1.25
-- Gains a 25% damage boost when used against Arcana monsters.
-- Poison effect is 4/tick
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.UNDEAD
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.WATER
    params.diff = 0 -- no stat increases magic accuracy
    params.skillType = xi.skill.BLUE_MAGIC
    params.hpMod = 10
    params.lvlMod = 1.25

    local damage = blueDoBreathSpell(caster, target, spell, params)
    -- damage = blueFinalizeDamage(caster, target, spell, damage, params)

    -- Added effect: Poison (4/tick for 30s/60s)
    if damage > 0 and not target:hasStatusEffect(xi.effect.POISON) then
        local resist = applyResistanceEffect(caster, target, spell, params)
        if resist >= 0.5 then
            target:addStatusEffect(xi.effect.POISON, 4, 0, 60 * resist)
        end
    end

    return damage
end

return spellObject
