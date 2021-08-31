-----------------------------------
-- Area: Apollyon SE
--  Mob: Grave Digger
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.HTH_SDT, 1500)
    mob:setMod(xi.mod.IMPACT_SDT, 1500)
    mob:setMod(xi.mod.PIERCE_SDT, 0)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        xi.limbus.handleDoors(mob:getBattlefield(), true, ID.npc.APOLLYON_SE_PORTAL[3])
    end
end

return entity
