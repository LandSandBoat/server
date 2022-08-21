-----------------------------------
-- Area: Balga's Dais
-- NM:
-- KSNM: Royale Ramble
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:SetMod(xi.mod.DOUBLE_ATTACK, 25)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
