-----------------------------------
-- Area: Den of Rancor
--   NM: Ogama
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    local power = (100 - mob:getHPP()) * 10
    if mob:getMod(xi.mod.MAIN_DMG_RATING) ~= utils.clamp(power, 1, 2000) then
        mob:setMod(xi.mod.MAIN_DMG_RATING, utils.clamp(power, 1, 2000))
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 398)
end

return entity
