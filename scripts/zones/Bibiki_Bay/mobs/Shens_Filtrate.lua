-----------------------------------
-- Area: Bibiki Bay
--  Mob: Shen's Filtrate - Shen Elemental
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.REGEN, 120)
end

entity.onMobDeath = function(mob, player, optParams)
    local shen = mob:getZone():queryEntitiesByName('Shen')[1]
    shen:setLocalVar('filtrateDeath', 1)
end

return entity
