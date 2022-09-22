-----------------------------------
-- Area: Western Altepa Desert (125)
--   NM: Celphie
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    if mob:hasStatusEffect(xi.effect.HUNDRED_FISTS) then
        mob:addMod(xi.mod.REGEN, 20)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
