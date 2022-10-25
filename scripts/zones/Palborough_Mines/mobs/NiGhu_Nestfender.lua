-----------------------------------
-- Area: Palborough Mines
--   NM: Ni'Ghu Nestfender
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 35 then
        mob:setMobMod(xi.mobMod.HEAL_CHANCE, 80)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
