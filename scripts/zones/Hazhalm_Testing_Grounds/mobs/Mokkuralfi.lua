-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Mokkuralfi (Einherjar)
-- Notes: Casts various tier 2/3 -ga spells and enfeebs with low cooldown.
-- At low HP, uses Xenoglossia once. Casts Thundaga IV instantly with it.
-- Immune to silence.
-----------------------------------
mixins =
{
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
    mob:addImmunity(xi.immunity.SILENCE)

    mob:setMobMod(xi.mobMod.MAGIC_COOL, 10)
end

entity.onMobMobskillChoose = function(mob, target)
    if
        mob:getHPP() <= 20 and
        mob:getLocalVar('xenoglossia') == 0
    then
        mob:setLocalVar('tga4Next', 1)
        mob:setLocalVar('xenoglossia', 1)
        return xi.mobSkill.XENOGLOSSIA
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    if mob:getLocalVar('tga4Next') ~= 0 then
        mob:setLocalVar('tga4Next', 0)
        return xi.magic.spell.THUNDAGA_IV
    end
end

return entity
