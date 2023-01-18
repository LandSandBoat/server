-----------------------------------
-- Area: Western Altepa Desert (125)
--   NM: Celphie
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == xi.jsa.HUNDRED_FISTS then
        mob:setMod(xi.mod.REGEN, 20)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
