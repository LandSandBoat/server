-----------------------------------
-- Area: Bhaflau Remnants
--  MOB: Colibri
-----------------------------------
mixins = { require('scripts/mixins/families/colibri_mimic') }
-----------------------------------

---@type TMobEntity
local entity = {}

-- mob takes double dmg
entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGMAGIC, 1000)
    mob:setMod(xi.mod.UDMGPHYS, 100)
    mob:setMod(xi.mod.UDMGRANGE, 100)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
