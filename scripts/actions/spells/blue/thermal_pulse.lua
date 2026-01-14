-----------------------------------
-- Spell: Thermal Pulse
-- Deals Fire damage to enemies within area of effect. Additional effect: Blindness
-- Spell cost: 151 MP
-- Monster Type: Vermin
-- Spell Type: Magical (FIRE)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+2
-- Level: 86
-- Casting Time: 5.5 seconds
-- Recast Time: 70 seconds
-- Magic Bursts on: None
-- Combos: Attck Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem   = xi.ecosystem.VERMIN
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.FIRE
    params.attribute   = xi.mod.INT
    params.multiplier  = 2.0
    params.tMultiplier = 4.0 -- https://www.ffxiah.com/forum/topic/30626/the-beast-within-a-guide-to-blue-mage/#spells concurs with https://wiki.ffo.jp/html/22468.html on tp
    params.duppercap   = 100
    params.str_wsc     = 0.0
    params.dex_wsc     = 0.0
    params.vit_wsc     = 0.4
    params.agi_wsc     = 0.0
    params.int_wsc     = 0.0
    params.mnd_wsc     = 0.0
    params.chr_wsc     = 0.0

    -- Handle damage.
    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    if damage <= 0 then
        return damage
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.BLINDNESS, 25, 0, 60 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
