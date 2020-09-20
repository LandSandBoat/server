-----------------------------------
-- Area: Behemoths Dominion
--   NM: Legendary Weapon
-----------------------------------
local ID = require("scripts/zones/Behemoths_Dominion/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/regimes")
-----------------------------------

function onMobDisengage(mob)
    DespawnMob(mob:getID(), 120)
end

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 102, 2, tpz.regime.type.FIELDS)
    if (isKiller and GetMobByID(ID.mob.ANCIENT_WEAPON):isDead()) then
        GetNPCByID(ID.npc.CERMET_HEADSTONE):setLocalVar("cooldown", os.time() + 900)
    end
end
