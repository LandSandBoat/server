-----------------------------------
-- Sturdy Pyxis Mixin
-----------------------------------
require('scripts/globals/abyssea/sturdypyxis/spawn')
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}

g_mixins.spawn_pyxis = function(mob)
    mob:addListener('DEATH', 'DEATH_SPAWN_PYXIS', function(mobArg, player, isKiller)
        if player and not mobArg:isNM() then
            xi.pyxis.spawnPyxis(mobArg, player)
        end
    end)
end

return g_mixins.spawn_pyxis
