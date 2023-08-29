-----------------------------------
-- Area: Xarcabard
--   NM: Barbaric Weapon
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.STORETP, 50) -- "Possesses extremely high Store TP."
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 318)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Gains Dread Spikes effect when using Whirl of Rage TP move
    if skill:getID() == 514 then
        mob:addStatusEffect(xi.effect.DREAD_SPIKES, 10, 0, 180)
    end
end

return entity
