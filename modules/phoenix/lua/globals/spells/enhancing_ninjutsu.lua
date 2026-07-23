-----------------------------------
-- Module: Enhancing Ninjutsu Adjustments
-- TODO: Convert to new spell organization once upstream is reworked
-----------------------------------
require('modules/module_utils')
-----------------------------------

-- Detection Spells: Revert durations.
-- Source: https://forum.square-enix.com/ffxi/threads/39564-Jan-21-2014-%28JST%29-Version-Update
local eraDuration =
{
    [xi.magic.spell.TONKO_ICHI ] = 180,
    [xi.magic.spell.TONKO_NI   ] = 300,
    [xi.magic.spell.MONOMI_ICHI] = 180,
}

if xi.pre(xi.expansion.SOA) then
    for spellId, duration in pairs(eraDuration) do
        xi.spells.enhancing.ninjutsuPTable[spellId][4] = duration -- column.EFFECT_DURATION
    end
end
