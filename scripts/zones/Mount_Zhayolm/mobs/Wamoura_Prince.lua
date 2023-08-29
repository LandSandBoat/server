-----------------------------------
-- Area: Mount Zhayolm
--   NM: Wamoura Prince
-- TODO: Damage resistances in streched and curled stances. Halting movement during stance change. Morph into Wamoura.
-----------------------------------
mixins = { require('scripts/mixins/families/wamouracampa') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobRoam = function(mob)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob)
end

return entity
