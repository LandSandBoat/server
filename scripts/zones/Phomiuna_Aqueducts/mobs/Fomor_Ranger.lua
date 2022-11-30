-----------------------------------
-- Area: Phomiuna_Aqueducts
--  Mob: Fomor Ranger
-----------------------------------
mixins = { require("scripts/mixins/fomor_hate") }
local ID = require('scripts/zones/Phomiuna_Aqueducts/IDs')
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    for _, v in pairs(ID.mob.FOMOR_PARTY_TWO) do
        if mob:getID() == v then
            mob:setMobMod(xi.mobMod.SUPERLINK, 2)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
