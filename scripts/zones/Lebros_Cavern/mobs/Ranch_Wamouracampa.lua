-----------------------------------
-- Area: Lebros Cavern (Wamoura Farm Raid)
--  Mob: Ranch Wamouracampa
-----------------------------------
local entity = {}

function onMobEngaged(mob, target)

end

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

return entity
