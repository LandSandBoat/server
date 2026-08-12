-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Fomor Paladin
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.HEARING, xi.detects.LOWHP, xi.detects.ABILITY))
end

return entity
