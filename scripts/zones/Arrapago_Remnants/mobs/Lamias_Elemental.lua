-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Lamia's Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.UDMGPHYS, 50)
    mob:addMod(xi.mod.UDMGMAGIC, 50)
    mob:addMod(xi.mod.UDMGRANGE, 50)
    mob:addMod(xi.mod.UDMGBREATH, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        xi.salvage.spawnTempChest(mob, {})
    end
end

return entity
