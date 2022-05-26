-----------------------------------
-- Area: Newton Movalpolos
--   NM: Bugbear Matman
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.REGAIN, 50)
end

entity.onMobWeaponSkillPrepare = function(mob,target)
    -- Below 30% Bugbear Matman heavily prefers Heavy Whisk
	if mob:getHPP() <= 30 and math.random() > 0.4 then
	    return 358
	end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 248)
end

return entity
