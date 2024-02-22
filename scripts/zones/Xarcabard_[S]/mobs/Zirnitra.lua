-----------------------------------
-- Area: Xarcabard [S]
--   NM: Zirnitra
-----------------------------------
local ID = zones[xi.zone.XARCABARD_S]
mixins = { require('scripts/mixins/families/amphiptere') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Precise regen/regain values need retail verification.
    -- Mob uses abilities with high frequency
    mob:setMod(xi.mod.REGEN, 50)
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMod(xi.mod.WIND_ABSORB, 100)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
end

entity.onMobEngage = function(mob)
    mob:setLocalVar('hasEngaged', 1)
end

entity.onMobRoam = function(mob)
    -- Based on video capture, mob prints this message if the party wipes.
    -- TODO: Message below should not originate from Zirnitra herself
    if mob:getLocalVar('hasEngaged') == 1 then
        mob:setLocalVar('hasEngaged', 0)
        mob:showText(mob, ID.text.VOIDWALKER_DESPAWN)
        DespawnMob(mob:getID())
    end
end

entity.onMobDespawn = function(mob)
    GetMobByID(ID.mob.ZIRNITRA):setRespawnTime(math.random(14400, 18000)) -- 4 to 5 hours
end

entity.onMobDeath = function(mob, player, optParams)
    player:setTitle(xi.title.ZIRNITRA_WINGCLIPPER)
    xi.hunts.checkHunt(mob, player, 543)
end

return entity
