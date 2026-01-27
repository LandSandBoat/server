-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Sweeping Cluster
-----------------------------------
mixins = { require('scripts/mixins/families/bomb_cluster') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mix.clusters.onMobMobskillChoose(mob, target)
end

return entity
