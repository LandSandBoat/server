-----------------------------------
-- Area: Bibiki Bay
--  Mob: Coastal Opo-opo
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- Opo-Opo in Bibiki Bay do not get their racial EVA bonus.
    mob:addMod(xi.mod.EVA, -25)
end

return entity
