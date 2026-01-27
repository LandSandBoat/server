-----------------------------------
-- Area: Ifrit's Cauldron
--   NM: Bomb Prince
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.GIL_BONUS, -100)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)

    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onMobSpawn = function(mob)
    local bombQueen = GetMobByID(ID.mob.BOMB_QUEEN)
    if bombQueen and bombQueen:isAlive() then
        bombQueen:setMagicCastingEnabled(true)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mobSkill.SELF_DESTRUCT_BOMB
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
