-----------------------------------
-- Spell: Bloodrake
-- Delivers a threefold attack. Absorbs HP equal to damage dealt
-- Spell cost: 99 MP
-- Monster Type: Undead (Vampyr)
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 4
-- Stat Bonus: STR+2, MND+2
-- Level: 99
-- Casting Time: 0.5 seconds
-- Recast Time: 30 seconds
-----------------------------------
-- Combos: None
-----------------------------------
-- Notes: Requires Unbridled Learning
-- 3-hit physical attack with HP drain
-- WSC: 30% STR, 30% MND
-- fTP: 1.0 (0 TP), 1.1375 (1500 TP)
-- Absorbs 100% of damage dealt
-- Does NOT drain HP from Undead targets
-- Skillchain: Darkness/Distortion
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    -- Requires Unbridled Learning
    if not caster:hasStatusEffect(xi.effect.UNBRIDLED_LEARNING) then
        return xi.msg.basic.STATUS_PREVENTS
    end

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.UNDEAD
    params.tpmod = xi.spells.blue.tpMod.DAMAGE
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.numhits = 3
    params.multiplier = 1.0
    params.tp150 = 1.1375
    params.tp300 = 1.1375
    params.azuretp = 1.1375
    params.duppercap = 75
    params.str_wsc = 0.3  -- 30% STR
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.3  -- 30% MND
    params.chr_wsc = 0.0

    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    -- HP Drain: Absorb 100% of damage dealt (does not work on Undead)
    if damage > 0 and not target:isUndead() then
        local drain = damage
        caster:addHP(drain)
        spell:setMsg(xi.msg.basic.SKILL_DRAIN)
    end

    return damage
end

return spellObject
