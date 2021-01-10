-----------------------------------
-- Area: Arrapago Reef
--   NM: Zareehkl the Jubilant
-----------------------------------
mixins = {require("scripts/mixins/families/qutrub")}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setLocalVar("qutrubBreakChance", 5) -- Wiki implies its weapon is harder to break
end

function onMobDeath(mob, player, isKiller)
end

return entity
