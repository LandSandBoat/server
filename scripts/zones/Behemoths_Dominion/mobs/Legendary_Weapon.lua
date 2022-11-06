-----------------------------------
-- Area: Behemoths Dominion
--   NM: Legendary Weapon
-----------------------------------
local ID = require("scripts/zones/Behemoths_Dominion/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDisengage = function(mob)
    DespawnMob(mob:getID(), 120)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 102, 2, xi.regime.type.FIELDS)
    if optParams.isKiller and GetMobByID(ID.mob.ANCIENT_WEAPON):isDead() then
        GetNPCByID(ID.npc.CERMET_HEADSTONE):setLocalVar("cooldown", os.time() + 900)
    end
end

return entity
