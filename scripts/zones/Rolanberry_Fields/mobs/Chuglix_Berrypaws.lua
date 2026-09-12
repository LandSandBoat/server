-----------------------------------
-- Area: Rolanberry Fields
--   NM: Chuglix Berrypaws
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
    if
        not player:hasKeyItem(xi.keyItem.SEEDSPALL_CAERULUM) and
        not player:hasKeyItem(xi.keyItem.VIRIDIAN_KEY)
    then
        npcUtil.giveKeyItem(player, xi.keyItem.SEEDSPALL_CAERULUM)
    end
end

return entity
