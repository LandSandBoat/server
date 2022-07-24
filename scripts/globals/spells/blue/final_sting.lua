-----------------------------------
-- Spell: Final Sting
-- Deals damage proportional to HP. Reduces HP to 1 on success.
-- Spell cost: 88 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 1
-- Stat Bonus: HP-20 AGI+5
-- Level: 81
-- Casting Time: 5 seconds
-- Recast Time: 11 seconds
-----------------------------------
local spell_object = {}

require("scripts/globals/settings")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/bluemagic")

spell_object.onMagicCastingCheck = function(caster, target, spell)
    caster:setLocalVar("final-sting_hp", caster:getHP())
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local duration = 300
    local playerHP = caster:getLocalVar("final-sting_hp")

    local params = {}
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.tpmod = TPMOD_DAMAGE
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.PIERCING
    params.scattr = SC_FUSION
    params.numhits = 1
    params.multiplier = 1
    params.tp150 = 0.8
    params.tp300 = 1.0
    params.azuretp = 1.0
    params.duppercap = 100 -- D upper >=69
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BluePhysicalSpell(caster, target, spell, params)

    if damage > 0 then
        local capped = playerHP > (target:getMaxHP() * 0.5)
        local final_damage = 0
        -- 
        if (capped) then
            local level_diff = target:getMainLvl() - caster:getMainLevel()
            local penalty = 0
            -- Guessing HP% penalty for max damage.
            if (level_diff > 8) then -- IT
                penalty = 0.45
            elseif (level_diff > 4) then -- VT
                penalty = 0.30
            elseif (level > -1 ) then -- EM and DC
                penalty = 0.15
            end
            final_damage = (0.65 - penalty) * target:getMaxHP()
        else
            -- Player HP will be a certain percentage lower than 50% of mob HP
            final_damage = playerHP
        end
        target:takeSpellDamage(caster, spell, final_damage, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
        caster:setHP(1)
    end

    return damage
end

return spell_object