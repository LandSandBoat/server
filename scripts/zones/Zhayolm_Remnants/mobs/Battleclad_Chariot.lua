-----------------------------------
-- Area: Zhayolm Remnants
--   NM: Battleclad Chariot
-----------------------------------
mixins = { require('scripts/mixins/families/chariot') }
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addMod(xi.mod.DMGPHYS, -2500)
    mob:addMod(xi.mod.DMGRANGE, -2500)
    mob:addMod(xi.mod.DEF, 50)
    mob:addMod(xi.mod.ATT, 150)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 45)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
    mob:setMobMod(xi.mobMod.ROAM_TURNS, 0)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.STAR_CHARIOTEER)
    if optParams.isKiller or optParams.noKiller then
        mob:getInstance():complete()
    end
end

return entity
