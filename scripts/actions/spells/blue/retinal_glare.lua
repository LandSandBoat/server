-----------------------------------
-- Spell: Retinal Glare
-- Deals light damage to a single target. Additional effect: Flash (high enmity)
-- Spell cost: 196 MP
-- Monster Type: Demon
-- Spell Type: Magical (Light)
-- Blue Magic Points: 8
-- Stat Bonus: INT+5, MND+5
-- Level: 99
-- Casting Time: 6 seconds
-- Recast Time: 60 seconds
-----------------------------------
-- Combos: Conserve MP
-----------------------------------
-- Notes: PROXY FORMULA: Based on Dark Orb (WSC 40% INT, fTP 4.5, dINT 2.0)
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Using Dark Orb formula
    local params = {}
    params.ecosystem   = xi.ecosystem.DEMON
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.LIGHT
    params.attribute   = xi.mod.INT
    params.multiplier  = 4.5
    params.tMultiplier = 2.0
    params.duppercap   = 99
    params.str_wsc     = 0.0
    params.dex_wsc     = 0.0
    params.vit_wsc     = 0.0
    params.agi_wsc     = 0.0
    params.int_wsc     = 0.4
    params.mnd_wsc     = 0.0
    params.chr_wsc     = 0.0

    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    if damage > 0 then
        -- Flash effect (high enmity generation)
        -- Flash applies Blindness and generates high enmity
        local effectTable =
        {
            [1] = { xi.effect.BLINDNESS, 40, 0, 12 },
        }

        xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

        -- Generate additional enmity
        target:addEnmity(caster, 0, 1800)
    end

    return damage
end

return spellObject
