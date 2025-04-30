require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.poroggo = function(poroggoMob)
    -- Change Poroggo spell list back to standard BLM after casting a providence spell
    poroggoMob:addListener('MAGIC_START', 'POROGGO_MAGIC_START', function(mob, spell, action)
        -- Reset Poroggo to specific spell list or default to generic BLM list
        local spellListId = mob:getLocalVar('spellListId') ~= 0 and mob:getLocalVar('spellListId') or 2

        if mob:getLocalVar('providence') == 1 then
            mob:setSpellList(spellListId)
            mob:setLocalVar('providence', 0)
            mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
        end
    end)
end

return g_mixins.families.poroggo
