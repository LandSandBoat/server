-----------------------------------
-- Sturdy Pyxis Mixin
-----------------------------------

local mixin = function(mob)
    mob:addListener('DEATH', 'DEATH_SPAWN_PYXIS', function(mobArg, player, isKiller)
        if player and not mobArg:isNM() then
            xi.pyxis.spawnPyxis(mobArg, player)
        end
    end)
end

return mixin
