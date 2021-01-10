-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Lamia Graverobber
-----------------------------------
mixins = {require("scripts/mixins/weapon_break")}
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    if instance:getStage() == 1 then
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
