-----------------------------------
-- Area: Bhaflau Remnants
--  MOB: Long-Bowed_Chariot
-- Note: Modifiers are placeholders for future, needs retail verification for stats
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
    mob:addMod(xi.mod.ATT, 100)
    mob:setMod(xi.mod.MAIN_DMG_RATING, 50)
    mob:setMod(xi.mod.REGAIN, 25)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
    mob:setMobMod(xi.mobMod.ROAM_TURNS, 0)
end

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()

    if instance then
        if instance:getLocalVar('bossModifier') == 1 then
            mob:addMod(xi.mod.DEF, -100)
            mob:setMod(xi.mod.DMGMAGIC, 100)
        elseif instance:getLocalVar('bossModifier') == 2 then
            mob:addMod(xi.mod.ATT, -100)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.COMET_CHARIOTEER)
    if optParams.isKiller or optParams.noKiller then
        mob:getInstance():complete()
    end
end

return entity
