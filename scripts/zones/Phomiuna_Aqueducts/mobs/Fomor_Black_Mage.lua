-----------------------------------
-- Area: Phomiuna_Aqueducts
--  Mob: Fomor Black Mage
-----------------------------------
mixins = {require("scripts/mixins/fomor_hate")}
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------
local entity = {}

entity.onMobRoam = function(mob)
    local tres = GetMobByID(ID.mob.TRES_DUENDES):getLocalVar("cooldown")
    if os.time() > tres and mob:getID(ID.mob.TRES_DUENDES - 1) then
        DisallowRespawn(mob:getID(), true)
        GetMobByID(ID.mob.TRES_DUENDES):setSpawn(mob:getXPos(),mob:getYPos(),mob:getZPos())
        DespawnMob(mob:getID())
        SpawnMob(ID.mob.TRES_DUENDES)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
