-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Fomor Thief
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.HEARING, xi.detects.LOWHP, xi.detects.ABILITY))
end

return entity
