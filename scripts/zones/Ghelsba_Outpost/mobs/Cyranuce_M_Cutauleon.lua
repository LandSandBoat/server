-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Cyranuce M Cutauleon
-- Involved in Quest: The Holy Crest
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    if mob:getHPP() <= 15 then
        return xi.mobSkill.CHAOS_BREATH
    end
end

return entity
