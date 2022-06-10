-----------------------------------
-- Area: Pashhow Marshlands
--   NM: Ni'Zho Bladebender
-----------------------------------
require("scripts/globals/regimes")
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobWeaponSkillPrepare = function(mob, target)
    -- Spams headbutt below 30% HP
    if mob:getHPP() <= 30 then
        return 612
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 60, 1, xi.regime.type.FIELDS)
    xi.hunts.checkHunt(mob, player, 214)
end

return entity
