-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Nasus
-----------------------------------
local ID = zones[xi.zone.YUHTUNGA_JUNGLE]
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
    local qm = GetNPCByID(ID.npc.TUNING_OUT_QM)
    qm:setLocalVar('NasusKilled', qm:getLocalVar('NasusKilled') + 1)
end

return entity
