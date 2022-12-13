-----------------------------------
-- Spell: Corrosive Ooze
-- Deals water damage to an enemy. Additional Effect: Attack Down and Defense Down
-- Spell cost: 55 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Water)
-- Blue Magic Points: 4
-- Stat Bonus: HP-10 MP+10
-- Level: 66
-- Casting Time: 5 seconds
-- Recast Time: 30 seconds
-----------------------------------
-- Combos: Clear Mind
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
    params.ecosystem = xi.ecosystem.AMORPH
<<<<<<< refs/remotes/upstream/base
    local multi = 2.125
    if caster:hasStatusEffect(xi.effect.AZURE_LORE) then
        multi = multi + 0.50
    end

=======
>>>>>>> Enfeebling diff/attribute fixes + general magic damage function + almost all magical dmg spells + AE
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.WATER
    params.attribute = xi.mod.INT
    params.multiplier = 2.125
    params.azureBonus = 0.5
    params.tMultiplier = 2.0
    params.duppercap = 69
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.2
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local typeEffectOne = xi.effect.DEFENSE_DOWN
    local typeEffectTwo = xi.effect.ATTACK_DOWN
    local power = 5
    local tick = 0
    local duration = 90

    local damage = blueDoMagicalSpell(caster, target, spell, params)
    damage = blueFinalizeDamage(caster, target, spell, damage, params)

    params.diff = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    params.skillType = xi.skill.BLUE_MAGIC
    local resist = applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then
        target:addStatusEffect(typeEffectOne, power, tick, duration * resist)
        target:addStatusEffect(typeEffectTwo, power, tick, duration * resist)
    end

    return damage
end

return spellObject
