-----------------------------------
-- Area: Uleguerand Range
--   NM: Skvader
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:addListener("MAGIC_USE", "SKVADER_MAGIC_USE", function(mobArg, target, spell, action)
        -- Hate reset after casting Banishga III
        if spell:getID() == 40 then
            mobArg:resetEnmity(target)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 321)
    mob:removeListener("SKVADER_MAGIC_EXIT")
end

return entity
