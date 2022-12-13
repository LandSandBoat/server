-----------------------------------
-- Spell: Regurgitation
-- Deals Water damage to an enemy. Additional Effect: Bind
-- Spell cost: 69 MP
-- Monster Type: Lizards
-- Spell Type: Magical (Water)
-- Blue Magic Points: 1
-- Stat Bonus: INT+1 MND+1 MP+3
-- Level: 68
-- Casting Time: 5 seconds
-- Recast Time: 24 seconds
-- Magic Bursts on: Reverberation, Distortion, and Darkness
-- Combos: Resist Gravity
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
    params.ecosystem = xi.ecosystem.LIZARD
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.WATER
    params.attribute = xi.mod.INT
    params.multiplier = 1.83
    params.tMultiplier = 2.0
    params.duppercap = 69
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.3
    params.chr_wsc = 0.0
<<<<<<< refs/remotes/upstream/base
    params.diff = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.bonus = 1.0
    local damage = blueDoMagicalSpell(caster, target, spell, params, INT_BASED)
    if caster:isBehind(target, 15) then -- guesstimating the angle at 15 degrees here
        damage = math.floor(damage * 1.25)
    end
<<<<<<< refs/remotes/upstream/base

    damage = BlueFinalAdjustments(caster, target, spell, damage, params)
=======
    damage = blueFinalizeDamage(caster, target, spell, damage, params)
>>>>>>> Renamed BLU functions, added drain function (yet to rewire), used existing systemStrength table
=======
>>>>>>> Enfeebling diff/attribute fixes + general magic damage function + almost all magical dmg spells + AE

    params.addedEffect = xi.effect.BIND
    local power = 1
    local tick = 0
    local duration = 30

    local damage = blueDoMagicalSpell(caster, target, spell, params)
    if caster:isBehind(target) then damage = math.floor(damage * 1.25) end
    damage = blueFinalizeDamage(caster, target, spell, damage, params)
    blueDoMagicalSpellAddedEffect(caster, target, spell, params, power, tick, duration)

    return damage
end

return spellObject
