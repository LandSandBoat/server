-----------------------------------
-- Area: Konschtat Highlands
--   NM: Forger
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mobSkill.BERSERK_BOMB
end

return entity
