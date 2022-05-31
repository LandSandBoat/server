-----------------------------------
-- Dynamis Beastmen NMs Era Module
-----------------------------------
require("modules/era/lua/dynamis/globals/era_dynamis")
require("modules/era/lua/dynamis/globals/era_dynamis_spawning")
require("scripts/globals/mixins")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.dynamis = xi.dynamis or {}

xi.dynamis.onSpawnBeastmenNM = function(mob)
    mixins =
    {
        require("scripts/mixins/job_special"),
        require("scripts/mixins/remove_doom")
    }
    xi.dynamis.setNMStats(mob)
end

xi.dynamis.onSpawnBeastmen = function(mob)
    mixins = {require("scripts/mixins/job_special"),}
    xi.dynamis.setMobStats(mob)
end