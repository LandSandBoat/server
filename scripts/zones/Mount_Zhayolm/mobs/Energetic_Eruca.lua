-----------------------------------
-- Area: Mount Zhayolm
--   NM: Energetic Eruca
-- Note: Place Holder: Magmatic Eruca
--       Does not sleep like other Eruca in the area
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 75)
    mob:setMod(xi.mod.LULLABYRESBUILD, 25)
    mob:setMod(xi.mod.SLASH_SDT, 0) -- Immune to slashing damage
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 455)
end

return entity
