-----------------------------------
-- Spell: Impact
-- Deals dark damage to an enemy and
-- decreases all 7 base stats by 20%
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local damage = xi.spells.damage.useDamageSpell(caster, target, spell)

    -- Apply effects.
    local effectTable =
    {
        [1] = { xi.effect.STR_DOWN, xi.mod.STR },
        [2] = { xi.effect.DEX_DOWN, xi.mod.DEX },
        [3] = { xi.effect.VIT_DOWN, xi.mod.VIT },
        [4] = { xi.effect.AGI_DOWN, xi.mod.AGI },
        [5] = { xi.effect.INT_DOWN, xi.mod.INT },
        [6] = { xi.effect.MND_DOWN, xi.mod.MND },
        [7] = { xi.effect.CHR_DOWN, xi.mod.CHR },
    }

    local resist = xi.combat.magicHitRate.calculateResistRate(caster, target, spell:getSpellGroup(), 0, 0, xi.element.DARK, xi.mod.INT, 0, 0)

    for i = 1, 7 do
        local effectId = effectTable[i][1]
        if not target:hasStatusEffect(effectId) then
            local power    = math.floor(target:getStat(effectTable[i][2]) / 5)
            local duration = math.floor(180 * resist)
            target:addStatusEffect(effectId, power, 0, duration)
        end
    end

    return damage
end

return spellObject
