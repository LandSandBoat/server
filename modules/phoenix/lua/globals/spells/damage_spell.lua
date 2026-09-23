-----------------------------------
-- Module: Damage Spell Adjustments
-- TODO: Convert to new spell organization once upstream is reworked
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('damage_spell_adjustments')

-----------------------------------
-- Revert AM2 magic accuracy to pre RoV values, plus merit-based magic burst and magic accuracy.
-- Source: https://forum.square-enix.com/ffxi/threads/55525-June.-10-2019-%28JST%29-Version-Update
-----------------------------------

-- These merits carry a value of 1, so getMerit returns the rank count.
local meritBySpell =
{
    [xi.magic.spell.FLARE_II  ] = xi.merit.FLARE_II,
    [xi.magic.spell.FREEZE_II ] = xi.merit.FREEZE_II,
    [xi.magic.spell.TORNADO_II] = xi.merit.TORNADO_II,
    [xi.magic.spell.QUAKE_II  ] = xi.merit.QUAKE_II,
    [xi.magic.spell.BURST_II  ] = xi.merit.BURST_II,
    [xi.magic.spell.FLOOD_II  ] = xi.merit.FLOOD_II,
}

-- Revert magic accuracy for BLM AM2 to pre RoV values.
for spellId in pairs(meritBySpell) do
    xi.spells.damage.pTable[spellId][2] = 0 -- column.BONUS_MACC
end

-- Apply magic accuracy and magic burst merit mods for spell calculations and remove them afterward.
m:addOverride('xi.spells.damage.useDamageSpell', function(caster, target, spell)
    local merit     = meritBySpell[spell:getID()]
    local meritRank = merit and caster:getMerit(merit) or 0

    -- The first rank only unlocks the spell.
    if meritRank < 2 then
        return super(caster, target, spell)
    end

    local maccBonus  = (meritRank - 1) * 5
    local burstBonus = (meritRank - 1) * 3

    caster:addMod(xi.mod.MACC, maccBonus)
    caster:addMod(xi.mod.MAGIC_BURST_BONUS_CAPPED, burstBonus)

    local castOk, damage = pcall(super, caster, target, spell)

    caster:delMod(xi.mod.MACC, maccBonus)
    caster:delMod(xi.mod.MAGIC_BURST_BONUS_CAPPED, burstBonus)

    if not castOk then
        error(damage, 0)
    end

    return damage
end)

return m
