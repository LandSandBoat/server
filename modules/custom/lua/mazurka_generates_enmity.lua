-----------------------------------
-- Make Mazurka Provoke!
--
-- https://www.bg-wiki.com/ffxi/The_History_of_Final_Fantasy_XI/2007
-- Mar. 8th, 2007: The enmity gained when using Chocobo Mazurka and Raptor Mazurka was reduced.
-- Just before this patch, BRDs could use Mazurka to generate ridiculous enmity.
-- The devs did not intend for this to happen and it was quickly patched.
-- But for a glorious few days, BRDs could tank surprisingly well.
-----------------------------------
require("modules/module_utils")
require("scripts/globals/spell_data")
-----------------------------------
local m = Module:new("mazurka_generates_enmity")

local chocoboMazurkaPower = 1.0
local raptorMazurkaPower = 1.1

local mazurkaProvoke = function(caster, target, spell, power)
    -- If not Mazurka, bail out
    if spell:getID() ~= xi.magic.spell.CHOCOBO_MAZURKA and spell:getID() ~= xi.magic.spell.RAPTOR_MAZURKA then
        return
    end

    -- Mazurka is a self-targetting spell, so target == caster, so we have to grab the
    -- entity we've got set as our battle target
    local battleTarget = caster:getTarget()
    if battleTarget == nil then
        return
    end

    -- TODO: Factor singing and instrument skill into this, etc.
    local enmity = spell:getTotalTargets() * (100 * power)

    -- Bard Provoke!
    battleTarget:addEnmity(caster, 0, enmity)
end

m:addOverride("xi.globals.spells.songs.chocobo_mazurka.onSpellCast", function(caster, target, spell)
    local songEffect = super(caster, target, spell)
    mazurkaProvoke(caster, target, spell, chocoboMazurkaPower)
    return songEffect
end)

m:addOverride("xi.globals.spells.songs.raptor_mazurka.onSpellCast", function(caster, target, spell)
    local songEffect = super(caster, target, spell)
    mazurkaProvoke(caster, target, spell, raptorMazurkaPower)
    return songEffect
end)

return m
