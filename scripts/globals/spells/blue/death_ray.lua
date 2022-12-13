-----------------------------------
-- Spell: Death Ray
-- Deals dark damage to an enemy
-- Spell cost: 49 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 2
-- Stat Bonus: HP-5, MP+5
-- Level: 34
-- Casting Time: 4.5 seconds
-- Recast Time: 29.25 seconds
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: None
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
    local multi = 1.625
    if caster:hasStatusEffect(xi.effect.AZURE_LORE) then
        multi = multi + 2.0
    end

=======
>>>>>>> Enfeebling diff/attribute fixes + general magic damage function + almost all magical dmg spells + AE
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.DARK
    params.attribute = xi.mod.INT
    params.multiplier = 1.625
    params.azureBonus = 2
    params.tMultiplier = 1.0
    params.duppercap = 51
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.2
    params.mnd_wsc = 0.1
    params.chr_wsc = 0.0
    
    local damage = blueDoMagicalSpell(caster, target, spell, params)
    damage = blueFinalizeDamage(caster, target, spell, damage, params)

    return damage
end

return spellObject
