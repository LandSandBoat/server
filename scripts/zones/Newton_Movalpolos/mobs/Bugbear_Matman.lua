-----------------------------------
-- Area: Newton Movalpolos
--   NM: Bugbear Matman
-----------------------------------
local ID = require("scripts/zones/Newton_Movalpolos/IDs")
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.REGAIN, 50)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    -- Below 30% Bugbear Matman heavily prefers Heavy Whisk
    if mob:getHPP() <= 30 and math.random() > 0.4 then
        return 358
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 248)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.MOBLIN_SHOWMAN):setStatus(xi.status.NORMAL)
end

return entity
