-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Genbu
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENWATER)
end

entity.onMobDeath = function(mob, player, isKiller)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 6)
end

return entity
