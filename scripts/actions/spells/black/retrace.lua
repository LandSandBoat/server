-----------------------------------
-- Spell: Retrace
-- Transports player to their Allied Nation. Can cast on allies.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if target:hasStatusEffect(xi.effect.MOUNTED) then
        return xi.msg.basic.MAGIC_CANNOT_BE_CAST
    end

    if target:getCampaignAllegiance() == 0 then
        return xi.msg.basic.MAGIC_CANNOT_BE_CAST
    end

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useTeleportSpell(caster, target, spell)
end

return spellObject
