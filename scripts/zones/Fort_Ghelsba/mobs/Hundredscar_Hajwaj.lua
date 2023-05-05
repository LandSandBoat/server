-----------------------------------
-- Area: Fort Ghelsba
--   NM: Hundredscar Hajwaj
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 172)
    xi.roe.onRecordTrigger(player, 222)
end

return entity
