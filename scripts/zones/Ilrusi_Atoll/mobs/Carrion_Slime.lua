-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Slime
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
local zoneUtil = require("scripts/zones/Ilrusi_Atoll/globals/zoneUtil")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    local firstCall = isKiller or noKiller

    if firstCall then
        zoneUtil.exterminationRandomSpawn(mob, ID.mob[EXTERMINATION].NMS.SLIME)
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
