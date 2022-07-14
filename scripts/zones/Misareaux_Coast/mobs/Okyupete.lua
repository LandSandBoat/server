-----------------------------------
-- Area: Misareaux Coast
--   NM: Okyupete
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 250)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Uses Triple Attack followed by Gliding Spike
    if skill:getID() == 400 then
        mob:useMobAbility(401)
    end
end


entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 446)
end

return entity
