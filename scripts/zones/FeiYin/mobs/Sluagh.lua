-----------------------------------
-- Area: FeiYin
--   NM: Sluagh
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    -- Possesses a potent Store TP trait that rises as HP declines
    local power = 20 + math.floor(utils.clamp(100 - mob:getHPP(), 0, 75) * 2.4)
    mob:setMod(xi.mod.STORETP, power)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 349)
end

return entity
