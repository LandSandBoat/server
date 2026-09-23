--[[
Colibri that copy spells cast on it.

localVar                        default     description
--------                        -------     -----------
[colibri]reflect_blue_magic     0           set to 1 for this mob to also reflect blue magic cast on it

https://ffxiclopedia.fandom.com/wiki/Colibri
https://ffxiclopedia.fandom.com/wiki/Greater_Colibri
https://ffxiclopedia.fandom.com/wiki/Chamrosh
-- TODO: supposedly Colibri can store up to 2 spells.
--]]

require('scripts/globals/mixins')
require('scripts/globals/magic')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.colibri_mimic = function(colibriMob)
    -- initial state 0
    local closedBeak = 4
    local openBeak   = 5

    colibriMob:addListener('MAGIC_TAKE', 'COLIBRI_MIMIC_MAGIC_TAKE', function(target, caster, spell)
        if
            target:getAnimationSub() ~= openBeak and
            spell:tookEffect() and
            (caster:isPC() or caster:isPet()) and
            (spell:getSpellGroup() ~= xi.magic.spellGroup.BLUE or target:getLocalVar('[colibri]reflect_blue_magic') == 1)
        then
            target:setLocalVar('[colibri]spellToMimic', spell:getID()) -- which spell to mimic
            target:setLocalVar('[colibri]castTime', GetSystemTime() + 6) -- enforce a delay between original spell, and mimic spell.
            target:setAnimationSub(openBeak)
        end
    end)

    colibriMob:addListener('COMBAT_TICK', 'COLIBRI_MIMIC_CTICK', function(mob)
        local spellToMimic = mob:getLocalVar('[colibri]spellToMimic')
        local castTime = mob:getLocalVar('[colibri]castTime')
        local osTime = GetSystemTime()

        if mob:getAnimationSub() == openBeak then
            if
                spellToMimic > 0 and
                osTime > castTime and
                not mob:hasStatusEffect(xi.effect.SILENCE) and
                not mob:hasPreventActionEffect()
            then
                mob:castSpell(spellToMimic)
                mob:setLocalVar('[colibri]spellToMimic', 0)
                mob:setLocalVar('[colibri]castTime', 0)
                mob:setAnimationSub(closedBeak)
            end
        end
    end)
end

return g_mixins.families.colibri_mimic
