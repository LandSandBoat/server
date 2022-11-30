-----------------------------------
-- Area: Phomiuna_Aqueducts
--  Mob: Fomor Dragoon
-----------------------------------
mixins = { require("scripts/mixins/fomor_hate") }
local ID = require('scripts/zones/Phomiuna_Aqueducts/IDs')
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    for _, v in pairs(ID.mob.FOMOR_PARTY_ONE) do
        if mob:getID() == v then
            mob:setMobMod(xi.mobMod.SUPERLINK, 1)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
