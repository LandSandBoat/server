-----------------------------------
-- Area: Nyzul Isle
--  NM:  Bloodtear_Baldurf
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/utils/nyzul")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.eliminateAllKill(mob)
    end
end

return entity
