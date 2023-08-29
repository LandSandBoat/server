-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Tipha
-----------------------------------
local ID = zones[xi.zone.YUHTUNGA_JUNGLE]
-----------------------------------
local entity = {}

entity.onMobDisengage = function(mob)
    DespawnMob(mob:getID(), 120)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller and GetMobByID(ID.mob.CARTHI):isDead() then
        GetNPCByID(ID.npc.CERMET_HEADSTONE):setLocalVar('cooldown', os.time() + 900)
    end
end

return entity
