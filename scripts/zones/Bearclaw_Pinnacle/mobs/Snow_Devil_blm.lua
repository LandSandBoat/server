-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Snow Devil (BLM)
-- ENM: When Hell Freezes Over
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 60)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 60)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMod(xi.mod.REGAIN, 50)
    mob:setMod(xi.mod.DESPAWN_TIME_REDUCTION, 15)
end

entity.onMobMagicPrepare = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.ICE_THRENODY,
        xi.magic.spell.BLIZZARD_IV,
        xi.magic.spell.BLIZZAGA_III,
    }
    return spellList[math.random(1, #spellList)]
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
