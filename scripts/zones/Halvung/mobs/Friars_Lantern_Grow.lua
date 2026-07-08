-----------------------------------
-- Area: Halvung
--  Mob: Friar's Lantern (Growing Version)
-----------------------------------
mixins = { require('scripts/mixins/families/growing_bomb') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mix.growingBomb.onMobMobskillChoose(mob, target)
end

return entity
