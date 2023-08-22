-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Ullikummi
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

-- TODO: Heavy Strike should ALWAYS knockback its target regardless of if it hits or does damage.

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 1000)

    mob:addListener("WEAPONSKILL_USE", "ULLI_WEAPONSKILL_USE", function(mobArg, target, wsid, tp, action)
        if action:getParam(target:getID()) > 1 then
            mobArg:resetEnmity(target)
        end
    end)
end

entity.onMobDespawn = function(mob)
    mob:removeListener("ULLI_WEAPONSKILL_USE")
end

return entity
