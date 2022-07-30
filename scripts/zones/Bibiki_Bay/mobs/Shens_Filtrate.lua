-----------------------------------
-- Area: Bibiki Bay
--  Mob: Shen's Filtrate - Shen Elemental
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.REGEN, 120)
end

entity.onMobDeath = function(mob, player, isKiller)
    GetMobByID(ID.mob.SHEN):setLocalVar("filtrateDeath", 1)
end

return entity
