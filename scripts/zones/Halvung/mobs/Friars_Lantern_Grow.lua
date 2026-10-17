-----------------------------------
-- Area: Halvung
--  Mob: Friar's Lantern (Growing Version)
-----------------------------------
mixins = { require('scripts/mixins/families/growing_bomb') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- Non NM TOAU Single Bombs do not gain 1.5x damage
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 0)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mix.growingBomb.onMobMobskillChoose(mob, target)
end

return entity
