-----------------------------------
-- Area: Batallia Downs
--  Mob: Vegnix Greenthumb
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
    if
        not player:hasKeyItem(xi.ki.SEEDSPALL_ROSEUM) and
        not player:hasKeyItem(xi.ki.VIRIDIAN_KEY)
    then
        npcUtil.giveKeyItem(player, xi.ki.SEEDSPALL_ROSEUM)
    end
end

return entity
