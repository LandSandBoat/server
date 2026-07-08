-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Greater Manticore
-- Notes: 100% drop a Temp Box
-----------------------------------
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.salvage.spawnTempChest(mob, { rate = 1000 })
    end
end

return entity
