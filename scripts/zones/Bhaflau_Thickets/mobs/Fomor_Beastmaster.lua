-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Fomor Beastmaster
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Fomors_Bats')
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.HEARING, xi.detects.LOWHP, xi.detects.ABILITY))
end

return entity
