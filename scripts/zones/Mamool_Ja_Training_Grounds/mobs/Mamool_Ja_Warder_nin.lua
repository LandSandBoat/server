-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  MOB: Mamool Ja Warder (NIN)
-----------------------------------

local warder = require('scripts/zones/Mamool_Ja_Training_Grounds/globals/warder')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    warder.onMobSpawn(mob)

    -- Keep NIN Warders in melee range so they engage gates.
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
end

entity.onMobWeaponSkill = warder.onMobWeaponSkill

return entity
