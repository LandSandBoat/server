-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Cherry Sapling
-- Note: PH for Cemetery Cherry
-----------------------------------
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    local allSaplingsDead = true
    for i = ID.mob.CHERRY_SAPLING_OFFSET, ID.mob.CHERRY_SAPLING_OFFSET + 12 do
        local mobObj = GetMobByID(i)
        if
            mobObj ~= nil and
            mobObj:getName() == 'Cherry_Sapling' and
            mobObj:isAlive()
        then
            allSaplingsDead = false
            break
        end
    end

    if allSaplingsDead then
        SpawnMob(ID.mob.CHERRY_SAPLING_OFFSET + 6) -- Cemetery Cherry
    end
end

return entity
