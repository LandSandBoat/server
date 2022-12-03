-----------------------------------
-- Area: Temenos Central Temenos
--  Mob: Mystic Avatar
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")
require("scripts/globals/limbus")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    local mobID = mob:getID()
    if mobID == ID.mob.TEMENOS_C_MOB[2] then --Carbuncle (Central Temenos 2nd Floor)
        mob:setMod(xi.mod.FIRE_SDT, 10000)    -- No damage.
        mob:setMod(xi.mod.ICE_SDT, 10000)     -- No damage.
        mob:setMod(xi.mod.WIND_SDT, 10000)    -- No damage.
        mob:setMod(xi.mod.EARTH_SDT, 10000)   -- No damage.
        mob:setMod(xi.mod.THUNDER_SDT, 10000) -- No damage.
        mob:setMod(xi.mod.WATER_SDT, 10000)   -- No damage.
        mob:setMod(xi.mod.LIGHT_SDT, 10000)   -- No damage.
        mob:setMod(xi.mod.DARK_SDT, -5000)    -- 50% more damage.
    end
end

entity.onMobEngaged = function(mob, target)
    local mobID = mob:getID()
    if mobID == ID.mob.TEMENOS_C_MOB[2] then --Carbuncle (Central Temenos 2nd Floor)
        GetMobByID(ID.mob.TEMENOS_C_MOB[2] + 2):updateEnmity(target)
        GetMobByID(ID.mob.TEMENOS_C_MOB[2] + 1):updateEnmity(target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local mobID = mob:getID()
        if mobID >= ID.mob.TEMENOS_C_MOB[2] + 9 then
            local elementOffset = mobID - ID.mob.TEMENOS_C_MOB[2] + 8
            local partnerOffset = elementOffset % 6 -- Levithan's partner starts at 0

            GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(xi.mod.FIRE_SDT - 1 + elementOffset, -5000) -- ? IDK
            if GetMobByID(ID.mob.TEMENOS_C_MOB[2] + 3 + partnerOffset):isAlive() then
                DespawnMob(ID.mob.TEMENOS_C_MOB[2] + 3 + partnerOffset)
                SpawnMob(ID.mob.TEMENOS_C_MOB[2] + 9 + partnerOffset)
            end
        end
    end
end

return entity
