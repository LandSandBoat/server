-----------------------------------
-- Area: Abyssea - Grauberg
--   NM: Burstrox Powderpate
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mobSkill.BOMB_TOSS_1
end

return entity
