-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Sewer Syrup
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGMAGIC, 5000) -- Takes +50% magic damage -- TODO: is this actually uncapped?
    mob:setMod(xi.mod.UDMGPHYS, -5000)  -- Takes -50%~ phys damage compared to its PHs

    -- Drops exactly 12k gil before Gilfinder every time
    mob:setMobMod(xi.mobMod.GIL_MIN, 12000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 12000)
end

return entity
